# 🚀 Guide du Développeur — MentorLink

> Guide complet pour comprendre, installer, modifier et déployer le projet MentorLink.

---

## 📖 Table des matières

1. [Présentation du projet](#-présentation-du-projet)
2. [Architecture générale](#-architecture-générale)
3. [Stack technologique](#-stack-technologique)
4. [Structure du projet](#-structure-du-projet)
5. [Installation et démarrage](#-installation-et-démarrage)
6. [Base de données](#-base-de-données)
7. [API REST](#-api-rest)
8. [WebSockets](#-websockets)
9. [Frontend](#-frontend)
10. [Tests](#-tests)
11. [Scripts utiles](#-scripts-utiles)
12. [Déploiement](#-déploiement)
13. [Guide de contribution](#-guide-de-contribution)
14. [Dépannage](#-dépannage)

---

## 🎯 Présentation du projet

**MentorLink** est une plateforme de mentorat pair-à-pair destinée aux étudiants de **l'IFRI** (Institut de Formation et de Recherche en Informatique de l'Université d'Abomey-Calavi, Bénin).

**Objectif :** Connecter les étudiants de différents niveaux pour qu'ils s'entraident académiquement. Les plus avancés proposent leur aide via des **offres** ("Je peux enseigner Python"), les débutants formulent des **demandes** ("J'ai besoin d'aide en Algorithmique").

**Fonctionnalités principales :**
- 🔐 Authentification JWT (inscription, connexion, refresh)
- 👤 Profils utilisateurs (compétences, disponibilités, bio)
- 📝 Publications d'offres et demandes de mentorat
- 🤖 **Matching intelligent** (score basé sur compétences, disponibilités, département, niveau)
- 💬 Messagerie en temps réel (WebSockets)
- 🔔 Notifications en temps réel
- 📊 Tableau de bord analytique
- ✅ Processus d'onboarding (vérification document)

---

## 🏗 Architecture générale

```
┌─────────────────────────────────────────────────────┐
│                    Frontend HTML/JS                  │
│            (Dossier frontend/)                       │
└─────────────────┬──────────────────────┬────────────┘
                  │ HTTP REST API        │ WebSocket
                  ▼                      ▼
┌─────────────────────────────────────────────────────┐
│             Daphne/ASGI Server (:8000)               │
│         Django + Channels + DRF                      │
├─────────────────────────────────────────────────────┤
│  Apps : accounts, profiles, mentoring, matching,    │
│         chat, notifications, onboarding, analytics  │
├─────────────────────────────────────────────────────┤
│  PostgreSQL 16       Redis 7        Celery          │
│  (Données)           (Cache/Ws)     (Async tasks)   │
└─────────────────────────────────────────────────────┘
```

### Flux des données

```
1. Client → API HTTP (DRF) → Serializer → Service → Repository → DB
2. Client ↔ WebSocket (Channels) ↔ Redis ↔ Daphne
3. Tâches async : Celery → Redis → Worker → DB
```

---

## 🛠 Stack technologique

### Backend

| Technologie | Version | Usage |
|-------------|---------|-------|
| **Python** | 3.12 | Langage |
| **Django** | 5.1.4 | Framework web |
| **Django REST Framework** | 3.15.2 | API REST |
| **Daphne** | 4.1.2 | Serveur ASGI |
| **Channels** | 4.2.0 | WebSockets |
| **Celery** | 5.4.0 | Tâches asynchrones |
| **Redis** | 7 | Cache + Broker |
| **PostgreSQL** | 16 | Base de données |
| **SimpleJWT** | 5.4.0 | Auth JWT |
| **drf-spectacular** | 0.28.0 | Swagger/OpenAPI |
| **Sentry** | 2.62.0 | Monitoring |
| **Pytest** | 8.3.4 | Tests |

### Frontend

| Technologie | Usage |
|-------------|-------|
| **HTML5** | Structure des pages |
| **Tailwind CSS** (CDN) | Styles utilitaires |
| **JavaScript ES Modules** | Logique client |
| **Material Symbols** | Icônes |
| **Google Fonts (Inter)** | Typographie |

---

## 📁 Structure du projet

```
MentorLink/
├── README.md                    # README original
├── .gitignore                   # Fichiers ignorés
├── docker-compose.yml           # Orchestration Docker (root)
│
├── backend/                     # 🐍 Application Django
│   ├── docker-compose.yml       # Docker Compose du backend
│   ├── Dockerfile               # Image Docker
│   ├── docker/entrypoint.sh     # Script d'entrée Docker
│   ├── requirements.txt         # Dépendances Python
│   ├── manage.py                # CLI Django
│   ├── Makefile                 # Commandes make
│   ├── seed.py                  # Script de seeding
│   ├── test_settings.py         # Config tests
│   ├── pytest.ini               # Config pytest
│   ├── mentorlink_dump.sql      # 🗄️ Dump de la base de données
│   ├── DB_GUIDE.md              # Guide base de données
│   ├── GUIDE_DEVELOPPEUR.md     # 👈 Ce fichier
│   ├── GUIDE_UTILISATEUR.md     # Guide utilisateur
│   │
│   ├── config/                  # Configuration Django
│   │   ├── settings.py          # Settings principaux
│   │   ├── urls.py              # URLs racine
│   │   ├── asgi.py              # Config ASGI (Channels)
│   │   ├── wsgi.py              # Config WSGI
│   │   └── celery.py            # Config Celery
│   │
│   └── apps/                    # Applications Django
│       ├── accounts/            # Gestion des utilisateurs
│       │   ├── models.py        # User (email, phone, UUID pk)
│       │   ├── serializers.py   # Login, Register, User
│       │   ├── services.py      # AuthService (register, login)
│       │   ├── repositories.py  # UserRepository
│       │   └── api/
│       │       ├── views.py     # AuthViewSet (ViewSet)
│       │       └── urls.py      # Routes auth
│       │
│       ├── profiles/            # Profils utilisateurs
│       │   ├── models.py        # Profile, Skill, UserSkill, AvailabilitySlot
│       │   ├── serializers.py   # ProfileSerializer, UserSkillSerializer, etc.
│       │   ├── services.py      # ProfileService (CRUD skills/availability)
│       │   ├── repositories.py  # Profile, Skill, UserSkill, Availability repos
│       │   └── api/
│       │       ├── views.py     # ProfileDetailView, AddSkillView, etc.
│       │       └── urls.py      # Routes /me, /me/skills, /me/availability
│       │
│       ├── mentoring/           # Mentorat (Posts, Matches, Reviews)
│       │   ├── models.py        # MentorshipPost, Match, Review
│       │   ├── serializers.py   # MentorshipPost, Match serializers
│       │   ├── services.py      # MentorshipService
│       │   ├── repositories.py  # Post, Match, Review repos
│       │   └── api/
│       │       ├── views.py     # PostListCreate, PostDetail, PostApply
│       │       └── urls.py      # Routes /posts
│       │
│       ├── matching/            # Algorithme de matching
│       │   ├── services/
│       │   │   └── matcher.py   # MatcherService (scoring algorithm)
│       │   ├── views.py         # MatchingRun, Recommendations, History
│       │   ├── urls.py          # Routes /matching
│       │   └── tests/
│       │       └── test_matcher.py
│       │
│       ├── chat/                # Messagerie
│       │   ├── models.py        # Conversation, ConversationMember, Message
│       │   ├── serializers.py   # Conversation, Message serializers
│       │   ├── repositories.py  # Conversation, Message repos
│       │   ├── consumers.py     # WebSocket consumer
│       │   ├── routing.py       # WebSocket routing
│       │   └── api/
│       │       ├── views.py     # ConversationListCreate, MessageListCreate
│       │       └── urls.py
│       │
│       ├── notifications/       # Notifications
│       │   ├── models.py        # Notification
│       │   ├── serializers.py
│       │   ├── tasks.py         # Tâches Celery pour notifications
│       │   ├── consumers.py     # WebSocket consumer
│       │   ├── routing.py
│       │   └── api/
│       │       ├── views.py     # NotificationList, MarkRead
│       │       └── urls.py
│       │
│       ├── onboarding/          # Processus d'inscription
│       │   ├── models.py        # VerificationDocument
│       │   ├── serializers.py
│       │   ├── services.py      # OnboardingService
│       │   ├── repositories.py
│       │   ├── tasks.py
│       │   ├── email_service.py
│       │   └── api/
│       │       ├── views.py     # AcademicInfo, Skills, Verification
│       │       └── urls.py
│       │
│       ├── analytics/           # Analytics
│       │   ├── views.py         # DashboardView
│       │   ├── urls.py
│       │   └── tests/
│       │
│       └── common/              # Utilitaires partagés
│           ├── models.py        # BaseModel (soft delete, timestamps)
│           ├── pagination.py    # StandardPagination
│           ├── responses.py     # success_response, error_response
│           ├── exceptions.py    # Custom exception handler
│           └── permissions.py   # Permissions personnalisées
│
└── frontend/                    # 🎨 Interface utilisateur
    ├── index.html               # Page d'accueil
    ├── PRODUCT.md               # Définition du produit
    ├── css/                     # Feuilles de styles
    │   ├── landing.css
    │   ├── dashboard.css
    │   ├── matching-results.css
    │   └── ...
    ├── html/                    # Pages HTML
    │   ├── login.html
    │   ├── sign-up.html
    │   ├── dashboard.html
    │   ├── feed-ifri.html       # Fil d'actualité
    │   ├── matching-results.html # Résultats du matching
    │   ├── mon-profile.html     # Mon profil
    │   ├── modiffier_profil.html # Modifier le profil
    │   ├── message.html         # Messagerie
    │   ├── notifs.html          # Notifications
    │   ├── settings.html        # Paramètres
    │   ├── offer.html           # Publier une offre
    │   ├── demande.html         # Publier une demande
    │   ├── student-profile.html # Profil public étudiant
    │   └── password-reset.html  # Réinitialisation mot de passe
    ├── js/                      # Scripts JavaScript (ES modules)
    │   ├── api.js               # Client API central (fetch, JWT, refresh)
    │   ├── auth.js              # Fonctions login/register/logout
    │   ├── matching-results.js  # Page de matching
    │   ├── modiffier_profil.js  # Modification profil
    │   ├── mon-profile.js       # Affichage profil
    │   ├── offer.js             # Publication offre
    │   ├── demande.js           # Publication demande
    │   ├── message.js           # Messagerie
    │   ├── chat.js              # Chat temps réel (WebSocket)
    │   ├── notifs.js            # Notifications
    │   └── ...
    └── partials/                # Partiels HTML (sidebar)
        └── sidebar.html
```

---

## 🚀 Installation et démarrage

### Prérequis

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (recommandé)
- Ou : Python 3.12+, PostgreSQL 16+, Redis 7+

### Avec Docker (recommandé)

```bash
# 1. Cloner le dépôt
git clone https://github.com/votre-username/mentorlink.git
cd mentorlink

# 2. Lancer tous les services
docker compose up --build

# 3. Dans un autre terminal, seed la base de données (optionnel)
docker exec -it mentorlink-app-1 python seed.py

# 4. Accéder à l'application
#    API :        http://localhost:8001/api/v1/
#    Swagger :    http://localhost:8001/api/docs/
#    Admin :      http://localhost:8001/admin/
#    Frontend :   Ouvrir directement les fichiers HTML dans le navigateur
```

### Démarrer les services un par un (Docker)

```bash
# Démarrer seulement la base de données et Redis
docker compose up db redis -d

# Puis l'application
docker compose up app --build -d

# Voir les logs
docker compose logs -f app
```

### Sans Docker (développement local)

```bash
# 1. Backend
cd backend
python -m venv venv
source venv/bin/activate  # Sur Windows: venv\Scripts\activate
pip install -r requirements.txt

# 2. Configurer la base de données PostgreSQL
#    Créez une base 'mentorlink' avec utilisateur 'mentorlink'
#    Ou modifiez les variables dans config/settings.py

# 3. Migrations
python manage.py migrate

# 4. Données de démo (optionnel)
python seed.py

# 5. Lancer le serveur
python manage.py runserver

# 6. Accéder à l'API sur http://localhost:8000/api/v1/
```

### Seeder la base de données

```bash
# Dans le conteneur Docker
docker exec -it mentorlink-app-1 python seed.py

# En local
cd backend && python seed.py
```

Le script `seed.py` crée :
- 10 utilisateurs avec profils
- 20 compétences
- 22 créneaux de disponibilité
- 18 offres/demandes de mentorat
- 7 matchs (dont certains acceptés/terminés)
- 5 conversations avec messages
- 24 notifications

**Comptes de démo :**

| Email | Mot de passe | Rôle |
|-------|-------------|------|
| `alice@example.com` | `password123` | Mentor (Python, Java) |
| `bob@example.com` | `password123` | Mentoré (Python, Web) |
| `carol@example.com` | `password123` | Mentor (Maths, Physique) |
| `dave@example.com` | `password123` | Mentoré (Web, Python) |
| `frank@example.com` | `password123` | Mentor (React, TypeScript) |

---

## 🗄 Base de données

### Modèles de données

```
┌──────────┐       ┌────────────┐       ┌──────────────┐
│   User   │──1:1──│   Profile  │──1:N──│  UserSkill   │──N:1──┐
│ (email,  │       │ (dept,     │       │ (STRENGTH/   │       │
│  phone,  │       │  level,    │       │  WEAKNESS)   │       │
│  name)   │       │  bio,      │       └──────────────┘       │
└────┬─────┘       │  photo)    │       ┌──────────────┐       │
     │             └─────┬──────┘──1:N──│Availability  │       │
     │                   │              │Slot          │       │
     │                   │              └──────────────┘       │
     │                   │              ┌──────────┐           │
     │1:N ┌──────────────┘      ┌───────│  Skill   │◄──────────┘
     ├────│ MentorshipPost      │       │ (name)   │
     │    │ (OFFER/REQUEST)     │       └──────────┘
     │    └────────┬────────────┘
     │             │              ┌──────────┐
     │             ├──offer──N:1──│  Match   │
     │             ├──request──N:1│ (score,  │
     │1:N ┌────────┐             │  status) │
     ├────│ Match  │──mentor─────┘          │
     │    │ (si    │──mentee────────────────┘
     │    │ mentor)│              ┌──────────┐
     │    └────────┘       ┌─────│  Review  │
     │                     │     │ (rating) │
     │1:N ┌────────────┐   │     └──────────┘
     ├────│Conversation│───┤
     │    │ (members)  │   │     ┌──────────┐
     │    └────────────┘   └─────│ Message  │
     │                          │ (content)│
     │1:N ┌──────────────┐      └──────────┘
     └────│ Notification │
          │ (type, read) │
          └──────────────┘
```

### Soft Delete

Tous les modèles principaux (`Profile`, `UserSkill`, `AvailabilitySlot`, `Match`, `MentorshipPost`, `Message`, `Conversation`, `Notification`) héritent de `BaseModel` qui implémente le **soft delete** via un champ `deleted_at`. Les objets supprimés ne sont pas retirés de la DB mais marqués avec une date.

### Migrations

```bash
# Créer une migration
docker exec -it mentorlink-app-1 python manage.py makemigrations

# Appliquer les migrations
docker exec -it mentorlink-app-1 python manage.py migrate

# Voir le statut
docker exec -it mentorlink-app-1 python manage.py showmigrations
```

---

## 📡 API REST

L'API est accessible à `http://localhost:8001/api/v1/` (Docker) ou `http://localhost:8000/api/v1/`.

### Documentation interactive

- **Swagger UI** : `http://localhost:8001/api/docs/`
- **Schéma OpenAPI** : `http://localhost:8001/api/schema/`

### Architecture des endpoints

```
/api/v1/
├── auth/                  # Authentification
├── me/                    # Profil (GET, PATCH)
├── me/skills/             # Compétences
├── me/availability/       # Disponibilités
├── me/photo/              # Photo de profil
├── me/stats/              # Statistiques
├── me/proposals/          # Mes publications
├── profiles/:id/          # Profil public
├── posts/                 # Offres/Demandes de mentorat
├── posts/:id/apply/       # Postuler
├── matching/run/          # Lancer le matching
├── matching/recommendations/ # Recommandations
├── matching/history/      # Historique
├── matching/:id/accept/   # Accepter un match
├── matching/:id/reject/   # Refuser un match
├── conversations/         # Conversations
├── messages/              # Messages
├── notifications/         # Notifications
├── notifications/read/    # Marquer comme lu
├── analytics/dashboard/   # Dashboard
└── onboarding/...         # Processus d'onboarding
```

### Format des réponses

**Succès :**
```json
{ "success": true, "message": "Operation successful", "data": { ... } }
```

**Erreur :**
```json
{ "success": false, "message": "Error description", "errors": { ... } }
```

**Liste paginée :**
```json
{ "count": 42, "next": "http://.../?page=2", "previous": null, "results": [ ... ] }
```

### Authentification JWT

L'API utilise **JSON Web Tokens** avec `djangorestframework-simplejwt`.

| Token | Durée | Usage |
|-------|-------|-------|
| **Access token** | 1 heure | En-tête `Authorization: Bearer <token>` |
| **Refresh token** | 30 jours | Renouvellement via `/auth/refresh` |

**Flux typique :**
```
1. POST /auth/register → { access, refresh, user }
2. Stocker access_token et refresh_token
3. Toutes les requêtes : Authorization: Bearer <access_token>
4. Si 401 : POST /auth/refresh → nouveaux tokens
```

### Endpoints détaillés

Voir le [README.md](./README.md) original ou la documentation Swagger pour la liste complète.

---

## 🔌 WebSockets

MentorLink utilise **Django Channels** pour la communication en temps réel.

### Chat en temps réel

```
ws://localhost:8001/ws/chat/{conversation_id}/
```

**Message entrant :**
```json
{ "type": "SEND_MESSAGE", "content": "Hello!" }
```

**Message sortant :**
```json
{
  "type": "chat.message",
  "event": "MESSAGE_RECEIVED",
  "message": { "id": "uuid", "content": "Hello!", ... }
}
```

### Notifications en temps réel

```
ws://localhost:8001/ws/notifications/
```

**Message sortant :**
```json
{
  "type": "notification.message",
  "event": "NEW_NOTIFICATION",
  "notification": { ... },
  "unread_count": 5
}
```

### Configuration Channels

```python
# config/settings.py
CHANNEL_LAYERS = {
    "default": {
        "BACKEND": "channels_redis.core.RedisChannelLayer",
        "CONFIG": { "hosts": [os.getenv("REDIS_URL", "redis://redis:6379/0")] },
    },
}

ASGI_APPLICATION = "config.asgi.application"
```

### Routing

```python
# apps/chat/routing.py
websocket_urlpatterns = [
    re_path(r"ws/chat/(?P<conversation_id>[a-f0-9-]+)/", ChatConsumer.as_asgi()),
]
```

### Connexion côté client (JavaScript)

```javascript
const token = encodeURIComponent(localStorage.getItem('access_token'));
const ws = new WebSocket(`ws://localhost:8001/ws/chat/${conversationId}?token=${token}`);

ws.onopen = () => ws.send(JSON.stringify({ type: 'SEND_MESSAGE', content: 'Hello!' }));
ws.onmessage = (event) => {
  const data = JSON.parse(event.data);
  if (data.event === 'MESSAGE_RECEIVED') console.log('Message:', data.message);
};
```

---

## 🎨 Frontend

Le frontend est une application **HTML/CSS/JS vanilla** (pas de framework JS) qui communique avec l'API REST.

### Architecture JS

```
frontend/js/
├── api.js                  # Client API (fetch, JWT, refresh automatique)
├── auth.js                 # Login, Register, Logout
├── matching-results.js     # Affichage des recommandations matching
├── modiffier_profil.js     # Modification du profil (skills, availability)
├── mon-profile.js          # Affichage du profil
├── offer.js                # Publication d'une offre de mentorat
├── demande.js              # Publication d'une demande
├── message.js              # Messagerie (HTTP + WebSocket)
├── chat.js                 # Chat temps réel
├── notifs.js               # Notifications
├── dashboard.js            # Tableau de bord
├── settings.js             # Paramètres utilisateur
├── landing.js              # Page d'accueil
├── feed-ifri.js            # Fil d'actualité
├── student-profile.js      # Profil public d'un étudiant
├── sign-up.js              # Inscription
├── sign-up-2.js            # Onboarding étape 2
├── sign-up-3.js            # Onboarding étape 3
└── login.js                # Connexion
```

### Client API (`api.js`)

Le fichier `frontend/js/api.js` fournit des fonctions essentielles :

```javascript
// Fonctions exportées
apiRequest(endpoint, options)  // Requête authentifiée avec refresh automatique
fetchWithAuth(endpoint, options)
fetchWithoutAuth(endpoint, options)
setTokens(tokens)
requireAuth()                  // Redirige vers login si pas de token
updateUserHeader()             // Met à jour le header avec les infos utilisateur
```

### Styles

Les styles utilisent **Tailwind CSS** via CDN. Les feuilles de style personnalisées sont dans `frontend/css/`.

### Pages

| Page | Fichier HTML | Fichier JS | Description |
|------|-------------|-------------|-------------|
| Accueil | `index.html` | `landing.js` | Page d'accueil |
| Connexion | `login.html` | `login.js` | Connexion |
| Inscription | `sign-up.html` | `sign-up.js` | Création de compte |
| Dashboard | `dashboard.html` | `dashboard.js` | Tableau de bord |
| Fil d'actualité | `feed-ifri.html` | `feed-ifri.js` | Publications |
| Matching | `matching-results.html` | `matching-results.js` | Résultats matching |
| Mon profil | `mon-profile.html` | `mon-profile.js` | Vue profil |
| Modifier profil | `modiffier_profil.html` | `modiffier_profil.js` | Édition profil |
| Messages | `message.html` | `message.js` | Messagerie |
| Notifications | `notifs.html` | `notifs.js` | Notifications |
| Offre | `offer.html` | `offer.js` | Publier une offre |
| Demande | `demande.html` | `demande.js` | Publier une demande |
| Paramètres | `settings.html` | `settings.js` | Paramètres |

---

## 🧪 Tests

### Exécuter les tests

```bash
# Tous les tests
docker exec -it mentorlink-app-1 pytest

# Avec couverture de code
docker exec -it mentorlink-app-1 pytest --cov=apps

# Mode verbeux
docker exec -it mentorlink-app-1 pytest -v

# Tests d'une app spécifique
docker exec -it mentorlink-app-1 pytest apps/matching/tests/

# En local (sans Docker)
cd backend
pytest
pytest -v
pytest --cov=apps
```

### Structure des tests

```
backend/
└── apps/
    ├── accounts/
    │   └── tests/test_auth.py        # 5 tests
    ├── profiles/
    │   └── tests/test_profiles.py     # 5 tests
    ├── mentoring/
    │   └── tests/test_mentoring.py    # 3 tests
    ├── matching/
    │   └── tests/test_matcher.py      # 6 tests
    ├── chat/
    │   └── tests/test_chat.py         # 5 tests
    ├── notifications/
    │   └── tests/test_notifications.py # 3 tests
    └── analytics/
        └── tests/test_analytics.py    # 2 tests
                                    ─────────
                TOTAL                29 tests
```

### Configuration des tests

Les tests utilisent une **base de données SQLite en mémoire** (configuration dans `test_settings.py`), donc :
- Pas besoin de PostgreSQL pour les tests
- Les tests sont isolés et rapides
- Les données sont nettoyées entre chaque test

```python
# test_settings.py
DATABASES = { "default": { "ENGINE": "django.db.backends.sqlite3", "NAME": ":memory:" } }
CHANNEL_LAYERS = { "default": { "BACKEND": "channels.layers.InMemoryChannelLayer" } }
CELERY_TASK_ALWAYS_EAGER = True
```

---

## 📜 Scripts utiles

### Makefile (backend/)

```bash
make setup       # Installer dépendances + migrer
make migrate     # Appliquer les migrations
make test        # Lancer les tests
make shell       # Django shell
make superuser   # Créer un super admin
make seed        # Seed la base de données
```

### Commandes Docker

```bash
# Logs
docker compose logs -f app           # Logs de l'app
docker compose logs -f db            # Logs de la DB

# Shell
docker exec -it mentorlink-app-1 sh          # Shell dans le conteneur
docker exec -it mentorlink-app-1 python manage.py shell  # Django shell

# DB
docker exec -it mentorlink-db-1 psql -U mentorlink -d mentorlink

# Redémarrer un service
docker compose restart app

# Voir les logs d'initialisation
docker compose logs mentorlink-app-1
```

### Commandes Django utiles

```bash
# Console Django
python manage.py shell

# Créer un superutilisateur
python manage.py createsuperuser

# Voir les URLs
python manage.py show_urls

# Collecter les fichiers statiques
python manage.py collectstatic

# Vérifier les migrations
python manage.py makemigrations --check
```

---

## 📦 Déploiement

### Variables d'environnement

```bash
# Obligatoires
SECRET_KEY=votre-clé-secrète-forte

# Optionnelles (avec valeurs par défaut)
DEBUG=False
DB_NAME=mentorlink
DB_USER=mentorlink
DB_PASSWORD=mentorlink
DB_HOST=db
DB_PORT=5432
REDIS_URL=redis://redis:6379/0

# Sentry (optionnel)
SENTRY_DSN=https://xxx@sentry.io/yyy
SENTRY_ENVIRONMENT=production
```

### En production

```bash
# Build et déploiement
docker compose up --build -d

# Vérifier que tout tourne
docker compose ps

# Voir les logs
docker compose logs -f --tail=100

# Backup de la base de données
docker exec mentorlink-db-1 pg_dump -U mentorlink -d mentorlink > backup_$(date +%Y%m%d).sql
```

---

## 🤝 Guide de contribution

### Conventions de code

- **Python** : Respecter PEP 8, utiliser des *type hints*
- **JavaScript** : ES Modules, fonctions async/await
- **Commits** : Messages en anglais ou français, descriptifs
- **Branches** : `feature/ma-feature`, `fix/mon-correctif`

### Workflow Git

```bash
# 1. Créer une branche
git checkout -b feature/ma-nouveauté

# 2. Coder et tester
# ...

# 3. Commiter
git add .
git commit -m "feat: ajout de la fonctionnalité X"

# 4. Pusher
git push origin feature/ma-nouveauté

# 5. Créer une Pull Request sur GitHub
```

### Structure des commits

```
feat: ajout de la fonctionnalité X
fix: correction du bug Y
refactor: nettoyage du code de Z
docs: mise à jour de la documentation
test: ajout de tests pour W
chore: mise à jour des dépendances
```

---

## ⚠️ Dépannage

### Problèmes courants

| Problème | Cause possible | Solution |
|----------|---------------|----------|
| `docker: command not found` | Docker pas installé | Installer Docker Desktop |
| Port déjà utilisé | 8001 ou 5433 occupé | `lsof -i :8001` puis `kill -9 <PID>` |
| `relation "users" does not exist` | Migrations pas faites | `docker exec mentorlink-app-1 python manage.py migrate` |
| `FATAL: database "mentorlink" does not exist` | DB pas créée | `docker compose up db` va la créer automatiquement |
| Token invalide/expiré | Access token expiré | Utiliser le refresh token ou se reconnecter |
| WebSocket refuse la connexion | Token manquant ou invalide | Vérifier que le token est passé dans l'URL |
| Erreur 403 sur /posts | Pas authentifié | Vérifier le token JWT dans l'en-tête |
| `No module named 'apps'` | Mauvais répertoire | Se placer dans `backend/` et exécuter depuis là |
| Les images ne s'affichent pas | Media files pas collectés | `docker exec mentorlink-app-1 python manage.py collectstatic --noinput` |

### Reset complet

```bash
# Arrêter tous les conteneurs
docker compose down

# Supprimer les volumes (⚠️ perd les données)
docker compose down -v

# Redémarrer
docker compose up --build -d

# Ré-appliquer les migrations
docker exec mentorlink-app-1 python manage.py migrate

# Re-seed (optionnel)
docker exec mentorlink-app-1 python seed.py
```

---

<div align="center">
  <p><strong>MentorLink</strong> — Développé avec ❤️ pour les étudiants de l'IFRI</p>
  <p>
    <a href="http://localhost:8001/api/docs/">📖 Swagger</a> ·
    <a href="./DB_GUIDE.md">🗄️ DB Guide</a> ·
    <a href="./GUIDE_UTILISATEUR.md">👤 Guide Utilisateur</a>
  </p>
</div>
