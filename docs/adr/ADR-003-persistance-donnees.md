# ADR-003 : Persistance et intégrité des données

**Statut** : Accepté (révisé le 2026-09-02 après clarification du cadrage de l'exercice)
**Date** : 2026-09-02
**Proposé par** : Binôme 2 — Audit & Architecture cible (Naem, Rayan)
**Décideurs** : Équipe (6) — validé en revue d'architecture Sprint 1

> **Note de révision** : une première version de cet ADR retenait une migration vers PostgreSQL + Prisma. Le cadrage de l'exercice a été précisé : corriger le legacy existant en place, sans changer de moteur de base de données. La décision ci-dessous corrige les défauts concrets identifiés par l'audit sans remplacer SQLite/MySQL.

## Contexte

L'audit (`docs/AUDIT_REPORT.md`, constat #5 et section 2.4) identifie quatre défauts concrets, pas un problème de choix de moteur de base de données :

1. Schéma SQLite créé inline (`CREATE TABLE IF NOT EXISTS todo_items (id varchar(36), name varchar(255), completed boolean)`), sans clé primaire ni contrainte d'unicité ni index.
2. Aucun mécanisme de migration versionnée — toute évolution de schéma se ferait à la main.
3. Duplication de la logique CRUD entre `sqlite.js` et `mysql.js`, avec une dérive déjà observée entre les deux.
4. Aucune configuration de concurrence SQLite (pas de mode WAL, pas de `busy_timeout`).

Le double support SQLite (dev)/MySQL (prod-like) fait partie de la conception originale de `docker/getting-started-app` et n'est pas lui-même en cause dans l'audit — ce qui est en cause, c'est l'intégrité du schéma et la duplication de code, pas le choix du moteur.

## Alternatives considérées

### Option A — Migration complète vers PostgreSQL + Prisma

Remplacer les deux drivers existants par une base PostgreSQL unique, accédée via un ORM.

- **Pour** : transactions ACID renforcées, contraintes FK natives, migrations et typage générés automatiquement.
- **Contre** : nécessite de faire tourner un nouveau service de base de données, de réécrire les deux drivers de persistance depuis zéro et d'abandonner un mécanisme qui fonctionne (le support SQLite/MySQL de l'application originale) — disproportionné par rapport aux défauts réellement identifiés (contraintes manquantes, duplication), et hors mandat « corriger sans remplacer ».

### Option B — Correction en place de SQLite/MySQL

Conserver les deux drivers existants, et corriger précisément les quatre défauts identifiés :

1. Ajouter `PRIMARY KEY`/`UNIQUE` sur `todo_items.id` via un script de migration SQL explicite et versionné (au lieu du `CREATE TABLE IF NOT EXISTS` inline actuel).
2. Introduire un petit exécuteur de migrations maison (fichiers `.sql` numérotés, appliqués dans l'ordre au démarrage, committés en Git) — sans ORM, cohérent avec le choix JavaScript de l'ADR-001.
3. Unifier la logique CRUD dupliquée derrière une interface de repository commune (cf. ADR-002), implémentée une fois par driver.
4. Activer le mode WAL et un `busy_timeout` raisonnable sur le driver SQLite.

- **Pour** : corrige les quatre défauts concrets sans changer de moteur ni ajouter de service d'infrastructure, préserve la compatibilité avec le déploiement Docker Compose original du projet, respecte le mandat de l'exercice.
- **Contre** : moins de garanties transactionnelles qu'un ORM sur PostgreSQL ; l'exécuteur de migrations maison est un code supplémentaire à écrire et tester, même minime.

## Décision

**Option B — Correction en place.** SQLite et MySQL restent tous deux supportés ; les quatre défauts identifiés dans l'audit sont corrigés directement, sans changement de moteur de base de données ni introduction d'ORM.

## Conséquences

**Positives :**

- Corrige les quatre défauts critiques de l'audit (absence de PK, absence de migrations versionnées, duplication, concurrence SQLite) sans réécrire la persistance existante.
- Préserve la compatibilité avec le mode de déploiement dual (SQLite dev / MySQL prod-like) déjà prévu par le projet original.
- Cohérent avec le choix JavaScript + JSDoc de l'ADR-001 : pas de dépendance à un ORM type-safe qui supposerait TypeScript.

**Négatives :**

- Pas de garanties transactionnelles aussi fortes qu'un ORM sur PostgreSQL ; SQLite reste single-writer même en mode WAL.
- L'exécuteur de migrations maison doit être écrit et testé — surface de code supplémentaire, bien que volontairement minimale.
- Aucun typage généré automatiquement sur les contrats de repository (cohérent avec ADR-001, mais nécessite une discipline de documentation JSDoc manuelle plutôt qu'une vérification par compilateur).
