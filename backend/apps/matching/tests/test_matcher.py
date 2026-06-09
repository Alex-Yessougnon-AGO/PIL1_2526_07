import pytest
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APIClient

from apps.accounts.models import User
from apps.matching.services.matcher import MatcherService
from apps.profiles.models import Profile, Skill, UserSkill


@pytest.fixture
def api_client():
    return APIClient()


def setup_users_and_skills():
    mentor = User.objects.create(email="mentor@test.com", first_name="Mentor", last_name="A")
    mentee = User.objects.create(email="mentee@test.com", first_name="Mentee", last_name="B")

    mentor_profile = Profile.objects.create(user=mentor, department="Informatique", academic_level="M2")
    mentee_profile = Profile.objects.create(user=mentee, department="Informatique", academic_level="M1")

    py = Skill.objects.create(name="Python")
    algo = Skill.objects.create(name="Algorithmics")
    math = Skill.objects.create(name="Mathematics")

    UserSkill.objects.create(profile=mentor_profile, skill=py, type="STRENGTH")
    UserSkill.objects.create(profile=mentor_profile, skill=algo, type="STRENGTH")
    UserSkill.objects.create(profile=mentee_profile, skill=py, type="WEAKNESS")
    UserSkill.objects.create(profile=mentee_profile, skill=math, type="WEAKNESS")

    return mentor, mentee, mentor_profile, mentee_profile


@pytest.mark.django_db
class TestMatcher:
    def test_skill_score_exact_match(self):
        mentor, mentee, _, _ = setup_users_and_skills()
        result = MatcherService.compute_match_score(mentor, mentee)
        assert result["skill_score"] > 0

    def test_compute_total_score(self):
        mentor, mentee, _, _ = setup_users_and_skills()
        result = MatcherService.compute_match_score(mentor, mentee)
        assert 0 <= result["score"] <= 100

    def test_create_match(self):
        mentor, mentee, _, _ = setup_users_and_skills()
        match = MatcherService.create_match(mentor, mentee)
        assert match.mentor == mentor
        assert match.mentee == mentee
        assert match.compatibility_score > 0

    def test_department_score_same(self):
        mentor, mentee, _, _ = setup_users_and_skills()
        score = MatcherService.compute_department_score(mentor, mentee)
        assert score == 100.0

    def test_level_score_close(self):
        mentor, mentee, _, _ = setup_users_and_skills()
        score = MatcherService.compute_level_score(mentor, mentee)
        assert score == 70.0

    def test_matching_api(self, api_client):
        mentor, mentee, _, _ = setup_users_and_skills()

        reg_data = {"first_name": "Test", "last_name": "User", "email": "test@test.com", "password": "testpass123", "terms_accepted": True}
        reg = api_client.post(reverse("register"), reg_data, format="json")
        token = reg.json()["data"]["access"]

        api_client.credentials(HTTP_AUTHORIZATION=f"Bearer {token}")
        response = api_client.post(reverse("matching-run"))
        # May be empty or have results depending on existing posts
        assert response.status_code == status.HTTP_200_OK
