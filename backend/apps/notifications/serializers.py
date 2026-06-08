from rest_framework import serializers

from apps.notifications.models import Notification


class NotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notification
        fields = ("id", "user_id", "type", "title", "content", "metadata", "is_read", "created_at")
        read_only_fields = ("id", "user_id", "created_at")


class MarkReadSerializer(serializers.Serializer):
    ids = serializers.ListField(child=serializers.UUIDField())
