from django.contrib import admin
from django.urls import include, path
from drf_spectacular.views import SpectacularAPIView, SpectacularSwaggerView

urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/v1/auth/", include("apps.accounts.api.urls")),
    path("api/v1/", include("apps.profiles.api.urls")),
    path("api/v1/", include("apps.onboarding.api.urls")),
    path("api/v1/", include("apps.mentoring.api.urls")),
    path("api/v1/", include("apps.matching.urls")),
    path("api/v1/", include("apps.chat.api.urls")),
    path("api/v1/", include("apps.notifications.api.urls")),
    path("api/v1/", include("apps.analytics.urls")),
    path("api/schema/", SpectacularAPIView.as_view(), name="schema"),
    path("api/docs/", SpectacularSwaggerView.as_view(url_name="schema"), name="swagger-ui"),
]
