from django.urls import path

from apps.profiles.api.views import (
    AddAvailabilityView,
    AddSkillView,
    MyProposalsView,
    ProfileDetailView,
    ProfilePhotoView,
    ProfileStatsView,
    PublicProfileStatsView,
    PublicProfileView,
    PublicReviewsView,
    RemoveAvailabilityView,
    RemoveSkillView,
)

urlpatterns = [
    path("me", ProfileDetailView.as_view(), name="profile-detail"),
    path("me/stats", ProfileStatsView.as_view(), name="profile-stats"),
    path("me/proposals", MyProposalsView.as_view(), name="my-proposals"),
    path("me/photo", ProfilePhotoView.as_view(), name="profile-photo"),
    path("me/skills", AddSkillView.as_view(), name="add-skill"),
    path("me/skills/<uuid:pk>", RemoveSkillView.as_view(), name="remove-skill"),
    path("me/availability", AddAvailabilityView.as_view(), name="add-availability"),
    path("me/availability/<uuid:pk>", RemoveAvailabilityView.as_view(), name="remove-availability"),
    path("profiles/<uuid:pk>", PublicProfileView.as_view(), name="public-profile"),
    path("profiles/<uuid:pk>/stats", PublicProfileStatsView.as_view(), name="public-profile-stats"),
    path("profiles/<uuid:pk>/reviews", PublicReviewsView.as_view(), name="public-profile-reviews"),
]
