from django.urls import path

from apps.notifications.api.views import MarkReadView, NotificationListView

urlpatterns = [
    path("notifications", NotificationListView.as_view(), name="notification-list"),
    path("notifications/read", MarkReadView.as_view(), name="notification-read"),
]
