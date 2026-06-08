# MentorLink

Plateforme connectant les étudiants IFRI pour du mentorat académique et professionnel.

## Stack

- **Backend**: Django 5.1, Django REST Framework 3.15
- **Base de données**: PostgreSQL 16
- **Cache / Realtime**: Redis 7
- **WebSockets**: Channels / Daphne
- **Tâches asynchrones**: Celery
- **Auth**: JWT (SimpleJWT)
- **Documentation API**: drf-spectacular (Swagger/OpenAPI)

## Prérequis

- Docker & Docker Compose

## Installation & Démarrage

```bash
# Lancer l'application complète
docker compose up --build

# Ou en local (sans Docker)
cd backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver
```

## Accès

| Service | URL |
|---------|-----|
| API REST | http://localhost:8000/api/v1/ |
| Documentation Swagger | http://localhost:8000/api/docs/ |
| Schéma OpenAPI | http://localhost:8000/api/schema/ |
| Admin Django | http://localhost:8000/admin/ |
| WebSocket Chat | ws://localhost:8000/ws/chat/{conversation_id} |
| WebSocket Notifications | ws://localhost:8000/ws/notifications |

## Endpoints API

### Authentification (`/api/v1/auth/`)
- `POST /register` — Créer un compte
- `POST /login` — Connexion (email ou téléphone + mot de passe)
- `POST /refresh` — Rafraîchir le token JWT
- `POST /logout` — Déconnexion (blacklist du refresh token)
- `POST /request-reset` — Demander un reset de mot de passe
- `POST /reset-password` — Réinitialiser le mot de passe

### Profils (`/api/v1/`)
- `GET/PATCH /me` — Consulter/modifier son profil
- `POST /me/photo` — Uploader une photo de profil
- `POST /me/skills` — Ajouter une compétence
- `DELETE /me/skills/{id}` — Supprimer une compétence
- `POST /me/availability` — Ajouter un créneau de disponibilité
- `DELETE /me/availability/{id}` — Supprimer un créneau

### Mentorat (`/api/v1/`)
- `GET/POST /posts` — Lister / Créer une offre ou demande
- `GET/PATCH/DELETE /posts/{id}` — Détail / Modifier / Supprimer
- `POST /posts/{id}/apply` — Postuler à une offre

### Matching (`/api/v1/matching/`)
- `POST /run` — Lancer le matching
- `GET /recommendations` — Recommandations
- `GET /history` — Historique des matchs
- `POST /{id}/accept` — Accepter un match
- `POST /{id}/reject` — Rejeter un match

### Messagerie (`/api/v1/`)
- `GET/POST /conversations` — Lister / Créer une conversation
- `GET /conversations/{id}` — Détail d'une conversation
- `GET/POST /messages` — Lister / Envoyer un message

### Notifications (`/api/v1/`)
- `GET /notifications` — Lister les notifications
- `POST /notifications/read` — Marquer comme lues

### Analytics (`/api/v1/analytics/`)
- `GET /dashboard` — Tableau de bord

## Tests

```bash
cd backend
pytest
```
