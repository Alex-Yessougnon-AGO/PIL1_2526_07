import uuid

from django.db import models


def verification_document_path(instance, filename):
    return f"verification/{instance.user_id}/{uuid.uuid4()}_{filename}"


class VerificationDocument(models.Model):
    STATUS_CHOICES = [
        ("PENDING", "Pending"),
        ("APPROVED", "Approved"),
        ("REJECTED", "Rejected"),
    ]

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.OneToOneField("accounts.User", on_delete=models.CASCADE, related_name="verification_document")
    file = models.FileField(upload_to=verification_document_path)
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default="PENDING")
    rejection_reason = models.TextField(null=True, blank=True)
    reviewed_by = models.ForeignKey(
        "accounts.User", on_delete=models.SET_NULL, null=True, blank=True, related_name="reviewed_verifications"
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "verification_documents"
        indexes = [
            models.Index(fields=["status"]),
            models.Index(fields=["user", "status"]),
        ]

    def __str__(self):
        return f"Verification for {self.user.email} - {self.status}"
