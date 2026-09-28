# Slides — Soutenance Sprint 1

**11 slides pour 10 minutes.** Contenu volontairement minimal : peu de texte à l'écran, le reste est dit (voir `SPRINT1_ORAL.md`). Chaque slide indique l'orateur et un renvoi vers la section du script.

> À actualiser le jour J : les chiffres d'avancement (slide 9) bougent jusqu'à la soutenance — reprendre l'état réel du board / `docs/SPRINT1_RECAP.md` juste avant.

---

## Slide 1 — Titre

**Reprise du projet legacy `docker/getting-started-app`**
Sprint 1 — Foundation & Architecture

Équipe (6) : Cédric · Etienne · Naem · Rayan · Florian · Evan
*Soutenance du 12 septembre 2026*

> Orateur : Presenter · ~15 s

---

## Slide 2 — Contexte du projet

- Reprendre un existant imparfait, pas repartir de zéro
- **Piloter** : comprendre → décider → justifier
- Sans réécrire, sans changer de langage ni de base de données
- Sprint 1 = fondations. Pas de fonctionnalité produit ce sprint (assumé)

> Orateur : PO · script §1 · ~1 min

---

## Slide 3 — Organisation d'équipe

| Binôme | Périmètre |
|---|---|
| 1 — Cédric, Etienne | Agile & Backlog |
| 2 — Naem, Rayan | Audit & Architecture |
| 3 — Florian, Evan | Outillage & CI/CD |

- PO fixe sur 3 sprints · **SM tournant** (SM #1 : *[nom]*)
- Cérémonies : daily · planning · review · rétro

> Orateur : SM · script §2 · ~1 min

---

## Slide 4 — Process & traçabilité

- **Definition of Done stricte** : PR + 1 revue + tests + quality gate + build Docker
- Board GitHub Projects, colonnes Backlog → Done
- Conventional Commits imposés (`commitlint` + `husky`)
- Règle : *une décision non écrite dans une Issue ou une PR n'a pas eu lieu*

> Orateur : SM · script §2 · ~1 min

---

## Slide 5 — Audit : ce qu'on a trouvé

Matrice de sévérité — Faible / Moyenne / **Critique**

Constats phares :
- Frontend React **compilé dans le navigateur** (Babel, sans build)
- Des tests existent mais **`jest` non installé, aucun `npm test`** → jamais exécutés
- `addItem` ne valide jamais le champ `name` → donnée corrompue silencieuse
- Zéro CI, persistance dupliquée SQLite/MySQL

> Orateur : Binôme 2 · script §3 · ~1 min 30
> [Slide visuelle : projeter la matrice de sévérité de `docs/audit/technical-debt-audit.md`]

---

## Slide 6 — Décisions : 4 ADR

| ADR | Décision |
|---|---|
| 0003 — Langage & typage | JavaScript + JSDoc (pas TypeScript) |
| 0002 — Persistance | SQLite/MySQL corrigés en place (pas PostgreSQL) |
| 0004 — Architecture applicative | Couche de service légère (pas de réécriture hexagonale) |
| 0001 — Sync vs async | EventBus in-process (pas de broker externe) |

Chaque ADR compare **≥ 2 alternatives réelles**, format Michael Nygard.

> Orateur : Binôme 2 · script §3 · ~1 min

---

## Slide 7 — Le changement d'avis, assumé

Premières pistes : TypeScript · PostgreSQL · réécriture complète

→ Après reclarification du mandat (*piloter, pas remplacer*) : **révision vers des corrections en place**

- Documenté dans chaque ADR (bandeau « Note de révision »)
- Pas caché : un jury verra qu'on a su reconnaître une erreur de cadrage

> Orateur : Binôme 2 · script §3 · ~45 s

---

## Slide 8 — Fondation événementielle (ADR 0001)

- Bus d'événements **interne au process** (`EventBus` + `InMemoryEventBus`)
- Pas de Redis/RabbitMQ : un seul service à faire tourner à ce stade
- Contrat pensé pour être remplacé plus tard sans toucher au code appelant
- Limites (perte au redémarrage, pas de scalabilité horizontale) documentées

> Orateur : Binôme 3 · script §3 · ~45 s

---

## Slide 9 — Roadmap

**Fait (mergé)** : audit · 4 ADR · validation d'entrée · interface repository commune · JSDoc/checkJs · commitlint

**En cours (PR ouvertes)** : CONTRIBUTING.md · health-check · Dockerfile · event bus · migrations SQL

**Sprint 2** : premières fonctionnalités produit, même discipline (DoD, ADR)

**Won't have (explicite)** : auth, Kanban, changement de langage/BDD

> Orateur : PO · script §4 · ~1 min 30 · **actualiser les listes le jour J**

---

## Slide 10 — Ce qu'on retient

- Comprendre avant de corriger
- Comparer avant de décider
- Tout tracer — y compris les changements d'avis

*C'est ce mindset qu'on garde pour le Sprint 2.*

> Orateur : Presenter · ~30 s

---

## Slide 11 — Questions

**Merci.**

Prêts à montrer sur demande : historique Git · une PR complète de bout en bout (issue → branche → commits → revue → merge)

> Orateur : Presenter · transition vers le Q&A

---

## Annexe (à garder ouverte, pas à projeter par défaut)

- **A1 — Historique Git** : terminal sur `git log --oneline --graph`, ou onglet Insights → Network de GitHub
- **A2 — Exemple de feature** : PR mergée choisie à l'avance (ex. PR #36 — validation d'entrée : issue #31 → branche `fix/...` → commits conventionnels → checklist DoD → revue → squash-merge)
