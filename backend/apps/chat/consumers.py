import json

from channels.db import database_sync_to_async
from channels.generic.websocket import AsyncWebsocketConsumer

from apps.chat.models import Conversation, Message
from apps.chat.repositories import ConversationRepository, MessageRepository


class ChatConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.conversation_id = self.scope["url_route"]["kwargs"]["conversation_id"]
        self.user = self.scope["user"]

        if not self.user.is_authenticated:
            await self.close()
            return

        conv = await self._get_conversation()
        if not conv or not await self._is_member(conv):
            await self.close()
            return

        self.room_group_name = f"chat_{self.conversation_id}"

        await self.channel_layer.group_add(self.room_group_name, self.channel_name)
        await self.accept()

    async def disconnect(self, close_code):
        await self.channel_layer.group_discard(self.room_group_name, self.channel_name)

    async def receive(self, text_data):
        data = json.loads(text_data)
        msg_type = data.get("type")

        if msg_type == "SEND_MESSAGE":
            content = data.get("content", "").strip()
            if not content:
                return

            msg = await self._save_message(content)
            await self.channel_layer.group_send(
                self.room_group_name,
                {
                    "type": "chat.message",
                    "event": "MESSAGE_RECEIVED",
                    "message": {
                        "id": str(msg.id),
                        "conversation_id": str(msg.conversation_id),
                        "sender_id": str(msg.sender_id),
                        "content": msg.content,
                        "created_at": msg.created_at.isoformat(),
                    },
                },
            )

        elif msg_type == "TYPING":
            await self.channel_layer.group_send(
                self.room_group_name,
                {
                    "type": "chat.typing",
                    "event": "TYPING",
                    "user_id": str(self.user.id),
                    "user_name": f"{self.user.first_name} {self.user.last_name}",
                },
            )

        elif msg_type == "READ":
            await self._mark_read()
            await self.channel_layer.group_send(
                self.room_group_name,
                {
                    "type": "chat.read",
                    "event": "READ",
                    "user_id": str(self.user.id),
                },
            )

    async def chat_message(self, event):
        await self.send(text_data=json.dumps(event))

    async def chat_typing(self, event):
        await self.send(text_data=json.dumps(event))

    async def chat_read(self, event):
        await self.send(text_data=json.dumps(event))

    @database_sync_to_async
    def _get_conversation(self):
        return ConversationRepository.get_by_id(self.conversation_id)

    @database_sync_to_async
    def _is_member(self, conv):
        return ConversationRepository.is_member(conv, self.user)

    @database_sync_to_async
    def _save_message(self, content):
        from django.utils import timezone
        from apps.chat.models import Conversation, ConversationMember
        from apps.notifications.models import Notification

        conv = Conversation.objects.get(id=self.conversation_id)
        msg = MessageRepository.create(conv, self.user, content)

        # Create notification for other conversation members
        other_members = ConversationMember.objects.filter(conversation=conv).exclude(user=self.user)
        for member in other_members:
            Notification.objects.create(
                user=member.user,
                type="NEW_MESSAGE",
                title=f"Nouveau message de {self.user.first_name} {self.user.last_name}",
                content=content[:200],
                metadata={"conversation_id": str(conv.id), "sender_id": str(self.user.id)},
            )

        return msg

    @database_sync_to_async
    def _mark_read(self):
        from django.utils import timezone
        Message.objects.filter(
            conversation_id=self.conversation_id,
            read_at__isnull=True,
        ).exclude(
            sender_id=self.user.id,
        ).update(read_at=timezone.now())
