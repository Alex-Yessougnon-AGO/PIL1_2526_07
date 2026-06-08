<div align="center">
  <h1>MentorLink API</h1>
  <p>Plateforme connectant les étudiants <strong>IFRI</strong> pour du mentorat académique et professionnel</p>
  <p>
    <a href="#-stack-technologique"><img src="https://img.shields.io/badge/Django-5.1-092E20?style=flat&logo=django" alt="Django"></a>
    <a href="#-stack-technologique"><img src="https://img.shields.io/badge/DRF-3.15-A30000?style=flat&logo=django" alt="DRF"></a>
    <a href="#-stack-technologique"><img src="https://img.shields.io/badge/PostgreSQL-16-4169E1?style=flat&logo=postgresql" alt="PostgreSQL"></a>
    <a href="#-stack-technologique"><img src="https://img.shields.io/badge/Redis-7-DC382D?style=flat&logo=redis" alt="Redis"></a>
    <a href="#-stack-technologique"><img src="https://img.shields.io/badge/Channels-4.2-46BD01?style=flat&logo=python" alt="Channels"></a>
  </p>
</div>

---

## 📋 Table des matières

- [Stack technologique](#-stack-technologique)
- [Démarrage rapide](#-démarrage-rapide)
- [Architecture de l'API](#-architecture-de-lapi)
- [Format des réponses](#-format-des-réponses)
- [Authentification](#-authentification)
- [Guide de consommation pour le frontend](#-guide-de-consommation-pour-le-frontend)
  - [Exemple avec fetch (JavaScript)](#exemple-avec-fetch-javascript)
  - [Exemple avec axios](#exemple-avec-axios)
  - [Exemple avec React Query / TanStack Query](#exemple-avec-react-query--tanstack-query)
- [Endpoints détaillés](#-endpoints-détaillés)
  - [Auth](#1-authentification-apiv1auth)
  - [Profils](#2-profils-apiv1me)
  - [Mentorat](#3-mentorat-apiv1posts)
  - [Matching](#4-matching-apiv1matching)
  - [Messagerie](#5-messagerie-apiv1conversations--apiv1messages)
  - [Notifications](#6-notifications-apiv1notifications)
  - [Analytics](#7-analytics-apiv1analytics)
- [WebSockets](#-websockets)
- [Pagination & Filtres](#-pagination--filtres)
- [Codes d'erreur](#-codes-derreur)
- [Tests](#-tests)
- [Déploiement](#-déploiement)
- [Contribution](#-contribution)

---

## 🛠 Stack technologique

| Technologie | Version | Usage |
|-------------|---------|-------|
| **Django** | 5.1.4 | Framework backend |
| **Django REST Framework** | 3.15.2 | API REST |
| **PostgreSQL** | 16 | Base de données |
| **Redis** | 7 | Cache, Celery, WebSockets |
| **Daphne / Channels** | 4.2 | WebSockets temps réel |
| **Celery** | 5.4 | Tâches asynchrones |
| **SimpleJWT** | 5.4.0 | Authentification JWT |
| **drf-spectacular** | 0.28.0 | Documentation Swagger/OpenAPI |
| **Sentry** | 2.62.0 | Monitoring des erreurs |

---

## 🚀 Démarrage rapide

### Mettre le projet sur GitHub

```bash
# 1. Créer un dépôt vide sur https://github.com/new
#    (Ne PAS cocher "Add a README", "Add .gitignore" ou "Choose a license")

# 2. Connecter le dépôt local à GitHub
git remote add origin https://github.com/votre-username/mentorlink.git

# 3. Pousser le code
git push -u origin main
```

### Avec Docker (recommandé)

```bash
# Cloner le projet
git clone https://github.com/votre-username/mentorlink.git
cd mentorlink

# Lancer tous les services
docker compose up --build

# Les services seront disponibles sur :
# - API :        http://localhost:8001/api/v1/
# - Swagger UI :  http://localhost:8001/api/docs/
# - Admin :       http://localhost:8001/admin/
```

### Sans Docker

```bash
cd backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Configurer PostgreSQL puis :
python manage.py migrate
python manage.py runserver
```

---

## 🏗 Architecture de l'API

**Base URL :** `http://localhost:8001/api/v1/`

Tous les endpoints sont préfixés par `/api/v1/`. L'authentification se fait via **JWT Bearer tokens**.

```
/api/v1/
├── auth/                  # Authentification
│   ├── POST /register
│   ├── POST /login
│   ├── POST /refresh
│   ├── POST /logout
│   ├── POST /request-reset
│   └── POST /reset-password
├── me/                    # Profil utilisateur
│   ├── GET|PATCH /
│   ├── POST /photo
│   ├── POST /skills
│   ├── DELETE /skills/:id
│   ├── POST /availability
│   └── DELETE /availability/:id
├── posts/                 # Mentorat
│   ├── GET|POST /
│   ├── GET|PATCH|DELETE /:id
│   └── POST /:id/apply
├── matching/              # Matching intelligent
│   ├── POST /run
│   ├── GET /recommendations
│   ├── GET /history
│   ├── POST /:id/accept
│   └── POST /:id/reject
├── conversations/         # Messagerie
│   ├── GET|POST /
│   └── GET /:id
├── messages/              # Messages
│   ├── GET /?conversation=:id
│   └── POST /
├── notifications/         # Notifications
│   ├── GET /
│   └── POST /read
└── analytics/             # Analytics
    └── GET /dashboard
```

---

## 📦 Format des réponses

### Succès
```json
{
  "success": true,
  "message": "Registration successful",
  "data": { ... }
}
```

### Erreur
```json
{
  "success": false,
  "message": "Validation failed",
  "errors": { "email": ["Email already registered"] }
}
```

### Pagination (listes)
```json
{
  "count": 42,
  "next": "http://.../?page=3",
  "previous": "http://.../?page=1",
  "results": [ ... ]
}
```

**Paramètres de pagination :**
- `?page=2` — Numéro de page
- `?page_size=50` — Éléments par page (défaut: 20, max: 200)

---

## 🔐 Authentification

L'API utilise **JWT (JSON Web Tokens)** via `djangorestframework-simplejwt`.

### Flux d'authentification

```
1. INSCRIPTION ──→ Obtient access_token + refresh_token
2. CONNEXION  ──→ Obtient access_token + refresh_token
3. REQUÊTES   ──→ En-tête: Authorization: Bearer <access_token>
4. RAFRAÎCHIR ──→ POST /refresh avec refresh_token → Nouveaux tokens
5. DÉCONNEXION ──→ POST /logout avec refresh_token → Blacklist
```

### Durée de vie des tokens

| Token | Durée |
|-------|-------|
| **Access token** | 1 heure |
| **Refresh token** | 30 jours (rotate & blacklist) |

### En-têtes HTTP

```http
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
Content-Type: application/json
```

---

## 🎯 Guide de consommation pour le frontend

### Exemple avec fetch (JavaScript)

```javascript
const API_BASE = 'http://localhost:8001/api/v1';

// === 1. INSCRIPTION ===
async function register(firstName, lastName, email, password) {
  const res = await fetch(`${API_BASE}/auth/register`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ first_name: firstName, last_name: lastName, email, password }),
  });
  return res.json();
}

// === 2. CONNEXION ===
async function login(identifier, password) {
  const res = await fetch(`${API_BASE}/auth/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ identifier, password }), // email ou téléphone
  });
  const data = await res.json();
  if (data.success) {
    localStorage.setItem('access_token', data.data.access);
    localStorage.setItem('refresh_token', data.data.refresh);
  }
  return data;
}

// === 3. REQUÊTE AUTHENTIFIÉE ===
async function getProfile() {
  const token = localStorage.getItem('access_token');
  const res = await fetch(`${API_BASE}/me`, {
    headers: { 'Authorization': `Bearer ${token}` },
  });
  return res.json();
}

// === 4. RAFRAÎCHIR LE TOKEN ===
async function refreshToken() {
  const refresh = localStorage.getItem('refresh_token');
  const res = await fetch(`${API_BASE}/auth/refresh`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ refresh }),
  });
  const data = await res.json();
  if (data.success) {
    localStorage.setItem('access_token', data.data.access);
    localStorage.setItem('refresh_token', data.data.refresh);
  }
  return data;
}

// === 5. INTERCEPTEUR AUTO-RAFRAÎCHISSEMENT ===
async function fetchWithAuth(url, options = {}) {
  let token = localStorage.getItem('access_token');
  let res = await fetch(url, {
    ...options,
    headers: { ...options.headers, 'Authorization': `Bearer ${token}` },
  });
  
  // Si 401, on tente un refresh
  if (res.status === 401) {
    const refresh = await refreshToken();
    if (refresh.success) {
      token = localStorage.getItem('access_token');
      res = await fetch(url, {
        ...options,
        headers: { ...options.headers, 'Authorization': `Bearer ${token}` },
      });
    }
  }
  return res.json();
}

// === 6. UPLOAD DE FICHIER (photo de profil) ===
async function uploadPhoto(file) {
  const token = localStorage.getItem('access_token');
  const formData = new FormData();
  formData.append('photo', file);
  
  const res = await fetch(`${API_BASE}/me/photo`, {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${token}` }, // PAS de Content-Type ici ! fetch le définit automatiquement
    body: formData,
  });
  return res.json();
}
```

### Exemple avec axios

```javascript
import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:8001/api/v1',
});

// Intercepteur pour ajouter le token
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('access_token');
  if (token) config.headers.Authorization = `Bearer ${token}`;
  return config;
});

// Intercepteur pour rafraîchir le token automatiquement
api.interceptors.response.use(
  (response) => response,
  async (error) => {
    if (error.response?.status === 401) {
      const refresh = localStorage.getItem('refresh_token');
      const { data } = await axios.post(`${api.defaults.baseURL}/auth/refresh`, { refresh });
      if (data.success) {
        localStorage.setItem('access_token', data.data.access);
        localStorage.setItem('refresh_token', data.data.refresh);
        error.config.headers.Authorization = `Bearer ${data.data.access}`;
        return api(error.config);
      }
    }
    return Promise.reject(error);
  }
);

// Utilisation
const login = async (email, password) => {
  const { data } = await api.post('/auth/login', { identifier: email, password });
  if (data.success) {
    localStorage.setItem('access_token', data.data.access);
    localStorage.setItem('refresh_token', data.data.refresh);
  }
  return data;
};

const getPosts = async () => {
  const { data } = await api.get('/posts');
  return data;
};

const createPost = async (postData) => {
  const { data } = await api.post('/posts', postData);
  return data;
};
```

### Exemple avec React Query / TanStack Query

```tsx
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';

const API = 'http://localhost:8001/api/v1';

// Hook d'authentification
function useLogin() {
  return useMutation({
    mutationFn: ({ identifier, password }) =>
      fetch(`${API}/auth/login`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ identifier, password }),
      }).then(r => r.json()),
    onSuccess: (data) => {
      if (data.success) {
        localStorage.setItem('access_token', data.data.access);
        localStorage.setItem('refresh_token', data.data.refresh);
      }
    },
  });
}

// Hook pour lister les posts
function usePosts(filters = {}) {
  const params = new URLSearchParams(filters);
  return useQuery({
    queryKey: ['posts', filters],
    queryFn: () =>
      fetch(`${API}/posts?${params}`, {
        headers: { Authorization: `Bearer ${localStorage.getItem('access_token')}` },
      }).then(r => r.json()),
  });
}

// Hook pour créer un post
function useCreatePost() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: (postData) =>
      fetch(`${API}/posts`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${localStorage.getItem('access_token')}`,
        },
        body: JSON.stringify(postData),
      }).then(r => r.json()),
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ['posts'] }),
  });
}
```

---

## 📖 Endpoints détaillés

### 1. Authentification (`/api/v1/auth/`)

---

#### `POST /auth/register` — Créer un compte

**Requête :**
```json
{
  "first_name": "Alice",
  "last_name": "Konan",
  "email": "alice@example.com",
  "phone": "+2250102030405",
  "password": "securepass123"
}
```
*Note : `phone` est optionnel.*

**Réponse (201) :**
```json
{
  "success": true,
  "message": "Registration successful",
  "data": {
    "user_id": "550e8400-e29b-41d4-a716-446655440000",
    "access": "eyJhbGciOiJIUzI1NiIs...",
    "refresh": "eyJhbGciOiJIUzI1NiIs..."
  }
}
```

---

#### `POST /auth/login` — Connexion

**Requête :**
```json
{
  "identifier": "alice@example.com",
  "password": "securepass123"
}
```
*`identifier` peut être un email OU un numéro de téléphone.*

**Réponse (200) :**
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "access": "eyJhbGciOiJIUzI1NiIs...",
    "refresh": "eyJhbGciOiJIUzI1NiIs...",
    "user": {
      "id": "550e8400-...",
      "email": "alice@example.com",
      "first_name": "Alice",
      "last_name": "Konan"
    }
  }
}
```

**Erreur (401) :**
```json
{
  "success": false,
  "message": "Invalid credentials",
  "errors": {}
}
```

---

#### `POST /auth/refresh` — Rafraîchir le token

**Requête :**
```json
{ "refresh": "eyJhbGciOiJIUzI1NiIs..." }
```

**Réponse (200) :**
```json
{
  "success": true,
  "message": "Token refreshed",
  "data": {
    "access": "eyJhbGciOiJIUzI1NiIs...",
    "refresh": "eyJhbGciOiJIUzI1NiIs..."
  }
}
```

---

#### `POST /auth/logout` — Déconnexion

**Requête :**
```json
{ "refresh": "eyJhbGciOiJIUzI1NiIs..." }
```

**Réponse (200) :**
```json
{
  "success": true,
  "message": "Logged out successfully",
  "data": null
}
```

---

#### `POST /auth/request-reset` — Demander un reset de mot de passe

**Requête :**
```json
{ "email": "alice@example.com" }
```

**Réponse (200) :**
```json
{
  "success": true,
  "message": "If email exists, reset link sent",
  "data": null
}
```

---

#### `POST /auth/reset-password` — Réinitialiser le mot de passe

**Requête :**
```json
{
  "token": "abc123...",
  "new_password": "newsecurepass456"
}
```

**Réponse (200) :**
```json
{
  "success": true,
  "message": "Password reset successfully",
  "data": null
}
```

---

### 2. Profils (`/api/v1/me`)

Tous les endpoints de profil nécessitent **authentification JWT**.

---

#### `GET /me` — Consulter son profil

**Réponse (200) :**
```json
{
  "success": true,
  "message": "Operation successful",
  "data": {
    "id": "uuid",
    "user": {
      "id": "uuid",
      "email": "alice@example.com",
      "phone": "+2250102030405",
      "first_name": "Alice",
      "last_name": "Konan"
    },
    "profile_photo": null,
    "department": "Informatique",
    "academic_level": "M2",
    "bio": "Senior developer passionate about teaching",
    "skills": [
      { "id": "uuid", "skill": "uuid", "skill_name": "Python", "type": "STRENGTH", "created_at": "..." }
    ],
    "availability": [
      { "id": "uuid", "day_of_week": "MONDAY", "start_time": "09:00:00", "end_time": "12:00:00", "created_at": "..." }
    ]
  }
}
```

---

#### `PATCH /me` — Modifier son profil

**Requête :**
```json
{
  "bio": "New bio text",
  "department": "Informatique",
  "academic_level": "M2"
}
```
*Champs modifiables : `bio`, `department`, `academic_level`*

**Réponse (200) :** Profil mis à jour.

---

#### `POST /me/photo` — Uploader une photo

**Requête :** `multipart/form-data`
```
photo: [fichier image]
```
*Limite : 5 Mo max.*

**Réponse (200) :** Profil avec `profile_photo` renseigné.

---

#### `POST /me/skills` — Ajouter une compétence

**Requête :**
```json
{
  "name": "Python",
  "type": "STRENGTH"
}
```
*`type` : `"STRENGTH"` (force) ou `"WEAKNESS"` (faiblesse)*

**Réponse (201) :**
```json
{
  "success": true,
  "message": "Skill added",
  "data": { "id": "uuid", "skill": "uuid", "skill_name": "Python", "type": "STRENGTH" }
}
```

---

#### `DELETE /me/skills/{id}` — Supprimer une compétence

**Réponse (200) :**
```json
{ "success": true, "message": "Skill removed", "data": null }
```

---

#### `POST /me/availability` — Ajouter un créneau

**Requête :**
```json
{
  "day": "MONDAY",
  "start": "09:00",
  "end": "12:00"
}
```
*Jours : `MONDAY`, `TUESDAY`, `WEDNESDAY`, `THURSDAY`, `FRIDAY`, `SATURDAY`, `SUNDAY`*

**Réponse (201) :** Créneau ajouté.

---

#### `DELETE /me/availability/{id}` — Supprimer un créneau

**Réponse (200) :**
```json
{ "success": true, "message": "Availability removed", "data": null }
```

---

### 3. Mentorat (`/api/v1/posts`)

---

#### `GET /posts` — Lister les offres/demandes

**Paramètres de filtrage :**
| Paramètre | Valeurs | Description |
|-----------|---------|-------------|
| `type` | `OFFER`, `REQUEST` | Type de post |
| `subject` | texte | Recherche dans le sujet |
| `format` | `ONLINE`, `PHYSICAL`, `BOTH` | Format |
| `status` | `OPEN`, `MATCHED`, `CLOSED` | Statut (défaut: OPEN) |
| `department` | texte | Département du créateur |
| `page` | nombre | Pagination |

**Réponse (200) :** Paginée.

---

#### `POST /posts` — Créer une offre ou demande

**Requête :**
```json
{
  "type": "OFFER",
  "subject": "Python Mentoring for Beginners",
  "description": "I can help you learn Python from scratch",
  "format": "ONLINE"
}
```
*`type`: `OFFER` (offrir du mentorat) ou `REQUEST` (demander du mentorat)*

**Réponse (201) :** Post créé.

---

#### `GET /posts/{id}` — Détail d'un post

**Réponse (200) :** Détail du post avec créateur.

---

#### `PATCH /posts/{id}` — Modifier un post

**Requête :**
```json
{ "subject": "New subject", "description": "New description", "format": "BOTH" }
```
*Champs modifiables : `subject`, `description`, `format`*

**Note :** Seul le créateur du post peut le modifier.

---

#### `DELETE /posts/{id}` — Supprimer un post

**Réponse (200) :** Post supprimé (soft delete).

---

#### `POST /posts/{id}/apply` — Postuler à une offre

- Si le post est une `OFFER` : le demandeur postule comme **mentee**
- Si le post est une `REQUEST` : le postulant postule comme **mentor**

**Réponse (201) :**
```json
{
  "success": true,
  "message": "Match created",
  "data": {
    "match_id": "uuid",
    "match_created": true,
    "score": 63.0
  }
}
```

---

### 4. Matching (`/api/v1/matching/`)

---

#### `POST /matching/run` — Lancer le matching

Lance l'algorithme de matching pour l'utilisateur connecté. Le score est calculé sur :

| Critère | Poids | Description |
|---------|-------|-------------|
| Compétences | 50% | Forces du mentor correspondent aux faiblesses du mentoré |
| Disponibilités | 30% | Créneaux horaires communs |
| Département | 10% | Même département = meilleur score |
| Niveau académique | 10% | Niveau proche = meilleur score |

**Réponse (200) :** Liste des nouveaux matchs créés avec scores.

---

#### `GET /matching/recommendations` — Recommandations

**Réponse (200) :** Liste des matchs en attente avec scores et infos détaillées.

---

#### `GET /matching/history` — Historique des matchs

**Réponse (200) :** Historique complet.

---

#### `POST /matching/{id}/accept` — Accepter un match

Met le statut du match à `ACCEPTED` et ferme les posts associés.

**Réponse (200) :**
```json
{ "success": true, "message": "Match accepted", "data": { "status": "ACCEPTED", ... } }
```

---

#### `POST /matching/{id}/reject` — Refuser un match

**Réponse (200) :**
```json
{ "success": true, "message": "Match rejected", "data": { "status": "REJECTED", ... } }
```

---

### 5. Messagerie (`/api/v1/conversations/` & `/api/v1/messages/`)

---

#### `GET /conversations` — Lister ses conversations

**Réponse (200) :** Paginée. Chaque conversation contient les membres et le dernier message.

---

#### `POST /conversations` — Créer une conversation

**Requête :**
```json
{ "user_id": "uuid-de-l-autre-utilisateur" }
```

**Réponse (201) :**
```json
{
  "success": true,
  "message": "Conversation created",
  "data": {
    "conversation_id": "uuid",
    "data": { "id": "uuid", "members": [...], "last_message": null, ... }
  }
}
```

---

#### `GET /conversations/{id}` — Détail d'une conversation

**Note :** Seuls les membres de la conversation peuvent y accéder (403 sinon).

---

#### `GET /messages?conversation={id}` — Messages d'une conversation

**Réponse (200) :** Paginée, triée par date croissante.

---

#### `POST /messages` — Envoyer un message

**Requête :**
```json
{
  "conversation_id": "uuid",
  "content": "Hello! Would you like to mentor me?"
}
```

**Réponse (201) :** Message créé avec son horodatage.

---

### 6. Notifications (`/api/v1/notifications/`)

---

#### `GET /notifications` — Lister les notifications

**Réponse (200) :** Paginée.
```json
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "user_id": "uuid",
      "type": "NEW_MATCH",
      "title": "New Match Found",
      "content": "You have a new potential mentor match",
      "metadata": null,
      "is_read": false,
      "created_at": "2025-01-01T00:00:00Z"
    }
  ]
}
```

**Types de notifications :** `NEW_MESSAGE`, `NEW_MATCH`, `MATCH_ACCEPTED`, `MATCH_REJECTED`

---

#### `POST /notifications/read` — Marquer comme lues

**Requête :**
```json
{ "ids": ["uuid-1", "uuid-2"] }
```

**Réponse (200) :**
```json
{ "success": true, "message": "Notifications marked as read", "data": { "updated": 2 } }
```

---

### 7. Analytics (`/api/v1/analytics/`)

---

#### `GET /analytics/dashboard` — Tableau de bord

**Réponse (200) :**
```json
{
  "success": true,
  "message": "Dashboard data retrieved",
  "data": {
    "posts_count": 5,
    "active_posts": 3,
    "matches": 2,
    "pending_matches": 1,
    "unread_notifications": 0
  }
}
```

---

## 🔌 WebSockets

L'API supporte les connexions WebSocket pour les fonctionnalités temps réel.

### Chat en temps réel

```
ws://localhost:8001/ws/chat/{conversation_id}/
```

**Message entrant (client → serveur) :**
```json
{ "type": "SEND_MESSAGE", "content": "Hello!" }
```

**Message sortant (serveur → client) :**
```json
{
  "type": "chat.message",
  "event": "MESSAGE_RECEIVED",
  "message": {
    "id": "uuid",
    "conversation_id": "uuid",
    "sender_id": "uuid",
    "content": "Hello!",
    "created_at": "2025-01-01T00:00:00Z"
  }
}
```

**Indicateur de frappe :**
```json
{ "type": "TYPING" }
```

**Accusé de lecture :**
```json
{ "type": "READ" }
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

### Exemple JavaScript WebSocket

```javascript
const token = localStorage.getItem('access_token');
const ws = new WebSocket(`ws://localhost:8001/ws/chat/${conversationId}/`);

// Authentification via cookie de session (Django Channels)
ws.onopen = () => {
  ws.send(JSON.stringify({ type: 'SEND_MESSAGE', content: 'Hello!' }));
  ws.send(JSON.stringify({ type: 'TYPING' }));
};

ws.onmessage = (event) => {
  const data = JSON.parse(event.data);
  if (data.event === 'MESSAGE_RECEIVED') {
    console.log('Nouveau message:', data.message);
  }
};
```

---

## 🔍 Pagination & Filtres

### Pagination
```
GET /api/v1/posts?page=2&page_size=50
```

### Filtres disponibles

| Endpoint | Paramètres de filtre |
|----------|---------------------|
| `GET /posts` | `type`, `subject`, `format`, `status`, `department` |
| `GET /messages` | `conversation` (obligatoire) |

### Recherche
```
GET /api/v1/posts?search=python
```
*Recherche textuelle sur les champs pertinents.*

### Tri
```
GET /api/v1/posts?ordering=-created_at
```
*Préfixez par `-` pour un ordre décroissant.*

---

## ⚠️ Codes d'erreur

| Code | Signification | Quand |
|------|---------------|-------|
| **200** | Succès | Requête traitée avec succès |
| **201** | Créé | Ressource créée |
| **400** | Requête invalide | Données manquantes ou invalides |
| **401** | Non authentifié | Token manquant, invalide ou expiré |
| **403** | Interdit | Pas les permissions nécessaires |
| **404** | Introuvable | Ressource inexistante |

---

## 🧪 Tests

```bash
cd backend
pytest                 # Lance tous les tests
pytest -v              # Mode verbeux
pytest --cov=apps      # Avec couverture de code
```

**29 tests — 100% de succès.**

| App | Tests | Couvre |
|-----|-------|--------|
| accounts | 5 | Inscription, connexion, refresh, logout |
| profiles | 5 | CRUD profil, compétences, disponibilités |
| mentoring | 3 | Création, liste, candidature |
| matching | 6 | Scoring, compatibilité, API |
| chat | 5 | Conversations, messages, permissions |
| notifications | 3 | Liste, marquage lecture |
| analytics | 2 | Dashboard |

---

## 📦 Déploiement

### Variables d'environnement

```bash
# Django
SECRET_KEY=votre-clé-secrète
DEBUG=False
ALLOWED_HOSTS=votre-domaine.com

# Base de données
DB_NAME=mentorlink
DB_USER=mentorlink
DB_PASSWORD=votre-mot-de-passe
DB_HOST=db
DB_PORT=5432

# Redis
REDIS_URL=redis://redis:6379/0

# Sentry (optionnel)
SENTRY_DSN=https://xxx@sentry.io/yyy
SENTRY_ENVIRONMENT=production
SENTRY_TRACES_SAMPLE_RATE=0.1
```

### Production

```bash
docker compose -f docker-compose.yml up --build -d
```

---

## 🤝 Contribution

1. Fork le projet
2. Créez votre branche (`git checkout -b feature/ma-feature`)
3. Commitez (`git commit -m 'feat: ajout de ma feature'`)
4. Push (`git push origin feature/ma-feature`)
5. Ouvrez une Pull Request

---

<div align="center">
  <p>Développé avec ❤️ pour les étudiants <strong>IFRI</strong></p>
  <p>
    <a href="http://localhost:8001/api/docs/" target="_blank">📖 Documentation Swagger</a>
    ·
    <a href="http://localhost:8001/api/schema/" target="_blank">📄 Schéma OpenAPI</a>
  </p>
</div>
