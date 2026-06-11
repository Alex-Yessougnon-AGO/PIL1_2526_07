from django.db.models import Count
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView

from apps.common.responses import error_response, success_response
from apps.accounts.repositories import UserRepository
from apps.mentoring.repositories import MatchRepository, MentorshipPostRepository, ReviewRepository
from apps.mentoring.serializers import MentorshipPostSerializer
from apps.profiles.repositories import AvailabilityRepository, ProfileRepository, UserSkillRepository
from apps.profiles.serializers import (
    AvailabilitySlotSerializer,
    ProfilePhotoSerializer,
    ProfileSerializer,
    ProfileStatsSerializer,
    PublicProfileStatsSerializer,
    ReviewSerializer,
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
        # Update user fields on the User model
        user_allowed = {"first_name", "last_name", "phone"}
        user_data = {k: v for k, v in request.data.items() if k in user_allowed and v is not None}
        for key, value in user_data.items():
            setattr(request.user, key, value)
        if user_data:
            request.user.save(update_fields=user_data.keys())

        # Update profile fields on the Profile model
        allowed = {"bio", "department", "academic_level"}
        data = {k: v for k, v in request.data.items() if k in allowed}
        profile = ProfileService.update_profile(request.user, data)

        # Handle skills if provided
        mentor_skills = request.data.get("mentor_skills")
        learner_skills = request.data.get("learner_skills")
        if mentor_skills is not None or learner_skills is not None:
            ProfileService.clear_skills(request.user)
            for skill_name in (mentor_skills or []):
                if skill_name.strip():
                    ProfileService.add_skill(request.user, skill_name.strip(), "STRENGTH")
            for skill_name in (learner_skills or []):
                if skill_name.strip():
                    ProfileService.add_skill(request.user, skill_name.strip(), "WEAKNESS")
            profile = ProfileService.get_or_create(request.user)

        serializer = ProfileSerializer(profile)
        return success_response(serializer.data, "Profile updated")


class PublicProfileView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, pk):
        user = UserRepository.get_by_id(pk)
        if not user:
            return error_response("User not found", status=status.HTTP_404_NOT_FOUND)

        profile = ProfileRepository.get_by_user(user)
        if not profile:
            profile = ProfileService.get_or_create(user)

        serializer = ProfileSerializer(profile)
        return success_response(serializer.data)


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


class ProfileStatsView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        stats = MatchRepository.get_profile_stats(request.user)
        serializer = ProfileStatsSerializer(stats)
        return success_response(serializer.data)


class MyProposalsView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        posts = MentorshipPostRepository.get_by_creator(request.user)
        serializer = MentorshipPostSerializer(posts, many=True)
        return success_response(serializer.data)


class PublicProfileStatsView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, pk):
        user = UserRepository.get_by_id(pk)
        if not user:
            return error_response("User not found", status=status.HTTP_404_NOT_FOUND)

        stats = MatchRepository.get_profile_stats(user)
        avg_rating = ReviewRepository.get_average_rating(user)
        review_count = len(ReviewRepository.get_for_user(user))
        ranking = "Top 5%" if stats["completion_rate"] >= 90 else "Top 10%" if stats["completion_rate"] >= 75 else "Top 25%" if stats["completion_rate"] >= 50 else "En progression"

        data = {
            "sessions_completed": stats["sessions_completed"],
            "average_rating": avg_rating,
            "total_reviews": review_count,
            "ranking": ranking,
        }
        serializer = PublicProfileStatsSerializer(data)
        return success_response(serializer.data)


class PublicReviewsView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, pk):
        user = UserRepository.get_by_id(pk)
        if not user:
            return error_response("User not found", status=status.HTTP_404_NOT_FOUND)

        reviews = ReviewRepository.get_for_user(user)
        serializer = ReviewSerializer(reviews, many=True)
        return success_response(serializer.data)
