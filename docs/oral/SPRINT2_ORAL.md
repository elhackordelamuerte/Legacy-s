# Script — Soutenance Sprint 2 (3 orateurs)

**Format** : 20 minutes — **10 min présentation** + **5 min Q&A** + **5 min feedback du coach**, réparties sur **3 orateurs** (pas les 5 rôles du Sprint 1 — les 3 autres membres soutiennent depuis la salle : chrono, prise de notes, renfort sur les questions techniques).

> ⚠️ **Statut au 23/09** : Must Have cœur **tous fermés** — auth (`#64`), schéma (`#63`), CRUD (`#66`), Kanban (`#68`), RGPD minimal (`#65`), monitoring multi-canaux (`#86`), dashboard Grafana/Prometheus (`#90`) et CI/Dockerfile (`#70`, PR #98) : tout est mergé sur `main`. Un bug critique trouvé et corrigé au passage (`#92`) : le Dockerfile ne copiait pas les migrations SQL dans l'image, donc l'app démarrait avec un schéma vide en Docker. Should Have avancé aussi : drag & drop (`#71`) et priorités/échéances (`#72`) mergés. Un seul Must Have reste ouvert : flux événementiel étendu (`#69`, Evan, pas de mouvement récent). Côté Should Have, sans assigné : publication Docker sur un registre (`#73`), notifications frontend (`#74`), ADR 0005 (`#77`). **Note pour le jour J** : revérifier ce statut juste avant de présenter, au cas où `#69` aurait bougé entre-temps.
>
> ⚠️ **Précision technique importante (à ne pas se tromper en Q&A)** : la publication de l'événement `TaskCreated` sur l'EventBus se fait dans `src/services/taskService.js` (la couche de service, appelée par `POST /tasks`), **pas** directement dans `src/routes/tasks.js`. Si quelqu'un grep uniquement le fichier de route, il ne verra pas l'appel `eventBus.publish` et pourrait penser que créer une carte Kanban ne déclenche rien — c'est faux, vérifié dans le code et en conditions réelles (vrai webhook Discord/Telegram). L'ancienne route legacy `/items` (`addItem.js`) publie aussi le même événement, en plus, pas à la place.

---

## 0. Répartition des 3 orateurs

| Orateur | Porte | Contenu |
|---|---|---|
| **Orateur 1** | Contexte + Roadmap + clôture | §1, §4, §5 (transition Q&A) |
| **Orateur 2** | Organisation d'équipe | §2 |
| **Orateur 3** | Insights & décisions techniques + démo | §3 (la section la plus longue) |

Les 3 autres membres de l'équipe sont dans la salle : un chrono (signes à 5 min et 8 min), un preneur de notes pour le feedback du coach, et tout le monde peut reprendre la main sur une question technique pointue en Q&A — ce n'est pas réservé aux 3 orateurs.

## Objectifs de cette soutenance (rappel)

- Le but et les objectifs du sprint sont-ils bien compris ?
- La direction est-elle claire ?
- Retour sur l'avancement réel.
- Clarifications pour le Sprint 3.
- Évaluation de ce qui a été accompli.

---

## 1. Trame minutée (10 min)

| Temps | Section | Orateur |
|---|---|---|
| 0:00–0:20 | Ouverture | 1 |
| 0:20–1:30 | **1. Contexte du sprint** | 1 |
| 1:30–3:00 | **2. Organisation d'équipe** | 2 |
| 3:00–8:00 | **3. Insights & décisions techniques + démo** | 3 |
| 8:00–9:30 | **4. Roadmap** | 1 |
| 9:30–10:00 | **5. Questions ?** | 1 |

---

## 2. Contenu détaillé

### 1. Contexte du sprint — Orateur 1 (~1 min 10)

> 📄 **Supports** : `docs/architecture/target-architecture.md`

« Sprint 1 a posé les fondations — audit, architecture cible, gouvernance, CI. Sprint 2 les a mises à l'épreuve : authentification, gestion de projets et de tâches, workflow Kanban. L'architecture cible avait déjà été décidée en Sprint 1, on n'a pas eu à re-discuter les choix techniques en cours de route — juste à les construire, brique par brique, chacune en PR indépendante. »

### 2. Organisation d'équipe — Orateur 2 (~1 min 30)

> 📄 **Supports** : `docs/AGILE_GOVERNANCE.md` §1, board GitHub Projects

« Même organisation qu'au Sprint 1 : 3 binômes, PO fixe, SM tournant. Ce qui a changé, c'est le rythme : on est passés de la documentation à des PR de code quotidiennes, avec la même Definition of Done sans exception — revue obligatoire, tests, CI verte. [Montrer le board.]

Un vrai exemple de discipline d'équipe ce sprint : deux PR ont été ouvertes indépendamment pour la même issue frontend, avec deux architectures différentes. Plutôt que de merger les deux et casser l'app, on a tranché en équipe — Cédric est lead frontend, sa PR a été retenue, l'autre fermée sans reproche sur le travail, juste un doublon d'effort. C'est exactement le genre de décision que la charte d'équipe est censée absorber. »

### 3. Insights & décisions techniques + démo — Orateur 3 (~5 min)

> 📄 **Supports** : PR mergées (`#79` auth, `#80` schéma, `#78` CRUD, `#81`/`#85` frontend, `#87` monitoring+Grafana, `#93` fix Docker, `#94` RGPD), `docs/api/projects-tasks.md`, `docs/architecture/monitoring.md`

« Trois choses à montrer.

**Un**, la méthode contrat-d'abord du Sprint 1 a tenu sur tout le sprint, pas juste sur un exemple isolé. Chaque nouvelle brique — persistance utilisateur, persistance Kanban, canaux de notification — a démarré par une interface JSDoc pure avant la moindre implémentation. Résultat concret : l'authentification, le CRUD Kanban et le frontend ont été développés en parallèle par des binômes différents, sans jamais s'attendre, parce que chacun codait contre un contrat écrit, pas contre le code des autres.

**Deux**, une démo réelle plutôt qu'une promesse : [inscription → connexion → création d'un projet avec ses 3 colonnes → ajout d'une carte → rechargement de page pour montrer que ça persiste]. Chaque bout de cette chaîne est une PR distincte, review et mergée séparément — pas une intégration de dernière minute.

**Trois**, le monitoring. On a construit un système d'alerte multi-canaux (Discord, Telegram, e-mail) qui surveille le bus d'événements et la santé de l'application, avec une règle simple : jamais de canal configuré qui casse l'app, jamais de spam. Et pour cette soutenance, on l'a complété avec un vrai dashboard Grafana/Prometheus — pas pour remplacer les alertes, pour les compléter : les notifiers répondent à *"préviens-moi quand X arrive"*, le dashboard répond à *"montre-moi la tendance dans le temps"*. Deux besoins différents, deux outils différents, documentés comme un ajout et non une remise en cause de la décision initiale. Les deux sont mergés, et on les a testés en conditions réelles avant la soutenance — un vrai webhook Discord et un vrai bot Telegram, pas des mocks : créer une tâche envoie effectivement un message dans les deux. [Démo : créer une tâche, montrer le message arriver sur Discord/Telegram et le compteur bouger sur le dashboard Grafana.]

**Quatre**, un bug qu'on n'aurait pas vu sans tester pour de vrai. En vérifiant le dashboard Grafana en local avec Docker, on s'est rendu compte que l'image ne copiait jamais le dossier des migrations SQL : l'app démarrait sans erreur, mais avec un schéma de base vide — rien ne marchait dès qu'on passait par `docker compose up`, ce qui aurait été catastrophique un jour de démo. Invisible en développement local, où le chemin de fichier est différent. Corrigé en une ligne, mais ça illustre bien pourquoi on teste sur la vraie stack et pas seulement sur `npm run dev`. »

### 4. Roadmap — Orateur 1 (~1 min 30)

> 📄 **Supports** : board GitHub Projects, milestone *Sprint 2 - Core Features*

« Le cœur fonctionnel est fait : auth, schéma, CRUD, Kanban, RGPD minimal, monitoring, dashboard, et CI/Dockerfile finalisés, tous mergés. Deux Should Have sont passés avec : drag & drop des cartes et priorités/échéances visibles. Ce qui reste ouvert et bascule en fin de sprint ou au Sprint 3 : le flux événementiel étendu à une vraie action produit, chez Evan, sans avancement notable pour l'instant. Publication Docker sur un registre, notifications visibles côté frontend et formalisation de l'ADR 0005 restent en Should Have, sans assigné : à répartir en rétro. »

### 5. Transition — Orateur 1 (~20 sec)

« Voilà pour notre Sprint 2. On est prêts pour vos questions. »

---

## 3. Après la présentation — à préparer

- **Historique Git** : montrer que les contrats (JSDoc) précèdent systématiquement les implémentations — visible sur les 3 dernières PR majeures, pas un cas isolé.
- **Exemple de feature de bout en bout** : choisir à l'avance la PR la plus complète et la plus propre à raconter (ex. le CRUD Kanban #78, ou l'auth #79) — issue → branche → commits conventionnels → checklist DoD → revue → merge.

## 4. Q&A — anticiper

| Question probable | Doc de référence |
|---|---|
| Pourquoi Grafana maintenant alors que l'ADR l'écartait ? | `docs/architecture/monitoring.md`, section "Ajout Sprint 2" — bien distinguer alerting (notifiers) et visualisation (Grafana) |
| Avez-vous vraiment testé les notifications, ou juste des mocks ? | Oui, en conditions réelles avant la soutenance : vrai webhook Discord + vrai bot Telegram, message reçu des deux côtés |
| Comment avez-vous géré le conflit entre les deux PR frontend ? | Commentaire de fermeture sur PR #82, `#67` |
| Qu'est-ce qui bascule au Sprint 3 ? | Board GitHub, milestone Sprint 3 — notamment `#69` s'il ne bouge pas |
| Créer une carte Kanban déclenche-t-il vraiment une notification, ou juste l'ancienne route `/items` ? | Oui, les deux : `taskService.js` (route `/tasks`) publie `TaskCreated`, tout comme `addItem.js` (legacy). Vérifié dans le code et en conditions réelles |
| L'ADR 0005 est-il fait ? | Issue `#77` — non, sans assigné, répondre honnêtement |
| Le bug Docker (migrations non copiées), comment vous l'avez trouvé ? | En testant `docker compose up` pour de vrai plutôt qu'en se fiant à `npm run dev` — cf. PR #93 |

## 5. Feedback du coach

Un membre de l'équipe (hors les 3 orateurs) prend des notes écrites — alimentent la rétrospective et le backlog Sprint 3.
