from django.contrib.auth.hashers import make_password
from rest_framework import status
from rest_framework.decorators import action
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.viewsets import ViewSet

from apps.accounts.repositories import UserRepository
from apps.accounts.serializers import (
    LoginSerializer,
    RegisterSerializer,
    RequestResetSerializer,
    ResetPasswordSerializer,
    UserSerializer,
)
from apps.accounts.services import AuthService
from apps.common.responses import error_response, success_response


class AuthViewSet(ViewSet):
    permission_classes = [AllowAny]

    @action(detail=False, methods=["post"])
    def register(self, request):
        serializer = RegisterSerializer(data=request.data)
        if not serializer.is_valid():
            return error_response("Validation failed", serializer.errors, status.HTTP_400_BAD_REQUEST)

        result = AuthService.register(**serializer.validated_data)
        return success_response(result, "Registration successful", status.HTTP_201_CREATED)

    @action(detail=False, methods=["post"])
    def login(self, request):
        serializer = LoginSerializer(data=request.data)
        if not serializer.is_valid():
            return error_response("Validation failed", serializer.errors, status.HTTP_400_BAD_REQUEST)

        result = AuthService.login(**serializer.validated_data)
        if not result:
            return error_response("Invalid credentials", status=status.HTTP_401_UNAUTHORIZED)

        return success_response(result, "Login successful")

    @action(detail=False, methods=["post"])
    def refresh(self, request):
        from rest_framework_simplejwt.exceptions import TokenError
        from rest_framework_simplejwt.tokens import RefreshToken

        refresh_str = request.data.get("refresh")
        if not refresh_str:
            return error_response("Refresh token required", status=status.HTTP_400_BAD_REQUEST)
        try:
            refresh = RefreshToken(refresh_str)
            return success_response(
                {
                    "access": str(refresh.access_token),
                    "refresh": str(refresh),
                },
                "Token refreshed",
            )
        except TokenError:
            return error_response("Invalid or expired refresh token", status=status.HTTP_401_UNAUTHORIZED)

    @action(detail=False, methods=["post"])
    def logout(self, request):
        from rest_framework_simplejwt.tokens import RefreshToken

        refresh_str = request.data.get("refresh")
        if refresh_str:
            try:
                RefreshToken(refresh_str).blacklist()
            except Exception:
                pass
        return success_response(None, "Logged out successfully")

    @action(detail=False, methods=["post"])
    def request_reset(self, request):
        serializer = RequestResetSerializer(data=request.data)
        if not serializer.is_valid():
            return error_response("Validation failed", serializer.errors, status.HTTP_400_BAD_REQUEST)

        email = serializer.validated_data["email"]
        user = UserRepository.get_by_email(email)
        if user:
            from django.utils.crypto import get_random_string
            from django.core.cache import cache

            token = get_random_string(32)
            cache.set(f"reset_token_{token}", str(user.id), timeout=3600)
            # In production, send email here

        return success_response(None, "If email exists, reset link sent")

    @action(detail=False, methods=["post"])
    def reset_password(self, request):
        serializer = ResetPasswordSerializer(data=request.data)
        if not serializer.is_valid():
            return error_response("Validation failed", serializer.errors, status.HTTP_400_BAD_REQUEST)

        from django.core.cache import cache

        token = serializer.validated_data["token"]
        user_id = cache.get(f"reset_token_{token}")
        if not user_id:
            return error_response("Invalid or expired token", status=status.HTTP_400_BAD_REQUEST)

        user = UserRepository.get_by_id(user_id)
        if not user:
            return error_response("User not found", status=status.HTTP_404_NOT_FOUND)

        user.password = make_password(serializer.validated_data["new_password"])
        user.save(update_fields=["password"])
        cache.delete(f"reset_token_{token}")
        return success_response(None, "Password reset successfully")
