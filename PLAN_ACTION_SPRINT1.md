# Plan d'action Sprint 1 — jusqu'à la soutenance du 12 septembre

**Date de rédaction** : jeudi 3 septembre 2026
**Échéance** : samedi 12 septembre 2026 (soutenance) — soit 9 jours calendaires, dont un week-end.

## 0. Où on en est réellement

La **phase de cadrage est terminée** : audit (`docs/AUDIT_REPORT.md`), 4 ADR validés (`docs/adr/`), gouvernance/backlog/charte d'équipe (`docs/AGILE_GOVERNANCE.md`), gabarit CI (`.github/workflows/ci.yml`), script oral (`docs/oral/SPRINT1_ORAL.md`).

**Rien de tout ça n'est encore codé.** Ce qui reste à faire d'ici le 12 : implémenter le backlog Must Have (S1-M4 à S1-M10), faire passer la CI au vert, répéter l'oral. C'est ça, la vraie course contre la montre — pas la documentation.

**Action collective avant toute autre chose (15 min, aujourd'hui)** : désigner le **PO** (fixe) et le **SM du Sprint 1** parmi les 6, en Sprint Planning éclair. Sans ça, personne n'a l'autorité pour trancher un arbitrage MoSCoW en cours de route.

---

## 1. À faire à l'instant, par personne

| Personne | Binôme | Tâche immédiate (aujourd'hui) |
|---|---|---|
| **Cédric** | 1 — Agile & Backlog | Finaliser le GitHub Project s'il n'est pas encore en place : labels, colonnes, jalons (checklist exacte en `AGILE_GOVERNANCE.md` §1.4). |
| **Etienne** | 1 — Agile & Backlog | Créer une Issue par item Must Have/Should Have restant (S1-M4 à S1-M10, S1-S1 à S1-S6), les assigner nominativement aux bons binômes, publier le template de PR avec la checklist DoD. |
| **Naem** | 2 — Persistance & Services | Ouvrir une branche et démarrer **S1-M6** (validation d'entrée sur les 4 routes — corrige le bug `name: undefined`). C'est le ticket le plus isolé et le plus rapide : il sert à ouvrir la première PR du sprint et à roder le circuit revue/DoD dès aujourd'hui. |
| **Rayan** | 2 — Persistance & Services | En binôme avec Naem sur S1-M6, puis préparer le script de migration SQL versionné pour **S1-M7** (contraintes `PRIMARY KEY`/`UNIQUE` sur `todo_items`). |
| **Florian** | 3 — Outillage & CI/CD | Écrire le `Dockerfile` multi-stage (**S1-M5**) — le dépôt n'en a actuellement aucun. S'appuyer sur le constat #2 de l'audit : multi-stage, utilisateur non-root, cache de layers. |
| **Evan** | 3 — Outillage & CI/CD | Ajouter dans `package.json` les scripts attendus par le pipeline CI déjà écrit — `lint`, `format:check`, `test` (ESLint + Prettier + Jest, actuellement absents des dépendances) — pour que `.github/workflows/ci.yml` (**S1-M4**) cesse d'échouer faute de scripts. |

---

## 2. Planning jour par jour

| Date | Jour | Objectif du jour | Qui | Jalon / preuve |
|---|---|---|---|---|
| **3 sept.** | Jeu | Kickoff : PO/SM désignés, board peuplé, tickets rapides lancés (voir §1) | Toute l'équipe | ≥ 1 PR ouverte en fin de journée |
| **4 sept.** | Ven | Binôme 2 termine S1-M6, avance S1-M7/S1-M8. Binôme 3 termine S1-M4/S1-M5 : la CI doit passer au vert (au moins lint + test) | Binôme 2, Binôme 3 | Pipeline CI vert sur au moins une PR |
| 5-6 sept. | Sam-Dim | Buffer optionnel — à utiliser si retard sur le Must Have, notamment si la CI n'est pas encore verte | Selon disponibilité | — |
| **7 sept.** | Lun | Binôme 3 termine S1-M9 (health-check), démarre S1-M10 (bus d'événements). Binôme 2 termine S1-M7/S1-M8 | Binôme 2, Binôme 3 | Must Have persistance 100 % Done |
| **8 sept.** | Mar | Binôme 3 termine S1-M10 (flux événementiel bout en bout démontrable) + S1-S1 (docker-compose). Binôme 1 audite : tout le Must Have est-il Done au sens strict de la DoD ? | Binôme 3, Binôme 1 | Walking skeleton démontrable |
| **9 sept.** | Mer | Sprint Review interne (démo à blanc devant toute l'équipe) + rétrospective courte. **Gel du scope** : plus aucune nouvelle tâche, seulement des fixes bloquants | Toute l'équipe | `RETROSPECTIVE_S1.md` rédigée |
| **10 sept.** | Jeu | Répétition chronométrée du script oral (`docs/oral/SPRINT1_ORAL.md`), répartition précise du temps de parole, test de la démo live sur la machine de soutenance | Toute l'équipe | Démo testée sur le poste réel |
| **11 sept.** | Ven | Finalisation : nettoyage du board pour qu'il soit présentable, relecture croisée des docs par un binôme différent de celui qui les a écrits, vérification que `main` est propre et la CI verte sur le dernier commit, **enregistrement d'une vidéo de secours** de la démo | Toute l'équipe | `main` vert, plan B prêt |
| **12 sept.** | Sam | **Soutenance** | Toute l'équipe | — |

---

## 3. Règles de vigilance jusqu'au 12

- La **DoD reste non négociable** même sous pression de deadline (`AGILE_GOVERNANCE.md` §2) : pas de merge sans revue, sans test, sans CI verte.
- Le **Won't Have** (auth, RGPD, Kanban, TypeScript, PostgreSQL) ne doit être entamé sous aucun prétexte, même s'il reste du temps le week-end — ce temps va en priorité aux Should Have (S1-S1 à S1-S6) ou à la répétition orale.
- Toute décision prise à l'oral (Discord/Slack, couloir) doit être réécrite dans une Issue ou une PR le jour même — c'est la règle de traçabilité de la charte d'équipe (§1.3).
- Si un Must Have (S1-M4 à S1-M10) n'est pas Done le 9 septembre, il devient la priorité absolue du 10-11 : la répétition orale et le polish passent après, un Must Have non fait est un vrai risque de soutenance, une slide imparfaite n'en est pas un.
