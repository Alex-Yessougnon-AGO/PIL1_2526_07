import uuid

from django.db import models

from apps.common.models import BaseModel


class Notification(BaseModel):
    NOTIFICATION_TYPES = [
        ("NEW_MESSAGE", "New Message"),
        ("NEW_MATCH", "New Match"),
        ("MATCH_ACCEPTED", "Match Accepted"),
        ("MATCH_REJECTED", "Match Rejected"),
        ("VERIFICATION_APPROVED", "Verification Approved"),
        ("VERIFICATION_REJECTED", "Verification Rejected"),
    ]

    user = models.ForeignKey("accounts.User", on_delete=models.CASCADE, related_name="notifications")
    type = models.CharField(max_length=30, choices=NOTIFICATION_TYPES)
    title = models.CharField(max_length=255)
    content = models.TextField()
    is_read = models.BooleanField(default=False)
    metadata = models.JSONField(null=True, blank=True)

    class Meta:
        db_table = "notifications"
        indexes = [
            models.Index(fields=["user", "is_read"]),
            models.Index(fields=["created_at"]),
        ]
        ordering = ["-created_at"]

    def __str__(self):
        return f"[{self.type}] {self.title} - {self.user.email}"
