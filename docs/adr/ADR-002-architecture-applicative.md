# ADR-002 : Architecture applicative

**Statut** : Accepté (révisé le 2026-09-02 après clarification du cadrage de l'exercice)
**Date** : 2026-09-02
**Proposé par** : Binôme 2 — Audit & Architecture cible (Naem, Rayan)
**Décideurs** : Équipe (6) — validé en revue d'architecture Sprint 1

> **Note de révision** : une première version de cet ADR retenait une restructuration complète en modules Clean/Hexagonale (dossiers `domain/`/`infrastructure/` par contexte). Le cadrage de l'exercice a été précisé : piloter et corriger le legacy en place, sans le réécrire. La décision ci-dessous privilégie une correction incrémentale à blast radius minimal.

## Contexte

L'audit (`docs/AUDIT_REPORT.md`, constat #5) montre que l'architecture actuelle couple directement le routeur à la persistance :

- Chaque fichier de `src/routes/` importe directement `../persistence` et appelle le driver bas niveau — aucune couche intermédiaire, aucun point unique de validation.
- `src/persistence/index.js` sélectionne l'implémentation via un simple test sur une variable d'environnement, sans interface commune.
- Les implémentations SQLite et MySQL dupliquent la même logique CRUD, avec une dérive déjà observée entre les deux (constat #5).
- Le mandat de l'exercice est de **corriger** ces deux défauts concrets (duplication, absence de validation) sans réécrire la structure existante du projet.

La question : comment supprimer la duplication et ajouter une validation centralisée sans restructurer l'ensemble du dépôt en profondeur ?

## Alternatives considérées

### Option A — Réécriture complète en architecture Clean/Hexagonale

Restructurer tout `src/` en modules verticaux (`domain/`, `infrastructure/` par contexte métier), avec ports et adaptateurs.

- **Pour** : séparation des responsabilités et testabilité maximales.
- **Contre** : touche pratiquement chaque fichier du dépôt existant, ce qui constitue de fait une réécriture de la structure applicative — hors mandat de l'exercice, et coûteux en temps sur un sprint de 10 jours déjà chargé (audit, ADR, gouvernance, CI, walking skeleton).

### Option B — Correction incrémentale par extraction d'une couche de service (approche « Strangler »)

Conserver la structure de dossiers existante (`src/routes/`, `src/persistence/`), et extraire une fine couche `src/services/` entre les deux, qui :
1. expose une interface de repository commune, implémentée une fois par driver (SQLite, MySQL) — ce qui supprime la duplication de logique CRUD (constat #5) sans retirer ni remplacer aucun des deux drivers ;
2. centralise la validation d'entrée absente aujourd'hui dans chaque route (constat #4).

Les fichiers ne sont modifiés que lorsqu'ils sont concernés par une correction (bug, duplication) ou par une capacité ajoutée plus tard (Kanban, auth) — jamais en bloc.

- **Pour** : corrige les deux défauts critiques identifiés par l'audit avec un changement minimal et localisé, respecte le mandat « corriger sans réécrire », risque de conflit réduit entre les binômes qui travaillent en parallèle sur des fichiers différents.
- **Contre** : moins rigide qu'une architecture hexagonale complète — les frontières entre couches restent des conventions de code, pas des contraintes imposées par la structure de dossiers.

## Décision

**Option B — Extraction incrémentale d'une couche de service, façon Strangler Fig.**

- `src/services/` regroupe la logique métier extraite des routes (validation, orchestration), sans toucher au reste de l'arborescence existante.
- Une interface de repository commune est définie et implémentée une fois par driver de persistance (cf. ADR-003), remplaçant la duplication actuelle entre `sqlite.js` et `mysql.js`.
- Toute nouvelle route doit passer par `src/services/`, jamais appeler `src/persistence/` directement — règle vérifiée en revue de code (DoD).
- Aucune restructuration rétroactive du code qui fonctionne déjà et n'est pas concerné par une correction identifiée dans l'audit.

## Conséquences

**Positives :**

- Corrige les deux défauts critiques (duplication CRUD, absence de validation) sans réécrire la structure du projet.
- Blast radius minimal : chaque binôme peut avancer sur son périmètre sans attendre une restructuration globale.
- Respecte strictement le mandat de l'exercice (piloter/corriger, pas remplacer).

**Négatives :**

- Moins de garanties structurelles qu'une architecture hexagonale complète : rien n'empêche techniquement (hors revue de code) qu'une future route recontourne `src/services/` pour appeler `src/persistence/` directement — le risque de recréer le couplage initial existe si la discipline de revue n'est pas maintenue.
- Si le scope grossit fortement en Sprint 2/3 (Kanban, auth, notifications), cette structure légère pourrait devenir insuffisante ; une restructuration plus profonde resterait alors à décider explicitement via un nouvel ADR, pas improvisée en cours de route.
