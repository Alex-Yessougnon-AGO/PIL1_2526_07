from django.db import migrations, models
import django.db.models.deletion
import apps.onboarding.models
import uuid


class Migration(migrations.Migration):
    initial = True

    dependencies = [
        ("accounts", "0001_initial"),
    ]

    operations = [
        migrations.CreateModel(
            name="VerificationDocument",
            fields=[
                ("id", models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, serialize=False)),
                ("file", models.FileField(upload_to=apps.onboarding.models.verification_document_path)),
                (
                    "status",
                    models.CharField(
                        choices=[("PENDING", "Pending"), ("APPROVED", "Approved"), ("REJECTED", "Rejected")],
                        default="PENDING",
                        max_length=10,
                    ),
                ),
                ("rejection_reason", models.TextField(blank=True, null=True)),
                (
                    "reviewed_by",
                    models.ForeignKey(
                        blank=True,
                        null=True,
                        on_delete=django.db.models.deletion.SET_NULL,
                        related_name="reviewed_verifications",
                        to="accounts.User",
                    ),
                ),
                ("created_at", models.DateTimeField(auto_now_add=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                (
                    "user",
                    models.OneToOneField(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="verification_document",
                        to="accounts.User",
                    ),
                ),
            ],
            options={
                "db_table": "verification_documents",
            },
        ),
        migrations.AddIndex(
            model_name="verificationdocument",
            index=models.Index(fields=["status"], name="vd_status_idx"),
        ),
        migrations.AddIndex(
            model_name="verificationdocument",
            index=models.Index(fields=["user", "status"], name="vd_user_status_idx"),
        ),
    ]
