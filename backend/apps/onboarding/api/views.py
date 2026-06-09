from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView

from apps.common.responses import error_response, success_response
from apps.onboarding.serializers import (
    AcademicInfoSerializer,
    OnboardingSkillsSerializer,
    VerificationDocumentSerializer,
    VerificationUploadSerializer,
)
from apps.onboarding.services import OnboardingService
from apps.profiles.repositories import ProfileRepository, UserSkillRepository


class AcademicInfoView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        serializer = AcademicInfoSerializer(data=request.data)
        if not serializer.is_valid():
            return error_response("Validation failed", serializer.errors, status.HTTP_400_BAD_REQUEST)

        profile = OnboardingService.save_academic_info(
            user=request.user,
            track=serializer.validated_data["track"],
            level=serializer.validated_data["level"],
        )

        return success_response(
            {
                "track": profile.department,
                "level": profile.academic_level,
            },
            "Academic info saved",
            status.HTTP_201_CREATED,
        )

    def get(self, request):
        profile = ProfileRepository.get_by_user(request.user)
        if not profile:
            return success_response({"track": None, "level": None})
        return success_response({"track": profile.department, "level": profile.academic_level})


class OnboardingSkillsView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        serializer = OnboardingSkillsSerializer(data=request.data)
        if not serializer.is_valid():
            return error_response("Validation failed", serializer.errors, status.HTTP_400_BAD_REQUEST)

        result = OnboardingService.save_skills(
            user=request.user,
            masteries=serializer.validated_data.get("masteries", []),
            needs=serializer.validated_data.get("needs", []),
        )

        return success_response(
            {
                "masteries": result["masteries"],
                "needs": result["needs"],
            },
            "Skills saved",
            status.HTTP_201_CREATED,
        )

    def get(self, request):
        profile = ProfileRepository.get_by_user(request.user)
        if not profile:
            return success_response({"masteries": [], "needs": []})

        user_skills = UserSkillRepository.get_profile_skills(profile)
        masteries = [us.skill.name for us in user_skills if us.type == "STRENGTH"]
        needs = [us.skill.name for us in user_skills if us.type == "WEAKNESS"]

        return success_response({"masteries": masteries, "needs": needs})


class VerificationUploadView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        serializer = VerificationUploadSerializer(data=request.data)
        if not serializer.is_valid():
            return error_response("Validation failed", serializer.errors, status.HTTP_400_BAD_REQUEST)

        doc = OnboardingService.upload_verification(
            user=request.user,
            file=serializer.validated_data["student_id_file"],
        )

        return success_response(
            VerificationDocumentSerializer(doc).data,
            "Document uploaded for verification",
            status.HTTP_201_CREATED,
        )


class VerificationStatusView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        doc = OnboardingService.get_verification_document(request.user)
        if not doc:
            return success_response({"status": None, "message": "No document uploaded yet"})

        return success_response(VerificationDocumentSerializer(doc).data)
