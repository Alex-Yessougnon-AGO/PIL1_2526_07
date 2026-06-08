import pytest
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APIClient

from apps.accounts.models import User


@pytest.fixture
def api_client():
    return APIClient()


@pytest.fixture
def authed_client(api_client):
    data = {"first_name": "Jane", "last_name": "Doe", "email": "jane@example.com", "password": "testpass123"}
    reg = api_client.post(reverse("register"), data, format="json")
    token = reg.json()["data"]["access"]
    api_client.credentials(HTTP_AUTHORIZATION=f"Bearer {token}")
    return api_client, User.objects.get(email="jane@example.com")


@pytest.mark.django_db
class TestProfile:
    def test_get_profile(self, authed_client):
        client, user = authed_client
        response = client.get(reverse("profile-detail"))
        assert response.status_code == status.HTTP_200_OK
        assert response.json()["success"] is True

    def test_update_profile(self, authed_client):
        client, user = authed_client
        response = client.patch(reverse("profile-detail"), {"bio": "Hello!", "department": "Informatique"}, format="json")
        assert response.status_code == status.HTTP_200_OK
        assert response.json()["data"]["bio"] == "Hello!"

    def test_add_skill(self, authed_client):
        client, user = authed_client
        response = client.post(reverse("add-skill"), {"name": "Python", "type": "STRENGTH"}, format="json")
        assert response.status_code == status.HTTP_201_CREATED
        assert response.json()["data"]["skill_name"] == "Python"

    def test_add_availability(self, authed_client):
        client, user = authed_client
        response = client.post(
            reverse("add-availability"), {"day": "MONDAY", "start": "09:00", "end": "11:00"}, format="json"
        )
        assert response.status_code == status.HTTP_201_CREATED

    def test_add_then_remove_skill(self, authed_client):
        client, user = authed_client
        add = client.post(reverse("add-skill"), {"name": "Django", "type": "STRENGTH"}, format="json")
        skill_id = add.json()["data"]["id"]
        response = client.delete(reverse("remove-skill", kwargs={"pk": skill_id}))
        assert response.status_code == status.HTTP_200_OK
