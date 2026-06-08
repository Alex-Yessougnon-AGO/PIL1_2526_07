from django.urls import path

from apps.mentoring.api.views import PostApplyView, PostDetailView, PostListCreateView

urlpatterns = [
    path("posts", PostListCreateView.as_view(), name="post-list-create"),
    path("posts/<uuid:pk>", PostDetailView.as_view(), name="post-detail"),
    path("posts/<uuid:pk>/apply", PostApplyView.as_view(), name="post-apply"),
]
