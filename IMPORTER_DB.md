# Importer la base de données MentorLink

## 1. Lancer PostgreSQL et Redis

```bash
docker compose up -d db redis
```

Attends que les services soient prêts (≈10 secondes).

## 2. Copier et importer le dump

```bash
docker cp backend/mentorlink_dump.sql mentorlink-db-1:/tmp/
docker exec mentorlink-db-1 psql -U mentorlink -d mentorlink -f /tmp/mentorlink_dump.sql
```

## 3. Lancer le reste des services

```bash
docker compose up --build
```

## 4. Lancer le frontend (dans un autre terminal)

```bash
cd frontend
python3 -m http.server 3000
```

## 5. Accéder à l'application

- **Frontend :** `http://localhost:3000/`
- **API :** `http://localhost:8001/api/v1/`
- **Swagger :** `http://localhost:8001/api/docs/`

## Comptes de test

Tous les mots de passe sont : **`password123`**

| Email | Rôle |
|-------|------|
| `alice@example.com` | Mentor (Python, Java) |
| `bob@example.com` | Mentoré (Python, Maths) |
| `carol@example.com` | Mentor (Maths, Physique) |
| `dave@example.com` | Mentoré (Web Dev) |
| `eve@example.com` | Mentor (Physique quantique, ML) |
| `frank@example.com` | Mentor (React, Full-Stack) |
| `grace@example.com` | Mentoré (Java, Mobile) |
| `henry@example.com` | Mentor (Cybersécurité, Réseaux) |
| `iris@example.com` | Mentoré (UI/UX, Frontend) |
| `james@example.com` | Mentor (Data Science, IA) |

Connecte-toi sur `http://localhost:3000/html/login.html`.
