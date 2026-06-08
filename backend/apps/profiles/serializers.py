from rest_framework import serializers

from apps.accounts.serializers import UserSerializer
from apps.profiles.models import AvailabilitySlot, Profile, Skill, UserSkill


class SkillSerializer(serializers.ModelSerializer):
    class Meta:
        model = Skill
        fields = ("id", "name")


class UserSkillSerializer(serializers.ModelSerializer):
    skill_name = serializers.CharField(source="skill.name", read_only=True)

    class Meta:
        model = UserSkill
        fields = ("id", "skill", "skill_name", "type", "created_at")
        read_only_fields = ("id", "created_at")


class AvailabilitySlotSerializer(serializers.ModelSerializer):
    class Meta:
        model = AvailabilitySlot
        fields = ("id", "day_of_week", "start_time", "end_time", "created_at")
        read_only_fields = ("id", "created_at")


class ProfileSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    skills = UserSkillSerializer(source="user_skills", many=True, read_only=True)
    availability = AvailabilitySlotSerializer(source="slots", many=True, read_only=True)

    class Meta:
        model = Profile
        fields = (
            "id",
            "user",
            "profile_photo",
            "department",
            "academic_level",
            "bio",
            "skills",
            "availability",
            "created_at",
            "updated_at",
        )
        read_only_fields = ("id", "created_at", "updated_at", "user")

    def validate_profile_photo(self, value):
        if value and value.size > 5 * 1024 * 1024:
            raise serializers.ValidationError("File too large (max 5MB)")
        return value


class ProfilePhotoSerializer(serializers.Serializer):
    photo = serializers.ImageField()

    def validate_photo(self, value):
        if value.size > 5 * 1024 * 1024:
            raise serializers.ValidationError("File too large (max 5MB)")
        return value
