# Plan Sprint 2 — Core Features

**Rédigé le** : 14 septembre 2026
**Échéance** : milestone GitHub *Sprint 2 - Core Features*, due le **18 septembre 2026** — soit **4 jours**.

> ⚠️ **Alerte planning avant tout le reste** : 4 jours pour authentification + RGPD + CRUD projets/tâches + Kanban + publication Docker + flux événementiel réel, c'est un Must Have de sprint objectivement large pour le délai. Ce document propose une coupe MoSCoW volontairement stricte pour livrer un cœur fonctionnel complet plutôt que six fonctionnalités à moitié faites (rappel du sujet : *"Quality over quantity"*).

---

## 0. Où on part (vérifié sur le repo le 14/09)

**Sprint 1 est quasi clos** — 6 PR encore ouvertes, toutes déjà en cours de revue, aucune ne nécessite de nouveau code :

| PR | Contenu | Auteur |
|---|---|---|
| #48 | WAL + busy_timeout SQLite (closes #47) | Rayan |
| #52 | Migrations versionnées + PK (closes #50) | Rayan |
| #54 | Routes → couche de service (closes #51) | Rayan |
| #55 | Outillage numérotation ADR (closes #53) | Rayan |
| #59 | Couverture de tests en CI | Evan |
| #62 | docker-compose (closes #11) | Florian |

**À faire en tout premier** : faire relire et merger ces 6 PR avant d'ouvrir le moindre chantier Sprint 2 — sinon Rayan se retrouve à rebaser 4 PR en parallèle du nouveau travail.

**L'architecture cible pour Sprint 2 est déjà décidée** (Binôme 2, Sprint 1) — ce n'est pas à re-discuter, juste à implémenter :

