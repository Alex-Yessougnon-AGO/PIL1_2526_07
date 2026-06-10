from django.urls import path

from apps.accounts.api.views import AuthViewSet

urlpatterns = [
    path("register", AuthViewSet.as_view({"post": "register"}), name="register"),
    path("verify-email", AuthViewSet.as_view({"post": "verify_email", "get": "verify_email"}), name="verify-email"),
    path("login", AuthViewSet.as_view({"post": "login"}), name="login"),
    path("refresh", AuthViewSet.as_view({"post": "refresh"}), name="refresh"),
    path("logout", AuthViewSet.as_view({"post": "logout"}), name="logout"),
    path("request-reset", AuthViewSet.as_view({"post": "request_reset"}), name="request-reset"),
    path("change-password", AuthViewSet.as_view({"post": "change_password"}), name="change-password"),
    path("reset-password", AuthViewSet.as_view({"post": "reset_password"}), name="reset-password"),
]
