import pytest
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APIClient

from apps.accounts.models import User


@pytest.fixture
def api_client():
    return APIClient()


def create_user(client, i=1):
    data = {"first_name": f"User{i}", "last_name": "Test", "email": f"user{i}@example.com", "password": "testpass123", "terms_accepted": True}
    reg = client.post(reverse("register"), data, format="json")
    token = reg.json()["data"]["access"]
    return token, User.objects.get(email=f"user{i}@example.com")


@pytest.mark.django_db
class TestMentoring:
    def test_create_post(self, api_client):
        token, user = create_user(api_client)
        api_client.credentials(HTTP_AUTHORIZATION=f"Bearer {token}")
        response = api_client.post(
            reverse("post-list-create"),
            {"type": "OFFER", "subject": "Python Mentoring", "description": "Learn Python"},
            format="json",
        )
        assert response.status_code == status.HTTP_201_CREATED
        assert response.json()["data"]["subject"] == "Python Mentoring"

    def test_list_posts(self, api_client):
        token, user = create_user(api_client)
        api_client.credentials(HTTP_AUTHORIZATION=f"Bearer {token}")
        api_client.post(
            reverse("post-list-create"),
            {"type": "OFFER", "subject": "Python Mentoring"},
            format="json",
        )
        response = api_client.get(reverse("post-list-create"))
        assert response.status_code == status.HTTP_200_OK
        assert len(response.json()["results"]) == 1

    def test_apply_to_post(self, api_client):
        token1, user1 = create_user(api_client, 1)
        token2, user2 = create_user(api_client, 2)

        api_client.credentials(HTTP_AUTHORIZATION=f"Bearer {token1}")
        post_resp = api_client.post(
            reverse("post-list-create"),
            {"type": "OFFER", "subject": "Math Mentoring"},
            format="json",
        )
        post_id = post_resp.json()["data"]["id"]

        api_client.credentials(HTTP_AUTHORIZATION=f"Bearer {token2}")
        response = api_client.post(reverse("post-apply", kwargs={"pk": post_id}))
        assert response.status_code == status.HTTP_201_CREATED
        assert response.json()["data"]["match_created"] is True
