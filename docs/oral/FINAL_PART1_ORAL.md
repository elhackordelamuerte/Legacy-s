# Script — Soutenance finale, Partie 1 : Sprint 3 & bilan final (3 orateurs)

**Partie 1 sur 2, ~16 minutes.** La Partie 2 (deep dive, démo live, clôture, Q&A, feedback du
coach) est un document séparé : `FINAL_PART2_ORAL.md` / `FINAL_PART2_SLIDES.md`. Slides en anglais
(`FINAL_PART1_SLIDES.md`), script en français. 3 orateurs présentent, les 3 autres membres de
l'équipe sont dans la salle et peuvent reprendre la main sur une question technique pointue à tout
moment — ce n'est pas réservé aux 3 orateurs.

> ⚠️ **Statut à la date de rédaction (29-30/09)** : cœur fonctionnel complet sur les 3 sprints
> (auth, RGPD, Kanban, monitoring multi-canaux vérifié en réel, dashboard Grafana vérifié en réel).
> Deux Must Have encore ouverts : `#102` (Dockerfile qui ne sert pas le frontend, en cours chez
> Florian) et `#69` (extension du flux événementiel, en cours chez Evan). **Note pour le jour J** :
> revérifier l'état de `#69`, `#96`, `#97`, `#99`, `#102`, `#105` juste avant de présenter.

---

## 0. Répartition des 3 orateurs (Partie 1)

| Orateur | Porte | Contenu |
|---|---|---|
| **Orateur 1** | Contexte, périmètre produit | Slides 1-2, 7-8 |
| **Orateur 2** | Organisation, stats/contributions | Slides 3, 9-10 |
| **Orateur 3** | ADR, architecture, modèle de données | Slides 4-6 |

## 1. Trame minutée (~16 min)

| Temps | Section | Orateur |
|---|---|---|
| 0:00–0:20 | Ouverture | 1 |
| 0:20–1:50 | Contexte du projet | 1 |
| 1:50–3:50 | Organisation finale de l'équipe | 2 |
| 3:50–6:50 | Décisions techniques (ADR) + architecture finale + modèle de données | 3 |
| 6:50–11:20 | Périmètre produit final : livré / manquant | 1 |
| 11:20–14:00 | Stats générales + contributions par personne | 2 |
| 14:00–16:00 | Insights personnels (les 3 orateurs) | 1, 2, 3 |

---

## 2. Contenu détaillé

### Ouverture — Orateur 1 (~20 s)

« Bonjour à tous. On est [noms], et on va vous présenter le bilan final du projet Legacy
TodoList Rework — trois sprints, une application Node.js/Express reprise et transformée en
Kanban authentifié avec RGPD et monitoring. »

### 1. Contexte du projet — Orateur 1 (~1 min 30)

> 📄 Support : slide 2

« Le point de départ, c'était `docker/getting-started-app` — l'application legacy officielle de
Docker, une simple TodoList sans authentification, sans build frontend, sans tests exécutables. La
mission du projet : la faire évoluer vers une vraie application Kanban avec authentification,
conformité RGPD et supervision en temps réel — **en corrigeant l'existant, pas en le réécrivant
depuis zéro**. C'était un principe directeur explicite dès le Sprint 1, et on l'a tenu sur les trois
sprints : le module de persistance, la séparation routes/services, tout ce qui était sain dans le
legacy a été gardé et étendu, pas jeté. Trois sprints, environ quatre semaines, du 1er au 30
septembre. »

### 2. Organisation finale de l'équipe — Orateur 2 (~2 min)

> 📄 Support : slide 3, `docs/AGILE_GOVERNANCE.md`

« Même organisation du premier au dernier jour : trois binômes fixes — Agile & Backlog, Audit &
Architecture/Persistance, Outillage & CI/CD — un Product Owner fixe sur les trois sprints, et un
Scrum Master qui tourne à chaque sprint. Les cérémonies n'ont pas changé non plus : daily
stand-up, sprint planning, sprint review, rétrospective — et une règle qu'on a vraiment appliquée
du début à la fin : toute décision, tout blocage discuté à l'oral est reporté par écrit le jour
même, dans une issue ou un commentaire de PR.

Un exemple concret de cette discipline, au Sprint 2 : deux personnes ont ouvert, chacune de son
côté, une PR pour la même fonctionnalité frontend, avec deux architectures différentes. Plutôt que
de merger les deux et se retrouver avec une app incohérente, on a tranché en équipe — qui est lead
sur le frontend — et fermé l'autre PR proprement, sans reproche sur le travail fait, juste un
doublon d'effort assumé. »

### 3. Décisions techniques (ADR) + architecture finale + modèle de données — Orateur 3 (~3 min)

> 📄 Support : slides 4, 5, 6 — `docs/architecture/adr/`, `docs/architecture/target-architecture.md`

« Cinq décisions structurantes ont été tracées en ADR, contexte, au moins deux
alternatives comparées, décision, conséquences assumées. Pas des choix a posteriori justifiés après
coup : écrits avant ou pendant l'implémentation.

