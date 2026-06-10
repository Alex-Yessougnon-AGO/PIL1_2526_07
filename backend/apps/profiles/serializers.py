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


class ProfileStatsSerializer(serializers.Serializer):
    sessions_given = serializers.IntegerField()
    sessions_received = serializers.IntegerField()
    sessions_total = serializers.IntegerField()
    sessions_completed = serializers.IntegerField()
    completion_rate = serializers.IntegerField()


class ReviewSerializer(serializers.Serializer):
    id = serializers.UUIDField()
    reviewer_name = serializers.SerializerMethodField()
    reviewer_avatar = serializers.SerializerMethodField()
    reviewer_level = serializers.SerializerMethodField()
    rating = serializers.IntegerField()
    content = serializers.CharField()
    session_type = serializers.CharField()
    created_at = serializers.DateTimeField()

    def get_reviewer_name(self, obj):
        user = obj.reviewer
        return f"{user.first_name} {user.last_name}"

    def get_reviewer_avatar(self, obj):
        profile = getattr(obj.reviewer, "profile", None)
        if profile and profile.profile_photo:
            return profile.profile_photo.url
        return None

    def get_reviewer_level(self, obj):
        profile = getattr(obj.reviewer, "profile", None)
        if profile and profile.academic_level:
            return profile.academic_level
        return ""


class PublicProfileStatsSerializer(serializers.Serializer):
    sessions_completed = serializers.IntegerField()
    average_rating = serializers.FloatField()
    total_reviews = serializers.IntegerField()
    ranking = serializers.CharField()
