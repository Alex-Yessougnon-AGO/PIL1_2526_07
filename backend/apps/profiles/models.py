import uuid

from django.db import models

from apps.common.models import BaseModel


class Skill(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=255, unique=True)

    class Meta:
        db_table = "skills"
        ordering = ["name"]

    def __str__(self):
        return self.name


def photo_upload_path(instance, filename):
    return f"profiles/{instance.user_id}/{filename}"


class Profile(BaseModel):
    user = models.OneToOneField("accounts.User", on_delete=models.CASCADE, related_name="profile")
    profile_photo = models.ImageField(upload_to=photo_upload_path, null=True, blank=True)
    department = models.CharField(max_length=255, null=True, blank=True)
    academic_level = models.CharField(max_length=100, null=True, blank=True)
    bio = models.TextField(null=True, blank=True)

    class Meta:
        db_table = "profiles"
        indexes = [
            models.Index(fields=["department"]),
            models.Index(fields=["academic_level"]),
        ]

    def __str__(self):
        return f"Profile of {self.user.email}"

    @property
    def skills(self):
        return self.user_skills.filter(deleted_at__isnull=True)

    @property
    def strengths(self):
        return self.user_skills.filter(type="STRENGTH", deleted_at__isnull=True)

    @property
    def weaknesses(self):
        return self.user_skills.filter(type="WEAKNESS", deleted_at__isnull=True)

    @property
    def availability(self):
        return self.slots.filter(deleted_at__isnull=True)


class UserSkill(BaseModel):
    profile = models.ForeignKey(Profile, on_delete=models.CASCADE, related_name="user_skills")
    skill = models.ForeignKey(Skill, on_delete=models.CASCADE, related_name="user_skills")
    type = models.CharField(max_length=10, choices=[("STRENGTH", "Strength"), ("WEAKNESS", "Weakness")])

    class Meta:
        db_table = "user_skills"
        unique_together = ("profile", "skill")

    def __str__(self):
        return f"{self.profile.user.email} - {self.skill.name} ({self.type})"


class AvailabilitySlot(BaseModel):
    profile = models.ForeignKey(Profile, on_delete=models.CASCADE, related_name="slots")
    day_of_week = models.CharField(
        max_length=10,
        choices=[
            ("MONDAY", "Monday"),
            ("TUESDAY", "Tuesday"),
            ("WEDNESDAY", "Wednesday"),
            ("THURSDAY", "Thursday"),
            ("FRIDAY", "Friday"),
            ("SATURDAY", "Saturday"),
            ("SUNDAY", "Sunday"),
        ],
    )
    start_time = models.TimeField()
    end_time = models.TimeField()

    class Meta:
        db_table = "availability_slots"
        ordering = ["day_of_week", "start_time"]

    def __str__(self):
        return f"{self.profile.user.email} - {self.day_of_week} {self.start_time}-{self.end_time}"
