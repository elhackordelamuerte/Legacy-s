# Slides — Soutenance Sprint 2

**10 slides pour les 10 minutes, réparties sur 3 orateurs.** Contenu minimal à l'écran — le texte est dit, pas lu (voir `SPRINT2_ORAL.md`).

> À actualiser le jour J : slide 8 (roadmap) et la mention Grafana en slide 6 dépendent de l'état réel des PR `#87`/`#90` au moment de la soutenance.

---

## Slide 1 — Titre

**Sprint 2 — Core Features**
Reprise du projet legacy `docker/getting-started-app`

Équipe (6) : Cédric · Etienne · Naem · Rayan · Florian · Evan
*Soutenance du [date]*

> Orateur 1 · ~20 s

---

## Slide 2 — Contexte du sprint

- Sprint 1 : fondations (audit, architecture cible, gouvernance, CI)
- Sprint 2 : mise à l'épreuve — auth, projets/tâches, Kanban
- Architecture déjà décidée en Sprint 1, pas re-discutée : construite

> Orateur 1 · ~1 min

---

## Slide 3 — Organisation d'équipe

- Même structure qu'au Sprint 1 : 3 binômes, PO fixe, SM tournant
- Rythme différent : PR de code quotidiennes, DoD sans exception
- **Exemple de discipline** : conflit entre 2 PR frontend → tranché en équipe (Cédric lead frontend), pas de merge des deux

> Orateur 2 · ~1 min 30

---

## Slide 4 — Méthode : contrat d'abord

- Chaque nouvelle brique commence par une interface JSDoc pure, avant le code
- Réutilisé sur : persistance utilisateur, persistance Kanban, canaux de notification
- Résultat : binômes développés en parallèle, sans s'attendre

> Orateur 3 · ~1 min

---

## Slide 5 — Démo : parcours complet

Inscription → Connexion → Création d'un projet (3 colonnes) → Ajout d'une carte → Persistance au rechargement

Chaque étape = une PR distincte, review et mergée séparément — pas une intégration de dernière minute.

> Orateur 3 · ~1 min 30 · [Démo live]

---

## Slide 6 — Monitoring : alerte + visualisation

| Besoin | Outil | Répond à |
|---|---|---|
| Alerte immédiate | Discord / Telegram / e-mail | « Préviens-moi quand X arrive » |
| Tendance dans le temps | Grafana / Prometheus | « Montre-moi l'évolution » |

Deux besoins différents, deux outils — **ajout**, pas remise en cause du choix initial (`docs/architecture/monitoring.md`).

> Orateur 3 · ~1 min 30 · [Démo : créer une tâche, montrer le compteur bouger]
> **Statut à confirmer le jour J** : `#87`/`#90` mergées ou en revue ?

---

## Slide 7 — Ce que ça corrige (rappel Sprint 1)

| Constat de l'audit | Réponse Sprint 2 |
|---|---|
| Pas de modèle Kanban | `User → Project → Column → Task` implémenté |
| Pas d'authentification | JWT, hash bcrypt |
| Pas de flux événementiel réel | Monitoring branché sur l'EventBus |

> Orateur 3 · ~30 s

---

## Slide 8 — Roadmap

**Fait (mergé)** : auth · schéma · CRUD Projets/Tâches · Kanban minimal

**En cours** : flux événementiel étendu (`#69`) · CI/Dockerfile complets (`#70`) · RGPD (`#65`) · monitoring + dashboard (`#86`/`#90`)

**Reporté (Should Have)** : drag & drop, priorités/deadlines visibles, publication Docker

> Orateur 1 · ~1 min 30 · **actualiser les listes le jour J**

---

## Slide 9 — Ce qu'on retient

- Le contrat d'abord n'est pas un one-shot : ça tient sur la durée
- Trancher un conflit d'équipe par une règle claire (qui est lead) plutôt que par un merge à l'aveugle
- Documenter un ajout d'outillage sans effacer la décision précédente

> Orateur 1 · ~20 s

---

## Slide 10 — Questions

**Merci.**

Prêts à montrer : historique Git (contrats avant implémentations) · une PR complète de bout en bout

> Orateur 1 · transition Q&A

---

## Annexe (pas à projeter par défaut)

- **A1** : `git log --oneline --graph` — repérer l'ordre contrat → implémentation sur 2-3 PR
- **A2** : PR choisie à l'avance pour la démo "feature complète" (issue → branche → commits → DoD → review → merge)
- **A3** : dashboard Grafana en plein écran si `#90` est mergée et testée avant la soutenance
