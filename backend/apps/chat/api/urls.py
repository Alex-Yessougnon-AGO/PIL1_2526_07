from django.urls import path

from apps.chat.api.views import ConversationDetailView, ConversationListCreateView, MessageListView

urlpatterns = [
    path("conversations", ConversationListCreateView.as_view(), name="conversation-list-create"),
    path("conversations/<uuid:pk>", ConversationDetailView.as_view(), name="conversation-detail"),
    path("messages", MessageListView.as_view(), name="message-list-create"),
]
