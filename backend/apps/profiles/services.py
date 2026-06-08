from apps.profiles.repositories import ProfileRepository, SkillRepository, UserSkillRepository, AvailabilityRepository


class ProfileService:
    @staticmethod
    def get_or_create(user):
        return ProfileRepository.get_or_create(user)

    @staticmethod
    def update_profile(user, data):
        profile = ProfileRepository.get_or_create(user)
        for key, value in data.items():
            if value is not None and hasattr(profile, key):
                setattr(profile, key, value)
        profile.save(update_fields=data.keys())
        return profile

    @staticmethod
    def add_skill(user, skill_name, skill_type):
        profile = ProfileRepository.get_or_create(user)
        skill = SkillRepository.get_or_create(skill_name)
        return UserSkillRepository.add_skill(profile, skill, skill_type)

    @staticmethod
    def remove_skill(user, skill_id):
        profile = ProfileRepository.get_by_user(user)
        if not profile:
            return
        UserSkillRepository.remove_skill(skill_id)

    @staticmethod
    def add_availability(user, day_of_week, start_time, end_time):
        profile = ProfileRepository.get_or_create(user)
        return AvailabilityRepository.add_slot(profile, day_of_week, start_time, end_time)

    @staticmethod
    def remove_availability(user, slot_id):
        profile = ProfileRepository.get_by_user(user)
        if not profile:
            return
        AvailabilityRepository.remove_slot(slot_id)
