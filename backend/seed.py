#!/usr/bin/env python
"""Enhanced seed script for MentorLink development database."""

import os
import sys
from datetime import datetime, timedelta, time

import django

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "config.settings")

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
django.setup()

from django.contrib.auth.hashers import make_password
from django.utils import timezone as tz

from apps.accounts.models import User
from apps.notifications.models import Notification
from apps.profiles.models import AvailabilitySlot, Profile, Skill, UserSkill
from apps.mentoring.models import MentorshipPost, Match
from apps.chat.models import Conversation, ConversationMember, Message


def seed():
    print("=" * 60)
    print("  MentorLink — Database Seed")
    print("=" * 60)

    # ──────────────────────────────────────────────
    # 1. Skills (20 total)
    # ──────────────────────────────────────────────
    print("\n📚 Skills...")
    skills_data = [
        ("Python", "Programming"),
        ("JavaScript", "Programming"),
        ("TypeScript", "Programming"),
        ("Java", "Programming"),
        ("C/C++", "Programming"),
        ("SQL", "Data"),
        ("Algorithmics", "Computer Science"),
        ("Data Structures", "Computer Science"),
        ("Mathematics", "Science"),
        ("Physics", "Science"),
        ("Machine Learning", "AI"),
        ("Deep Learning", "AI"),
        ("Web Development", "Programming"),
        ("React", "Programming"),
        ("Mobile Development", "Programming"),
        ("Database Design", "Data"),
        ("Networking", "IT"),
        ("Cybersecurity", "IT"),
        ("UI/UX Design", "Design"),
        ("DevOps", "IT"),
    ]
    skills = {}
    for name, cat in skills_data:
        s, _ = Skill.objects.get_or_create(name=name)
        skills[name] = s
    print(f"  ✅ {Skill.objects.count()} skills")

    # ──────────────────────────────────────────────
    # 2. Users & Profiles (10 users)
    # ──────────────────────────────────────────────
    print("\n👤 Users & Profiles...")
    now = tz.now()
    users_data = [
        # Existing 5
        {"email": "alice@example.com",   "first_name": "Alice",   "last_name": "Konan",    "password": "password123", "department": "Informatique",       "level": "M2", "bio": "Senior developer passionate about teaching. I specialize in Python, Java, and web development.", "is_mentor": True, "phone": "+22501010101"},
        {"email": "bob@example.com",     "first_name": "Bob",     "last_name": "Kouassi",   "password": "password123", "department": "Informatique",       "level": "L3", "bio": "Looking to improve my programming skills. Interested in Python and web dev.", "is_mentor": False, "phone": "+22501010102"},
        {"email": "carol@example.com",   "first_name": "Carol",   "last_name": "Diallo",    "password": "password123", "department": "Mathematiques",     "level": "M1", "bio": "Math tutor available for mentoring. Can help with statistics and physics too.", "is_mentor": True, "phone": "+22501010103"},
        {"email": "dave@example.com",    "first_name": "Dave",    "last_name": "Traore",    "password": "password123", "department": "Informatique",       "level": "L2", "bio": "Want to learn web development and Python. Motivated and curious.", "is_mentor": False, "phone": "+22501010104"},
        {"email": "eve@example.com",     "first_name": "Eve",     "last_name": "NGuessan",   "password": "password123", "department": "Physique",          "level": "M2", "bio": "Physics researcher offering mentorship in quantum mechanics and ML.", "is_mentor": True, "phone": "+22501010105"},
        # 5 New users
        {"email": "frank@example.com",   "first_name": "Frank",   "last_name": "Soro",      "password": "password123", "department": "Informatique",       "level": "M1", "bio": "Full-stack developer with 3 years experience. Love React and TypeScript.", "is_mentor": True, "phone": "+22501010106"},
        {"email": "grace@example.com",   "first_name": "Grace",   "last_name": "Koffi",     "password": "password123", "department": "Informatique",       "level": "L3", "bio": "Beginner in programming. Want to learn Java and mobile development.", "is_mentor": False, "phone": "+22501010107"},
        {"email": "henry@example.com",   "first_name": "Henry",   "last_name": "Zadi",      "password": "password123", "department": "Reseaux",           "level": "M2", "bio": "Cybersecurity expert. Can mentor in networking, security, and DevOps.", "is_mentor": True, "phone": "+22501010108"},
        {"email": "iris@example.com",    "first_name": "Iris",    "last_name": "Bamba",     "password": "password123", "department": "Design",            "level": "L3", "bio": "UI/UX designer looking for mentorship in frontend development.", "is_mentor": False, "phone": "+22501010109"},
        {"email": "james@example.com",   "first_name": "James",   "last_name": "Toure",     "password": "password123", "department": "Informatique",       "level": "M1", "bio": "Machine learning enthusiast. Can mentor in data science and AI.", "is_mentor": True, "phone": "+22501010110"},
    ]

    users = {}
    for ud in users_data:
        user, created = User.objects.get_or_create(
            email=ud["email"],
            defaults={
                "first_name": ud["first_name"],
                "last_name": ud["last_name"],
                "password": make_password(ud["password"]),
                "phone": ud.get("phone", ""),
                "is_verified": True,
            },
        )
        if created:
            profile, _ = Profile.objects.get_or_create(user=user)
            profile.department = ud["department"]
            profile.academic_level = ud["level"]
            profile.bio = ud["bio"]
            profile.save()
        users[ud["email"]] = user

    print(f"  ✅ {User.objects.count()} users")

    # ──────────────────────────────────────────────
    # 3. User Skills
    # ──────────────────────────────────────────────
    print("\n🎯 User Skills...")
    us_data = [
        ("alice@example.com", ["Python", "Java", "Web Development", "Database Design"], ["Algorithmics", "Machine Learning"]),
        ("bob@example.com",   ["JavaScript"], ["Python", "Web Development", "Data Structures"]),
        ("carol@example.com", ["Mathematics", "Physics", "Data Structures", "Algorithmics"], []),
        ("dave@example.com",  [], ["Python", "Web Development", "Database Design", "JavaScript"]),
        ("eve@example.com",   ["Physics", "Mathematics", "Machine Learning", "Deep Learning"], ["Python"]),
        ("frank@example.com", ["JavaScript", "TypeScript", "React", "Web Development", "Python"], ["DevOps"]),
        ("grace@example.com", [], ["Java", "Mobile Development", "Python", "Web Development"]),
        ("henry@example.com", ["Networking", "Cybersecurity", "DevOps", "C/C++"], ["Machine Learning"]),
        ("iris@example.com",  ["UI/UX Design", "Web Development", "JavaScript"], ["React", "Python"]),
        ("james@example.com", ["Python", "Machine Learning", "Deep Learning", "Mathematics", "Data Structures"], ["Web Development"]),
    ]

    count = 0
    for email, strengths, weaknesses in us_data:
        profile = Profile.objects.get(user=users[email])
        for s_name in strengths:
            _, created = UserSkill.objects.get_or_create(profile=profile, skill=skills[s_name], defaults={"type": "STRENGTH"})
            if created:
                count += 1
        for w_name in weaknesses:
            _, created = UserSkill.objects.get_or_create(profile=profile, skill=skills[w_name], defaults={"type": "WEAKNESS"})
            if created:
                count += 1
    print(f"  ✅ {count} user skills created ({UserSkill.objects.count()} total)")

    # ──────────────────────────────────────────────
    # 4. Availability Slots
    # ──────────────────────────────────────────────
    print("\n📅 Availability Slots...")
    availability_data = [
        ("alice@example.com",  "MONDAY",    time(9, 0),  time(12, 0)),
        ("alice@example.com",  "WEDNESDAY", time(14, 0), time(17, 0)),
        ("alice@example.com",  "FRIDAY",    time(10, 0), time(13, 0)),
        ("bob@example.com",    "MONDAY",    time(10, 0), time(12, 0)),
        ("bob@example.com",    "TUESDAY",   time(14, 0), time(16, 0)),
        ("carol@example.com",  "TUESDAY",   time(9, 0),  time(12, 0)),
        ("carol@example.com",  "THURSDAY",  time(15, 0), time(17, 0)),
        ("carol@example.com",  "SATURDAY",  time(9, 0),  time(12, 0)),
        ("dave@example.com",   "WEDNESDAY", time(9, 0),  time(11, 0)),
        ("dave@example.com",   "FRIDAY",    time(14, 0), time(16, 0)),
        ("eve@example.com",    "MONDAY",    time(13, 0), time(15, 0)),
        ("eve@example.com",    "FRIDAY",    time(9, 0),  time(12, 0)),
        ("frank@example.com",  "TUESDAY",   time(10, 0), time(14, 0)),
        ("frank@example.com",  "THURSDAY",  time(14, 0), time(18, 0)),
        ("grace@example.com",  "WEDNESDAY", time(13, 0), time(15, 0)),
        ("grace@example.com",  "SATURDAY",  time(10, 0), time(13, 0)),
        ("henry@example.com",  "MONDAY",    time(14, 0), time(17, 0)),
        ("henry@example.com",  "WEDNESDAY", time(9, 0),  time(12, 0)),
        ("iris@example.com",   "THURSDAY",  time(9, 0),  time(12, 0)),
        ("iris@example.com",   "FRIDAY",    time(10, 0), time(14, 0)),
        ("james@example.com",  "MONDAY",    time(15, 0), time(18, 0)),
        ("james@example.com",  "WEDNESDAY", time(10, 0), time(13, 0)),
    ]
    for email, day, start, end in availability_data:
        profile = Profile.objects.get(user=users[email])
        AvailabilitySlot.objects.get_or_create(profile=profile, day_of_week=day, start_time=start, end_time=end)
    print(f"  ✅ {AvailabilitySlot.objects.count()} slots")

    # ──────────────────────────────────────────────
    # 5. Mentorship Posts
    # ──────────────────────────────────────────────
    print("\n📝 Mentorship Posts...")
    posts_data = [
        # Offers (mentors offering help)
        ("alice@example.com", "OFFER", "Python Programming for Beginners",
         "I can help you learn Python from scratch. We'll cover basics, OOP, and small projects.", "ONLINE"),
        ("alice@example.com", "OFFER", "Java Fundamentals",
         "Learn Java from the ground up. Topics: syntax, OOP, collections, and basic algorithms.", "BOTH"),
        ("carol@example.com", "OFFER", "Mathematics Tutoring (All Levels)",
         "Available for math tutoring up to M1 level. Algebra, calculus, statistics.", "BOTH"),
        ("carol@example.com", "OFFER", "Physics for Engineers",
         "Help with mechanics, thermodynamics, and electromagnetism.", "PHYSICAL"),
        ("eve@example.com", "OFFER", "Quantum Physics Mentorship",
         "Deep dive into quantum mechanics for advanced students.", "ONLINE"),
        ("eve@example.com", "OFFER", "Machine Learning from Scratch",
         "Understand the math behind ML algorithms. From linear regression to neural networks.", "ONLINE"),
        ("frank@example.com", "OFFER", "React & TypeScript Crash Course",
         "Modern frontend development with React, hooks, and TypeScript.", "ONLINE"),
        ("frank@example.com", "OFFER", "Full-Stack Web Development",
         "From database to deployment. Django + React + Docker.", "BOTH"),
        ("henry@example.com", "OFFER", "Cybersecurity 101",
         "Learn ethical hacking, network security, and penetration testing basics.", "ONLINE"),
        ("henry@example.com", "OFFER", "Network Architecture",
         "Understanding TCP/IP, routing, switching, and network design.", "PHYSICAL"),
        ("james@example.com", "OFFER", "Data Science with Python",
         "Pandas, NumPy, visualization, and basic ML models.", "ONLINE"),
        ("james@example.com", "OFFER", "Deep Learning Specialization",
         "Neural networks, CNNs, RNNs, and Transformers with PyTorch.", "ONLINE"),
        # Requests (students looking for help)
        ("bob@example.com", "REQUEST", "Looking for Python Mentor",
         "Need help with Python and algorithms for my L3 project.", "ONLINE"),
        ("dave@example.com", "REQUEST", "Web Development Help",
         "Looking for guidance on building my first web project.", "PHYSICAL"),
        ("grace@example.com", "REQUEST", "Java Programming Tutor",
         "Beginner in Java, need help understanding OOP concepts.", "BOTH"),
        ("grace@example.com", "REQUEST", "Mobile App Development",
         "Want to learn Android or Flutter development.", "ONLINE"),
        ("iris@example.com", "REQUEST", "Frontend Development Mentor",
         "I know design but need help with HTML, CSS, and JavaScript.", "ONLINE"),
        ("iris@example.com", "REQUEST", "React.js Learning Partner",
         "Looking for someone to learn React with.", "BOTH"),
    ]

    posts = {}
    for email, ptype, subject, desc, fmt in posts_data:
        post, _ = MentorshipPost.objects.get_or_create(
            creator=users[email], type=ptype, subject=subject,
            defaults={"description": desc, "format": fmt}
        )
        key = f"{email}|{ptype}|{subject}"
        posts[key] = post

    print(f"  ✅ {MentorshipPost.objects.count()} posts")

    # ──────────────────────────────────────────────
    # 6. Matches (various statuses)
    # ──────────────────────────────────────────────
    print("\n🤝 Matches...")

    match_data = [
        # PENDING
        ("alice@example.com", "bob@example.com",
         "alice@example.com|OFFER|Python Programming for Beginners",
         "bob@example.com|REQUEST|Looking for Python Mentor", 85.5, "PENDING"),
        # ACCEPTED (active mentorship)
        ("frank@example.com", "dave@example.com",
         "frank@example.com|OFFER|Full-Stack Web Development",
         "dave@example.com|REQUEST|Web Development Help", 92.0, "ACCEPTED"),
        # ACCEPTED
        ("carol@example.com", "bob@example.com",
         "carol@example.com|OFFER|Mathematics Tutoring (All Levels)",
         None, 78.0, "ACCEPTED"),
        # PENDING
        ("henry@example.com", "grace@example.com",
         "henry@example.com|OFFER|Cybersecurity 101",
         "grace@example.com|REQUEST|Java Programming Tutor", 65.0, "PENDING"),
        # ACCEPTED
        ("james@example.com", "iris@example.com",
         "james@example.com|OFFER|Data Science with Python",
         "iris@example.com|REQUEST|Frontend Development Mentor", 71.0, "ACCEPTED"),
        # FINISHED (completed mentorship)
        ("alice@example.com", "dave@example.com",
         "alice@example.com|OFFER|Java Fundamentals",
         None, 88.0, "FINISHED"),
        # REJECTED
        ("eve@example.com", "grace@example.com",
         "eve@example.com|OFFER|Quantum Physics Mentorship",
         None, 45.0, "REJECTED"),
    ]

    match_count = 0
    for mentor_email, mentee_email, offer_key, request_key, score, status in match_data:
        mentor = users[mentor_email]
        mentee = users[mentee_email]
        offer = posts.get(offer_key)
        request = posts.get(request_key) if request_key else None

        if not offer and offer_key:
            continue

        # Create match with specific matched_at date ranging from 2 weeks ago
        days_ago = match_count * 3  # spread matches over time
        matched_at_val = now - timedelta(days=days_ago)

        match, created = Match.objects.get_or_create(
            mentor=mentor, mentee=mentee, offer=offer, request=request,
            defaults={
                "compatibility_score": score,
                "status": status,
            },
        )
        if created:
            # Forcer le timestamp via UPDATE direct
            Match.objects.filter(pk=match.pk).update(matched_at=matched_at_val)
        else:
            match.compatibility_score = score
            match.status = status
            match.save()

        match_count += 1

    print(f"  ✅ {Match.objects.count()} matches")

    # ──────────────────────────────────────────────
    # 7. Conversations & Messages
    # ──────────────────────────────────────────────
    print("\n💬 Conversations & Messages...")

    conversations_data = [
        # Alice & Bob — about Python mentoring
        ("alice@example.com", "bob@example.com", [
            ("alice@example.com", "Hi Bob! I saw your request for a Python mentor. I'd be happy to help you!", now - timedelta(days=13, hours=2)),
            ("bob@example.com", "Hey Alice! That would be great! I'm really struggling with Python classes and OOP.", now - timedelta(days=13, hours=1)),
            ("alice@example.com", "No worries, we all start somewhere. Let's begin with the basics of Python syntax and gradually move to OOP. Are you free this Monday?", now - timedelta(days=13)),
            ("bob@example.com", "Yes, Monday works for me! I'm free from 10am to 12pm.", now - timedelta(days=12, hours=20)),
            ("alice@example.com", "Perfect! Let's meet Monday at 10am. I'll send you a Google Meet link. For the first session, please review Python data types and loops.", now - timedelta(days=12, hours=18)),
            ("bob@example.com", "Got it, I'll review those. Thanks so much Alice!", now - timedelta(days=12, hours=17)),
            ("alice@example.com", "Great session today Bob! You did well with the exercises. For next time, practice classes and inheritance.", now - timedelta(days=10, hours=1)),
            ("bob@example.com", "Thanks Alice! The session was really helpful. I'll practice classes this week.", now - timedelta(days=10)),
        ]),
        # Frank & Dave — about full-stack dev
        ("frank@example.com", "dave@example.com", [
            ("frank@example.com", "Hey Dave! I saw you need help with web development. I'm a full-stack dev, happy to mentor you!", now - timedelta(days=8, hours=3)),
            ("dave@example.com", "Awesome Frank! I've been trying to build a portfolio site but I'm stuck.", now - timedelta(days=8, hours=2)),
            ("frank@example.com", "Let's start with the basics. Have you worked with HTML, CSS, and JavaScript yet?", now - timedelta(days=8, hours=1)),
            ("dave@example.com", "I know some HTML and CSS from class, but JavaScript is new to me.", now - timedelta(days=8)),
            ("frank@example.com", "Perfect! That's a good start. Let me create a roadmap for you. First two weeks: JavaScript fundamentals. Then we'll move to React.", now - timedelta(days=7, hours=22)),
            ("frank@example.com", "Here's a good resource: https://javascript.info/ — start with the first 5 chapters.", now - timedelta(days=7, hours=21)),
            ("dave@example.com", "Thanks Frank! I've started reading. The explanations are really clear.", now - timedelta(days=6, hours=12)),
            ("frank@example.com", "Great progress Dave! Your JavaScript is coming along nicely. Next week we start React!", now - timedelta(days=2, hours=1)),
            ("dave@example.com", "Can't wait! I built a small calculator project with vanilla JS this week.", now - timedelta(days=2)),
            ("frank@example.com", "That's excellent! Share it with me, I'll review the code.", now - timedelta(days=1, hours=22)),
        ]),
        # Carol & Bob — about math tutoring
        ("carol@example.com", "bob@example.com", [
            ("carol@example.com", "Hi Bob! I'm available to help you with mathematics. What topics are you working on?", now - timedelta(days=5, hours=4)),
            ("bob@example.com", "Hi Carol! I need help with statistics and probability for my data science class.", now - timedelta(days=5, hours=3)),
            ("carol@example.com", "Great, statistics is my favorite! Let's start with descriptive statistics and probability distributions.", now - timedelta(days=5, hours=2)),
            ("bob@example.com", "Perfect, I have an exam in 3 weeks so the sooner the better!", now - timedelta(days=5)),
            ("carol@example.com", "We have plenty of time. I'll prepare some exercises for our first session.", now - timedelta(days=4, hours=20)),
            ("bob@example.com", "Thank you Carol! See you Thursday.", now - timedelta(days=4, hours=18)),
        ]),
        # James & Iris — about data science / frontend
        ("james@example.com", "iris@example.com", [
            ("james@example.com", "Hi Iris! I saw we matched. Even though my expertise is data science, I can help you with Python basics which is useful for web dev too!", now - timedelta(days=3, hours=5)),
            ("iris@example.com", "Hi James! That sounds good. I actually want to understand how to make data visualizations for my portfolio.", now - timedelta(days=3, hours=4)),
            ("james@example.com", "Perfect! Python has great libraries for data viz. Let me show you Matplotlib and Plotly.", now - timedelta(days=3, hours=3)),
            ("iris@example.com", "I love design, and I think data visualization combines both design and programming perfectly!", now - timedelta(days=3, hours=2)),
            ("james@example.com", "Absolutely! Good design is crucial for data viz. We'll work on both the technical and visual aspects.", now - timedelta(days=3, hours=1)),
        ]),
        # Henry & Grace — about cybersecurity
        ("henry@example.com", "grace@example.com", [
            ("henry@example.com", "Hello Grace! I saw you need a Java tutor, but I also offer cybersecurity mentoring if you're interested.", now - timedelta(days=1, hours=6)),
            ("grace@example.com", "Hi Henry! Cybersecurity sounds really interesting! Can I try both Java and security?", now - timedelta(days=1, hours=5)),
            ("henry@example.com", "Of course! Java is actually widely used in security. We can learn Java by building security tools!", now - timedelta(days=1, hours=4)),
            ("grace@example.com", "That's a great approach! When can we start?", now - timedelta(days=1, hours=3)),
            ("henry@example.com", "Let's meet this Wednesday at 2pm. I'll prepare a Java security beginner roadmap.", now - timedelta(days=1, hours=2)),
            ("grace@example.com", "Perfect, see you Wednesday!", now - timedelta(days=1, hours=1)),
        ]),
    ]

    conv_count = 0
    msg_count = 0
    for email1, email2, messages in conversations_data:
        user1 = users[email1]
        user2 = users[email2]

        # Create or get existing conversation
        conv = Conversation.objects.create()
        ConversationMember.objects.create(conversation=conv, user=user1)
        ConversationMember.objects.create(conversation=conv, user=user2)
        conv_count += 1

        # Create messages then force timestamps via .update() (bypasses auto_now_add)
        for sender_email, content, timestamp in messages:
            msg = Message.objects.create(
                conversation=conv,
                sender=users[sender_email],
                content=content,
            )
            Message.objects.filter(pk=msg.pk).update(created_at=timestamp)
            msg_count += 1

    print(f"  ✅ {conv_count} conversations with {msg_count} messages")

    # ──────────────────────────────────────────────
    # 8. Notifications
    # ──────────────────────────────────────────────
    print("\n🔔 Notifications...")

    notifications_data = [
        # Alice's notifications
        ("alice@example.com", "NEW_MATCH", "New Match: Bob Kouassi",
         "You have been matched with Bob Kouassi for Python Mentoring for Beginners (85.5% compatibility)."),
        ("alice@example.com", "MATCH_ACCEPTED", "Match Accepted: Dave Traore",
         "Dave Traore has accepted your Java Fundamentals offer. You can now start mentoring!"),
        ("alice@example.com", "NEW_MESSAGE", "New message from Bob Kouassi",
         "Bob sent you a message in your conversation."),
        # Bob's notifications
        ("bob@example.com", "NEW_MATCH", "New Match: Alice Konan",
         "You have been matched with Alice Konan for your Python mentoring request (85.5% compatibility)."),
        ("bob@example.com", "NEW_MATCH", "New Match: Carol Diallo",
         "You have been matched with Carol Diallo for Mathematics Tutoring (78.0% compatibility)."),
        ("bob@example.com", "NEW_MESSAGE", "New message from Alice Konan",
         "Alice sent you a message in your conversation."),
        # Carol's notifications
        ("carol@example.com", "NEW_MATCH", "New Mentee: Bob Kouassi",
         "Bob Kouassi has been matched with you for Mathematics Tutoring (78.0% compatibility)."),
        ("carol@example.com", "NEW_MESSAGE", "New message from Bob Kouassi",
         "Bob sent you a message."),
        # Dave's notifications
        ("dave@example.com", "NEW_MATCH", "New Match: Frank Soro",
         "You have been matched with Frank Soro for Full-Stack Web Development (92.0% compatibility)."),
        ("dave@example.com", "MATCH_ACCEPTED", "Match Accepted!",
         "Frank Soro has accepted your Web Development Help request. Start your mentorship!"),
        ("dave@example.com", "NEW_MESSAGE", "New message from Frank Soro",
         "Frank sent you a message in your conversation."),
        # Frank's notifications
        ("frank@example.com", "NEW_MATCH", "New Mentee: Dave Traore",
         "Dave Traore has been matched with you for Full-Stack Web Development (92.0% compatibility)."),
        ("frank@example.com", "NEW_MESSAGE", "New message from Dave Traore",
         "Dave sent you a message."),
        # Eve's notifications
        ("eve@example.com", "MATCH_REJECTED", "Match Rejected: Grace Koffi",
         "Grace Koffi has rejected your Quantum Physics Mentorship offer."),
        # Henry's notifications
        ("henry@example.com", "NEW_MATCH", "New Mentee: Grace Koffi",
         "Grace Koffi has been matched with you for Cybersecurity 101 (65.0% compatibility)."),
        # James's notifications
        ("james@example.com", "NEW_MATCH", "New Mentee: Iris Bamba",
         "Iris Bamba has been matched with you for Data Science with Python (71.0% compatibility)."),
        ("james@example.com", "NEW_MESSAGE", "New message from Iris Bamba",
         "Iris sent you a message."),
        # Grace's notifications
        ("grace@example.com", "NEW_MATCH", "New Match: Henry Zadi",
         "You have been matched with Henry Zadi for Cybersecurity 101 (65.0% compatibility)."),
        ("grace@example.com", "MATCH_REJECTED", "Quantum Physics Match Rejected",
         "Your match with Eve NGuessan for Quantum Physics Mentorship has been rejected."),
        # Iris's notifications
        ("iris@example.com", "NEW_MATCH", "New Match: James Toure",
         "You have been matched with James Toure for Data Science with Python (71.0% compatibility)."),
        ("iris@example.com", "NEW_MESSAGE", "New message from James Toure",
         "James sent you a message in your conversation."),
    ]

    # Spread notification timestamps over the past days
    for i, (email, ntype, title, content) in enumerate(notifications_data):
        notif_time = now - timedelta(hours=i * 3)
        # bulk_create bypasses auto_now_add on timestamp
        Notification.objects.create(
            user=users[email], type=ntype, title=title,
            content=content,
            is_read=i > 8,  # first 9 are unread, rest are read
            created_at=notif_time,  # sera ignoré par auto_now_add…
        )
        # On force le vrai timestamp via UPDATE direct
        Notification.objects.filter(
            user=users[email], type=ntype, title=title
        ).update(created_at=notif_time)

    print(f"  ✅ {Notification.objects.count()} notifications")

    # ──────────────────────────────────────────────
    # Summary
    # ──────────────────────────────────────────────
    print("\n" + "=" * 60)
    print("  📊 Seed Summary")
    print("=" * 60)
    print(f"  Skills:          {Skill.objects.count()}")
    print(f"  Users:           {User.objects.count()}")
    print(f"  User Skills:     {UserSkill.objects.count()}")
    print(f"  Availability:    {AvailabilitySlot.objects.count()}")
    print(f"  Posts:           {MentorshipPost.objects.count()}")
    print(f"  Matches:         {Match.objects.count()}")
    print(f"  Conversations:   {Conversation.objects.count()}")
    print(f"  Messages:        {Message.objects.count()}")
    print(f"  Notifications:   {Notification.objects.count()}")
    print("=" * 60)
    print("  ✅ Database seeded successfully!")
    print("=" * 60)


if __name__ == "__main__":
    seed()
