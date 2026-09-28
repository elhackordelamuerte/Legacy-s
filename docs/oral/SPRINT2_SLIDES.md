# Slides — Soutenance Sprint 2

**10 slides pour les 10 minutes, réparties sur 3 orateurs.** Contenu minimal à l'écran — le texte est dit, pas lu (voir `SPRINT2_ORAL.md`).

> Statut au 23/09 : `#86`/`#87` (monitoring), `#90`/`#91` (Grafana) et `#70`/`#98` (CI/Dockerfile) sont mergés et vérifiés. Slide 8 (roadmap) à recaler le jour J seulement si `#69` a bougé entre-temps. Slide 5 : la démo Kanban déclenche bien une vraie notification (`taskService.js` publie `TaskCreated`, pas juste l'ancienne route `/items`) — vérifié dans le code, ne pas laisser un doute s'installer en Q&A.

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

Inscription → Connexion → Création d'un projet (3 colonnes) → Ajout d'une carte → Drag & drop entre colonnes → Priorité/échéance → Persistance au rechargement

Chaque étape = une PR distincte, review et mergée séparément — pas une intégration de dernière minute.

> Orateur 3 · ~1 min 30 · [Démo live]

---

## Slide 6 — Monitoring : alerte + visualisation

| Besoin | Outil | Répond à |
|---|---|---|
| Alerte immédiate | Discord / Telegram / e-mail | « Préviens-moi quand X arrive » |
| Tendance dans le temps | Grafana / Prometheus | « Montre-moi l'évolution » |

Deux besoins différents, deux outils — **ajout**, pas remise en cause du choix initial (`docs/architecture/monitoring.md`).

Testé en conditions réelles : vrai webhook Discord + vrai bot Telegram, message reçu des deux côtés.

> Orateur 3 · ~1 min 30 · [Démo : créer une tâche, montrer le message arriver sur Discord/Telegram et le compteur bouger sur Grafana]

---

## Slide 7 — Ce que ça corrige (rappel Sprint 1)

| Constat de l'audit | Réponse Sprint 2 |
|---|---|
| Pas de modèle Kanban | `User → Project → Column → Task` implémenté |
| Pas d'authentification | JWT, hash bcrypt |
| Pas de gestion RGPD | Consentement explicite + droit à l'effacement (cascade) |
| Pas de flux événementiel réel | Monitoring branché sur l'EventBus |

> Orateur 3 · ~30 s

---

## Slide 8 — Roadmap

**Fait (mergé)** : auth · schéma · CRUD Projets/Tâches · Kanban · RGPD minimal · monitoring + dashboard Grafana · CI/Dockerfile complets · drag & drop · priorités/échéances

**En cours** : flux événementiel étendu (`#69`), chez Evan, sans avancement notable

**Reporté, sans assigné** : publication Docker sur un registre (`#73`) · notifications frontend (`#74`) · ADR 0005 (`#77`)

> Orateur 1 · ~1 min 30 · **revérifier #69 le jour J**

---

## Slide 9 — Ce qu'on retient

- Le contrat d'abord n'est pas un one-shot : ça tient sur la durée
- Trancher un conflit d'équipe par une règle claire (qui est lead) plutôt que par un merge à l'aveugle
- Documenter un ajout d'outillage sans effacer la décision précédente
- Tester sur la vraie stack (Docker, vrais webhooks) a trouvé un bug qu'aucun test unitaire n'aurait vu

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
- **A3** : dashboard Grafana en plein écran (mergé et testé, prêt à montrer)
