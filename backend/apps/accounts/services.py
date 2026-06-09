from django.contrib.auth.hashers import make_password
from django.core.cache import cache
from django.utils.crypto import get_random_string
from rest_framework_simplejwt.tokens import RefreshToken

from apps.accounts.models import User
from apps.accounts.repositories import UserRepository
from apps.onboarding.tasks import send_verification_email


class AuthService:
    @staticmethod
    def register(first_name, last_name, email, password, phone=None, terms_accepted=False) -> dict:
        user = User.objects.create(
            first_name=first_name,
            last_name=last_name,
            email=email,
            phone=phone,
            password=make_password(password),
        )

        # Generate email verification token (24h expiry)
        token = get_random_string(64)
        cache.set(f"email_verify_{token}", str(user.id), timeout=86400)

        # Enqueue email verification task
        send_verification_email.delay(
            user_id=str(user.id),
            token=token,
            email=email,
            first_name=first_name,
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
