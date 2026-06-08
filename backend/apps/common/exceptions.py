from collections import OrderedDict

from rest_framework.views import exception_handler


def custom_exception_handler(exc, context):
    response = exception_handler(exc, context)
    if response is not None:
        detail = response.data
        response.data = OrderedDict(
            [
                ("success", False),
                ("message", "Request failed"),
                ("errors", detail),
            ]
        )
    return response
