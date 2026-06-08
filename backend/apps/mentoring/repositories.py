from django.db.models import Q

from apps.mentoring.models import Match, MentorshipPost


class MentorshipPostRepository:
    @staticmethod
    def create(creator, data):
        return MentorshipPost.objects.create(creator=creator, **data)

    @staticmethod
    def get_by_id(post_id) -> MentorshipPost | None:
        return MentorshipPost.objects.filter(id=post_id, deleted_at__isnull=True).select_related("creator").first()

    @staticmethod
    def get_all(type=None, subject=None, format=None, department=None, status="OPEN"):
        qs = MentorshipPost.objects.filter(deleted_at__isnull=True).select_related("creator")
        if type:
            qs = qs.filter(type=type)
        if subject:
            qs = qs.filter(subject__icontains=subject)
        if format:
            qs = qs.filter(format=format)
        if department:
            qs = qs.filter(creator__profile__department=department)
        if status:
            qs = qs.filter(status=status)
        return qs.order_by("-created_at")

    @staticmethod
    def update(post: MentorshipPost, data: dict) -> MentorshipPost:
        for k, v in data.items():
            if v is not None:
                setattr(post, k, v)
        post.save(update_fields=data.keys())
        return post

    @staticmethod
    def delete(post: MentorshipPost):
        post.soft_delete()


class MatchRepository:
    @staticmethod
    def create(mentor, mentee, offer, request_obj, score):
        return Match.objects.create(mentor=mentor, mentee=mentee, offer=offer, request=request_obj, compatibility_score=score)

    @staticmethod
    def get_by_id(match_id) -> Match | None:
        return Match.objects.filter(id=match_id, deleted_at__isnull=True).select_related("mentor", "mentee").first()

    @staticmethod
    def get_for_user(user):
        return (
            Match.objects.filter(Q(mentor=user) | Q(mentee=user), deleted_at__isnull=True)
            .select_related("mentor", "mentee")
            .order_by("-compatibility_score")
        )

    @staticmethod
    def get_recommendations(user, limit=20):
        return (
            Match.objects.filter(Q(mentor=user) | Q(mentee=user), status="PENDING", deleted_at__isnull=True)
            .select_related("mentor", "mentee")
            .order_by("-compatibility_score")[:limit]
        )

    @staticmethod
    def update_status(match: Match, status: str) -> Match:
        match.status = status
        match.save(update_fields=["status"])
        return match
