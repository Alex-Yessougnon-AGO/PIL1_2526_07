from apps.onboarding.models import VerificationDocument
from apps.profiles.models import Profile, Skill, UserSkill


class VerificationRepository:
    @staticmethod
    def get_by_user(user):
        return VerificationDocument.objects.filter(user=user).first()

    @staticmethod
    def create_or_update(user, file):
        doc, created = VerificationDocument.objects.update_or_create(
            user=user,
            defaults={"file": file, "status": "PENDING", "rejection_reason": None},
        )
        return doc

    @staticmethod
    def get_status(user):
        doc = VerificationDocument.objects.filter(user=user).first()
        return doc.status if doc else None

    @staticmethod
    def get_document(user):
        return VerificationDocument.objects.filter(user=user).first()


class OnboardingProfileRepository:
    @staticmethod
    def update_academic_info(user, track, level):
        profile, _ = Profile.objects.get_or_create(user=user)
        profile.department = track
        profile.academic_level = level
        profile.save(update_fields=["department", "academic_level"])
        return profile


class OnboardingSkillRepository:
    @staticmethod
    def get_or_create_skill(name: str) -> Skill:
        skill, _ = Skill.objects.get_or_create(name__iexact=name, defaults={"name": name})
        return skill

    @staticmethod
    def add_skill(profile, skill, skill_type: str):
        return UserSkill.objects.get_or_create(
            profile=profile,
            skill=skill,
            defaults={"type": skill_type},
        )

    @staticmethod
    def clear_user_skills(profile):
        UserSkill.objects.filter(profile=profile).delete()
