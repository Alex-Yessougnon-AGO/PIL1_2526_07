from collections import OrderedDict

from rest_framework.response import Response


def success_response(data=None, message="Operation successful", status=200):
    return Response(
        OrderedDict(
            [
                ("success", True),
                ("message", message),
                ("data", data),
            ]
        ),
        status=status,
    )


def error_response(message="Operation failed", errors=None, status=400):
    return Response(
        OrderedDict(
            [
                ("success", False),
                ("message", message),
                ("errors", errors or {}),
            ]
        ),
        status=status,
    )
