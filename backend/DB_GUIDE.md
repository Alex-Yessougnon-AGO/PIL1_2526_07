# 🗄️ Guide de connexion à la base de données MentorLink

> Ce guide explique comment se connecter à la base de données PostgreSQL depuis le terminal pour explorer, inspecter et manipuler les données.

---

## 📋 Informations de connexion

| Information | Valeur |
|-------------|--------|
| **SGBD** | PostgreSQL 16 |
| **Hôte** | `localhost` |
| **Port** | `5433` (via Docker) |
| **Nom de la base** | `mentorlink` |
| **Utilisateur** | `mentorlink` |
| **Mot de passe** | `mentorlink` |

---

## 🐳 Méthode 1 : Connexion via Docker (recommandée)

### Avec `psql` directement dans le conteneur

```bash
# Se connecter à la base
docker exec -it mentorlink-db-1 psql -U mentorlink -d mentorlink
```

### Commandes utiles une fois dans psql

```sql
-- Lister toutes les tables
\dt

-- Voir la structure d'une table
\d+ users
\d+ profiles
\d+ user_skills
\d+ availability_slots
\d+ mentorship_posts
\d+ matches
\d+ conversations
\d+ messages
\d+ notifications

-- Voir tous les index
\di

-- Voir les utilisateurs
\du

-- Basculer en mode colonnes (plus lisible)
\x auto

-- Exécuter une requête SQL
SELECT * FROM users LIMIT 5;

-- Voir les 10 dernières notifications
SELECT * FROM notifications ORDER BY created_at DESC LIMIT 10;

-- Quitter psql
\q
```

### Connexion directe au conteneur bash + psql

```bash
# D'abord entrer dans le conteneur
docker exec -it mentorlink-db-1 sh

# Puis se connecter
psql -U mentorlink -d mentorlink
```

---

## 💻 Méthode 2 : Connexion depuis votre machine (si psql est installé)

```bash
psql -h localhost -p 5433 -U mentorlink -d mentorlink
```

*Mot de passe : `mentorlink`*

---

## 📊 Requêtes utiles pour inspecter les données

### Voir tous les utilisateurs

```sql
SELECT id, email, first_name, last_name, is_verified, is_active
FROM users
ORDER BY created_at DESC;
```

### Voir les profils avec leurs compétences

```sql
-- Forces (STRENGTH) — "Je peux aider en"
SELECT u.email, u.first_name, u.last_name, s.name AS skill
FROM users u
JOIN profiles p ON p.user_id = u.id
JOIN user_skills us ON us.profile_id = p.id
JOIN skills s ON s.id = us.skill_id
WHERE us.type = 'STRENGTH' AND us.deleted_at IS NULL
ORDER BY u.email;

-- Faiblesses (WEAKNESS) — "Je souhaite apprendre"
SELECT u.email, u.first_name, u.last_name, s.name AS skill
FROM users u
JOIN profiles p ON p.user_id = u.id
JOIN user_skills us ON us.profile_id = p.id
JOIN skills s ON s.id = us.skill_id
WHERE us.type = 'WEAKNESS' AND us.deleted_at IS NULL
ORDER BY u.email;
```

### Voir les disponibilités

```sql
SELECT u.email, u.first_name, u.last_name,
       a.day_of_week, a.start_time, a.end_time
FROM users u
JOIN profiles p ON p.user_id = u.id
JOIN availability_slots a ON a.profile_id = p.id
WHERE a.deleted_at IS NULL
ORDER BY u.email, a.day_of_week, a.start_time;
```

### Voir les matchs et leurs scores

```sql
SELECT
  m.id,
  mentor.email AS mentor_email,
  mentee.email AS mentee_email,
  m.compatibility_score,
  m.status,
  m.matched_at
FROM matches m
JOIN users mentor ON mentor.id = m.mentor_id
JOIN users mentee ON mentee.id = m.mentee_id
WHERE m.deleted_at IS NULL
ORDER BY m.compatibility_score DESC;
```

### Voir les offres et demandes de mentorat

```sql
SELECT
  p.id,
  u.email AS creator,
  p.type,
  p.subject,
  p.format,
  p.status,
  p.created_at
FROM mentorship_posts p
JOIN users u ON u.id = p.creator_id
WHERE p.deleted_at IS NULL
ORDER BY p.created_at DESC;
```

### Voir les messages récents

```sql
SELECT
  c.id AS conversation_id,
  sender.email AS sender,
  LEFT(m.content, 80) AS content_preview,
  m.created_at
FROM messages m
JOIN conversations c ON c.id = m.conversation_id
JOIN users sender ON sender.id = m.sender_id
WHERE m.deleted_at IS NULL
ORDER BY m.created_at DESC
LIMIT 20;
```

---

## 🔄 Restaurer la base de données depuis le dump

Si vous avez le fichier `mentorlink_dump.sql`, vous pouvez restaurer les données :

```bash
# Restaurer dans un conteneur Docker
docker exec -i mentorlink-db-1 psql -U mentorlink -d mentorlink < backend/mentorlink_dump.sql

# Ou depuis votre machine
psql -h localhost -p 5433 -U mentorlink -d mentorlink < backend/mentorlink_dump.sql
```

---

## 📁 Export d'un nouveau dump

```bash
# Schéma uniquement
docker exec mentorlink-db-1 pg_dump -U mentorlink -d mentorlink --schema-only --no-owner --no-acl > backend/mentorlink_schema.sql

# Données uniquement
docker exec mentorlink-db-1 pg_dump -U mentorlink -d mentorlink --data-only --no-owner --no-acl > backend/mentorlink_data.sql

# Full dump (schéma + données)
docker exec mentorlink-db-1 pg_dump -U mentorlink -d mentorlink --no-owner --no-acl > backend/mentorlink_dump.sql
```

---

## ⚠️ Dépannage

| Problème | Solution |
|----------|----------|
| `docker: command not found` | Docker n'est pas installé. Installez Docker Desktop |
| `Cannot connect to the Docker daemon` | Démarrez Docker Desktop |
| `container not found` | Lancez d'abord `docker compose up -d` |
| `psql: FATAL: database "mentorlink" does not exist` | La base n'a pas été créée → `docker compose up -d` puis `docker exec mentorlink-app-1 python manage.py migrate` |
| `FATAL: password authentication failed` | Vérifiez que le mot de passe est `mentorlink` |
