import pytest
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APIClient

from apps.accounts.models import User


@pytest.fixture
def api_client():
    return APIClient()


@pytest.fixture
def user_data():
    return {
        "first_name": "John",
        "last_name": "Doe",
        "email": "john@example.com",
        "password": "testpass123",
        "phone": "+2250101020304",
    }


@pytest.mark.django_db
class TestAuth:
    def test_register_success(self, api_client, user_data):
        response = api_client.post(reverse("register"), user_data, format="json")
        assert response.status_code == status.HTTP_201_CREATED
        data = response.json()
        assert data["success"] is True
        assert "access" in data["data"]
        assert "refresh" in data["data"]
        assert "user_id" in data["data"]
        assert User.objects.count() == 1

    def test_register_duplicate_email(self, api_client, user_data):
        api_client.post(reverse("register"), user_data, format="json")
        response = api_client.post(reverse("register"), user_data, format="json")
        assert response.status_code == status.HTTP_400_BAD_REQUEST
        assert response.json()["success"] is False

    def test_login_success(self, api_client, user_data):
        api_client.post(reverse("register"), user_data, format="json")
        response = api_client.post(
            reverse("login"), {"identifier": "john@example.com", "password": "testpass123"}, format="json"
        )
        assert response.status_code == status.HTTP_200_OK
        assert response.json()["data"]["access"] is not None

    def test_login_invalid_credentials(self, api_client, user_data):
        api_client.post(reverse("register"), user_data, format="json")
        response = api_client.post(
            reverse("login"), {"identifier": "john@example.com", "password": "wrong"}, format="json"
        )
        assert response.status_code == status.HTTP_401_UNAUTHORIZED

    def test_refresh_token(self, api_client, user_data):
        reg = api_client.post(reverse("register"), user_data, format="json")
        refresh_token = reg.json()["data"]["refresh"]
        response = api_client.post(reverse("refresh"), {"refresh": refresh_token}, format="json")
        assert response.status_code == status.HTTP_200_OK
        assert "access" in response.json()["data"]
