from django.contrib.auth.hashers import make_password
from rest_framework_simplejwt.tokens import RefreshToken

from apps.accounts.models import User
from apps.accounts.repositories import UserRepository


class AuthService:
    @staticmethod
    def register(first_name, last_name, email, password, phone=None) -> dict:
        user = User.objects.create(
            first_name=first_name,
            last_name=last_name,
            email=email,
            phone=phone,
            password=make_password(password),
        )
        refresh = RefreshToken.for_user(user)
        return {
            "user_id": str(user.id),
            "access": str(refresh.access_token),
            "refresh": str(refresh),
        }

    @staticmethod
    def login(identifier: str, password: str) -> dict | None:
        user = UserRepository.get_by_identifier(identifier)
        if not user or not user.check_password(password):
            return None
        refresh = RefreshToken.for_user(user)
        from apps.accounts.serializers import UserSerializer
        return {
            "access": str(refresh.access_token),
            "refresh": str(refresh),
            "user": UserSerializer(user).data,
        }

    @staticmethod
    def refresh_token(refresh_str: str) -> dict:
        refresh = RefreshToken(refresh_str)
        return {
            "access": str(refresh.access_token),
            "refresh": str(refresh),
        }
