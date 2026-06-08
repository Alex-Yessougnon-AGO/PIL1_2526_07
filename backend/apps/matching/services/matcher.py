from django.db.models import Q

from apps.mentoring.models import Match
from apps.mentoring.repositories import MatchRepository
from apps.profiles.models import Profile, UserSkill
from apps.profiles.repositories import ProfileRepository


class MatcherService:
    WEIGHTS = {
        "skills": 0.5,
        "availability": 0.3,
        "department": 0.1,
        "level": 0.1,
    }

    @staticmethod
    def _get_or_create_profile(user):
        profile, _ = Profile.objects.get_or_create(user=user)
        return profile

    @staticmethod
    def compute_skill_score(mentor, mentee) -> tuple[float, list[str]]:
        mentor_profile = MatcherService._get_or_create_profile(mentor)
        mentee_profile = MatcherService._get_or_create_profile(mentee)

        mentor_skills = set(
            UserSkill.objects.filter(profile=mentor_profile, type="STRENGTH", deleted_at__isnull=True).values_list(
                "skill__name", flat=True
            )
        )
        mentee_weaknesses = set(
            UserSkill.objects.filter(profile=mentee_profile, type="WEAKNESS", deleted_at__isnull=True).values_list(
                "skill__name", flat=True
            )
        )
        mentee_strengths = set(
            UserSkill.objects.filter(profile=mentee_profile, type="STRENGTH", deleted_at__isnull=True).values_list(
                "skill__name", flat=True
            )
        )

        common_skills = list(mentor_skills & (mentee_weaknesses | mentee_strengths))

        if not mentor_skills or not (mentee_weaknesses or mentee_strengths):
            return 0.0, common_skills

        exact = mentor_skills & mentee_weaknesses
        partial = mentor_skills & mentee_strengths

        numerator = len(exact) * 100 + len(partial) * 50
        denominator = len(mentor_skills) + len(mentee_weaknesses) + len(mentee_strengths)
        if denominator == 0:
            return 0.0, common_skills

        score = numerator / denominator
        return min(score, 100.0), common_skills

    @staticmethod
    def compute_availability_score(mentor, mentee) -> tuple[float, list[dict]]:
        mentor_profile = MatcherService._get_or_create_profile(mentor)
        mentee_profile = MatcherService._get_or_create_profile(mentee)

        mentor_slots = mentor_profile.slots.filter(deleted_at__isnull=True).values("day_of_week", "start_time", "end_time")
        mentee_slots = mentee_profile.slots.filter(deleted_at__isnull=True).values("day_of_week", "start_time", "end_time")

        if not mentor_slots or not mentee_slots:
            return 0.0, []

        common = []
        for ms in mentor_slots:
            for me_s in mentee_slots:
                if ms["day_of_week"] == me_s["day_of_week"]:
                    if ms["start_time"] <= me_s["end_time"] and me_s["start_time"] <= ms["end_time"]:
                        common.append(
                            {
                                "day": ms["day_of_week"],
                                "mentor_start": str(ms["start_time"]),
                                "mentor_end": str(ms["end_time"]),
                                "mentee_start": str(me_s["start_time"]),
                                "mentee_end": str(me_s["end_time"]),
                            }
                        )

        if not common:
            return 0.0, []

        total_interactions = len(list(mentor_slots)) + len(list(mentee_slots))
        score = (len(common) * 2 / total_interactions) * 100 if total_interactions > 0 else 0
        return min(score, 100.0), common

    @staticmethod
    def compute_department_score(mentor, mentee) -> float:
        mentor_profile = MatcherService._get_or_create_profile(mentor)
        mentee_profile = MatcherService._get_or_create_profile(mentee)

        d1 = mentor_profile.department
        d2 = mentee_profile.department

        if not d1 or not d2:
            return 20.0

        if d1 == d2:
            return 100.0
        if d1[:3] == d2[:3]:
            return 60.0
        return 20.0

    @staticmethod
    def compute_level_score(mentor, mentee) -> float:
        mentor_profile = MatcherService._get_or_create_profile(mentor)
        mentee_profile = MatcherService._get_or_create_profile(mentee)

        l1 = mentor_profile.academic_level
        l2 = mentee_profile.academic_level

        if not l1 or not l2:
            return 30.0

        levels = {"L1": 1, "L2": 2, "L3": 3, "M1": 4, "M2": 5, "Doctorat": 6}
        v1 = levels.get(l1, 0)
        v2 = levels.get(l2, 0)

        if v1 == 0 or v2 == 0:
            return 30.0

        diff = abs(v1 - v2)
        if diff == 0:
            return 100.0
        if diff <= 1:
            return 70.0
        return 30.0

    @staticmethod
    def compute_match_score(mentor, mentee) -> dict:
        skill_score, common_skills = MatcherService.compute_skill_score(mentor, mentee)
        availability_score, common_slots = MatcherService.compute_availability_score(mentor, mentee)
        department_score = MatcherService.compute_department_score(mentor, mentee)
        level_score = MatcherService.compute_level_score(mentor, mentee)

        total = (
            skill_score * MatcherService.WEIGHTS["skills"]
            + availability_score * MatcherService.WEIGHTS["availability"]
            + department_score * MatcherService.WEIGHTS["department"]
            + level_score * MatcherService.WEIGHTS["level"]
        )

        return {
            "score": round(total, 2),
            "skill_score": round(skill_score, 2),
            "availability_score": round(availability_score, 2),
            "department_score": round(department_score, 2),
            "level_score": round(level_score, 2),
            "common_skills": common_skills,
            "common_slots": common_slots,
        }

    @staticmethod
    def create_match(mentor, mentee, offer=None, request_obj=None) -> Match:
        result = MatcherService.compute_match_score(mentor, mentee)
        match = MatchRepository.create(
            mentor=mentor,
            mentee=mentee,
            offer=offer,
            request_obj=request_obj,
            score=result["score"],
        )
        return match

    @staticmethod
    def run_matching_for_user(user) -> list[Match]:
        profile = MatcherService._get_or_create_profile(user)
        user_posts = profile.user.posts.filter(deleted_at__isnull=True)

        offers = user_posts.filter(type="OFFER", status="OPEN")
        requests = user_posts.filter(type="REQUEST", status="OPEN")

        matches = []

        if offers.exists():
            potential_mentees = Profile.objects.filter(
                deleted_at__isnull=True,
                user__posts__type="REQUEST",
                user__posts__status="OPEN",
                user__posts__deleted_at__isnull=True,
            ).exclude(user=user).select_related("user")

            for p in potential_mentees:
                existing = Match.objects.filter(
                    Q(mentor=user, mentee=p.user) | Q(mentor=p.user, mentee=user),
                    deleted_at__isnull=True,
                )
                if existing.exists():
                    continue

                match = MatcherService.create_match(mentor=user, mentee=p.user, offer=offers.first(), request_obj=None)
                matches.append(match)

        if requests.exists():
            potential_mentors = Profile.objects.filter(
                deleted_at__isnull=True,
                user__posts__type="OFFER",
                user__posts__status="OPEN",
                user__posts__deleted_at__isnull=True,
            ).exclude(user=user).select_related("user")

            for p in potential_mentors:
                existing = Match.objects.filter(
                    Q(mentor=p.user, mentee=user) | Q(mentor=user, mentee=p.user),
                    deleted_at__isnull=True,
                )
                if existing.exists():
                    continue

                match = MatcherService.create_match(mentor=p.user, mentee=user, offer=None, request_obj=requests.first())
                matches.append(match)

        return matches
