from django.db import migrations, models


class Migration(migrations.Migration):
    """Increase max_length of Notification.type from 20 to 30
    to accommodate VERIFICATION_APPROVED and VERIFICATION_REJECTED."""

    dependencies = [
        ("notifications", "0001_initial"),
    ]

    operations = [
        migrations.AlterField(
            model_name="notification",
            name="type",
            field=models.CharField(
                choices=[
                    ("NEW_MESSAGE", "New Message"),
                    ("NEW_MATCH", "New Match"),
                    ("MATCH_ACCEPTED", "Match Accepted"),
                    ("MATCH_REJECTED", "Match Rejected"),
                    ("VERIFICATION_APPROVED", "Verification Approved"),
                    ("VERIFICATION_REJECTED", "Verification Rejected"),
                ],
                max_length=30,
            ),
        ),
    ]
