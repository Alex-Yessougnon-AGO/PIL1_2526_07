import pytest
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APIClient

from apps.accounts.models import User


@pytest.fixture
def api_client():
    return APIClient()


def create_user(client, i=1):
    data = {"first_name": f"User{i}", "last_name": "Test", "email": f"chatuser{i}@example.com", "password": "testpass123"}
    reg = client.post(reverse("register"), data, format="json")
    token = reg.json()["data"]["access"]
    return token, User.objects.get(email=f"chatuser{i}@example.com")


@pytest.mark.django_db
class TestChat:
    def test_create_conversation(self, api_client):
        token1, user1 = create_user(api_client, 1)
        token2, user2 = create_user(api_client, 2)

        api_client.credentials(HTTP_AUTHORIZATION=f"Bearer {token1}")
        response = api_client.post(
            reverse("conversation-list-create"),
            {"user_id": str(user2.id)},
            format="json",
        )
        assert response.status_code == status.HTTP_201_CREATED
        assert "conversation_id" in response.json()["data"]

    def test_list_conversations(self, api_client):
        token1, user1 = create_user(api_client, 1)
        token2, user2 = create_user(api_client, 2)

        api_client.credentials(HTTP_AUTHORIZATION=f"Bearer {token1}")
        api_client.post(
            reverse("conversation-list-create"),
            {"user_id": str(user2.id)},
            format="json",
        )
        response = api_client.get(reverse("conversation-list-create"))
        assert response.status_code == status.HTTP_200_OK
        assert response.json()["count"] >= 1

    def test_send_message(self, api_client):
        token1, user1 = create_user(api_client, 1)
        token2, user2 = create_user(api_client, 2)

        api_client.credentials(HTTP_AUTHORIZATION=f"Bearer {token1}")
        conv_resp = api_client.post(
            reverse("conversation-list-create"),
            {"user_id": str(user2.id)},
            format="json",
        )
        conv_id = conv_resp.json()["data"]["conversation_id"]

        response = api_client.post(
            reverse("message-list-create"),
            {"conversation_id": conv_id, "content": "Hello!"},
            format="json",
        )
        assert response.status_code == status.HTTP_201_CREATED
        assert response.json()["data"]["content"] == "Hello!"

    def test_get_messages(self, api_client):
        token1, user1 = create_user(api_client, 1)
        token2, user2 = create_user(api_client, 2)

        api_client.credentials(HTTP_AUTHORIZATION=f"Bearer {token1}")
        conv_resp = api_client.post(
            reverse("conversation-list-create"),
            {"user_id": str(user2.id)},
            format="json",
        )
        conv_id = conv_resp.json()["data"]["conversation_id"]

        api_client.post(
            reverse("message-list-create"),
            {"conversation_id": conv_id, "content": "Hello!"},
            format="json",
        )
        response = api_client.get(
            reverse("message-list-create"),
            {"conversation": conv_id},
            format="json",
        )
        assert response.status_code == status.HTTP_200_OK
        assert response.json()["count"] >= 1

    def test_forbidden_access_conversation(self, api_client):
        token1, user1 = create_user(api_client, 1)
        token2, user2 = create_user(api_client, 2)
        token3, user3 = create_user(api_client, 3)

        api_client.credentials(HTTP_AUTHORIZATION=f"Bearer {token1}")
        conv_resp = api_client.post(
            reverse("conversation-list-create"),
            {"user_id": str(user2.id)},
            format="json",
        )
        conv_id = conv_resp.json()["data"]["conversation_id"]

        api_client.credentials(HTTP_AUTHORIZATION=f"Bearer {token3}")
        response = api_client.get(
            reverse("conversation-detail", kwargs={"pk": conv_id}),
            format="json",
        )
        assert response.status_code == status.HTTP_403_FORBIDDEN
