from django.urls import path

from apps.profiles.api.views import (
    AddAvailabilityView,
    AddSkillView,
    ProfileDetailView,
    ProfilePhotoView,
    RemoveAvailabilityView,
    RemoveSkillView,
)

urlpatterns = [
    path("me", ProfileDetailView.as_view(), name="profile-detail"),
    path("me/photo", ProfilePhotoView.as_view(), name="profile-photo"),
    path("me/skills", AddSkillView.as_view(), name="add-skill"),
    path("me/skills/<uuid:pk>", RemoveSkillView.as_view(), name="remove-skill"),
    path("me/availability", AddAvailabilityView.as_view(), name="add-availability"),
    path("me/availability/<uuid:pk>", RemoveAvailabilityView.as_view(), name="remove-availability"),
]
