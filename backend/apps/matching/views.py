from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView

from apps.common.responses import error_response, success_response
from apps.matching.services.matcher import MatcherService
from apps.mentoring.models import Match
from apps.mentoring.repositories import MatchRepository
from apps.mentoring.serializers import MatchSerializer


class MatchingRunView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        matches = MatcherService.run_matching_for_user(request.user)
        data = []
        for m in matches:
            result = MatcherService.compute_match_score(m.mentor, m.mentee)
            data.append(
                {
                    "match_id": str(m.id),
                    "score": m.compatibility_score,
                    "common_skills": result["common_skills"],
                    "common_slots": result["common_slots"],
                    "mentor": {"id": str(m.mentor.id), "email": m.mentor.email, "first_name": m.mentor.first_name, "last_name": m.mentor.last_name},
                    "mentee": {"id": str(m.mentee.id), "email": m.mentee.email, "first_name": m.mentee.first_name, "last_name": m.mentee.last_name},
                }
            )
        return success_response(data, "Matching completed")


class MatchingRecommendationsView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        matches = MatchRepository.get_recommendations(request.user)
        data = []
        for m in matches:
            result = MatcherService.compute_match_score(m.mentor, m.mentee)
            data.append(
                {
                    "id": str(m.id),
                    "mentor": MatchSerializer(m.mentor).data,
                    "mentee": MatchSerializer(m.mentee).data,
                    "score": m.compatibility_score,
                    "common_skills": result["common_skills"],
                    "common_slots": result["common_slots"],
                    "status": m.status,
                }
            )
        return success_response(data, "Recommendations retrieved")


class MatchingHistoryView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        matches = MatchRepository.get_for_user(request.user)
        serializer = MatchSerializer(matches, many=True)
        return success_response(serializer.data, "History retrieved")


class AcceptMatchView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request, pk):
        match = MatchRepository.get_by_id(pk)
        if not match:
            return error_response("Match not found", status=status.HTTP_404_NOT_FOUND)
        if match.mentor != request.user and match.mentee != request.user:
            return error_response("Forbidden", status=status.HTTP_403_FORBIDDEN)
        if match.status not in ("PENDING",):
            return error_response("Match already processed", status=status.HTTP_400_BAD_REQUEST)

        MatchRepository.update_status(match, "ACCEPTED")
        from apps.mentoring.repositories import MentorshipPostRepository
        if match.offer:
            MentorshipPostRepository.update(match.offer, {"status": "MATCHED"})
        if match.request:
            MentorshipPostRepository.update(match.request, {"status": "MATCHED"})

        return success_response(MatchSerializer(match).data, "Match accepted")


class RejectMatchView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request, pk):
        match = MatchRepository.get_by_id(pk)
        if not match:
            return error_response("Match not found", status=status.HTTP_404_NOT_FOUND)
        if match.mentor != request.user and match.mentee != request.user:
            return error_response("Forbidden", status=status.HTTP_403_FORBIDDEN)
        if match.status not in ("PENDING",):
            return error_response("Match already processed", status=status.HTTP_400_BAD_REQUEST)

        MatchRepository.update_status(match, "REJECTED")
        return success_response(MatchSerializer(match).data, "Match rejected")
