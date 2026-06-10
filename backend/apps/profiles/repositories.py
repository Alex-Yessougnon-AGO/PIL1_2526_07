from django.db import models

from apps.profiles.models import AvailabilitySlot, Profile, Skill, UserSkill


class ProfileRepository:
    @staticmethod
    def get_by_user(user):
        return Profile.objects.filter(user=user).first()

    @staticmethod
    def get_or_create(user):
        profile, _ = Profile.objects.get_or_create(user=user)
        return profile

    @staticmethod
    def get_all_profiles(department=None, academic_level=None):
        qs = Profile.objects.filter(deleted_at__isnull=True).select_related("user")
        if department:
            qs = qs.filter(department=department)
        if academic_level:
            qs = qs.filter(academic_level=academic_level)
        return qs


class SkillRepository:
    @staticmethod
    def get_or_create(name: str) -> Skill:
        skill, _ = Skill.objects.get_or_create(name__iexact=name, defaults={"name": name})
        return skill


class UserSkillRepository:
    @staticmethod
    def add_skill(profile, skill, skill_type: str) -> UserSkill:
        return UserSkill.objects.create(profile=profile, skill=skill, type=skill_type)

    @staticmethod
    def remove_skill(us_id):
        us = UserSkill.objects.filter(id=us_id, deleted_at__isnull=True).first()
        if us:
            us.soft_delete()

    @staticmethod
    def get_profile_skills(profile):
        return UserSkill.objects.filter(profile=profile, deleted_at__isnull=True).select_related("skill")

    @staticmethod
    def delete_all_profile_skills(profile):
        UserSkill.objects.filter(profile=profile).delete()


class AvailabilityRepository:
    @staticmethod
    def add_slot(profile, day_of_week, start_time, end_time):
        return AvailabilitySlot.objects.create(profile=profile, day_of_week=day_of_week, start_time=start_time, end_time=end_time)

    @staticmethod
    def remove_slot(slot_id):
        slot = AvailabilitySlot.objects.filter(id=slot_id, deleted_at__isnull=True).first()
        if slot:
            slot.soft_delete()

    @staticmethod
    def get_profile_slots(profile):
        return AvailabilitySlot.objects.filter(profile=profile, deleted_at__isnull=True)
