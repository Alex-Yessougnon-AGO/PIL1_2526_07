from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView

from apps.common.responses import success_response
from apps.mentoring.models import Match, MentorshipPost
from apps.notifications.models import Notification


class DashboardView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        user = request.user
        return success_response(
            {
                "posts_count": MentorshipPost.objects.filter(creator=user, deleted_at__isnull=True).count(),
                "active_posts": MentorshipPost.objects.filter(creator=user, status="OPEN", deleted_at__isnull=True).count(),
                "matches": Match.objects.filter(mentor=user, deleted_at__isnull=True).count()
                + Match.objects.filter(mentee=user, deleted_at__isnull=True).count(),
                "pending_matches": Match.objects.filter(
                    mentor=user, status="PENDING", deleted_at__isnull=True
                ).count()
                + Match.objects.filter(mentee=user, status="PENDING", deleted_at__isnull=True).count(),
                "unread_notifications": Notification.objects.filter(user=user, is_read=False).count(),
            },
            "Dashboard data retrieved",
        )
