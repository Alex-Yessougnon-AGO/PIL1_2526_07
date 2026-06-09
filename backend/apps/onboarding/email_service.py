import logging

logger = logging.getLogger(__name__)


class EmailService:
    """
    Service for sending transactional emails.

    In production, integrate with SendGrid, Mailgun, or any email provider.
    For development, logs email content to the console.
    """

    @staticmethod
    def send_verification_email(user_email: str, first_name: str, token: str):
        """Send email verification link."""
        verify_url = f"/api/v1/auth/verify-email?token={token}"

        subject = "Vérifiez votre adresse email - MentorLink"
        body = f"""
Bonjour {first_name},

Merci de vous être inscrit sur MentorLink !

Pour vérifier votre adresse email et activer votre compte, veuillez cliquer sur le lien suivant :
{verify_url}

Ce lien expire dans 24 heures.

Si vous n'avez pas créé de compte sur MentorLink, ignorez cet email.

Cordialement,
L'équipe MentorLink
        """.strip()

        logger.info(f"[EMAIL] To: {user_email} | Subject: {subject}\n\n{body}\n")
        # TODO: In production, send actual email via SMTP or API

    @staticmethod
    def send_verification_approved_email(user_email: str, first_name: str):
        """Send notification that verification was approved."""
        subject = "Vérification approuvée - MentorLink"
        body = f"""
Bonjour {first_name},

Votre document d'identité étudiante a été vérifié et approuvé avec succès.

Vous pouvez dès maintenant profiter pleinement de toutes les fonctionnalités de MentorLink :
- Créer et publier des offres de mentorat
- Répondre aux demandes de mentorat
- Utiliser le matching intelligent

Cordialement,
L'équipe MentorLink
        """.strip()

        logger.info(f"[EMAIL] To: {user_email} | Subject: {subject}\n\n{body}\n")
        # TODO: In production, send actual email

    @staticmethod
    def send_verification_rejected_email(user_email: str, first_name: str, reason: str = None):
        """Send notification that verification was rejected."""
        subject = "Vérification rejetée - MentorLink"
        body = f"""
Bonjour {first_name},

Malheureusement, votre document d'identité étudiante n'a pas pu être vérifié.
        """
        if reason:
            body += f"\nRaison : {reason}\n"
        body += """
Veuillez télécharger un nouveau document clair et lisible depuis votre profil.

Cordialement,
L'équipe MentorLink
        """.strip()

        logger.info(f"[EMAIL] To: {user_email} | Subject: {subject}\n\n{body}\n")
        # TODO: In production, send actual email
