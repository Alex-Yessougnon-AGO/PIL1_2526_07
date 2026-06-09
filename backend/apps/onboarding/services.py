from apps.onboarding.repositories import OnboardingProfileRepository, OnboardingSkillRepository, VerificationRepository


class OnboardingService:
    @staticmethod
    def save_academic_info(user, track, level):
        return OnboardingProfileRepository.update_academic_info(user, track, level)

    @staticmethod
    def save_skills(user, masteries=None, needs=None):
        from apps.profiles.repositories import ProfileRepository

        profile = ProfileRepository.get_or_create(user)
        OnboardingSkillRepository.clear_user_skills(profile)

        results = {"masteries": [], "needs": []}

        for skill_name in (masteries or []):
            skill = OnboardingSkillRepository.get_or_create_skill(skill_name)
            us, created = OnboardingSkillRepository.add_skill(profile, skill, "STRENGTH")
            results["masteries"].append(skill.name)

        for skill_name in (needs or []):
            skill = OnboardingSkillRepository.get_or_create_skill(skill_name)
            us, created = OnboardingSkillRepository.add_skill(profile, skill, "WEAKNESS")
            results["needs"].append(skill.name)

        return results

    @staticmethod
    def upload_verification(user, file):
        return VerificationRepository.create_or_update(user, file)

    @staticmethod
    def get_verification_document(user):
        """Return the full VerificationDocument object."""
        return VerificationRepository.get_document(user)
