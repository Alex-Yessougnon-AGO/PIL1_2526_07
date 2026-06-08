# IFRI MentorLink — Backend

Platform connecting IFRI students for academic and professional mentoring.

## Tech Stack

- **Framework:** Django 5 + Django REST Framework
- **Database:** PostgreSQL 16
- **Real-time:** Django Channels + Redis
- **Auth:** JWT (SimpleJWT)
- **Async:** Celery + Redis
- **Docs:** drf-spectacular (Swagger/OpenAPI)
- **Tests:** Pytest
- **Container:** Docker Compose

## Quick Start

```bash
# Build and run everything
docker compose up --build

# Run seed data
docker compose exec app python seed.py

# Run tests
docker compose exec app pytest
```

## Services

| Service | Port | Description |
|---------|------|-------------|
| `app` | 8000 | Django ASGI (Daphne) |
| `db` | 5432 | PostgreSQL |
| `redis` | 6379 | Redis + Channel Layer |
| `celery_worker` | — | Async task worker |
| `celery_beat` | — | Scheduled tasks |

## API Endpoints

| Endpoint | Description |
|----------|-------------|
| `POST /api/v1/auth/register` | Register |
| `POST /api/v1/auth/login` | Login |
| `POST /api/v1/auth/refresh` | Refresh token |
| `POST /api/v1/auth/logout` | Logout |
| `POST /api/v1/auth/request-reset` | Request password reset |
| `POST /api/v1/auth/reset-password` | Reset password |
| `GET/PATCH /api/v1/me` | Profile |
| `POST /api/v1/me/photo` | Upload photo |
| `POST/DELETE /api/v1/me/skills` | Manage skills |
| `POST/DELETE /api/v1/me/availability` | Manage availability |
| `GET/POST /api/v1/posts` | Mentorship posts |
| `GET/PATCH/DELETE /api/v1/posts/{id}` | Post detail |
| `POST /api/v1/posts/{id}/apply` | Apply to post |
| `POST /api/v1/matching/run` | Run matching |
| `GET /api/v1/matching/recommendations` | Get recommendations |
| `GET /api/v1/matching/history` | Match history |
| `POST /api/v1/matching/{id}/accept` | Accept match |
| `POST /api/v1/matching/{id}/reject` | Reject match |
| `GET/POST /api/v1/conversations` | Conversations |
| `GET /api/v1/conversations/{id}` | Conversation detail |
| `GET/POST /api/v1/messages` | Messages |
| `GET /api/v1/notifications` | List notifications |
| `POST /api/v1/notifications/read` | Mark as read |
| `GET /api/v1/analytics/dashboard` | Dashboard stats |

### WebSocket

| Path | Description |
|------|-------------|
| `ws/chat/{conversation_id}` | Chat via WebSocket |

### Documentation

- Swagger UI: `http://localhost:8000/api/docs/`
- OpenAPI Schema: `http://localhost:8000/api/schema/`

## Architecture

```
backend/
├── apps/
│   ├── accounts/     # User model + auth endpoints
│   ├── profiles/     # Profile, skills, availability
│   ├── mentoring/    # Posts, matches
│   ├── matching/     # Matching engine + scoring
│   ├── chat/         # Conversations + WebSocket
│   ├── notifications/# Real-time notifications
│   ├── common/       # Base model, pagination, responses
│   └── analytics/    # Dashboard stats
├── config/           # Django settings, ASGI, Celery
├── docker/           # Dockerfile + entrypoint
├── schema.sql        # Raw SQL schema
├── seed.py           # Development seed data
└── docker-compose.yml
```

## Matching Engine

Score formula:

```
score = skills × 0.5 + availability × 0.3 + department × 0.1 + level × 0.1
```

Minimum valid score: 60

## Environment Variables

See `.env.example`. All have defaults for Docker Compose.

## Commands

```bash
make setup      # Install + migrate
make migrate    # Run migrations
make run        # Docker Compose up
make test       # Run tests
make seed       # Seed database
```
