from rest_framework.permissions import BasePermission


class IsAuthenticatedOrRegister(BasePermission):
    def has_permission(self, request, view):
        if view.action == "register" or view.action == "login":
            return True
        return request.user and request.user.is_authenticated
