# Backlog Sprint 3 — Stabilisation & Quality

Milestone GitHub : **Sprint 3 - Stabilisation & Quality**, échéance **30/09/2026**. Kickoff le 28/09 —
2 jours de marge, donc backlog volontairement resserré : on stabilise et on nettoie, on n'ajoute pas
de nouvelle fonctionnalité produit.

## Must Have

| # | Titre | Origine | Assigné |
|---|---|---|---|
| #69 | [S2-M7] Flux événementiel réel (au-delà du prototype Sprint 1) | Spillover Sprint 2 | Evan — aucun mouvement depuis le 14/09 |
| #102 | [S3-M1] Le Dockerfile ne construit pas le frontend — l'image ne sert rien sur `/` | Nouveau, trouvé en préparant Sprint 3 | non-assigné |

**#102 est le plus critique des deux pour le rendu final** : si un correcteur fait `docker compose up`
et ouvre `localhost:3000`, il ne voit rien d'utilisable aujourd'hui. Le fix est petit
(`npm run build` dans `frontend/` avant la copie `src/` du Dockerfile, `vite.config.js` sort déjà
dans `src/static/`), donc bon candidat à prendre en premier vu le peu de temps restant.

## Should Have

| # | Titre | Origine | État |
|---|---|---|---|
| #77 | Formaliser l'ADR 0005 (Vite, JWT, validation) | Spillover Sprint 2 | PR #99 — changements demandés (formulation JWT à corriger) |
| #96 | Messages de notification peu lisibles | Spillover Sprint 2 | PR #97 — en attente de reviewer |
| #73 | [S2-S3] Publication de l'image Docker sur un registre (GHCR) | Spillover Sprint 2 | non-assigné |
| #74 | [S2-S4] Notifications visibles côté frontend | Spillover Sprint 2 | non-assigné |
| #103 | [S3-S1] Erreur TypeScript préexistante jamais corrigée (`addItem.js`) | Nouveau | non-assigné — petit fix, bon "quick win" |
| #104 | [S3-S2] Couverture de tests frontend insuffisante (drag & drop, priorité/échéance non testés) | Nouveau | non-assigné |

## Could Have

| # | Titre | Origine |
|---|---|---|
| #76 | [S2-C2] Export / droit à l'oubli RGPD complet | Spillover Sprint 2 |

## Déjà réglé en clôturant Sprint 2 / en ouvrant Sprint 3

- **#100** (bug critique : jeton d'un compte supprimé faisait planter le serveur, stack trace SQL
  exposée) → **PR #101 approuvée par moi**, fermeture automatique au merge. Fix propre : vérification
  de l'existence du compte dans `requireAuth` + gestionnaire d'erreurs générique en dernier maillon.
- **#98/#70** (CI/Dockerfile) → mergé, CI valide maintenant `docker compose up --build` + santé de
  toute la stack (Prometheus, Grafana, `/metrics`). Ne couvre pas le frontend — d'où #102.

## Non retenu pour ce sprint (backlog produit, pas stabilisation)

Rien d'écarté explicitement cette fois — le Sprint 2 a déjà mis toutes les nouvelles fonctionnalités
en Should/Could Have. Sprint 3 n'a vocation qu'à finir/stabiliser, pas à ouvrir de nouveau chantier.
