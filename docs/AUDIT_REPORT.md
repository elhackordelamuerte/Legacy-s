# Audit technique — TodoList legacy (`docker/getting-started-app`)

| | |
|---|---|
| **Projet** | G-ING-900-PAR-9-1-legacy-3 |
| **Sprint** | Sprint 1 — Fondations & architecture |
| **Date** | 2026-09-02 |
| **Périmètre analysé** | `src/`, `spec/`, `package.json`, `README.md` (état du dépôt au commit `c774917`) |
| **Réalisé par** | Binôme 2 — Audit de la dette technique & Architecture cible (Naem, Rayan) |
| **Méthode** | Lecture exhaustive du code source, du `package.json`/`package-lock.json`, des specs existantes, absence de `.github/`, `Dockerfile`, config lint/format |

> Cet audit ne repose sur aucune supposition générique. Chaque constat renvoie à un fichier ou un extrait de code réellement présent dans le dépôt à la date ci-dessus.

---

## 1. Résumé exécutif

L'application est un CRUD Express minimal (`GET/POST/PUT/DELETE /items`) persistant des todos, avec un frontend React servi statiquement. Le code fonctionne, mais **aucun garde-fou industriel n'est en place** : pas de CI, pas de Dockerfile, pas de linter, pas de typage, et des tests qui existent dans le dépôt mais qui ne peuvent **pas être exécutés** (`jest` n'est pas une dépendance, aucun script `test`). Le tout doit absorber un scope cible bien plus large (auth, GDPR, Kanban, événementiel) sans base solide.

**Constat le plus critique** : trois piliers du Must-Have du projet (pipeline CI, publication d'image Docker, tests exécutables) sont **actuellement à zéro**, pas dégradés — inexistants.

---

## 2. Analyse détaillée par dimension

### 2.1 Langage & Runtime

- **Aucun typage** : 100 % JavaScript (CommonJS, `require`/`module.exports`), aucun `tsconfig.json`, aucun JSDoc de contrat.
- **Aucune version Node figée** : pas de champ `engines` dans `package.json`, pas de `.nvmrc`. Avec 6 développeurs sur des machines différentes, rien n'empêche une divergence de runtime silencieuse.
- Conséquence concrète déjà présente dans le code : `src/routes/addItem.js` lit `req.body.name` sans aucune vérification de présence/type. Un payload malformé stocke silencieusement `name: undefined` en base — aucun typage, aucune validation ne l'empêche.
- → Traité en **ADR-001**.

### 2.2 Dépendances & sécurité

- `package.json` déclare un bloc `overrides` (`tar`, `glob`, `semver`, `cross-spawn`, `braces`, `http-cache-semantics`, `socks`). C'est la preuve qu'un `npm audit fix --force` (ou équivalent manuel) a déjà dû forcer des versions de dépendances **transitives** vulnérables. Le correctif existe, mais aucun processus n'est en place pour détecter la prochaine vulnérabilité — il n'y a pas de `npm audit` ni de scanner de dépendances en CI (inexistante).
- `express` est figé sur `^5.2.1` : Express 5 vient de passer stable et introduit des ruptures de compatibilité avec l'écosystème de middlewares Express 4 ; aucun test de non-régression n'existe pour sécuriser une montée de version future.
- Deux drivers de base de données (`sqlite3`, `mysql2`) sont embarqués **simultanément** alors qu'un seul est utilisé à l'exécution (voir 2.4) : surface de dépendances doublée pour une seule fonctionnalité.

### 2.3 Architecture & couplage

- Chaque route (`src/routes/*.js`) importe directement `../persistence` et appelle le driver bas niveau : **aucune couche domaine/use-case**, le contrôleur HTTP *est* la logique métier.
- `src/persistence/index.js` sélectionne l'implémentation (`sqlite.js` vs `mysql.js`) via la simple présence de `process.env.MYSQL_HOST` — ce n'est pas une abstraction (pas d'interface commune, pas de port), c'est un `if` global au chargement du module.
- `sqlite.js` et `mysql.js` réimplémentent **la même logique CRUD** presque à l'identique (copier-coller), avec une dérive déjà visible : le SQL de `updateItem` diffère entre les deux fichiers (espace superflu, formulation de la clause `WHERE`). C'est la signature classique d'une dette qui va diverger silencieusement.
- → Traité en **ADR-002** (découpage modulaire) et **ADR-003** (persistance unifiée).

### 2.4 Persistance des données

- Schéma SQLite créé inline dans le code (`CREATE TABLE IF NOT EXISTS todo_items (id varchar(36), name varchar(255), completed boolean)`) : **aucune clé primaire, aucune contrainte d'unicité, aucun index**, et surtout **aucun mécanisme de migration versionnée**. Toute évolution de schéma (nécessaire pour Kanban : projets, tâches, utilisateurs, relations) devra être faite à la main, sans traçabilité Git du schéma.
- Aucune configuration de concurrence SQLite (pas de mode WAL, pas de `busy_timeout`) : les écritures concurrentes se sérialiseront ou échoueront sous charge.
- Le driver `mysql.js` lit ses identifiants via des variables `*_FILE` (pattern Docker secrets), alors que `sqlite.js` n'a aucune notion de secret. Deux chemins de persistance = deux modèles de sécurité à auditer.
- → Traité en **ADR-003**.

### 2.5 Tests & qualité

- Des fichiers de tests existent bel et bien (`spec/routes/*.spec.js`, `spec/persistence/sqlite.spec.js`), écrits avec la syntaxe Jest (`test(...)`, `jest.mock(...)`).
- **Mais `jest` n'est déclaré nulle part dans `package.json`** (ni en dépendance, ni en devDependency), et il n'existe **aucun script `test`** (le seul script défini est `"dev": "nodemon -L src/index.js"`). Concrètement : **`npm test` échoue immédiatement, ces tests n'ont probablement jamais tourné dans un pipeline**. C'est plus trompeur qu'une absence totale de tests : un contributeur non averti peut croire le projet couvert alors qu'aucune exécution n'est possible en l'état.
- Aucun linter (pas d'ESLint), aucun formateur (pas de Prettier), aucun `.editorconfig`.

### 2.6 Frontend

- Contrairement à l'hypothèse initiale « JS natif », le frontend est en réalité **React 17 (builds UMD) + react-bootstrap**, mais **compilé côté navigateur** via Babel Standalone (`<script type="text/babel" src="js/app.js">` dans `src/static/index.html`). C'est un anti-pattern connu : le compilateur Babel (plusieurs centaines de Ko) est livré et exécuté à chaque chargement de page, sans build step, sans bundler (pas de webpack/vite), sans minification du code applicatif.
- Toutes les dépendances front (React, ReactDOM, react-bootstrap, Bootstrap CSS, Font Awesome, Babel) sont **vendues manuellement** en fichiers statiques committés, sans manifeste (`package.json` frontend), donc sans version traçable ni intégrité vérifiable (pas de SRI).
- Aucun outillage de test frontend (pas de React Testing Library, pas d'environnement DOM pour Jest).

### 2.7 Build & Packaging (Docker / CI)

- **Aucun `Dockerfile` n'est présent dans le dépôt** — seul un `.dockerignore` y fait référence. L'application ne peut donc **actuellement pas être conteneurisée** dans cet état, ce qui bloque directement l'exigence Must-Have « publication d'image Docker ».
- **Aucun répertoire `.github/`** : aucune CI, aucune vérification automatique sur les Pull Requests. Toute régression (fonctionnelle, sécurité, style) ne peut être détectée qu'à l'œil.
- Aucun healthcheck HTTP (`/health` ou équivalent) n'existe, ce qui bloquera l'orchestration Docker Compose/Kubernetes prévue au walking skeleton.
- Aucune gestion d'erreurs centralisée dans `src/index.js` (pas de middleware d'erreur Express) : une exception non gérée dans une route retombe sur la page d'erreur par défaut d'Express, qui peut exposer la stack trace selon `NODE_ENV`.
- Pas de CORS, pas de Helmet, pas d'en-têtes de sécurité HTTP de base.

---

## 3. Matrice de sévérité de la dette technique

| # | Constat | Domaine | Sévérité | Impact / Risque |
|---|---|---|---|---|
| 1 | Aucune CI (`.github/` absent) | Build/Qualité | **Critique** | Aucune détection automatique de régression, incompatible avec la « CI bloquante » exigée |
| 2 | Aucun `Dockerfile` | Build/Packaging | **Critique** | Bloque le Must-Have « publication d'image Docker » |
| 3 | Tests présents mais non exécutables (`jest` absent, pas de script `test`) | Qualité | **Critique** | Faux sentiment de couverture ; DoD « tests unitaires » inatteignable en l'état |
| 4 | Zéro validation d'entrée sur les 4 routes (`addItem`, `updateItem`, etc.) | Sécurité/Fiabilité | **Critique** | Corruption de données silencieuse (`name: undefined` déjà possible) |
| 5 | Persistance dupliquée SQLite/MySQL sans abstraction ni migrations | Architecture/Données | **Critique** | Divergence déjà observée entre les deux implémentations ; bloquant pour tout schéma relationnel futur |
| 6 | Aucun typage statique | Langage | **Critique** | Aucune garantie de contrat à la compilation, cause racine du constat #4 |
| 7 | Frontend compilé côté client via Babel Standalone, dépendances vendues sans manifeste | Frontend/Supply-chain | **Moyenne** | Performance dégradée, provenance des libs non vérifiable, pas bloquant fonctionnellement à court terme |
| 8 | Aucun linter/formatter/EditorConfig | Qualité | **Moyenne** | Dérive de style garantie à 6 développeurs, aggravée par la rotation en binômes |
| 9 | Aucune gestion d'erreurs centralisée Express | Fiabilité/Sécurité | **Moyenne** | Risque de fuite d'informations (stack trace) selon l'environnement |
| 10 | Overrides npm forcés sur dépendances transitives | Sécurité | **Moyenne** | Vulnérabilités déjà rencontrées une fois ; aucun processus de veille en continu |
| 11 | Pas de CORS/Helmet/en-têtes de sécurité | Sécurité | **Moyenne** | Surface d'attaque basique non couverte, à traiter avant l'introduction de l'authentification (Sprint 2) |
| 12 | Pas de secrets management formalisé (`.env.example` absent) | Sécurité/Ops | **Moyenne** | Onboarding fragile, risque de credentials en clair dans des configs locales |
| 13 | Version Node non figée (`engines` absent) | Ops | **Faible** | Risque « ça marche chez moi », correction triviale |
| 14 | Pas de healthcheck HTTP | Ops | **Faible** | Bloque l'orchestration Docker Compose du walking skeleton, correction triviale |
| 15 | SQLite sans mode WAL / `busy_timeout` | Données | **Faible** | Corrigé en place (SQLite/MySQL conservés), voir ADR-003 et backlog S1-S6 |

---

## 4. Conclusion & priorités Sprint 1

Les constats **critiques (#1 à #6)** définissent directement le périmètre Must-Have du Sprint 1 : ils ne sont pas des optimisations, ce sont des **prérequis bloquants** à toute fonctionnalité future (Kanban, auth, GDPR). Les décisions de remédiation sont formalisées dans `docs/adr/ADR-001` à `ADR-004`, et traduites en backlog MoSCoW dans `docs/AGILE_GOVERNANCE.md`.
