import pytest
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APIClient

from apps.accounts.models import User
from apps.mentoring.models import MentorshipPost
from apps.notifications.models import Notification


@pytest.fixture
def api_client():
    return APIClient()


def create_user_and_login(client):
    data = {"first_name": "Analytics", "last_name": "User", "email": "analytics@example.com", "password": "testpass123"}
    reg = client.post(reverse("register"), data, format="json")
    token = reg.json()["data"]["access"]
    return token, User.objects.get(email="analytics@example.com")


@pytest.mark.django_db
class TestAnalytics:
    def test_dashboard(self, api_client):
        token, user = create_user_and_login(api_client)

        MentorshipPost.objects.create(creator=user, type="OFFER", subject="Test Offer")
        Notification.objects.create(user=user, type="NEW_MATCH", title="Test", content="Content")

        api_client.credentials(HTTP_AUTHORIZATION=f"Bearer {token}")
        response = api_client.get(reverse("analytics-dashboard"))
        assert response.status_code == status.HTTP_200_OK
        assert response.json()["success"] is True
        data = response.json()["data"]
        assert data["posts_count"] == 1
        assert data["active_posts"] == 1
        assert data["unread_notifications"] == 1

    def test_dashboard_empty(self, api_client):
        token, user = create_user_and_login(api_client)

        api_client.credentials(HTTP_AUTHORIZATION=f"Bearer {token}")
        response = api_client.get(reverse("analytics-dashboard"))
        assert response.status_code == status.HTTP_200_OK
        data = response.json()["data"]
        assert data["posts_count"] == 0
        assert data["matches"] == 0
        assert data["unread_notifications"] == 0
