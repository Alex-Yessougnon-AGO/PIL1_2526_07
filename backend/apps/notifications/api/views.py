from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView

from apps.common.pagination import StandardPagination
from apps.common.responses import error_response, success_response
from apps.notifications.models import Notification
from apps.notifications.serializers import MarkReadSerializer, NotificationSerializer


class NotificationListView(APIView, StandardPagination):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        qs = Notification.objects.filter(user=request.user, deleted_at__isnull=True)

        filter_type = request.query_params.get("type")
        if filter_type:
            types = [t.strip() for t in filter_type.split(",") if t.strip()]
            qs = qs.filter(type__in=types)

        is_read = request.query_params.get("is_read")
        if is_read is not None:
            if is_read.lower() == "true":
                qs = qs.filter(is_read=True)
            elif is_read.lower() == "false":
                qs = qs.filter(is_read=False)

        page = self.paginate_queryset(qs, request)
        if page is not None:
            serializer = NotificationSerializer(page, many=True)
            return self.get_paginated_response(serializer.data)
        serializer = NotificationSerializer(qs, many=True)
        return success_response(serializer.data)


class MarkReadView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        serializer = MarkReadSerializer(data=request.data)
        if not serializer.is_valid():
            return error_response("Validation failed", serializer.errors, status.HTTP_400_BAD_REQUEST)

        ids = serializer.validated_data["ids"]
        updated = Notification.objects.filter(id__in=ids, user=request.user).update(is_read=True)
        return success_response({"updated": updated}, "Notifications marked as read")
