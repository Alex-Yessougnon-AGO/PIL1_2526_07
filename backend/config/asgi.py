import logging
import os
from urllib.parse import parse_qsl

from django.core.asgi import get_asgi_application

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "config.settings")
django_asgi_app = get_asgi_application()

from channels.auth import AuthMiddlewareStack
from channels.db import database_sync_to_async
from channels.middleware import BaseMiddleware
from channels.routing import ProtocolTypeRouter, URLRouter
from django.contrib.auth import get_user_model
from django.db import close_old_connections
from rest_framework_simplejwt.tokens import AccessToken

import apps.chat.routing

websocket_urlpatterns = apps.chat.routing.websocket_urlpatterns

from apps.notifications import routing as notifications_routing
websocket_urlpatterns += notifications_routing.websocket_urlpatterns

logger = logging.getLogger(__name__)
User = get_user_model()


class JWTAuthMiddleware(BaseMiddleware):
    """Extract JWT token from query string and authenticate the WebSocket user.

    Must be placed INSIDE AuthMiddlewareStack so it runs after session auth.
    If a valid JWT token is found in the query string, it overrides scope['user'].
    """

    async def __call__(self, scope, receive, send):
        close_old_connections()

        # Extract token from query string using proper URL parsing
        query_string = scope.get("query_string", b"").decode()
        params = dict(parse_qsl(query_string))
        token = params.get("token")

        if token:
            try:
                access_token = AccessToken(token)
                user_id = access_token["user_id"]
                user = await self._get_user(user_id)
                if user and user.is_active:
                    scope["user"] = user
                else:
                    logger.warning("WebSocket JWT auth: user not found or inactive (id=%s)", user_id)
            except Exception as exc:
                logger.warning("WebSocket JWT auth failed: %s", exc)

        return await super().__call__(scope, receive, send)

    @database_sync_to_async
    def _get_user(self, user_id):
        try:
            return User.objects.get(id=user_id)
        except User.DoesNotExist:
            return None


application = ProtocolTypeRouter(
    {
        "http": django_asgi_app,
        "websocket": AuthMiddlewareStack(
            JWTAuthMiddleware(URLRouter(websocket_urlpatterns))
        ),
    }
)
