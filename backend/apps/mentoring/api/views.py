from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView

from apps.common.pagination import StandardPagination
from apps.common.responses import error_response, success_response
from apps.mentoring.models import MentorshipPost
from apps.mentoring.repositories import MentorshipPostRepository
from apps.mentoring.serializers import MentorshipPostCreateSerializer, MentorshipPostSerializer
from apps.mentoring.services import MentorshipService


class PostListCreateView(APIView, StandardPagination):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        posts = MentorshipService.list_posts(
            type=request.query_params.get("type"),
            subject=request.query_params.get("subject"),
            format=request.query_params.get("format"),
            department=request.query_params.get("department"),
            status=request.query_params.get("status", "OPEN"),
        )
        page = self.paginate_queryset(posts, request)
        if page is not None:
            serializer = MentorshipPostSerializer(page, many=True)
            return self.get_paginated_response(serializer.data)
        serializer = MentorshipPostSerializer(posts, many=True)
        return success_response(serializer.data)

    def post(self, request):
        serializer = MentorshipPostCreateSerializer(data=request.data)
        if not serializer.is_valid():
            return error_response("Validation failed", serializer.errors, status.HTTP_400_BAD_REQUEST)

        post = MentorshipService.create_post(request.user, serializer.validated_data)
        return success_response(MentorshipPostSerializer(post).data, "Post created", status.HTTP_201_CREATED)


class PostDetailView(APIView):
    permission_classes = [IsAuthenticated]

    def _get_post(self, pk):
        post = MentorshipPostRepository.get_by_id(pk)
        if not post:
            return None
        return post

    def get(self, request, pk):
        post = self._get_post(pk)
        if not post:
            return error_response("Post not found", status=status.HTTP_404_NOT_FOUND)
        return success_response(MentorshipPostSerializer(post).data)

    def patch(self, request, pk):
        post = self._get_post(pk)
        if not post:
            return error_response("Post not found", status=status.HTTP_404_NOT_FOUND)
        if post.creator != request.user:
            return error_response("Forbidden", status=status.HTTP_403_FORBIDDEN)

        allowed = {"subject", "description", "format"}
        data = {k: v for k, v in request.data.items() if k in allowed and v is not None}
        post = MentorshipService.update_post(pk, data)
        return success_response(MentorshipPostSerializer(post).data, "Post updated")

    def delete(self, request, pk):
        post = self._get_post(pk)
        if not post:
            return error_response("Post not found", status=status.HTTP_404_NOT_FOUND)
        if post.creator != request.user:
            return error_response("Forbidden", status=status.HTTP_403_FORBIDDEN)

        MentorshipService.delete_post(pk)
        return success_response(None, "Post deleted")


class PostApplyView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request, pk):
        post = MentorshipPostRepository.get_by_id(pk)
        if not post:
            return error_response("Post not found", status=status.HTTP_404_NOT_FOUND)
        if post.status != "OPEN":
            return error_response("Post is not open", status=status.HTTP_400_BAD_REQUEST)
        if post.creator == request.user:
            return error_response("Cannot apply to own post", status=status.HTTP_400_BAD_REQUEST)

        from apps.matching.services.matcher import MatcherService

        if post.type == "OFFER":
            match = MatcherService.create_match(mentor=post.creator, mentee=request.user, offer=post, request_obj=None)
        else:
            match = MatcherService.create_match(mentor=request.user, mentee=post.creator, offer=None, request_obj=post)

        if post.type == "OFFER":
            from apps.mentoring.repositories import MentorshipPostRepository as MPR
            related_posts = MentorshipPost.objects.filter(creator=request.user, type="REQUEST", status="OPEN")
        else:
            related_posts = MentorshipPost.objects.filter(creator=post.creator, type="OFFER", status="OPEN")

        return success_response(
            {
                "match_id": str(match.id),
                "match_created": True,
                "score": match.compatibility_score,
            },
            "Match created",
            status.HTTP_201_CREATED,
        )
