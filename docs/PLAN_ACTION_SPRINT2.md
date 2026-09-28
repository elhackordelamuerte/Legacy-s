# Plan d'action Sprint 2 — jusqu'au 18 septembre

**Date de rédaction** : lundi 14 septembre 2026
**Échéance** : vendredi 18 septembre 2026 (milestone GitHub *Sprint 2 - Core Features*) — soit **4 jours**.

## 0. Où on en est réellement

Sprint 1 est validé (soutenance passée). **Reste 6 PR Sprint 1 non mergées** (aucune ne demande de nouveau code, juste une revue) : #48, #52, #54, #55 (Rayan), #59 (Evan), #62 (Florian). Priorité absolue avant d'ouvrir le moindre chantier Sprint 2 — sinon Rayan rebase 4 PR en parallèle du nouveau travail.

L'architecture cible Sprint 2 est déjà décidée (voir `docs/architecture/target-architecture.md`, `data-model.md`) : schéma `User/Project/Column/Task`, auth JWT, frontend React+Vite, event bus hybride sync/async. **15 issues Sprint 2 sont déjà créées et sur le board** (`#63`–`#77`, milestone *Sprint 2 - Core Features*, détail dans `docs/GITHUB_ISSUES_SPRINT2.md`).

**Action collective avant tout code (aujourd'hui)** : Sprint Planning Sprint 2 — valider le backlog, et **trancher qui fait le frontend** (personne n'a touché à React/Vite en Sprint 1, l'assignation actuelle de `#67`/`#68` à Florian est une proposition, pas un fait acquis).

---

## 1. À faire à l'instant, par personne (14/09)

| Personne | Binôme | Tâche immédiate |
|---|---|---|
| **Rayan** | 2 — Persistance & Services | Terminer et faire merger ses 4 PR Sprint 1 (`#48`, `#52`, `#54`, `#55`) avant tout nouveau code. Une fois fait, démarrer **`#66`** (S2-M4, API CRUD Projets/Tâches). |
| **Naem** | 2 — Persistance & Services | Démarrer **`#63`** (S2-M1, migration du schéma `User/Project/Column/Task`) sur une branche dédiée, sans attendre les PR de Rayan (fichiers différents). |
| **Evan** | 3 — Outillage & CI/CD | Finir **PR #59** (couverture de tests), puis démarrer **`#70`** (S2-M8, CI verte avec les nouvelles dépendances) en parallèle de **`#69`** (S2-M7, flux événementiel réel). |
| **Florian** | 3 — Outillage & CI/CD | Faire merger **PR #62** (docker-compose), puis démarrer **`#67`** (S2-M5, bootstrap Vite) — squelette de projet uniquement aujourd'hui, pas de fonctionnalité. |
| **Etienne** | 1 — Agile & Backlog | Démarrer **`#64`** (S2-M2, auth JWT) : choix de librairie (`jsonwebtoken` + `bcrypt`), squelette `src/auth/`. |
| **Cédric** (`Zeishy`) | 1 — Agile & Backlog | Démarrer **`#65`** (S2-M3, RGPD minimale) — dépend du schéma `User` de Naem (`#63`), peut commencer par le squelette d'endpoint `DELETE /users/me` en attendant. |

**Avant la fin de journée, toute l'équipe** : Sprint Planning — confirmer la répartition ci-dessus, en particulier le frontend (voir §3).

---

## 2. Planning jour par jour

| Date | Jour | Objectif du jour | Jalon |
|---|---|---|---|
| **14 sept.** | Lun | Merge des 6 PR Sprint 1 restantes. Sprint Planning Sprint 2. Démarrage `#63` (schéma), `#64` (auth), `#67` (Vite bootstrap) | Sprint 1 clos à 100 %, Sprint 2 lancé |
| **15 sept.** | Mar | `#63` mergée. `#64`, `#65` avancent. `#67` opérationnel (build Vite qui tourne). `#69`/`#70` avancent | Schéma en base, premier build frontend |
| **16 sept.** | Mer | `#66` (API CRUD) démarre sur le nouveau schéma. `#64` mergée si possible (auth fonctionnelle). `#68` (vue Kanban) démarre | Auth fonctionnelle de bout en bout (register/login) |
| **17 sept.** | Jeu | **Jour d'intégration** : `#68` consomme l'API de `#66`, `#69` branché sur une vraie action produit. Point d'équipe : Must Have réellement Done vs à risque — arbitrer Should Have en conséquence | Démo interne à blanc du parcours complet (inscription → connexion → créer un projet → voir une tâche) |
| **18 sept.** | Ven | Finalisation : `#70` (CI/Dockerfile à jour), nettoyage, préparation de la démo/soutenance si prévue. Should Have (`#71`–`#74`) seulement si le Must Have est sécurisé | Milestone *Sprint 2* clos |

---

## 3. Règles de vigilance

- **Ne pas commencer les Should/Could Have (`#71`–`#76`) tant que le Must Have (`#63`–`#70`) n'est pas Done** — 4 jours ne pardonnent pas la dispersion.
- `#65` (RGPD) et `#66` (CRUD) dépendent du schéma `#63` — Naem doit livrer vite, ou les autres démarrent sur des mocks en attendant pour ne pas rester bloqués.
- Le frontend (`#67`/`#68`) est le risque principal du sprint : zéro expérience Vite/React démontrée par l'équipe en Sprint 1. Si ça bloque le 16, en parler immédiatement plutôt que d'espérer que ça se débloque seul.
- La DoD (`CONTRIBUTING.md` §4) s'applique sans exception, y compris sous pression de deadline — c'est explicitement l'objectif du Sprint 2 (*"quality process now fully integrated"*).
- L'ADR `0005` (`#77`) n'est pas bloquante mais ne doit pas être oubliée — c'est ce qui a été salué à la soutenance Sprint 1.
