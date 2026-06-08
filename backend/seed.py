#!/usr/bin/env python
"""Seed script for MentorLink development database."""

import os
import sys
from datetime import time

import django

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "config.settings")

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
django.setup()

from django.contrib.auth.hashers import make_password

from apps.accounts.models import User
from apps.notifications.models import Notification
from apps.profiles.models import AvailabilitySlot, Profile, Skill, UserSkill


def seed():
    print("Seeding database...")

    # Skills
    skills_data = [
        ("Python", "Programming"),
        ("JavaScript", "Programming"),
        ("Java", "Programming"),
        ("SQL", "Data"),
        ("Algorithmics", "Computer Science"),
        ("Data Structures", "Computer Science"),
        ("Mathematics", "Science"),
        ("Physics", "Science"),
        ("Machine Learning", "AI"),
        ("Web Development", "Programming"),
        ("Mobile Development", "Programming"),
        ("Database Design", "Data"),
        ("Networking", "IT"),
        ("Cybersecurity", "IT"),
        ("UI/UX Design", "Design"),
    ]
    skills = {}
    for name, cat in skills_data:
        s, _ = Skill.objects.get_or_create(name=name)
        skills[name] = s
    print(f"  Created {Skill.objects.count()} skills")

    # Users
    users_data = [
        {"email": "alice@example.com", "first_name": "Alice", "last_name": "Konan", "password": "password123", "department": "Informatique", "level": "M2", "bio": "Senior developer passionate about teaching"},
        {"email": "bob@example.com", "first_name": "Bob", "last_name": "Kouassi", "password": "password123", "department": "Informatique", "level": "L3", "bio": "Looking to improve my programming skills"},
        {"email": "carol@example.com", "first_name": "Carol", "last_name": "Diallo", "password": "password123", "department": "Mathematiques", "level": "M1", "bio": "Math tutor available for mentoring"},
        {"email": "dave@example.com", "first_name": "Dave", "last_name": "Traore", "password": "password123", "department": "Informatique", "level": "L2", "bio": "Want to learn web development"},
        {"email": "eve@example.com", "first_name": "Eve", "last_name": "NGuessan", "password": "password123", "department": "Physique", "level": "M2", "bio": "Physics researcher offering mentorship"},
    ]

    for ud in users_data:
        user, created = User.objects.get_or_create(
            email=ud["email"],
            defaults={
                "first_name": ud["first_name"],
                "last_name": ud["last_name"],
                "password": make_password(ud["password"]),
                "is_verified": True,
            },
        )
        if created:
            profile, _ = Profile.objects.get_or_create(user=user)
            profile.department = ud["department"]
            profile.academic_level = ud["level"]
            profile.bio = ud["bio"]
            profile.save()
    print(f"  Created/verified {User.objects.count()} users")

    # User skills
    us_data = [
        ("alice@example.com", ["Python", "Java", "Web Development"], ["Algorithmics"]),
        ("bob@example.com", [], ["Python", "JavaScript", "Web Development"]),
        ("carol@example.com", ["Mathematics", "Physics", "Data Structures"], []),
        ("dave@example.com", [], ["Python", "Web Development", "Database Design"]),
        ("eve@example.com", ["Physics", "Mathematics", "Machine Learning"], []),
    ]

    count = 0
    for email, strengths, weaknesses in us_data:
        user = User.objects.get(email=email)
        profile = Profile.objects.get(user=user)
        for s_name in strengths:
            UserSkill.objects.get_or_create(profile=profile, skill=skills[s_name], defaults={"type": "STRENGTH"})
            count += 1
        for w_name in weaknesses:
            UserSkill.objects.get_or_create(profile=profile, skill=skills[w_name], defaults={"type": "WEAKNESS"})
            count += 1
    print(f"  Created {count} user skills")

    # Availability
    availability_data = [
        ("alice@example.com", "MONDAY", time(9, 0), time(12, 0)),
        ("alice@example.com", "WEDNESDAY", time(14, 0), time(17, 0)),
        ("bob@example.com", "MONDAY", time(10, 0), time(12, 0)),
        ("bob@example.com", "TUESDAY", time(14, 0), time(16, 0)),
        ("carol@example.com", "TUESDAY", time(9, 0), time(12, 0)),
        ("carol@example.com", "THURSDAY", time(15, 0), time(17, 0)),
        ("dave@example.com", "WEDNESDAY", time(9, 0), time(11, 0)),
        ("dave@example.com", "FRIDAY", time(14, 0), time(16, 0)),
        ("eve@example.com", "MONDAY", time(13, 0), time(15, 0)),
        ("eve@example.com", "FRIDAY", time(9, 0), time(12, 0)),
    ]
    for email, day, start, end in availability_data:
        user = User.objects.get(email=email)
        profile = Profile.objects.get(user=user)
        AvailabilitySlot.objects.get_or_create(profile=profile, day_of_week=day, start_time=start, end_time=end)
    print(f"  Created {AvailabilitySlot.objects.count()} availability slots")

    # Posts
    from apps.mentoring.models import MentorshipPost
    posts_data = [
        ("alice@example.com", "OFFER", "Python Mentoring for Beginners", "I can help you learn Python from scratch", "ONLINE"),
        ("carol@example.com", "OFFER", "Mathematics Tutoring", "Available for math tutoring up to M1 level", "BOTH"),
        ("eve@example.com", "OFFER", "Physics & ML Mentorship", "Help with physics and machine learning", "ONLINE"),
        ("bob@example.com", "REQUEST", "Looking for Python Mentor", "Need help with Python and algorithms", "ONLINE"),
        ("dave@example.com", "REQUEST", "Web Development Help", "Looking for guidance on web dev projects", "PHYSICAL"),
    ]
    for email, ptype, subject, desc, fmt in posts_data:
        user = User.objects.get(email=email)
        MentorshipPost.objects.get_or_create(
            creator=user, type=ptype, subject=subject,
            defaults={"description": desc, "format": fmt}
        )
    print(f"  Created {MentorshipPost.objects.count()} posts")

    # Make matches
    from apps.mentoring.models import Match
    alice = User.objects.get(email="alice@example.com")
    bob = User.objects.get(email="bob@example.com")
    offer = MentorshipPost.objects.filter(creator=alice, type="OFFER").first()
    request = MentorshipPost.objects.filter(creator=bob, type="REQUEST").first()
    if offer and request:
        Match.objects.get_or_create(
            mentor=alice, mentee=bob, offer=offer, request=request,
            defaults={"compatibility_score": 85.5, "status": "PENDING"}
        )
    print(f"  Created {Match.objects.count()} matches")

    # Notifications
    for user in User.objects.all()[:3]:
        Notification.objects.get_or_create(
            user=user, type="NEW_MATCH", title="New Match Found",
            defaults={"content": "A potential mentor match has been found for you."}
        )
    print(f"  Created {Notification.objects.count()} notifications")

    print("\nDatabase seeded successfully!")


if __name__ == "__main__":
    seed()
