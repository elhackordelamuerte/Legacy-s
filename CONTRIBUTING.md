# Contribuer à ce projet

Ce dépôt est un projet legacy en cours de correction, pas une réécriture. Avant de contribuer, lisez au moins `docs/AUDIT_REPORT.md` et `docs/adr/` : ils expliquent pourquoi le code est structuré ainsi et ce qui a été délibérément écarté (voir notamment ADR-001 à ADR-003 — pas de TypeScript, pas de PostgreSQL, correction en place).

## 1. Prérequis

- Node.js 20 (version alignée sur `.github/workflows/ci.yml` — le projet n'a pas de version figée aujourd'hui, c'est un défaut connu, voir constat #13 de l'audit).
- `npm` (le dépôt utilise `package-lock.json`, toujours installer avec `npm ci`, jamais `npm install`, pour ne pas dériver du lockfile).

## 2. Installation locale

```bash
npm ci
npm run dev
```

> Les scripts `lint`, `format:check` et `test` sont attendus par la CI (`.github/workflows/ci.yml`) mais ne sont pas encore câblés dans `package.json` — c'est l'objet de l'issue GitHub `[S1-M4]`. Une fois cette issue fermée, les commandes ci-dessous seront disponibles :
>
> ```bash
> npm run lint          # ESLint
> npm run format:check  # Prettier
> npm test              # Jest, avec couverture
> ```

## 3. Workflow Git

### Branches

Une branche par ticket, jamais de commit direct sur `main` (protégé, voir issue `[S1-S3]`) :

```
<type>/<numéro-issue>-<description-courte>
```

Exemples : `fix/6-input-validation`, `feat/16-event-bus`, `chore/1-github-project-setup`.

### Commits — Conventional Commits

Chaque commit respecte un des préfixes suivants (imposé par la Definition of Done, `docs/AGILE_GOVERNANCE.md` §2) :

| Préfixe | Usage |
|---|---|
| `feat:` | Nouvelle capacité (ex. endpoint, mécanisme) |
| `fix:` | Correction de bug |
| `refactor:` | Changement de structure sans changement de comportement |
| `test:` | Ajout/modification de tests uniquement |
| `docs:` | Documentation uniquement |
| `chore:` | Outillage, config, dépendances |

Exemple : `fix: valide le champ name avant stockage (closes #6)`

### Pull Requests

- Une PR = une issue = une branche. La description de la PR doit contenir `closes #<numéro>`.
- Utiliser le template de PR (`.github/pull_request_template.md`) : il embarque la checklist DoD, à cocher intégralement avant de demander une revue.
- **Au moins 1 approbation obligatoire** avant merge. Aucune exception, y compris en fin de sprint.
- Squash-merge recommandé pour garder un historique `main` lisible, aligné sur les Conventional Commits.

## 4. Definition of Done (rappel)

Une tâche n'est **Done** que si tous ces points sont vérifiés (détail complet dans `docs/AGILE_GOVERNANCE.md` §2) :

1. Revue de code approuvée (1 minimum).
2. Issue liée (`closes #X`), Conventional Commits respectés.
3. Tests unitaires ajoutés pour toute logique métier introduite.
4. Quality Gate vert (lint + format + seuil de couverture).
5. Pipeline CI complet passé.
6. Build Docker réussi.
7. Documentation associée mise à jour (ADR si décision d'architecture, ce fichier si convention).
8. Démontrable en Sprint Review.

## 5. Convention de code

- **Langage** : JavaScript (CommonJS), pas de migration vers TypeScript — voir ADR-001. Le typage se fait par annotations JSDoc (`@param`, `@returns`) sur toute fonction publique ajoutée ou modifiée, vérifiées statiquement via `tsc --noEmit` (mode `checkJs`, `tsconfig.json`).
- **Style** : ESLint + Prettier (config à venir, issue `[S1-M4]`) ; en attendant, respecter le style déjà présent dans le fichier édité.
- **Architecture** : les routes (`src/routes/`) ne doivent jamais importer `src/persistence/` directement — elles passent par `src/services/` (voir ADR-002). Toute nouvelle logique métier va dans `src/services/`, pas dans un contrôleur de route.
- **Persistance** : toute évolution de schéma passe par une migration versionnée dans `migrations/`, jamais par une modification manuelle de la base (voir ADR-003).

## 6. Tests

- Framework : Jest. Les fichiers vivent dans `spec/`, en miroir de la structure de `src/` (ex. `src/routes/addItem.js` → `spec/routes/addItem.spec.js`).
- Toute Pull Request qui touche à `src/services/` ou `src/routes/` doit inclure un test correspondant — sans exception (DoD point 3).
- Lancer localement : `npm test` (une fois l'issue `[S1-M4]` fermée).

## 7. Proposer un changement d'architecture (ADR)

Toute décision structurante (langage, architecture, persistance, communication inter-modules) passe par un ADR au format Michael Nygard, dans `docs/adr/` :

1. Copier la structure d'un ADR existant (`docs/adr/ADR-00X-*.md`).
2. Renseigner Contexte, **au moins 2 alternatives réelles comparées**, Décision, Conséquences positives et négatives.
3. Soumettre en Pull Request pour discussion et validation par l'équipe avant de passer le statut à *Accepté*.

Ne jamais changer une décision actée sans passer par ce processus — voir ADR-001/002/003 pour un exemple de révision assumée et documentée plutôt que silencieuse.

## 8. Où trouver le reste

| Sujet | Fichier |
|---|---|
| Audit technique du legacy | `docs/AUDIT_REPORT.md` |
| Décisions d'architecture | `docs/adr/` |
| Rôles, cérémonies, backlog MoSCoW, DoD complète | `docs/AGILE_GOVERNANCE.md` |

> `docs/PLAN_ACTION_SPRINT1.md`, `docs/GITHUB_ISSUES_SPRINT1.md` et `docs/oral/` sont des documents de travail internes à l'équipe (planning, brouillons de tickets, script de soutenance) — volontairement exclus du suivi Git (`.gitignore`), donc absents d'un clone frais du dépôt. Ils circulent hors dépôt (partage direct entre membres de l'équipe).