L'ADR 0001 tranche la communication interne : une approche hybride, synchrone en REST pour le CRUD,
asynchrone via un event bus en mémoire pour tout ce qui est notification — sans aller jusqu'à
Kafka ou RabbitMQ, disproportionné pour l'échelle du projet. L'ADR 0002 garde SQLite et MySQL tous
les deux, corrigés en place plutôt que remplacés par un unique moteur. L'ADR 0003 choisit
JavaScript avec JSDoc et `checkJs` plutôt que TypeScript — du typage réel, sans migration de
langage. L'ADR 0004 formalise une couche de service, extraite progressivement, qui centralise
toute la logique métier et la validation. Le cinquième, l'ADR 0005, regroupe trois choix qui
n'avaient jamais été comparés à une alternative — Vite, JWT, la stratégie de validation — il est
encore en revue à l'heure où je vous parle, pas encore mergé.

Concrètement, l'architecture finale ressemble à ça [montrer le diagramme, slide 5] : un frontend
SPA qui parle en REST à l'API, un module d'authentification JWT, un event bus qui découple le
métier de la notification, et une couche d'observabilité — Prometheus et Grafana — volontairement
tenue à l'écart de ce schéma parce qu'elle ne change rien au fonctionnement de l'app elle-même,
elle ne fait que l'observer de l'extérieur.

Le modèle de données, enfin : `User → Project → Column → Task`, avec la règle de propriété portée
par la couche service, jamais dupliquée route par route. La suppression d'un compte supprime en
cascade ses projets ; si l'utilisateur n'était qu'assigné sur une tâche d'un autre, seule
l'assignation disparaît, pas la tâche. »

### 4. Périmètre produit final : livré / manquant — Orateur 1 (~3 min 30)

> 📄 Support : slides 7, 8

« Ce qui est réellement livré et mergé : l'authentification JWT complète, le RGPD minimal —
consentement explicite à l'inscription, droit à l'effacement avec cascade, et l'export des données
personnelles. Le Kanban complet : projets, colonnes, tâches, drag & drop entre colonnes, priorité
et échéance visibles sur les cartes. Le monitoring multi-canaux — Discord, Telegram, e-mail —
qu'on a testé avec de vrais webhooks et un vrai bot, pas des mocks : créer une tâche envoie
vraiment un message. Le dashboard Grafana/Prometheus, vérifié avec de vraies données qui bougent
en direct. Et deux durcissements de sécurité trouvés en testant la vraie stack : un gestionnaire
d'erreurs générique qui ne renvoie plus jamais de détail technique au client, et une vérification
que le compte associé à un jeton JWT existe toujours.

Une précision importante : l'exigence de base du sujet — *"au moins
un flux événementiel complet et démontrable"* — est **déjà satisfaite**, en production : créer une
tâche publie un événement sur l'EventBus, consommé par le service de notification, qui envoie
vraiment un message Discord et Telegram. Ce qui reste ouvert sur ce sujet, c'est d'aller plus loin
— une conséquence métier persistée au-delà de la simple notification — mais ce n'est pas la brique
de base qui manquerait.


### 5. Stats générales + contributions par personne — Orateur 2 (~3 min)

> 📄 Support : slides 9, 10

« Quelques chiffres, tous vérifiés directement sur le dépôt, pas des estimations. 118 commits,
43 pull requests mergées, 57 issues GitHub ouvertes sur les trois sprints dont 48 fermées. Cinq
ADR, dont quatre mergés. 362 tests backend et 19 tests frontend qui passent sur `main` en ce
moment — plus encore sur les PR en cours de revue. Environ 3 900 lignes de code backend, 1 500
côté frontend.

Deux bugs critiques trouvés, tous les deux en testant la vraie infrastructure plutôt qu'en se
fiant aux seuls tests unitaires : une image Docker qui démarrait avec un schéma de base
complètement vide parce que les migrations n'étaient jamais copiées dedans, et un jeton JWT d'un
compte supprimé qui restait valide et pouvait faire planter le serveur en exposant une trace SQL
complète au client. Les deux ont été corrigés dans la semaine de leur découverte.

Côté répartition du travail [montrer le tableau, slide 10] : Rayan et Naem portent la persistance
et l'API CRUD avec dix et neuf PR mergées chacun. Cédric porte tout le frontend — Vite, Kanban,
drag & drop, export RGPD. Evan porte le monitoring, Grafana/Prometheus et une bonne partie de la
CI. Etienne porte l'authentification et les corrections de sécurité. Florian porte les fondations
Docker/CI et la stabilisation de fin de sprint. Ce ne sont pas des rôles figés sur le papier — ce
sont des PR réellement mergées, qu'on peut montrer une par une. »

### 6. Insights personnels — Orateurs 1, 2, 3 (~2 min, ~20s chacun)

> 📄 Support : slide 11 — **à personnaliser réellement avant le jour J, pas à lire tel quel**

« [Orateur 1] : *(exemple à remplacer par un vrai ressenti — ex. sur la discipline de tester la
vraie stack plutôt que de se fier aux tests unitaires)*

[Orateur 2] : *(exemple à remplacer — ex. sur ce que la méthode contrat-d'abord a changé dans la
façon de travailler à plusieurs sans se marcher dessus)*

[Orateur 3] : *(exemple à remplacer — ex. sur la difficulté de tracer une décision d'architecture
a posteriori vs. le faire au moment où elle se prend)* »

---

**Fin de la Partie 1.** Enchaîner directement avec `FINAL_PART2_ORAL.md` (deep dive, démo live,
clôture).
