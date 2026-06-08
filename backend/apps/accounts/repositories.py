from django.db import models

from apps.accounts.models import User


class UserRepository:
    @staticmethod
    def get_by_id(user_id) -> User | None:
        return User.objects.filter(id=user_id).first()

    @staticmethod
    def get_by_email(email: str) -> User | None:
        return User.objects.filter(email=email).first()

    @staticmethod
    def get_by_identifier(identifier: str) -> User | None:
        return User.objects.filter(models.Q(email=identifier) | models.Q(phone=identifier)).first()

    @staticmethod
    def exists(email: str = None, phone: str = None) -> bool:
        q = models.Q()
        if email:
            q |= models.Q(email=email)
        if phone:
            q |= models.Q(phone=phone)
        return User.objects.filter(q).exists()
