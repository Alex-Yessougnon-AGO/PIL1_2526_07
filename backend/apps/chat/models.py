import uuid

from django.db import models

from apps.common.models import BaseModel


class Conversation(BaseModel):
    members = models.ManyToManyField("accounts.User", through="ConversationMember", related_name="conversations")

    class Meta:
        db_table = "conversations"
        ordering = ["-created_at"]

    def __str__(self):
        return f"Conversation {self.id}"


class ConversationMember(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    conversation = models.ForeignKey(Conversation, on_delete=models.CASCADE, related_name="membership_set")
    user = models.ForeignKey("accounts.User", on_delete=models.CASCADE, related_name="membership_set")
    joined_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "conversation_members"
        unique_together = ("conversation", "user")

    def __str__(self):
        return f"{self.user.email} in {self.conversation.id}"


class Message(BaseModel):
    conversation = models.ForeignKey(Conversation, on_delete=models.CASCADE, related_name="messages")
    sender = models.ForeignKey("accounts.User", on_delete=models.CASCADE, related_name="messages")
    content = models.TextField()
    read_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        db_table = "messages"
        indexes = [
            models.Index(fields=["conversation", "created_at"]),
            models.Index(fields=["sender"]),
        ]
        ordering = ["created_at"]

    def __str__(self):
        return f"Message from {self.sender.email} in {self.conversation.id}"
