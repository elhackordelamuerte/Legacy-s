# Changelog Sprint 2 — Core Features

Suivi partagé, même principe que `docs/SPRINT1_CHANGELOG.md`. Rafraîchi par vérification directe du dépôt (`git`/`gh`).

> Dernière vérification : **14/09**.

---

## 1. Statut des 7 objectifs Must Have officiels (cahier des charges §6.1)

| # | Objectif | Statut | Issue(s) | Preuve |
|---|---|---|---|---|
| 1 | Secure authentication | ⬜ Non démarré | `#64` | Assigné à Etienne, démarre le 14/09 |
| 2 | GDPR-compatible user management | ⬜ Non démarré | `#65` | Dépend du schéma (`#63`) |
| 3 | Project and task CRUD operations | ⬜ Non démarré | `#66` | Dépend du schéma (`#63`) |
| 4 | Basic Kanban workflow | ⬜ Non démarré | `#67`, `#68` | Dépend de l'API (`#66`) et du bootstrap frontend (`#67`) |
| 5 | Complete CI pipeline | 🟡 **Déjà vert sur le périmètre Sprint 1** | `#70` | CI verte sur `main` depuis la fin Sprint 1 ; reste à valider avec les nouvelles dépendances |
| 6 | Docker image publication | 🟡 **Build fait, publication non faite** | `#70`, `#73` (Should) | Dockerfile mergé (Sprint 1, PR closes #7) ; publication sur registre = Should Have Sprint 2 |
| 7 | At least one demonstrable event-driven workflow | 🟡 **Prototype livré en Sprint 1, à étendre** | `#69` | `task.created` → handler (PR #10, mergée) ; `#69` demande un effet persisté sur une vraie action produit |

**Lecture honnête** : le socle (CI, Docker build, prototype événementiel) vient de Sprint 1 et n'a pas besoin d'être refait — juste étendu. Les 3 vrais chantiers neufs de Sprint 2 sont l'auth, le CRUD/schéma et le frontend Kanban, et **aucun n'est démarré au moment de la rédaction**.

---

## 2. Journal détaillé

### 2026-09-14 — Cadrage Sprint 2

- ✅ Vérification de l'état réel du repo avant planification : Sprint 1 quasi clos (6 PR restantes, toutes en revue, zéro nouveau code nécessaire), architecture cible déjà décidée en Sprint 1 (`docs/architecture/target-architecture.md`, `data-model.md` : schéma Kanban, JWT, Vite, event bus hybride).
- ✅ `docs/SPRINT2_PLAN.md` rédigé : objectifs, backlog MoSCoW, répartition par binôme.
- ⚠️ **Alerte planning** : milestone GitHub *Sprint 2 - Core Features* dû le **18/09**, soit 4 jours pour un Must Have large (auth, RGPD, CRUD, Kanban, event-driven réel, CI/Docker).
- ⚠️ **Incident** : le board GitHub Project (#43) était **fermé** au moment de créer les issues Sprint 2 — cause inconnue. Rouvert après confirmation de l'utilisateur (`updateProjectV2` via l'API GraphQL, `closed: false`).
- ✅ **15 issues créées** (`#63`–`#77`) : 8 Must Have, 4 Should Have, 2 Could Have, 1 tâche de traçabilité (ADR 0005). Toutes ajoutées au board (colonne Backlog, champ MoSCoW renseigné). Détail dans `docs/GITHUB_ISSUES_SPRINT2.md`.
- 🔧 Erreur de script en cours de route : les 8 premières tentatives de création (Must Have) ont échoué silencieusement côté contenu (mauvaise gestion des guillemets dans une fonction bash) — aucune n'a été créée avant correction, reprises une par une avec succès.
- ✅ Les 8 Must Have assignées à la personne qui les démarre aujourd'hui (Naem `#63`, Etienne `#64`, Cédric `#65`, Rayan `#66`, Florian `#67`/`#68`, Evan `#69`/`#70`).
- ✅ `docs/PLAN_ACTION_SPRINT2.md` rédigé : planning jour par jour jusqu'au 18/09, tâches immédiates par personne.
- 📣 **Retour du correcteur (toutes équipes confondues, pas spécifique à nous)** : aucune équipe n'a abordé la stratégie de déploiement en production, le plan de migration de l'ancienne vers la nouvelle solution, les plans de sauvegarde/rollback avant et après migration, ni l'exploitation quotidienne de la nouvelle solution. Angle mort à traiter (voir §3, point 5).

### À venir (rien de coché tant que non confirmé)

- ⬜ `#48`, `#52`, `#54`, `#55` (Rayan), `#59` (Evan), `#62` (Florian) — PR Sprint 1 à merger
- ⬜ `#63` à `#70` — Must Have Sprint 2
- ⬜ `#77` — ADR 0005

---

## 3. ⚠️ Points de vigilance ouverts

| # | Constat | Action attendue |
|---|---|---|
| 1 | Personne n'a d'expérience React/Vite démontrée — `#67`/`#68` assignées à Florian par défaut | Confirmer en Sprint Planning, réattribuer si besoin |
| 2 | 6 PR Sprint 1 encore ouvertes au lancement de Sprint 2 | Merger avant de considérer Sprint 1 réellement clos |
| 3 | 4 jours pour 8 items Must Have dont 3 chantiers neufs complets (auth, CRUD, Kanban) | Suivre `docs/PLAN_ACTION_SPRINT2.md` §3 — couper des Should Have plutôt que de dégrader la DoD |
| 4 | **Angle mort signalé par le correcteur** : ni le déploiement en production, ni la migration de l'ancienne solution, ni le backup/rollback, ni l'exploitation quotidienne ne sont documentés ou planifiés à ce jour | Voir §4 — au minimum documenter la stratégie avant la prochaine revue |

## 4. 📣 Retour du correcteur — angle mort commun à toutes les équipes

> *"No team spoke about deployment strategy to production, migration from the old to the new solution, backup and rollback plans before and after solution migration, how to operate the new solution on a daily basis."*

Ce n'est pas un bug de notre travail spécifiquement — **aucune** équipe n'a couvert ces points en soutenance Sprint 1. Concrètement, ce qui manque à ce jour dans nos documents :

| Sujet | État actuel | Ce qu'il faudrait |
|---|---|---|
| Déploiement en production | Un `Dockerfile` existe (Sprint 1), mais rien ne dit **où** l'image tourne réellement, ni comment un déploiement se déclenche | Décrire (même simplement) l'environnement cible et le déclenchement d'un déploiement |
| Migration ancienne → nouvelle solution | Question déjà ouverte dans `#63` (sort des données `todo_items`) mais pas encore une vraie stratégie | Décrire le plan de bascule : migration des données existantes ou remise à zéro assumée |
| Backup / rollback | Rien à ce jour | Avant toute migration de schéma : sauvegarde de la base ; en cas d'échec : comment revenir en arrière (image précédente, snapshot DB) |
| Exploitation quotidienne | `/health` existe (Sprint 1) mais pas de runbook | Un minimum : comment vérifier que l'app tourne, où sont les logs, comment redémarrer |

**Proposition** (à valider avec l'équipe, pas décidé unilatéralement) : ajouter une issue de documentation — un ADR ou un `docs/architecture/deployment-ops.md` couvrant ces 4 points — pour le Sprint 2 ou, si le planning ne le permet pas, en tête du Sprint 3 (*"Stabilisation & Quality"*, qui s'y prête thématiquement). Autant le documenter maintenant que de le découvrir en soutenance.

---

## 5. Tenue à jour

Même règle qu'en Sprint 1 : dès qu'une PR ferme une issue Sprint 2, ou en cas de blocage/régression, dites-le-moi ou éditez directement. Objectif : savoir où vous en êtes réellement avant le 18/09, pas enjoliver.
