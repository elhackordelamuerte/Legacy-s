# Script — Soutenance Sprint 1

**Format imposé** : 20 minutes au total — **10 min présentation** + **5 min Q&A** + **5 min feedback du coach**. Ce script ne couvre que les 10 premières minutes ; le reste ne se scripte pas (voir §4 et §5 pour s'y préparer).

> Les passages entre crochets `[...]` sont des indications de mise en scène (slide/écran), pas du texte à dire.
> **📄 Supports** liste sous chaque section les documents à avoir ouverts pendant qu'on parle.

---

## 0. Rôles pendant la soutenance (à assigner avant le jour J)

| Rôle | Responsabilité | Qui |
|---|---|---|
| **Presenter** | Mène le déroulé : introduit, fait les transitions entre sections, relance en cas de blanc, clôture et lance les questions | à désigner |
| **Product Owner** | Présente la partie « produit » : contexte/objectif (§1) et roadmap/priorités (§4) | PO du Sprint 1 |
| **Scrum Master** | Présente la partie organisationnelle : équipe, cérémonies, process (§2) | SM du Sprint 1 |
| **Time keeper** | Surveille le chrono en silence pendant les 10 min, fait un signe discret à 5 min et à 8 min pour accélérer si besoin | à désigner |
| **Scribe** | Ne parle pas pendant la présentation ; prend des notes écrites pendant le Q&A et le feedback du coach (§4/§5) | à désigner |

6 personnes pour 5 rôles formels : la personne restante intervient sur §3 (Insights & décisions/ADR) — c'est la section la plus dense, elle peut être partagée entre 2 personnes (celles qui ont fait l'audit/les ADR) sans que ça casse le déroulé, tant que le Presenter garde la main sur les transitions.

## Objectifs de cette soutenance (ce qui est évalué — à garder en tête en répondant)

- Le but et les objectifs du projet sont-ils bien compris par l'équipe ?
- La direction prise est-elle claire ?
- Retour sur l'avancement réel du projet.
- Clarifications à obtenir pour le Sprint 2.
- Évaluation de ce qui a été accompli à ce stade.

---

## 1. Trame minutée (10 min)

| Temps | Section | Contenu officiel | Porté par |
|---|---|---|---|
| 0:00–0:30 | Ouverture | Présentation de l'équipe et de l'agenda | Presenter |
| 0:30–1:30 | **1. Contexte du projet** | Objectif à atteindre sur ce projet legacy | PO |
| 1:30–3:30 | **2. Organisation d'équipe** | Rôles, cérémonies, process, traces de réunions | SM |
| 3:30–7:30 | **3. Insights & décisions (ADR)** | Ce qu'on a appris de l'audit, décisions prises et justifiées | Binôme Audit/Architecture (+ appui Outillage) |
| 7:30–9:00 | **4. Roadmap** | Priorités, ce qui reste, ce qui vient au Sprint 2 | PO |
| 9:00–9:30 | **5. Questions ?** | Transition vers le Q&A | Presenter |

---

## 2. Contenu détaillé

### 1. Contexte du projet — PO (~1 min)

> [Slide : titre + équipe]
> 📄 **Supports** : aucun document technique à l'écran, garder `docs/AGILE_GOVERNANCE.md` sous la main en cas de question immédiate.

« Bonjour, nous reprenons le projet legacy `docker/getting-started-app`. Notre mandat n'est pas de le réécrire ni de développer de nouvelles fonctionnalités ce sprint — pas de Kanban, pas de nouveau CRUD. Il s'agit de **piloter un existant imparfait** : comprendre ce qui ne va pas, décider comment le corriger, le justifier, sans changer de langage ni de base de données. Ce Sprint 1 pose les fondations — audit, architecture cible, gouvernance, CI, premier flux événementiel — avant que le Sprint 2 ne livre des fonctionnalités. »

### 2. Organisation d'équipe — SM (~2 min)

