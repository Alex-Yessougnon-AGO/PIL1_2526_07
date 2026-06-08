from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView

from apps.common.responses import error_response, success_response
from apps.profiles.repositories import AvailabilityRepository, UserSkillRepository
from apps.profiles.serializers import (
    AvailabilitySlotSerializer,
    ProfilePhotoSerializer,
    ProfileSerializer,
    UserSkillSerializer,
)
from apps.profiles.services import ProfileService


class ProfileDetailView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        profile = ProfileService.get_or_create(request.user)
        serializer = ProfileSerializer(profile)
        return success_response(serializer.data)

    def patch(self, request):
        allowed = {"bio", "department", "academic_level"}
        data = {k: v for k, v in request.data.items() if k in allowed}
        profile = ProfileService.update_profile(request.user, data)
        serializer = ProfileSerializer(profile)
        return success_response(serializer.data, "Profile updated")


class ProfilePhotoView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        serializer = ProfilePhotoSerializer(data=request.data)
        if not serializer.is_valid():
            return error_response("Validation failed", serializer.errors, status.HTTP_400_BAD_REQUEST)

        profile = ProfileService.get_or_create(request.user)
        profile.profile_photo = serializer.validated_data["photo"]
        profile.save(update_fields=["profile_photo"])
        return success_response(ProfileSerializer(profile).data, "Photo uploaded")


class AddSkillView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        name = request.data.get("name")
        skill_type = request.data.get("type", "STRENGTH")
        if not name:
            return error_response("Skill name is required", status=status.HTTP_400_BAD_REQUEST)
        if skill_type not in ("STRENGTH", "WEAKNESS"):
            return error_response("Type must be STRENGTH or WEAKNESS", status=status.HTTP_400_BAD_REQUEST)

        us = ProfileService.add_skill(request.user, name, skill_type)
        return success_response(UserSkillSerializer(us).data, "Skill added", status.HTTP_201_CREATED)


class RemoveSkillView(APIView):
    permission_classes = [IsAuthenticated]

    def delete(self, request, pk):
        ProfileService.remove_skill(request.user, pk)
        return success_response(None, "Skill removed")


class AddAvailabilityView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        day = request.data.get("day")
        start = request.data.get("start")
        end = request.data.get("end")
        if not all([day, start, end]):
            return error_response("day, start, end required", status=status.HTTP_400_BAD_REQUEST)

        slot = ProfileService.add_availability(request.user, day, start, end)
        return success_response(AvailabilitySlotSerializer(slot).data, "Availability added", status.HTTP_201_CREATED)


class RemoveAvailabilityView(APIView):
    permission_classes = [IsAuthenticated]

    def delete(self, request, pk):
        ProfileService.remove_availability(request.user, pk)
        return success_response(None, "Availability removed")