- **Modèle de données** (`docs/architecture/data-model.md`) : `User → Project → Column → Task`, avec `password_hash`, `consent_given_at` (RGPD), `priority`, `due_date`, `position` (drag & drop).
- **Frontend** : migration vers **React + Vite** (vrai build, tests Jest + React Testing Library) — remplace le React+Babel-en-CDN actuel.
- **Auth** : **JWT**, stateless.
- **Validation** : middleware centralisé (ex. Zod) + gestion d'erreurs HTTP centralisée.
- **Event-driven** : hybride REST (sync) + events (async) — le prototype `task.created` → notification livré en Sprint 1 (PR #10) est le patron à réutiliser pour les nouveaux événements (`task.assigned`, `task.moved`, etc.).

Rien de tout ça n'est encore implémenté sauf le prototype événementiel Sprint 1.

---

## 1. Objectifs officiels du Sprint 2 (cahier des charges)

> Focus on delivering the main functional requirements. The quality process should now be fully integrated into your development workflow. Features should be delivered incrementally through short Pull Requests rather than through one large final integration.

Concrètement : la DoD (`CONTRIBUTING.md` §4) s'applique sans exception dès la première PR — ce n'est plus une mise en place, c'est un acquis à faire tenir. Chaque fonctionnalité arrive en petites PR indépendantes, pas en une seule branche géante.

---

## 2. Backlog MoSCoW — coupe réaliste pour 4 jours

### Must Have

| ID | Item | Domaine |
|---|---|---|
| S2-M1 | Migration du schéma : `User`, `Project`, `Column`, `Task` (remplace `todo_items`) | Data |
| S2-M2 | Authentification JWT : inscription, connexion, middleware de vérification de token | Auth |
| S2-M3 | Gestion RGPD minimale : consentement à l'inscription (`consent_given_at`), endpoint de suppression de compte | Auth |
| S2-M4 | API CRUD Projets + Tâches (`POST/GET/PATCH/DELETE /projects`, `/tasks`) | Backend |
| S2-M5 | Frontend : bootstrap Vite + React, page de connexion/inscription | Frontend |
| S2-M6 | Frontend : vue Kanban minimale (colonnes + cartes, sans drag & drop obligatoire pour le Must Have) | Frontend |
| S2-M7 | Flux événementiel réel sur une action produit (ex. `task.created` → notification persistée, pas juste un log) | Events |
| S2-M8 | CI verte sur l'ensemble (finir #59), Dockerfile à jour avec les nouvelles dépendances | CI/CD |

### Should Have (si le Must Have est sécurisé avant le 17/09)

| ID | Item |
|---|---|
| S2-S1 | Drag & drop des cartes entre colonnes (`position`) |
| S2-S2 | Priorités et deadlines visibles sur les cartes |
| S2-S3 | Publication de l'image Docker sur un registre (GHCR) |
| S2-S4 | Notifications visibles côté frontend (pas seulement en base) |

### Could Have

- Écran d'accueil personnalisé
- Export/droit à l'oubli RGPD complet (au-delà de la suppression de compte)

### Won't Have (ce sprint, à documenter pour Sprint 3)

- Fermeture automatique de projet
- Pipeline de Continuous Delivery complet
- Tests de contrat inter-composants

---

## 3. Répartition par binôme

La continuité des binômes est gardée (habitudes de revue déjà rodées), mais le **périmètre change** : Sprint 2 est du développement produit, plus du cadrage.

| Binôme | Membres | Périmètre Sprint 2 |
|---|---|---|
| **Binôme 1** | Cédric, Etienne | **Auth & RGPD** (S2-M2, S2-M3) + suivi du backlog/board Sprint 2 (continuité du rôle Agile) |
| **Binôme 2** | Naem, Rayan | Finir les 4 PR Sprint 1 en cours, puis **migration du schéma + API CRUD Projets/Tâches** (S2-M1, S2-M4) — continuité directe de leur travail data-model/persistence |
| **Binôme 3** | Florian, Evan | **Frontend Vite + Kanban** (S2-M5, S2-M6) et **event-driven réel + CI/CD** (S2-M7, S2-M8) |

> ⚠️ **Décision d'équipe nécessaire, pas la mienne** : personne n'a touché au frontend en Sprint 1 (tout le travail était backend/outillage). Je n'ai aucune donnée sur qui est à l'aise en React/Vite. Confirmez en Sprint Planning que Florian/Evan sont partants pour le frontend, sinon réattribuez S2-M5/M6 à un autre binôme et compensez ailleurs.

---

## 4. Tâches immédiates par personne (aujourd'hui, 14/09)

| Personne | Tâche du jour |
|---|---|
| **Rayan** | Terminer et faire merger ses 4 PR ouvertes (#48, #52, #54, #55) — priorité absolue avant tout nouveau code. |
| **Evan** | Finir PR #59 (couverture de tests), puis démarrer S2-M8 (CI verte sur l'ensemble). |
| **Florian** | Faire merger PR #62 (docker-compose), puis lancer le bootstrap Vite (S2-M5) — squelette de projet frontend, pas encore de fonctionnalité. |
| **Naem** | En attendant que les PR de Rayan soient mergées, préparer la migration de schéma (S2-M1) sur une branche : script de migration `User`/`Project`/`Column`/`Task`. |
| **Cédric** | Créer les issues Sprint 2 sur le board (milestone déjà existant), à partir du backlog §2 de ce document. |
| **Etienne** | Démarrer S2-M2 (auth JWT) : choix de la librairie (`jsonwebtoken` + `bcrypt`), squelette du module `src/auth/`. |

**Avant la fin de journée, toute l'équipe** : Sprint Planning Sprint 2 — valider ce backlog, trancher la question frontend (§3), répartir les issues sur le board.

---

## 5. Point ouvert à formaliser

Le choix **Vite / JWT / validation centralisée** est documenté dans `docs/architecture/target-architecture.md` (tableau "Choix techniques") mais **pas dans un ADR dédié**, contrairement à la pratique du Sprint 1 (*"chaque changement structurant passe par un ADR"*, `CONTRIBUTING.md` §7). À considérer : un ADR `0005` formalisant ces choix avec leurs alternatives, pour rester cohérent avec la traçabilité déjà démontrée en soutenance — pas bloquant pour démarrer, mais à faire avant la revue de mi-sprint.
