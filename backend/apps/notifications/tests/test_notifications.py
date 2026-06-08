import pytest
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APIClient

from apps.accounts.models import User
from apps.notifications.models import Notification


@pytest.fixture
def api_client():
    return APIClient()


def create_user_and_login(client, i=1):
    data = {"first_name": f"NotifUser{i}", "last_name": "Test", "email": f"notifuser{i}@example.com", "password": "testpass123"}
    reg = client.post(reverse("register"), data, format="json")
    token = reg.json()["data"]["access"]
    return token, User.objects.get(email=f"notifuser{i}@example.com")


@pytest.mark.django_db
class TestNotifications:
    def test_list_notifications(self, api_client):
        token, user = create_user_and_login(api_client)

        Notification.objects.create(user=user, type="NEW_MATCH", title="Test Match", content="You have a new match!")

        api_client.credentials(HTTP_AUTHORIZATION=f"Bearer {token}")
        response = api_client.get(reverse("notification-list"))
        assert response.status_code == status.HTTP_200_OK
        assert response.json()["count"] >= 1
        assert response.json()["results"][0]["title"] == "Test Match"

    def test_mark_notifications_read(self, api_client):
        token, user = create_user_and_login(api_client)

        n1 = Notification.objects.create(user=user, type="NEW_MATCH", title="Match 1", content="Content 1")
        n2 = Notification.objects.create(user=user, type="NEW_MESSAGE", title="Message 1", content="Content 2")

        api_client.credentials(HTTP_AUTHORIZATION=f"Bearer {token}")
        response = api_client.post(
            reverse("notification-read"),
            {"ids": [str(n1.id), str(n2.id)]},
            format="json",
        )
        assert response.status_code == status.HTTP_200_OK
        assert response.json()["data"]["updated"] == 2

        n1.refresh_from_db()
        n2.refresh_from_db()
        assert n1.is_read is True
        assert n2.is_read is True

    def test_list_empty_notifications(self, api_client):
        token, user = create_user_and_login(api_client)

        api_client.credentials(HTTP_AUTHORIZATION=f"Bearer {token}")
        response = api_client.get(reverse("notification-list"))
        assert response.status_code == status.HTTP_200_OK
        assert response.json()["count"] == 0
