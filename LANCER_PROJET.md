# Lancer le projet MentorLink

## Avec Docker (recommandé)

### 1. Backend + services (PostgreSQL, Redis, Celery)

```bash&
docker compose up --build
```

L'API est disponible sur : `http://localhost:8001/api/v1/`
Swagger : `http://localhost:8001/api/docs/`

### 2. Frontend (dans un autre terminal)

```bash
cd frontend
python3 -m http.server 3000
```

Ou avec npx :

```bash
cd frontend
npx serve .
```

Le frontend est disponible sur : `http://localhost:3000/`

---

## Sans Docker (alternative)

### Backend

```bash
cd backend
source venv/bin/activate
python manage.py runserver 8001
```

### Frontend

```bash
cd frontend
python3 -m http.server 3000
```
