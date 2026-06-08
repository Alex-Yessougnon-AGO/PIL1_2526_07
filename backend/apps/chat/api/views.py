from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView

from apps.chat.repositories import ConversationRepository, MessageRepository
from apps.chat.serializers import (
    ConversationSerializer,
    CreateConversationSerializer,
    MessageSerializer,
    SendMessageSerializer,
)
from apps.common.pagination import StandardPagination
from apps.common.responses import error_response, success_response


class ConversationListCreateView(APIView, StandardPagination):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        convs = ConversationRepository.get_for_user(request.user)
        page = self.paginate_queryset(convs, request)
        if page is not None:
            serializer = ConversationSerializer(page, many=True)
            return self.get_paginated_response(serializer.data)
        serializer = ConversationSerializer(convs, many=True)
        return success_response(serializer.data)

    def post(self, request):
        serializer = CreateConversationSerializer(data=request.data)
        if not serializer.is_valid():
            return error_response("Validation failed", serializer.errors, status.HTTP_400_BAD_REQUEST)

        from apps.accounts.repositories import UserRepository

        other_user = UserRepository.get_by_id(serializer.validated_data["user_id"])
        if not other_user:
            return error_response("User not found", status=status.HTTP_404_NOT_FOUND)
        if other_user == request.user:
            return error_response("Cannot create conversation with yourself", status=status.HTTP_400_BAD_REQUEST)

        conv = ConversationRepository.create(request.user, other_user)
        return success_response(
            {"conversation_id": str(conv.id), "data": ConversationSerializer(conv).data},
            "Conversation created",
            status.HTTP_201_CREATED,
        )


class ConversationDetailView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, pk):
        conv = ConversationRepository.get_by_id(pk)
        if not conv:
            return error_response("Conversation not found", status=status.HTTP_404_NOT_FOUND)
        if not ConversationRepository.is_member(conv, request.user):
            return error_response("Forbidden", status=status.HTTP_403_FORBIDDEN)

        return success_response(ConversationSerializer(conv).data)


class MessageListView(APIView, StandardPagination):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        conv_id = request.query_params.get("conversation")
        if not conv_id:
            return error_response("conversation query param required", status=status.HTTP_400_BAD_REQUEST)

        conv = ConversationRepository.get_by_id(conv_id)
        if not conv:
            return error_response("Conversation not found", status=status.HTTP_404_NOT_FOUND)
        if not ConversationRepository.is_member(conv, request.user):
            return error_response("Forbidden", status=status.HTTP_403_FORBIDDEN)

        messages = MessageRepository.get_for_conversation(conv_id)
        page = self.paginate_queryset(messages, request)
        if page is not None:
            serializer = MessageSerializer(page, many=True)
            return self.get_paginated_response(serializer.data)
        serializer = MessageSerializer(messages, many=True)
        return success_response(serializer.data)

    def post(self, request):
        serializer = SendMessageSerializer(data=request.data)
        if not serializer.is_valid():
            return error_response("Validation failed", serializer.errors, status.HTTP_400_BAD_REQUEST)

        conv = ConversationRepository.get_by_id(serializer.validated_data["conversation_id"])
        if not conv:
            return error_response("Conversation not found", status=status.HTTP_404_NOT_FOUND)
        if not ConversationRepository.is_member(conv, request.user):
            return error_response("Forbidden", status=status.HTTP_403_FORBIDDEN)

        msg = MessageRepository.create(conv, request.user, serializer.validated_data["content"])
        from apps.chat.serializers import MessageSerializer as MS
        return success_response(MS(msg).data, "Message sent", status.HTTP_201_CREATED)
