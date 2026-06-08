from django.db.models import Q

from apps.chat.models import Conversation, ConversationMember, Message


class ConversationRepository:
    @staticmethod
    def create(user1, user2) -> Conversation:
        existing = ConversationRepository.find_existing(user1, user2)
        if existing:
            return existing

        conv = Conversation.objects.create()
        ConversationMember.objects.create(conversation=conv, user=user1)
        ConversationMember.objects.create(conversation=conv, user=user2)
        return conv

    @staticmethod
    def find_existing(user1, user2) -> Conversation | None:
        convs1 = set(
            ConversationMember.objects.filter(user=user1).values_list("conversation_id", flat=True)
        )
        convs2 = set(
            ConversationMember.objects.filter(user=user2).values_list("conversation_id", flat=True)
        )
        common = convs1 & convs2
        if common:
            return Conversation.objects.filter(id=list(common)[0]).first()
        return None

    @staticmethod
    def get_for_user(user):
        return Conversation.objects.filter(
            membership_set__user=user, deleted_at__isnull=True
        ).prefetch_related("membership_set__user").distinct()

    @staticmethod
    def get_by_id(conv_id) -> Conversation | None:
        return Conversation.objects.filter(id=conv_id, deleted_at__isnull=True).prefetch_related("membership_set__user").first()

    @staticmethod
    def is_member(conv: Conversation, user) -> bool:
        return ConversationMember.objects.filter(conversation=conv, user=user).exists()


class MessageRepository:
    @staticmethod
    def create(conversation, sender, content) -> Message:
        return Message.objects.create(conversation=conversation, sender=sender, content=content)

    @staticmethod
    def get_for_conversation(conversation_id):
        return Message.objects.filter(
            conversation_id=conversation_id, deleted_at__isnull=True
        ).select_related("sender").order_by("created_at")
