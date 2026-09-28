# Plan d'action — Sprint 3 (Stabilisation & Quality)

**Fenêtre** : 28/09 → 30/09/2026 (2 jours). Dernière phase avant le rendu final — priorité à la
stabilisation, pas à de nouvelles fonctionnalités. Détail du backlog : `docs/GITHUB_ISSUES_SPRINT3.md`.

## Où on en est en entrant dans Sprint 3

Sprint 2 est fonctionnellement complet : auth, schéma, CRUD Kanban, RGPD minimal, monitoring
multi-canaux (vérifié avec de vrais webhooks Discord/Telegram), dashboard Grafana/Prometheus
(vérifié avec de vraies données), CI/Dockerfile durcis (#98). Deux bugs critiques trouvés et
corrigés en cours de route (migrations Docker absentes #92/#93, jeton d'un compte supprimé qui
plantait le serveur #100/#101) — les deux fois en testant la vraie stack plutôt qu'en se fiant aux
tests unitaires seuls.

## Priorité absolue : #102 (Dockerfile ne sert pas le frontend)

Le seul Must Have vraiment neuf de ce sprint. À traiter en premier : c'est le risque le plus visible
pour le rendu final si un correcteur lance `docker compose up` sans autre contexte. Fix connu et
petit (voir l'issue).

## #69 reste bloqué

Flux événementiel réel, assigné à Evan, aucun mouvement depuis le 14/09 malgré plusieurs relances
(11/24, commentaires sur #69 et #70). À évoquer directement en stand-up plutôt que par un
3e commentaire GitHub sans réponse — si ça ne bouge pas d'ici la fin du sprint, l'assumer
explicitement comme non traité en soutenance plutôt que de laisser un doute.

## PR en attente qui bloquent la clôture du sprint

- **PR #99** (ADR 0005) : changements demandés par moi (formulation JWT à corriger pour refléter
  que le risque n'est plus hypothétique). Petit fix texte, pas de code — devrait pouvoir merger vite
  une fois corrigé.
- **PR #97** (notifications lisibles, #96) : ouverte depuis le 23/09, toujours aucun reviewer.
  À relancer si personne ne s'en saisit d'ici demain.
- **PR #101** (fix #100) : approuvée par moi, prête à merger.

## Ce qui n'est *pas* prévu ce sprint

Pas de nouvelle fonctionnalité produit. #73, #74, #76 (Should/Could Have spillover) sont dans le
backlog mais seulement si le temps le permet après #102 et les PR en attente — la priorité reste
stabilisation + rendu propre, pas extension de périmètre.

## Après Sprint 3 : préparation de la soutenance finale

Comme pour les Sprints 1 et 2 : script oral + slides pour 3 orateurs, à préparer une fois l'état
réel du sprint connu (proche de l'échéance du 30/09), pas maintenant — trop tôt pour que le contenu
reste exact jusqu'au jour J. Réutiliser le format `docs/oral/SPRINT2_ORAL.md` /
`docs/oral/SPRINT2_SLIDES.md` comme gabarit.
