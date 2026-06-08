from rest_framework import serializers

from apps.accounts.serializers import UserSerializer
from apps.mentoring.models import Match, MentorshipPost


class MentorshipPostSerializer(serializers.ModelSerializer):
    creator = UserSerializer(read_only=True)

    class Meta:
        model = MentorshipPost
        fields = ("id", "creator", "type", "subject", "description", "format", "status", "created_at", "updated_at")
        read_only_fields = ("id", "creator", "status", "created_at", "updated_at")


class MentorshipPostCreateSerializer(serializers.Serializer):
    type = serializers.ChoiceField(choices=["OFFER", "REQUEST"])
    subject = serializers.CharField(max_length=255)
    description = serializers.CharField(required=False, allow_blank=True)
    format = serializers.ChoiceField(choices=["ONLINE", "PHYSICAL", "BOTH"], default="ONLINE")


class MatchSerializer(serializers.ModelSerializer):
    mentor = UserSerializer(read_only=True)
    mentee = UserSerializer(read_only=True)
    common_skills = serializers.SerializerMethodField()
    common_slots = serializers.SerializerMethodField()

    class Meta:
        model = Match
        fields = (
            "id",
            "mentor",
            "mentee",
            "offer",
            "request",
            "compatibility_score",
            "common_skills",
            "common_slots",
            "status",
            "matched_at",
            "created_at",
        )
        read_only_fields = ("id", "matched_at", "created_at")

    def get_common_skills(self, obj):
        return []

    def get_common_slots(self, obj):
        return []
