# Changelog Sprint 1 — Foundation & Architecture

Document de suivi partagé (vous + moi) : chaque étape validée y est notée, avec sa preuve. Objectif : voir d'un coup d'œil ce qui est réellement fait vs seulement décidé/documenté. À mettre à jour au fil de l'eau — voir §3.

> Je n'ai pas de visibilité directe sur votre GitHub Project (issues/PR réellement créées, mergées). Ce document reflète ce que je peux vérifier dans les fichiers du dépôt, plus ce que vous me rapportez. S'il diverge de la réalité du board, le board fait foi — dites-le moi et je corrige.

---

## 1. Statut des 7 objectifs officiels du Sprint 1

| # | Objectif (cahier des charges) | Statut | Preuve | Reste à faire |
|---|---|---|---|---|
| 1 | Understand the existing application | ✅ **Validé** | `docs/AUDIT_REPORT.md` — audit ligne par ligne du code réel, 15 constats classés par sévérité | — |
| 2 | Turn the requirements into a usable backlog | ✅ **Validé** (contenu) · 🟡 **saisie GitHub en cours** | Backlog MoSCoW dans `docs/AGILE_GOVERNANCE.md` §3, 22 tickets détaillés dans `docs/GITHUB_ISSUES_SPRINT1.md` | Création effective du board + des issues sur GitHub (`[S1-M3a]`/`[S1-M3b]`, Cédric/Etienne) |
| 3 | Establish your development conventions | ✅ **Validé** | `CONTRIBUTING.md` (branches, Conventional Commits, PR/DoD), `docs/AGILE_GOVERNANCE.md` §1.3 (charte d'équipe) | Activer la protection de branche `main` (`[S1-S3]`) — convention écrite mais pas encore techniquement imposée |
| 4 | Define **and implement** your target architecture | 🟡 **Défini, pas implémenté** | Décidé : ADR-001 (JS+JSDoc), ADR-002 (couche `services/`), ADR-003 (SQLite/MySQL corrigés en place) | Aucun code écrit — `[S1-M6]` `[S1-M7]` `[S1-M8a]` `[S1-M8b]` non démarrés |
| 5 | Establish a working end-to-end application flow | ⬜ **Non démarré** | — | Endpoint de santé `[S1-M9]`, aucune preuve de fonctionnement de bout en bout à ce jour |
| 6 | Introduce the foundations of your event-driven architecture | 🟡 **Défini, pas implémenté** | Décidé : ADR-004 (EventEmitter in-process, port `EventBus`) | `[S1-M10a]` (EventBus) et `[S1-M10b]` (flux démontrable) non démarrés |
| 7 | Establish the CI and quality processes | 🟡 **Gabarit prêt, pipeline rouge** | `.github/workflows/ci.yml` écrit (lint → test → build Docker), Quality Gate défini | Rouge tant que `[S1-M4]` (scripts npm) et `[S1-M5]` (Dockerfile) ne sont pas faits — aucun commit poussé sur le dépôt distant à ce jour |

**Lecture honnête de ce tableau** : la phase de cadrage (comprendre, décider, documenter, planifier) est terminée à 100 %. La phase d'implémentation (objectifs 4 à 7, partie « implement »/« working »/« establish ») est à 0 % en code — c'est attendu et assumé (voir `docs/PLAN_ACTION_SPRINT1.md`), mais c'est la vraie course jusqu'au 12 septembre.

---

## 2. Journal détaillé

### 2026-09-02 — Cadrage : audit et décisions d'architecture

- ✅ Audit technique complet du dépôt réel (`docker/getting-started-app` forké en `G-ING-900-PAR-9-1-legacy-3`) → `docs/AUDIT_REPORT.md`, 15 constats, matrice de sévérité.
- ✅ ADR-001 à ADR-004 rédigés (format Nygard, ≥2 alternatives comparées par décision) → `docs/adr/`.
- 🔁 **Révision assumée** : ADR-001/002/003 initialement rédigés vers TypeScript / PostgreSQL+Prisma / Clean Architecture complète, puis **révisés** vers des corrections en place (JS+JSDoc, SQLite/MySQL corrigés, couche `services/` légère) après clarification du mandat de l'exercice (« piloter le legacy, pas le réécrire »). Documenté dans chaque ADR (bandeau "Note de révision"), pas caché.

### 2026-09-02/03 — Gouvernance et backlog

- ✅ Rôles, charte d'équipe, Definition of Done, checklist GitHub Project, backlog MoSCoW → `docs/AGILE_GOVERNANCE.md`.
- 🔁 Répartition en 3 binômes affinée deux fois : d'abord une répartition technique générique (DevOps/Persistance/Event), puis alignée sur la vraie répartition donnée (Binôme 1 Cédric/Etienne — Agile & Backlog ; Binôme 2 Naem/Rayan — Audit & Architecture ; Binôme 3 Florian/Evan — Outillage & CI/CD).
- ✅ 22 issues prêtes à saisir, avec critères d'acceptation et traçabilité vers les constats d'audit / ADR → `docs/GITHUB_ISSUES_SPRINT1.md`.

### 2026-09-03 — Outillage et conventions

- ✅ Gabarit de pipeline CI (`lint` → `test` → `docker-build`) → `.github/workflows/ci.yml`. Volontairement rouge (scripts npm et Dockerfile pas encore écrits).
- ✅ Script de soutenance Sprint 1, découpé par binôme → `docs/oral/SPRINT1_ORAL.md`.
- ✅ Plan d'action jour par jour jusqu'au 12/09 + tâches immédiates par personne → `docs/PLAN_ACTION_SPRINT1.md`.
- ✅ `CONTRIBUTING.md` : branches, Conventional Commits, règles de PR, DoD, convention de code.
- ✅ Relecture croisée de l'ensemble des documents : 3 incohérences trouvées et corrigées (IDs de backlog obsolètes dans `ci.yml`, référence PostgreSQL périmée dans l'audit, étiquetage de traçabilité dans les issues de gouvernance) ; décision confirmée de garder `docs/PLAN_ACTION_SPRINT1.md`, `docs/GITHUB_ISSUES_SPRINT1.md` et `docs/oral/` hors suivi Git (`.gitignore`, volontaire).

### À venir (rien de coché tant que non confirmé)

- ⬜ `[S1-M3a]`/`[S1-M3b]` — GitHub Project + issues effectivement créés sur GitHub
- ⬜ `[S1-M4]` — Scripts npm (`lint`, `format:check`, `test`) câblés, CI verte
- ⬜ `[S1-M5]` — Dockerfile multi-stage
- ⬜ `[S1-M6]` — Validation d'entrée sur les 4 routes
- ⬜ `[S1-M7]` — Contraintes PK/UNIQUE + migration SQL versionnée
- ⬜ `[S1-M8a]`/`[S1-M8b]` — Couche de service partagée
- ⬜ `[S1-M9]` — Endpoint de health-check
- ⬜ `[S1-M10a]`/`[S1-M10b]` — EventBus + flux événementiel démontrable

---

## 3. Comment tenir ce document à jour

- Dès qu'une issue `[S1-Mx]`/`[S1-Sx]` est **mergée** (PR fermée, DoD respectée) : dites-le-moi (ou éditez directement), j'ajoute une ligne au journal §2 et je fais passer la case correspondante à ✅ en §1 et dans la liste "À venir".
- Un ⬜ qui devient 🟡 = travail commencé mais pas mergé (utile pour voir ce qui traîne).
- Une régression ou un retour en arrière (ex. une PR revert) mérite aussi une ligne — ce changelog n'est pas là pour enjoliver, il sert à savoir où vous en êtes réellement avant le 12/09.
