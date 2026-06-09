from django.urls import path

from apps.onboarding.api.views import (
    AcademicInfoView,
    OnboardingSkillsView,
    VerificationStatusView,
    VerificationUploadView,
)

urlpatterns = [
    path("onboarding/academic", AcademicInfoView.as_view(), name="onboarding-academic"),
    path("onboarding/skills", OnboardingSkillsView.as_view(), name="onboarding-skills"),
    path("onboarding/verification", VerificationUploadView.as_view(), name="onboarding-verification-upload"),
    path("onboarding/verification/status", VerificationStatusView.as_view(), name="onboarding-verification-status"),
]
