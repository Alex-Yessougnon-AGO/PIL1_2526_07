from rest_framework import serializers

from apps.accounts.serializers import UserSerializer
from apps.chat.models import Conversation, ConversationMember, Message


class ConversationSerializer(serializers.ModelSerializer):
    members = UserSerializer(many=True, read_only=True)
    last_message = serializers.SerializerMethodField()

    class Meta:
        model = Conversation
        fields = ("id", "members", "last_message", "created_at", "updated_at")
        read_only_fields = ("id", "created_at", "updated_at")

    def get_last_message(self, obj):
        msg = obj.messages.order_by("-created_at").first()
        if msg:
            return {"content": msg.content, "sender_id": str(msg.sender_id), "created_at": msg.created_at}
        return None


class MessageSerializer(serializers.ModelSerializer):
    sender = UserSerializer(read_only=True)

    class Meta:
        model = Message
        fields = ("id", "conversation_id", "sender", "sender_id", "content", "read_at", "created_at")
        read_only_fields = ("id", "sender", "read_at", "created_at")


class SendMessageSerializer(serializers.Serializer):
    conversation_id = serializers.UUIDField()
    content = serializers.CharField()


class CreateConversationSerializer(serializers.Serializer):
    user_id = serializers.UUIDField()
