# Issues GitHub — Sprint 2

**Contrairement au document équivalent du Sprint 1, ces issues sont déjà créées sur GitHub** (milestone *Sprint 2 - Core Features*, board #43, colonne Backlog). Ce document sert de référence — contenu exact, critères d'acceptation, dépendances — pas de mode d'emploi de saisie.

Labels utilisés : `priority: must/should/could`, `type:feature` (hors convention, sans espace — label existant sur le repo), `type: enabler`, `type: chore`, `type: docs`, `area: auth/gdpr/projects/tasks/kanban/events/ui/ci-cd`, `area:governance`.

---

## Binôme 2 — Naem & Rayan (Persistance & Services)

*Avant tout ce qui suit : terminer les 4 PR Sprint 1 encore ouvertes — `#48`, `#52`, `#54`, `#55`.*

### #63 — [S2-M1] Migration du schéma : User, Project, Column, Task
**Assigné** : Naem · **Labels** : `priority: must`, `type: enabler`, `area: projects`

Remplace la table plate `todo_items` par le modèle cible (`docs/architecture/data-model.md`).

Critères : migrations versionnées pour les 4 tables (id UUID, FKs, `password_hash`, `consent_given_at`, `priority`, `due_date`, `position`) · décision explicite sur le sort des données `todo_items` existantes.

### #66 — [S2-M4] API CRUD Projets et Tâches
**Assigné** : Rayan · **Labels** : `priority: must`, `type:feature`, `area: projects`, `area: tasks`
**Dépend de** : `#63`

`POST/GET/PATCH/DELETE /projects` et `/tasks` (avec `column_id`, `assignee_id`), validation d'entrée, tests unitaires.

---

## Binôme 1 — Cédric & Etienne (Agile & Backlog → Auth/RGPD ce sprint)

### #64 — [S2-M2] Authentification JWT
**Assigné** : Etienne · **Labels** : `priority: must`, `type:feature`, `area: auth`

`POST /auth/register`, `POST /auth/login`, middleware de vérification de token. Mot de passe hashé (bcrypt), jamais loggé en clair.

### #65 — [S2-M3] Gestion RGPD minimale
**Assigné** : Cédric (`Zeishy`) · **Labels** : `priority: must`, `type:feature`, `area: gdpr`
**Dépend de** : `#63` (champ `consent_given_at` sur `User`)

`consent_given_at` renseigné à l'inscription · `DELETE /users/me` supprime le compte et ses données liées.

---

## Binôme 3 — Florian & Evan (Outillage & CI/CD → Frontend/Events ce sprint)

*Avant tout ce qui suit : PR #59 (Evan, couverture de tests) et PR #62 (Florian, docker-compose) à faire merger.*

### #67 — [S2-M5] Frontend : bootstrap Vite + page de connexion/inscription
**Assigné** : Florian · **Labels** : `priority: must`, `type:feature`, `area: ui`

Remplace React+Babel-en-CDN par un vrai build Vite. Tests Jest + React Testing Library configurés.

### #68 — [S2-M6] Frontend : vue Kanban minimale
**Assigné** : Florian · **Labels** : `priority: must`, `type:feature`, `area: kanban`, `area: ui`
**Dépend de** : `#66`, `#67`

Colonnes + cartes par projet, création de tâche depuis l'UI. Drag & drop hors périmètre (voir `#71`).

### #69 — [S2-M7] Flux événementiel réel
**Assigné** : Evan · **Labels** : `priority: must`, `type:feature`, `area: events`

Étend le prototype Sprint 1 (`task.created` → log, PR #10) à un effet persisté (notification en base), pas juste un log.

### #70 — [S2-M8] CI verte sur l'ensemble + Dockerfile à jour
**Assigné** : Evan · **Labels** : `priority: must`, `type: chore`, `area: ci-cd`

CI verte avec les nouvelles dépendances (Vite, JWT, bcrypt), Dockerfile mis à jour pour le build frontend.

---

## Should Have — non assignées (à répartir une fois le Must Have sécurisé)

| # | Titre | Dépend de |
|---|---|---|
| `#71` | [S2-S1] Drag & drop des cartes entre colonnes | `#68` |
| `#72` | [S2-S2] Priorités et deadlines visibles sur les cartes | `#66`, `#68` |
| `#73` | [S2-S3] Publication de l'image Docker sur un registre (GHCR) | `#70` |
| `#74` | [S2-S4] Notifications visibles côté frontend | `#69`, `#67` |
| `#77` | Formaliser un ADR 0005 (Vite, JWT, validation) | — (non bloquant, mais attendu avant la revue de mi-sprint) |

## Could Have — non assignées

| # | Titre |
|---|---|
| `#75` | [S2-C1] Écran d'accueil personnalisé |
| `#76` | [S2-C2] Export / droit à l'oubli RGPD complet |

---

## Récapitulatif par personne

| Personne | Issues Sprint 2 |
|---|---|
| Naem | `#63` |
| Rayan | `#66` (+ finir `#48`, `#52`, `#54`, `#55` de Sprint 1) |
| Etienne | `#64` |
| Cédric (`Zeishy`) | `#65` |
| Florian | `#67`, `#68` (+ finir `#62`) |
| Evan | `#69`, `#70` (+ finir `#59`) |
