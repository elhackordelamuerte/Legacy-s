# ADR-001 : Stratégie de langage et de typage

**Statut** : Accepté (révisé le 2026-09-02 après clarification du cadrage de l'exercice)
**Date** : 2026-09-02
**Proposé par** : Binôme 2 — Audit & Architecture cible (Naem, Rayan)
**Décideurs** : Équipe (6) — validé en revue d'architecture Sprint 1

> **Note de révision** : une première version de cet ADR retenait une migration vers TypeScript strict. Le cadrage de l'exercice a été précisé : l'objectif est de **piloter et corriger un projet legacy en place**, pas de le réécrire ni d'en changer le langage. La décision ci-dessous remplace la précédente pour cette raison, pas pour une raison technique nouvelle.

## Contexte

L'audit (`docs/AUDIT_REPORT.md`, constats #4 et #6) a mis en évidence :

- 100 % du code backend en JavaScript pur (CommonJS), aucun contrat de type, aucun `tsconfig.json`.
- Un bug de fiabilité concret déjà présent : `src/routes/addItem.js` lit `req.body.name` sans validation ; un payload malformé stocke silencieusement `name: undefined` en base.
- Des fichiers de tests écrits en syntaxe Jest existent (`spec/`) mais aucune infrastructure de build/typage ne les accompagne.
- Le cadrage de l'exercice (`STARTING-SPRINT1.md`, `LEGACY - TodoList Rework Project.md`) définit explicitement l'objectif comme la **correction** d'un projet legacy existant, sans réécriture ni changement de langage — le typage doit donc réduire les bugs identifiés sans imposer une migration de fond qui déborderait ce mandat.

La question posée : comment réduire le risque illustré par le bug `name: undefined` sans transformer le Sprint 1 en projet de migration de langage ?

## Alternatives considérées

### Option A — JavaScript + JSDoc, avec `checkJs` en analyse statique

Conserver du JavaScript pur (aucun changement de runtime, de module system, ni d'étape de build), et ajouter des annotations JSDoc (`@param`, `@returns`) sur les fonctions touchées, avec un `tsconfig.json` minimal en mode `checkJs` (utilisé uniquement par `tsc --noEmit` en CI et par l'éditeur pour l'autocomplétion — aucune compilation, aucun fichier `.ts`).

- **Pour** : zéro changement de langage, zéro étape de build supplémentaire dans le pipeline d'exécution (seul `tsc --noEmit` s'ajoute en CI, en lecture seule), courbe d'apprentissage minimale, cohérent avec le mandat « corriger en place ».
- **Contre** : le typage JSDoc reste par nature partiel — il documente une intention, mais n'empêche rien à l'exécution si un fichier n'est pas annoté. Moins de garanties qu'un typage complet.

### Option B — Migration vers TypeScript strict (`strict: true`)

Adopter TypeScript pour tout le code backend, avec le mode strict activé, compilé en CI (échec de build si erreur de type).

- **Pour** : détection des erreurs de contrat à la compilation, écosystème mature (`ts-jest`, `tsc`).
- **Contre** : impose de renommer et retravailler chaque fichier du dépôt (`.js` → `.ts`), ajoute une étape de compilation permanente au runtime de l'application, et constitue de fait une réécriture progressive de l'ensemble de la base — précisément ce que le cadrage de l'exercice exclut. Le risque n'est pas seulement technique : c'est un contresens sur la nature de l'exercice (piloter un legacy, pas le remplacer).

## Décision

**Option A — JavaScript + JSDoc avec `checkJs`.**

- Le langage, le runtime (CommonJS) et la chaîne d'outils existante restent inchangés : aucun fichier n'est renommé en `.ts`, aucune étape de compilation n'est ajoutée à l'exécution de l'application.
- Un `tsconfig.json` minimal (`allowJs: true`, `checkJs: true`, `noEmit: true`) est ajouté au dépôt et exécuté en CI via `tsc --noEmit`, en tant que **vérification statique additionnelle**, pas comme un build.
- Les annotations JSDoc sont ajoutées **au fil de l'eau**, sur les fichiers effectivement corrigés dans le cadre du Sprint 1 (ex. `src/routes/addItem.js` pour fermer le bug identifié dans l'audit), et non rétroactivement sur tout le dépôt.
- Toute nouvelle fonction publique ajoutée dans un module corrigé doit porter une annotation JSDoc de contrat (`@param`, `@returns`) — vérifié en revue de code (voir DoD, `docs/AGILE_GOVERNANCE.md`).

## Conséquences

**Positives :**

- Respecte strictement le cadrage de l'exercice : aucune réécriture, aucun changement de langage.
- Le bug identifié dans l'audit (constat #4) peut être corrigé et documenté par contrat JSDoc sans aucun changement d'outillage de build.
- Coût d'entrée quasi nul pour les 6 développeurs, quel que soit leur niveau sur TypeScript.

**Négatives :**

- Le typage reste partiel et non bloquant par construction : rien n'empêche un développeur d'omettre une annotation JSDoc sur un nouveau bout de code (mitigé par la revue de code obligatoire).
- Moins de garanties qu'un typage complet vérifié par un compilateur strict — accepté comme compromis assumé, cohérent avec le périmètre de l'exercice.
- Si la dette de typage devient bloquante en Sprint 2/3 (ex. surface de code trop large pour être fiabilisée par JSDoc seul), cette décision devra être révisée explicitement via un nouvel ADR — pas contournée silencieusement.