> [Slide : board GitHub Projects, table des rôles]
> 📄 **Supports** :
> - `docs/AGILE_GOVERNANCE.md` §1 (binômes, rôles PO/SM, rotation), §1.3 (charte d'équipe), §2 (Definition of Done)
> - Le board GitHub Projects réel, en partage d'écran

« On est 6, organisés en 3 binômes fixes pour le travail technique : Cadrage Agile & Backlog, Audit & Architecture cible, Outillage/Qualité/CI-CD. Le Product Owner est fixe sur les 3 sprints ; le Scrum Master tourne à chaque sprint parmi les 5 autres — j'occupe ce rôle pour le Sprint 1.

Nos cérémonies : daily stand-up, Sprint Planning, Sprint Review, rétrospective. Notre charte d'équipe pose une règle simple : toute décision prise à l'oral doit être réécrite dans une Issue ou une PR GitHub — si ce n'est pas écrit, ça n'a pas eu lieu. C'est ce qui nous donne une trace vérifiable de comment on a travaillé, pas seulement de ce qu'on a produit.

Notre Definition of Done est stricte et sans exception : revue de PR obligatoire, tests, quality gate vert, build Docker qui passe, documentation à jour. [Montrer le board GitHub Projects réel ici.] »

### 3. Insights & décisions — Binôme Audit/Architecture (~4 min)

> [Slide : matrice de sévérité + les 4 ADR]
> 📄 **Supports** :
> - `docs/AUDIT_REPORT.md` §2 (constats), §3 (matrice de sévérité)
> - `docs/adr/ADR-001` à `ADR-004` — ouvrir le bandeau **« Note de révision »** en tête des ADR-001/002/003

« On a audité le code existant ligne par ligne plutôt que de supposer. Deux surprises concrètes : le frontend n'est pas du JS natif comme on le pensait, c'est du React compilé **dans le navigateur** via Babel, sans build ; et des fichiers de tests existent dans le dépôt, mais `jest` n'est même pas déclaré en dépendance et il n'y a aucun script `npm test` — ces tests n'ont probablement jamais tourné. On a aussi trouvé un bug concret : la création d'un item ne valide jamais que le champ `name` existe.

À partir de ces constats critiques — zéro tests exécutables, zéro CI, persistance dupliquée sans contrainte d'intégrité — on a rédigé 4 ADR, chacun comparant au moins deux alternatives réelles. Et on assume un point important : nos premières pistes étaient plus radicales — TypeScript, PostgreSQL, réécriture hexagonale complète. En reprécisant le mandat de l'exercice, on a révisé ces trois décisions vers des corrections **en place** : JavaScript + JSDoc, SQLite/MySQL corrigés sans changer de moteur, une fine couche de service plutôt qu'une réécriture. On documente ce changement d'avis plutôt que de le cacher — c'est écrit noir sur blanc dans chaque ADR.

Le quatrième ADR porte sur l'événementiel : un bus d'événements interne au process, pas de broker externe, parce qu'on n'a qu'un seul service à faire tourner à ce stade — [état du jour à préciser ici : conception actée, implémentation en cours/faite]. »

> **Note pour le jour J** : ajuster le dernier paragraphe selon l'état réel constaté (est-ce que le flux événementiel et les autres Must Have sont mergés au moment de la soutenance ? cf. `docs/SPRINT1_CHANGELOG.md` pour le statut à jour).

### 4. Roadmap — PO (~1,5 min)

> [Slide : backlog MoSCoW]
> 📄 **Supports** : `docs/AGILE_GOVERNANCE.md` §3 (backlog complet)

« Ce qu'on a priorisé Must Have pour ce sprint : les corrections critiques de l'audit, la CI bloquante, le flux événementiel minimal. En Should Have : docker-compose, seuil de couverture, protection de branche. On a explicitement mis en Won't Have tout changement de langage ou de base de données, et toute fonctionnalité produit (auth, Kanban) — ça part au Sprint 2.

Pour le Sprint 2, la priorité sera de livrer les premières fonctionnalités produit sur les fondations qu'on vient de poser, en gardant la même discipline : DoD stricte, ADR pour toute décision structurante. »

### 5. Transition — Presenter (~30 sec)

« Voilà pour notre Sprint 1. On est prêts pour vos questions. »

---

## 3. Après la présentation — à préparer, pas à scripter

Ces deux éléments ne sont pas dans les 10 minutes chronométrées mais doivent être **prêts à montrer immédiatement** si le coach les demande en Q&A ou juste après :

- **Historique Git** : avoir un terminal ouvert sur `git log --oneline --graph --all` (ou l'onglet **Insights → Network** de GitHub) pour montrer des commits qui suivent la convention Conventional Commits et des PR liées à des issues.
- **Exemple de feature respectant le process d'équipe** : choisir à l'avance **une PR mergée concrète** (issue → branche nommée selon la convention → commits conventionnels → PR avec checklist DoD cochée → review approuvée → merge) et être capable de l'ouvrir en 10 secondes. Ne pas improviser ce choix pendant la soutenance.

---

## 4. Q&A (5 min) — anticiper sans scripter

Le jury évalue en particulier (cf. Objectifs en tête de document) : la compréhension du but du projet, la clarté de la direction, l'avancement réel, les points à clarifier pour le Sprint 2. Questions probables et où trouver la réponse si besoin de se raccrocher à un document :

| Question probable | Doc de référence |
|---|---|
| Pourquoi avoir changé d'avis sur TypeScript/PostgreSQL ? | Bandeaux "Note de révision" des ADR-001/002/003 |
| Comment vous assurez-vous qu'une PR respecte la DoD ? | `docs/AGILE_GOVERNANCE.md` §2, template de PR (`.github/pull_request_template.md`) |
| Qu'est-ce qui n'est pas fait / à risque pour la démo ? | `docs/SPRINT1_CHANGELOG.md`, `docs/PLAN_ACTION_SPRINT1.md` §3 |
| Quel est le prochain Scrum Master ? Comment ça tourne ? | `docs/AGILE_GOVERNANCE.md` §1.2 |

Toute l'équipe peut répondre, pas seulement le Presenter — le jury demandera probablement à la personne la plus proche du sujet posé.

## 5. Feedback du coach (5 min)

Pas de script : le Scribe prend des notes écrites (pas seulement mentales) de chaque remarque, même informelle. Ces notes alimentent la rétrospective (`docs/RETROSPECTIVE_S1.md`) et le backlog du Sprint 2 — une remarque du coach non tracée par écrit risque d'être oubliée, même règle que pour les décisions d'équipe (charte, §1.3 de `AGILE_GOVERNANCE.md`).
