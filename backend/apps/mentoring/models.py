import uuid

from django.db import models

from apps.common.models import BaseModel


class MentorshipPost(BaseModel):
    POST_TYPES = [("OFFER", "Offer"), ("REQUEST", "Request")]
    FORMAT_CHOICES = [("ONLINE", "Online"), ("PHYSICAL", "Physical"), ("BOTH", "Both")]
    STATUS_CHOICES = [("OPEN", "Open"), ("MATCHED", "Matched"), ("CLOSED", "Closed")]

    creator = models.ForeignKey("accounts.User", on_delete=models.CASCADE, related_name="posts")
    type = models.CharField(max_length=10, choices=POST_TYPES)
    subject = models.CharField(max_length=255)
    description = models.TextField(null=True, blank=True)
    format = models.CharField(max_length=10, choices=FORMAT_CHOICES, default="ONLINE")
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default="OPEN")

    class Meta:
        db_table = "mentorship_posts"
        indexes = [
            models.Index(fields=["type", "status"]),
            models.Index(fields=["subject"]),
            models.Index(fields=["created_at"]),
            models.Index(fields=["creator", "status"]),
        ]
        ordering = ["-created_at"]

    def __str__(self):
        return f"{self.type} - {self.subject} by {self.creator.email}"


class Match(BaseModel):
    STATUS_CHOICES = [("PENDING", "Pending"), ("ACCEPTED", "Accepted"), ("REJECTED", "Rejected"), ("FINISHED", "Finished")]

    mentor = models.ForeignKey("accounts.User", on_delete=models.CASCADE, related_name="mentor_matches")
    mentee = models.ForeignKey("accounts.User", on_delete=models.CASCADE, related_name="mentee_matches")
    offer = models.ForeignKey(MentorshipPost, on_delete=models.CASCADE, related_name="offer_matches", null=True)
    request = models.ForeignKey(MentorshipPost, on_delete=models.CASCADE, related_name="request_matches", null=True)
    compatibility_score = models.FloatField(default=0.0)
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default="PENDING")
    matched_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "matches"
        indexes = [
            models.Index(fields=["status"]),
            models.Index(fields=["mentor", "status"]),
            models.Index(fields=["mentee", "status"]),
            models.Index(fields=["compatibility_score"]),
        ]

    def __str__(self):
        return f"Match: {self.mentor.email} - {self.mentee.email} ({self.compatibility_score})"


class Review(BaseModel):
    RATING_CHOICES = [(i, str(i)) for i in range(1, 6)]

    reviewer = models.ForeignKey("accounts.User", on_delete=models.CASCADE, related_name="reviews_given")
    reviewed = models.ForeignKey("accounts.User", on_delete=models.CASCADE, related_name="reviews_received")
    match = models.ForeignKey(Match, on_delete=models.CASCADE, related_name="reviews", null=True, blank=True)
    rating = models.IntegerField(choices=RATING_CHOICES)
    content = models.TextField(null=True, blank=True)
    session_type = models.CharField(max_length=50, null=True, blank=True, help_text="e.g. Session mentorat, Session technique")

    class Meta:
        db_table = "reviews"
        indexes = [
            models.Index(fields=["reviewed"]),
            models.Index(fields=["reviewer"]),
            models.Index(fields=["rating"]),
        ]
        ordering = ["-created_at"]

    def __str__(self):
        return f"Review by {self.reviewer.email} for {self.reviewed.email}: {self.rating}/5"
