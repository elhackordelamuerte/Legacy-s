# Issues GitHub prêtes à saisir — Sprint 1

**Mode d'emploi** : créer les issues **dans l'ordre ci-dessous** (les premières posent les labels/le board dont les suivantes ont besoin). Pour chaque issue : copier le **Titre** tel quel dans le champ titre, coller le bloc **Corps** tel quel dans la description, appliquer les **Labels**, assigner la **Personne**, mettre le **Milestone** à `Sprint 1` (échéance 12/09/2026), et respecter les **Dépend de** en les liant en commentaire (`Bloqué par #X`).

Labels à créer en premier (issue #1) : `must-have`, `should-have`, `could-have`, `wont-have`, `type:bug`, `type:chore`, `type:docs`, `type:feature`, `type:refactor`, `area:ci`, `area:persistence`, `area:governance`, `area:events`.

Convention de préfixe des titres : `[S1-Mx]`/`[S1-Sx]`/`[S1-Cx]` renvoie à l'ID exact du backlog dans `docs/AGILE_GOVERNANCE.md` §3. `[ORGA]` désigne une tâche de logistique/planning pour tenir le 12/09 (`docs/PLAN_ACTION_SPRINT1.md`) : elle n'a volontairement pas d'ID MoSCoW, ce n'est pas un défaut de traçabilité.

---

## Binôme 1 — Cédric & Etienne

### Issue 1 — Cédric
**Titre** : `[S1-M3a] Initialiser le GitHub Project (labels, colonnes, jalons)`
**Labels** : `must-have`, `type:chore`, `area:governance`
**Milestone** : Sprint 1

**Corps :**
```
## Contexte
Le board GitHub Projects n'est pas encore opérationnel. C'est le prérequis pour tracer tout
le reste du backlog (docs/AGILE_GOVERNANCE.md §1.4).

## Objectif
Mettre en place la structure du board avant la création des autres issues.

## Critères d'acceptation
- [ ] Labels créés : must-have, should-have, could-have, wont-have, type:bug, type:chore,
      type:docs, type:feature, type:refactor, area:ci, area:persistence, area:governance, area:events
- [ ] Colonnes créées : Backlog → Ready → In Progress → In Review → Done
- [ ] Automatisation : PR ouverte → In Review ; PR mergée → Done
- [ ] Milestone "Sprint 1" créé, échéance 12/09/2026

## Référence
docs/AGILE_GOVERNANCE.md §1.4
```

---

### Issue 2 — Etienne
**Titre** : `[S1-M3b/S1-S2] Créer les issues du backlog Sprint 1 + template de PR`
**Labels** : `must-have`, `type:chore`, `area:governance`
**Milestone** : Sprint 1
**Dépend de** : #1

**Corps :**
```
## Contexte
Le backlog MoSCoW est rédigé (docs/AGILE_GOVERNANCE.md §3) mais pas encore transformé
en issues assignées individuellement.

## Objectif
Créer les issues #6 à #22 de ce document (docs/GITHUB_ISSUES_SPRINT1.md), les assigner
nominativement, publier le template de PR avec la checklist DoD et les modèles d'issues.

## Critères d'acceptation
- [ ] Toutes les issues #6 à #22 créées avec le bon label et la bonne personne assignée
- [ ] .github/pull_request_template.md publié avec la checklist DoD (AGILE_GOVERNANCE.md §2)
- [ ] .github/ISSUE_TEMPLATE/ contient : Bug report, User Story, Tâche technique

## Référence
docs/AGILE_GOVERNANCE.md §1.4, §2
```

---

### Issue 3 — Cédric & Etienne
**Titre** : `[ORGA] Organiser la Sprint Review interne + rétrospective (9 septembre)`
**Labels** : `must-have`, `type:chore`, `area:governance`
**Milestone** : Sprint 1

**Corps :**
```
## Contexte
Le 9/09 marque le gel du scope : plus aucune nouvelle tâche après cette date, seulement
des correctifs bloquants (docs/PLAN_ACTION_SPRINT1.md §2).

## Objectif
Organiser une démo interne du walking skeleton + état du Must Have, suivie d'une
rétrospective courte.

## Critères d'acceptation
- [ ] Créneau bloqué dans les agendas le 9/09
- [ ] Grille de démo préparée (quel ticket, qui montre quoi)
- [ ] docs/RETROSPECTIVE_S1.md créé et rempli après la séance
```

---

### Issue 4 — Cédric
**Titre** : `[ORGA] Organiser la répétition orale chronométrée (10 septembre)`
**Labels** : `must-have`, `type:chore`, `area:governance`
**Milestone** : Sprint 1

**Corps :**
```
## Contexte
Le script oral existe (docs/oral/SPRINT1_ORAL.md) mais n'a jamais été répété ni chronométré.

## Objectif
Répéter chaque section du script en conditions réelles, avec la démo live sur le poste
qui servira à la soutenance.

## Critères d'acceptation
- [ ] Créneau bloqué le 10/09
- [ ] Chronométrage par section (Intro, Binôme 1, Binôme 2, Binôme 3, Conclusion)
- [ ] Démo testée sur la machine réelle de soutenance
```

---

### Issue 5 — Etienne
**Titre** : `[ORGA] Nettoyage final du board + relecture croisée (11 septembre)`
**Labels** : `must-have`, `type:docs`, `area:governance`
**Milestone** : Sprint 1

**Corps :**
```
## Contexte
Dernier jour avant la soutenance : le board et les documents doivent être présentables
à un jury externe.

## Objectif
Nettoyer le board, vérifier l'état de main, relire les documents en croisé, préparer un
plan B pour la démo.

## Critères d'acceptation
- [ ] Board nettoyé (aucune issue orpheline en "In Progress")
- [ ] main vert sur le dernier commit (CI complète passée)
- [ ] Relecture croisée effectuée : chaque doc relu par un binôme différent de celui qui
      l'a écrit, remarques en commentaire d'issue
- [ ] Vidéo de secours de la démo enregistrée et accessible hors ligne
```

---

## Binôme 2 — Naem & Rayan

### Issue 6 — Naem
**Titre** : `[S1-M6] Validation d'entrée sur les routes existantes`
**Labels** : `must-have`, `type:bug`, `area:persistence`
**Milestone** : Sprint 1

**Corps :**
```
## Contexte
src/routes/addItem.js lit req.body.name sans validation : un payload malformé stocke
silencieusement `name: undefined` en base (constat #4 de l'audit).

## Objectif
Valider les entrées des 4 routes (addItem, updateItem, deleteItem, getItems) avant tout
accès à la persistance.

## Critères d'acceptation
- [ ] addItem rejette une requête sans `name` (string non vide) avec un code 400
- [ ] updateItem valide `name`/`completed` avant d'appeler db.updateItem
- [ ] Tests unitaires ajoutés dans spec/routes/ couvrant les cas invalides
- [ ] JSDoc de contrat ajouté sur les fonctions modifiées (ADR-001)

## Références
docs/AUDIT_REPORT.md constat #4 · docs/adr/ADR-001 · docs/adr/ADR-002
```

---

### Issue 7 — Rayan
**Titre** : `[S1-M7] Contraintes PK/UNIQUE + migration SQL versionnée sur todo_items`
**Labels** : `must-have`, `type:chore`, `area:persistence`
**Milestone** : Sprint 1

**Corps :**
```
## Contexte
Le schéma todo_items est créé inline (CREATE TABLE IF NOT EXISTS), sans clé primaire,
sans contrainte d'unicité, sans migration versionnée (constat #5 de l'audit).

## Objectif
Introduire un exécuteur de migrations minimal (fichiers .sql numérotés, appliqués dans
l'ordre au démarrage) et corriger le schéma.

## Critères d'acceptation
- [ ] Dossier migrations/ avec un premier fichier numéroté ajoutant PRIMARY KEY (id)
- [ ] Exécuteur minimal appliquant les migrations dans l'ordre (src/persistence/)
- [ ] Fonctionne sur le driver SQLite ET MySQL
- [ ] Test couvrant l'application de la migration sur une base vierge

## Références
docs/AUDIT_REPORT.md constat #5 · docs/adr/ADR-003
```

---

### Issue 8 — Naem
**Titre** : `[S1-M8a] Extraire une interface de repository commune (SQLite/MySQL)`
**Labels** : `must-have`, `type:refactor`, `area:persistence`
**Milestone** : Sprint 1

**Corps :**
```
## Contexte
sqlite.js et mysql.js dupliquent la même logique CRUD, avec une dérive déjà observée
entre les deux (constat #5 de l'audit).

## Objectif
Définir un contrat de repository unique, implémenté une fois par driver.

## Critères d'acceptation
- [ ] Interface documentée en JSDoc (src/services/ ou src/persistence/repository.js)
- [ ] sqlite.js et mysql.js implémentent ce même contrat
- [ ] Aucune régression sur les tests spec/persistence/

## Références
docs/adr/ADR-002 · docs/adr/ADR-003
```

---

### Issue 9 — Rayan
**Titre** : `[S1-M8b] Migrer les routes pour passer par la couche de service`
**Labels** : `must-have`, `type:refactor`, `area:persistence`
**Milestone** : Sprint 1
**Dépend de** : #8

**Corps :**
```
## Contexte
Suite à #8, les routes doivent passer par la couche de service, plus jamais appeler
src/persistence/ directement (règle fixée par ADR-002).

## Objectif
src/routes/*.js n'importent plus ../persistence mais ../services/.

## Critères d'acceptation
- [ ] Les 4 routes passent par src/services/
- [ ] Revue de code vérifie l'absence d'import direct de persistence dans routes/
- [ ] Tests existants (spec/routes/) toujours verts

## Référence
docs/adr/ADR-002
```

---

### Issue 10 — Naem
**Titre** : `[S1-S5] JSDoc + tsc --noEmit (mode checkJs) sur les fichiers corrigés`
**Labels** : `should-have`, `type:chore`, `area:persistence`
**Milestone** : Sprint 1

**Corps :**
```
## Contexte
ADR-001 retient JavaScript + JSDoc plutôt que TypeScript, avec vérification statique
via tsc --noEmit en mode checkJs.

## Objectif
Ajouter un tsconfig.json minimal et annoter en JSDoc les fichiers touchés ce sprint (#6, #8, #9).

## Critères d'acceptation
- [ ] tsconfig.json ajouté (allowJs, checkJs, noEmit)
- [ ] tsc --noEmit passe sans erreur sur les fichiers modifiés ce sprint

## Référence
docs/adr/ADR-001
```

---

### Issue 11 — Rayan
**Titre** : `[S1-S6] Activer le mode WAL + busy_timeout sur SQLite`
**Labels** : `should-have`, `type:chore`, `area:persistence`
**Milestone** : Sprint 1

**Corps :**
```
## Contexte
Aucune configuration de concurrence sur le driver SQLite (constat #15 de l'audit).

## Objectif
Activer le mode WAL et un busy_timeout raisonnable à l'initialisation de la connexion.

## Critères d'acceptation
- [ ] PRAGMA journal_mode=WAL activé à l'init
- [ ] PRAGMA busy_timeout configuré (ex. 5000 ms)

## Références
docs/AUDIT_REPORT.md constat #15 · docs/adr/ADR-003
```

---

### Issue 12 — Rayan *(Could have — si le temps le permet)*
**Titre** : `[S1-C3] Outillage de génération/numérotation automatique des ADR`
**Labels** : `could-have`, `type:chore`, `area:governance`
**Milestone** : Sprint 1

**Corps :**
```
## Contexte
Les ADR sont numérotées et créées à la main. Un petit script (ou l'outil adr-tools)
pourrait fiabiliser la numérotation pour les sprints suivants.

## Critères d'acceptation
- [ ] Commande unique pour créer un nouvel ADR pré-rempli et numéroté
```

---

## Binôme 3 — Florian & Evan

### Issue 13 — Evan
**Titre** : `[S1-M4] Câbler les scripts npm attendus par la CI (lint, format:check, test)`
**Labels** : `must-have`, `type:chore`, `area:ci`
**Milestone** : Sprint 1

**Corps :**
```
## Contexte
.github/workflows/ci.yml appelle npm run lint, npm run format:check et npm test, qui
n'existent pas dans package.json. ESLint, Prettier et Jest ne sont même pas des
dépendances déclarées (constats #1 et #3 de l'audit). Les fichiers spec/ existent déjà
mais ne tournent jamais.

## Objectif
Ajouter ESLint + Prettier + Jest en devDependencies, configurer les scripts npm, faire
passer la CI au vert.

## Critères d'acceptation
- [ ] eslint, prettier, jest ajoutés en devDependencies
- [ ] Scripts "lint", "format:check", "test" ajoutés dans package.json
- [ ] npm test exécute réellement les fichiers de spec/ (actuellement orphelins)
- [ ] Le pipeline CI (.github/workflows/ci.yml) passe au vert sur une PR de test

## Références
docs/AUDIT_REPORT.md constats #1, #3
```

---

### Issue 14 — Florian
**Titre** : `[S1-M5] Dockerfile multi-stage`
**Labels** : `must-have`, `type:chore`, `area:ci`
**Milestone** : Sprint 1

**Corps :**
```
## Contexte
Aucun Dockerfile n'existe dans le dépôt (constat #2 de l'audit) ; seul un .dockerignore
y fait référence.

## Objectif
Écrire un Dockerfile multi-stage (étape build séparée de l'étape runtime), utilisateur
non-root, image minimale.

## Critères d'acceptation
- [ ] Étape build distincte de l'étape runtime
- [ ] Utilisateur non-root en exécution
- [ ] docker build réussit en local ET dans le job docker-build de ci.yml

## Référence
docs/AUDIT_REPORT.md constat #2
```

---

### Issue 15 — Florian
**Titre** : `[S1-M9] Endpoint de health-check HTTP`
**Labels** : `must-have`, `type:feature`, `area:ci`
**Milestone** : Sprint 1

**Corps :**
```
## Contexte
Aucun endpoint de santé n'existe (constat #14 de l'audit), ce qui bloque toute
orchestration Docker Compose/liveness.

## Objectif
Ajouter GET /health, répondant 200 avec le statut de la connexion à la base.

## Critères d'acceptation
- [ ] Route ajoutée (src/index.js ou via src/services/)
- [ ] Test unitaire couvrant la route (cas OK et cas DB down)

## Référence
docs/AUDIT_REPORT.md constat #14
```

---

### Issue 16 — Evan
**Titre** : `[S1-M10a] EventBus in-process (port + implémentation InMemory)`
**Labels** : `must-have`, `type:feature`, `area:events`
**Milestone** : Sprint 1

**Corps :**
```
## Contexte
ADR-004 retient un EventEmitter in-process encapsulé derrière un port EventBus, sans
broker externe.

## Objectif
Implémenter le contrat publish/subscribe défini par l'ADR.

## Critères d'acceptation
- [ ] Interface EventBus documentée en JSDoc (publish(event), subscribe(type, handler))
- [ ] Implémentation InMemoryEventBus
- [ ] Tests unitaires : publish déclenche bien les subscribers, pas de fuite entre tests

## Référence
docs/adr/ADR-004
```

---

### Issue 17 — Florian
**Titre** : `[S1-M10b] Walking skeleton : flux événementiel démontrable de bout en bout`
**Labels** : `must-have`, `type:feature`, `area:events`
**Milestone** : Sprint 1
**Dépend de** : #16

**Corps :**
```
## Contexte
Le Sprint 1 exige un flux événementiel démontrable de bout en bout, pas seulement le
mécanisme en isolation.

## Objectif
Brancher un exemple concret producteur/consommateur : ex. TaskCreated publié depuis
addItem, traité par un handler observable (log ou effet visible).

## Critères d'acceptation
- [ ] Un événement est publié depuis une route existante (ex. addItem)
- [ ] Un handler distinct le consomme, avec un effet observable (log explicite)
- [ ] Démontrable en Sprint Review : appel API → effet visible du handler

## Référence
docs/adr/ADR-004
```

---

### Issue 18 — Florian
**Titre** : `[S1-S1] docker-compose.yml (app + persistance existante)`
**Labels** : `should-have`, `type:chore`, `area:ci`
**Milestone** : Sprint 1

**Corps :**
```
## Contexte
Aucun environnement de développement reproductible n'existe actuellement.

## Objectif
Orchestrer l'application avec sa persistance existante (SQLite dev / MySQL prod-like),
sans introduire de nouveau moteur de base de données (ADR-003).

## Critères d'acceptation
- [ ] Service "app" + service "db" configurés
- [ ] `docker compose up` démarre une application fonctionnelle en local
```

---

### Issue 19 — Evan
**Titre** : `[S1-S3] Règles de protection de la branche main`
**Labels** : `should-have`, `type:chore`, `area:ci`
**Milestone** : Sprint 1

**Corps :**
```
## Critères d'acceptation
- [ ] Pull Request obligatoire avant tout merge sur main
- [ ] Statut CI vert exigé avant merge
- [ ] Au moins 1 review obligatoire (cohérent avec la DoD)
```

---

### Issue 20 — Evan
**Titre** : `[S1-S4] Seuil de couverture de tests bloquant en CI`
**Labels** : `should-have`, `type:chore`, `area:ci`
**Milestone** : Sprint 1

**Corps :**
```
## Critères d'acceptation
- [ ] Seuil de couverture configuré dans Jest (coverageThreshold)
- [ ] Le job "test" de la CI échoue si le seuil n'est pas atteint
```

---

### Issue 21 — Florian *(Could have)*
**Titre** : `[S1-C1] Hooks pre-commit (Husky)`
**Labels** : `could-have`, `type:chore`, `area:ci`
**Milestone** : Sprint 1

---

### Issue 22 — Evan *(Could have)*
**Titre** : `[S1-C2] commitlint (Conventional Commits en local)`
**Labels** : `could-have`, `type:chore`, `area:governance`
**Milestone** : Sprint 1

---

## Récapitulatif par personne

| Personne | Issues assignées |
|---|---|
| Cédric | #1, #3, #4 |
| Etienne | #2, #3, #5 |
| Naem | #6, #8, #10 |
| Rayan | #7, #9, #11, #12 |
| Florian | #14, #15, #17, #18, #21 |
| Evan | #13, #16, #19, #20, #22 |
