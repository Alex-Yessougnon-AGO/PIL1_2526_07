from django.urls import path

from apps.matching.views import (
    AcceptMatchView,
    MatchingHistoryView,
    MatchingRecommendationsView,
    MatchingRunView,
    RejectMatchView,
)

urlpatterns = [
    path("matching/run", MatchingRunView.as_view(), name="matching-run"),
    path("matching/recommendations", MatchingRecommendationsView.as_view(), name="matching-recommendations"),
    path("matching/history", MatchingHistoryView.as_view(), name="matching-history"),
    path("matching/<uuid:pk>/accept", AcceptMatchView.as_view(), name="matching-accept"),
    path("matching/<uuid:pk>/reject", RejectMatchView.as_view(), name="matching-reject"),
]
