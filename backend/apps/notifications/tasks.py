from asgiref.sync import async_to_sync
from celery import shared_task
from channels.layers import get_channel_layer

from apps.notifications.models import Notification
from apps.notifications.serializers import NotificationSerializer


@shared_task
def send_notification(user_id, notif_type, title, content, metadata=None):
    notification = Notification.objects.create(
        user_id=user_id,
        type=notif_type,
        title=title,
        content=content,
        metadata=metadata or {},
    )

    channel_layer = get_channel_layer()
    group_name = f"notifications_{user_id}"

    async_to_sync(channel_layer.group_send)(
        group_name,
        {
            "type": "notification.message",
            "event": "NEW_NOTIFICATION",
            "notification": NotificationSerializer(notification).data,
            "unread_count": Notification.objects.filter(user_id=user_id, is_read=False).count(),
        },
    )

    return str(notification.id)
