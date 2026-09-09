# Changelog Sprint 1 — Foundation & Architecture


> **Mise à jour le 09/09** : ce document est désormais rafraîchi par vérification directe du dépôt (`git`/`gh`), pas seulement sur déclaration. En cas de doute, je revérifie plutôt que de supposer.

---

## 1. Statut des 7 objectifs officiels du Sprint 1

| # | Objectif (cahier des charges) | Statut | Preuve | Reste à faire |
|---|---|---|---|---|
| 1 | Understand the existing application | ✅ **Validé** | `docs/AUDIT_REPORT.md` (local) + `docs/audit/technical-debt-audit.md` (mergé sur `main`, PR #4) | — |
| 2 | Turn the requirements into a usable backlog | ✅ **Validé** | Backlog MoSCoW `docs/AGILE_GOVERNANCE.md` §3, board GitHub Project actif | Board reconstruit après incident de suppression (voir §3) — plusieurs issues historiques n'y sont pas encore rattachées |
| 3 | Establish your development conventions | ✅ **Validé** (doc) · 🟡 **PR en attente de revue** | `CONTRIBUTING.md` rédigé, PR #20 ouverte depuis plusieurs jours, **0 review à ce jour** | Faire relire/merger PR #20 ; activer la protection de branche `main` (`#12`, pas encore faite) |
| 4 | Define **and implement** your target architecture | 🟡 **En cours d'implémentation** | Décidé : ADR-001/002/003 (mergés via PR #5 et en cours via #23/#25). Code : couche service/validation **pas encore démarrée** | `#31` (validation d'entrée), `#32` (couche de service) — créées le 09/09, personne assigné pour l'instant |
| 5 | Establish a working end-to-end application flow | 🟡 **En cours** | Health-check en PR (#29, non mergée), Dockerfile en PR (#30, non mergée) | Rien de mergé à ce jour permettant une démo de bout en bout |
| 6 | Introduce the foundations of your event-driven architecture | 🟡 **En cours** | ADR-004 mergé (via #5). EventBus : PR #33 ouverte (Evan), walking skeleton : PR #28 ouverte (Florian) | Aucune des deux PR mergée ; PR #33 ne référence même pas `closes #9` (ne fermera pas l'issue automatiquement) |
| 7 | Establish the CI and quality processes | 🟡 **CI verte sur le lint/scripts, pas sur l'ensemble** | PR #21 (scripts npm) **mergée**, issue #6 fermée | Dockerfile (`#7`) et branch protection (`#12`) toujours en attente |

**Lecture honnête** : contrairement à la version précédente de ce document (rédigée le 03/09), l'implémentation a réellement démarré — 3 PR mergées (`#4`, `#5`, `#21`, `#27`), 6 PR ouvertes en cours de revue. Mais **rien de ce qui touche à la persistance applicative (validation, couche de service) n'a encore de PR**, et deux problèmes de traçabilité concrets ralentissent la clôture propre des tickets (voir §3).

---

## 2. Journal détaillé

### 2026-09-02 — Cadrage : audit et décisions d'architecture (local, Claude + Etienne)

- ✅ Audit complet + 4 ADR rédigés localement (`docs/AUDIT_REPORT.md`, `docs/adr/`).
- 🔁 **Révision assumée** : ADR-001/002/003 réorientés de TypeScript/PostgreSQL/Clean Architecture vers des corrections en place, après clarification du mandat de l'exercice.

### 2026-09-02/03 — Gouvernance, backlog, outillage (local)

- ✅ `docs/AGILE_GOVERNANCE.md`, `docs/GITHUB_ISSUES_SPRINT1.md` (22 tickets rédigés), `.github/workflows/ci.yml`, `CONTRIBUTING.md`, script oral v1.

### 2026-09-05/06 — Premières actions réelles sur GitHub

- ✅ Issues `#16`–`#19` créées et assignées (Etienne), PR `#20` (CONTRIBUTING.md) ouverte.
- 🔍 Découverte : l'équipe avait déjà commencé en parallèle (branches `docs/technical-debt-audit`, `docs/target-architecture` par Naem) — doublon partiel avec l'audit/les ADR rédigés localement, signalé à l'équipe plutôt que résolu unilatéralement.
- 🔍 Labels/milestones réels du repo vérifiés et documentés dans `AGILE_GOVERNANCE.md` §1.4 (différents de ma proposition initiale).

### 2026-09-08 — Premiers merges

- ✅ **PR #4** (Naem) — audit technique → mergée, ferme `#1`/`#2`.
- ✅ **PR #5** (Naem) — architecture cible, modèle de données, ADR sync/async → mergée, ferme `#3`.
- 🟡 Rayan reprend la suite : `#22`/`#23` (ADR persistance+migration), `#24`/`#25` (ADR langage/architecture manquants), `#26`/`#27` (compléter l'audit) — la duplication se résorbe organiquement, sans intervention de ma part.

### 2026-09-09 — Vérification complète, incident board, comblement de trous

- ✅ **PR #21** (Evan) mergée → ferme `#6` (scripts npm CI).
- ✅ **PR #27** (Rayan) mergée → ferme `#26` (audit : matrice de sévérité + constats manquants).
- 🟡 PR ouvertes non mergées : `#20` (moi/Etienne), `#23`, `#25` (Rayan), `#28`, `#29`, `#30` (Florian), `#33` (Evan).
- ⚠️ **Incident** : le GitHub Project actif a été supprimé (ancien objet, numéro #9, introuvable via l'API) et recréé (nouveau numéro #43), perdant l'historique de statuts de toute l'équipe — pas seulement le mien. Origine inconnue (ni moi, vérifié par l'absence de toute commande de suppression dans mon historique de session). Mes issues (`#16`–`#19`) reconstruites sur le nouveau board ; **le reste des tickets de l'équipe n'y a pas été rajouté**.
- ✅ Issues `#31` ([S1-M6] validation d'entrée) et `#32` ([S1-M8] couche de service) créées — deux trous du backlog Must Have qui n'avaient encore aucun ticket.
- ✅ Titre/corps de `#17` corrigés (9→10 septembre), alignés sur l'échéance réelle du milestone GitHub.
- ⚠️ Commentaire posté sur PR `#30` (Florian) : référence `closes #14` incorrecte (devrait être `#7`) — **non corrigé à ce jour**.
- 🔁 Script oral (`docs/oral/SPRINT1_ORAL.md`) entièrement restructuré sur le format imposé de soutenance (20 min : 10 présentation + 5 Q&A + 5 feedback coach, 5 rôles formels).
- 🔁 `docs/PLAN_ACTION_SPRINT1.md` : gel de scope décalé du 9 au 10/09 pour matcher l'échéance réelle du milestone GitHub.

---

## 3. ⚠️ Points de vigilance ouverts (à date du 09/09)

| # | Constat | Action attendue |
|---|---|---|
| 1 | Board GitHub Project reconstruit après suppression — `#7,8,10,11,12,13,14,15,22,24` n'y figurent pas | Décider en équipe si on repeuple le reste (voir échange précédent) |
| 2 | PR `#30` référence `closes #14` au lieu de `closes #7` | Florian corrige avant merge |
| 3 | PR `#33` ne référence aucun `closes #X` | Evan ajoute `closes #9` pour fermeture automatique au merge |
| 4 | Issue `#9` marquée "Done" sur le board alors qu'elle est encore ouverte (aucune PR la fermant n'est mergée) | Statut du board à corriger manuellement, ou attendre le merge de `#33` |
| 5 | PR `#20` (CONTRIBUTING.md) ouverte depuis plusieurs jours, 0 review | Demander explicitement une revue avant le gel du 10/09 |
| 6 | Item `#12` (protection de branche) présent sur le board sans statut renseigné | À corriger par qui l'a ajouté |

---

## 4. Comment tenir ce document à jour

- Dès qu'une PR ferme une issue `[S1-Mx]`/`[S1-Sx]`/numéro réel : dites-le-moi ou éditez directement, j'ajoute une ligne au journal §2 et je mets à jour §1/§3.
- Une régression (PR revert, statut de board incohérent) mérite aussi une ligne — ce changelog n'est pas là pour enjoliver, il sert à savoir où vous en êtes réellement avant le 12/09.
