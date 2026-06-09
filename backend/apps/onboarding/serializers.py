from rest_framework import serializers

from apps.onboarding.models import VerificationDocument
from apps.profiles.models import Skill


class AcademicInfoSerializer(serializers.Serializer):
    track = serializers.ChoiceField(
        choices=[
            "Génie Logiciel (GL)",
            "Intelligence Artificielle (IA)",
            "Cybersécurité (SI)",
            "Internet et Multimédia (IM)",
            "Data Science",
        ]
    )
    level = serializers.ChoiceField(
        choices=[
            "Licence 1",
            "Licence 2",
            "Licence 3",
            "Master 1",
            "Master 2",
        ]
    )


class OnboardingSkillsSerializer(serializers.Serializer):
    masteries = serializers.ListField(
        child=serializers.CharField(max_length=255),
        required=False,
        default=list,
    )
    needs = serializers.ListField(
        child=serializers.CharField(max_length=255),
        required=False,
        default=list,
    )


class VerificationDocumentSerializer(serializers.ModelSerializer):
    class Meta:
        model = VerificationDocument
        fields = ("id", "file", "status", "rejection_reason", "created_at", "updated_at")
        read_only_fields = ("id", "status", "rejection_reason", "created_at", "updated_at")


class VerificationUploadSerializer(serializers.Serializer):
    student_id_file = serializers.FileField()

    def validate_student_id_file(self, value):
        if value.size > 10 * 1024 * 1024:
            raise serializers.ValidationError("File too large (max 10MB)")
        allowed_types = ["image/jpeg", "image/png", "image/jpg", "application/pdf"]
        if value.content_type not in allowed_types:
            raise serializers.ValidationError("Only JPEG, PNG, and PDF files are allowed")
        return value
