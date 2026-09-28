# Changelog Sprint 1 — Foundation & Architecture

Suivi partagé (vous + moi). Rafraîchi par vérification directe du dépôt (`git`/`gh`).
Le suivi officiel de l'équipe est `docs/SPRINT1_RECAP.md` (par binôme) — ce document-ci croise avec l'état réel du repo.

> Dernière vérification : **10/09, ~18h**.

---

## 1. Statut des 7 objectifs officiels

| # | Objectif | Statut | Preuve | Reste à faire |
|---|---|---|---|---|
| 1 | Understand the existing application | ✅ **Validé** | `docs/audit/technical-debt-audit.md` (mergé, PR #4 + #27 + #46) | — |
| 2 | Turn the requirements into a usable backlog | ✅ **Validé** | Board GitHub Project #43 actif, `docs/AGILE_GOVERNANCE.md` §4 (mergé, PR #58) | Board repeuplé par l'admin après incident, quelques statuts encore incohérents |
| 3 | Establish your development conventions | ✅ **Validé** | `CONTRIBUTING.md` + templates PR/issue **mergés** (PR #20) ; `docs/AGILE_GOVERNANCE.md` **mergé** (PR #58) ; `commitlint`+`husky` mergés (PR #49) | Protection de branche `main` : `#12` marquée fermée mais **aucune règle n'est réellement configurée** (`gh api .../protection` → 404) |
| 4 | Define **and implement** your target architecture | 🟡 **Bien avancé** | ADR `0002`/`0003`/`0004` mergés (PR #23/#25). Code : validation d'entrée mergée (PR #36, ferme `#31`), interface repository commune mergée (PR #37), JSDoc/`checkJs` mergé (PR #38/#39) | Migrations + PK (`#50`, PR #52 ouverte), routes → couche de service (`#51`, PR #54 ouverte) |
| 5 | Establish a working end-to-end application flow | 🟡 **En cours** | — | Health-check (`#8`, PR #29) et Dockerfile (`#7`, PR #30) : **PR ouvertes, pas mergées** — rien ne permet encore une démo de bout en bout |
| 6 | Introduce the foundations of your event-driven architecture | 🟡 **Fondation posée** | ADR `0001` (sync/async) mergé ; **EventBus in-process mergé** (PR #33, ferme `#9`) ; test événementiel en CI mergé (PR #42) | Flux producteur→consommateur démontrable (`#10`, PR #28 ouverte) |
| 7 | Establish the CI and quality processes | 🟡 **Outillage en place, CI sans signal** | Scripts `lint`/`format:check`/`test` mergés (PR #21), `commitlint`+`husky` mergés | **`package-lock.json` absent de `main`** → `npm ci` échoue en 3 s sur toutes les PR. La CI ne produit aucun résultat exploitable. Dockerfile (`#7`) toujours en attente |

**Lecture honnête** : le cadrage et une bonne partie de l'exécution sont mergés. Les points restants pour la démo du 12 : **flux événementiel de bout en bout, health-check, Dockerfile** (3 PR ouvertes) — et la **CI reste cassée pour tout le monde** faute de lockfile sur `main` (assumé pour le contexte Sprint 1 selon l'équipe).

---

## 2. Journal détaillé

### 2026-09-02/03 — Cadrage (local, Claude + Etienne)

- ✅ Audit + 4 ADR + gouvernance + backlog + gabarit CI + script oral, en local.
- 🔁 **Révision assumée** : ADR réorientés de TypeScript/PostgreSQL/Clean Architecture vers des corrections en place.

### 2026-09-05/06 — Premières actions GitHub

- ✅ Issues `#16`–`#19` créées/assignées (Etienne), PR `#20` ouverte.
- 🔍 L'équipe avait démarré en parallèle (audit + architecture par Naem) — doublon signalé, résolu organiquement par la suite (Rayan complète, PR #23/#25/#27).

### 2026-09-08 — Premiers merges

- ✅ PR #4 (audit), PR #5 (architecture cible + ADR) — Naem. Ferme `#1`/`#2`/`#3`.

### 2026-09-09 — Vérification, incident board, comblement de trous

- ✅ PR #21 (scripts CI, Evan), PR #27 (matrice de sévérité, Rayan) mergées.
- ⚠️ **Incident** : le GitHub Project #9 a été supprimé (introuvable via l'API) et recréé en #43, perdant les statuts de toute l'équipe. Vérifié que ce n'est pas venu de ma session (aucune commande de suppression). Mes issues reconstruites sur #43.
- ✅ Issues `#31` (validation) et `#32` (couche de service) créées — trous du backlog Must Have.
- 🔁 Script oral restructuré au format imposé (20 min, 5 rôles). Plan d'action : gel décalé 9→10/09 (échéance réelle du milestone).

### 2026-09-10 — Vague de merges, CI cassée, gouvernance publiée

- ✅ **Mergé** : EventBus in-process (#33, ferme `#9`), validation d'entrée (#36, ferme `#31`), interface repository (#37), JSDoc/checkJs (#38/#39), ADR persistance/langage/architecture (#23/#25), `commitlint`+`husky` (#49/#56), test événementiel en CI (#42), dédup audit (#46), RECAP par binôme (#40).
- ✅ **PR #20 mergée** (Zeishy) → `CONTRIBUTING.md` + templates PR/issue sur `main`. Ferme `#19`. **Débloque `#16`** (les templates sont enfin sur `main` → `#16` peut être fermée).
- ✅ **PR #58 mergée** (Zeishy) → `docs/AGILE_GOVERNANCE.md` sur `main`. Ferme `#57`. La partie « organisation d'équipe » de la soutenance a maintenant un document de référence.
- 🔧 Avant merge, `CONTRIBUTING.md` et `AGILE_GOVERNANCE.md` **réalignés** sur la vraie structure de `main` (ADR `000X`, `docs/audit/`, `docs/SPRINT1_RECAP.md`) — ils pointaient tous vers des chemins locaux inexistants.
- 🔁 Script oral et slides (`docs/oral/SPRINT1_SLIDES.md`, nouveau) réalignés sur la vraie numérotation d'ADR.
- ⚠️ **Découverte** : `package-lock.json` absent de `main` → CI cassée pour toute l'équipe depuis ~PR #46. Non corrigé (assumé pour le contexte Sprint 1).

---

## 3. ⚠️ Points de vigilance (au 10/09)

| # | Constat | État | Action |
|---|---|---|---|
| 1 | CI cassée sur `main` — `package-lock.json` absent, `npm ci` échoue avant tout check | Ouvert (assumé) | Régénérer le lockfile sur une branche depuis `main` si on veut un signal CI |
| 2 | PR `#30` (Dockerfile) référence `closes #14` au lieu de `closes #7` | **Toujours pas corrigé** | Florian corrige avant merge, sinon la mauvaise issue se ferme |
| 3 | Protection de branche `main` : `#12` fermée mais aucune règle configurée | Ouvert | Configurer réellement, ou rouvrir `#12` |
| 4 | Issue `#14` (Husky) : `.husky/` + `commitlint.config.js` sont sur `main` (via #49) mais l'issue est restée ouverte | Ouvert | Fermer `#14` |
| 5 | Board #43 : quelques items sans statut ou avec statut périmé (ex. `#31` fermée mais affichée Backlog) | Ouvert | Nettoyage (issue `#18`, prévu le 11/09) |

### Résolus depuis le 09/09

- PR `#20` mergée (était : 0 review depuis 5 jours).
- Board repeuplé par l'admin de l'org.
- `#33` mergée et `#9` fermée (le manque de `closes #9` n'a pas posé problème au final).
- Trou audit/architecture résorbé (Rayan a tout complété et fait merger).

---

## 4. Statut des issues d'Etienne (`elhackordelamuerte`)

| # | Titre | État |
|---|---|---|
| 16 | Créer les issues du backlog + template de PR | 🟢 **Fermable maintenant** (templates mergés via #20, backlog créé) |
| 17 | ORGA — Sprint Review interne + rétro (10/09) | ⬜ à tenir aujourd'hui, puis rédiger le compte-rendu |
| 18 | ORGA — Nettoyage final du board + relecture croisée (11/09) | ⬜ demain |
| 19 | Publier CONTRIBUTING.md | ✅ **Fermée** (PR #20 mergée) |
| 57 | Publier docs/AGILE_GOVERNANCE.md | ✅ **Fermée** (PR #58 mergée) |

---

## 5. Tenue à jour

Dès qu'une PR ferme une issue, ou en cas de régression / incohérence de board : dites-le-moi ou éditez directement. Ce document n'enjolive rien — il sert à savoir où vous en êtes réellement avant le 12/09.
