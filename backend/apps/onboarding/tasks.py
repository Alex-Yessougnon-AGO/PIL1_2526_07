from asgiref.sync import async_to_sync
from celery import shared_task
from channels.layers import get_channel_layer

from apps.notifications.models import Notification
from apps.notifications.serializers import NotificationSerializer


@shared_task
def notify_verification_approved(user_id, user_email):
    """Send notification when a user's verification document is approved."""
    title = "Vérification approuvée"
    content = f"Votre document d'identité étudiante a été approuvé. Vous pouvez maintenant utiliser pleinement MentorLink."

    notification = Notification.objects.create(
        user_id=user_id,
        type="VERIFICATION_APPROVED",
        title=title,
        content=content,
    )

    # Send real-time notification via WebSocket
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

    # TODO: In production, send email notification too
    return str(notification.id)


@shared_task
def notify_verification_rejected(user_id, user_email, reason=None):
    """Send notification when a user's verification document is rejected."""
    title = "Vérification rejetée"
    content = f"Votre document d'identité étudiante a été rejeté."
    if reason:
        content += f" Raison : {reason}"
    content += " Veuillez télécharger un nouveau document depuis votre profil."

    notification = Notification.objects.create(
        user_id=user_id,
        type="VERIFICATION_REJECTED",
        title=title,
        content=content,
    )

    # Send real-time notification via WebSocket
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

    # TODO: In production, send email notification too
    return str(notification.id)


@shared_task
def send_verification_email(user_id, token, email, first_name):
    """Send email verification link after registration.

    In production, this should use a proper email backend (SendGrid, Mailgun, etc.).
    For now, we just log the verification link for development.
    """
    import logging

    logger = logging.getLogger(__name__)
    verify_url = f"/api/v1/auth/verify-email?token={token}"
    logger.info(f"[DEV] Email verification for {email} ({first_name}): {verify_url}")
    # TODO: In production, send actual email via SendGrid/Mailgun/etc.
