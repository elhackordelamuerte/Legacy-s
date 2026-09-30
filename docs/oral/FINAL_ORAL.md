# Script — Soutenance finale du projet (3 orateurs)

**Format imposé** : 45 minutes — **15 min** Sprint 3 & bilan final, **25 min** deep dive
(ADR, code, process), **5 min** feedback du coach. Slides en anglais (`FINAL_SLIDES.md`), script en
français. 3 orateurs présentent, les 3 autres membres de l'équipe sont dans la salle et peuvent
reprendre la main sur une question technique pointue à tout moment — ce n'est pas réservé aux
3 orateurs.

> ⚠️ **Statut à la date de rédaction (29/09)** : cœur fonctionnel complet sur les 3 sprints (auth,
> RGPD, Kanban, monitoring multi-canaux vérifié en réel, dashboard Grafana vérifié en réel). Un
> seul Must Have encore ouvert et critique : `#102` (le Dockerfile ne sert pas le frontend), en
> cours chez Florian, échéance du Sprint 3 le 30/09. **Note pour le jour J** : revérifier l'état de
> `#69`, `#96`, `#97`, `#99`, `#102`, `#105` juste avant de présenter — ce script est écrit à J-1.

---

## 0. Répartition des 3 orateurs

| Orateur | Porte | Contenu |
|---|---|---|
| **Orateur 1** | Contexte, périmètre produit, démo live, clôture | Slides 1-2, 7-8, 18-21 |
| **Orateur 2** | Organisation, stats/contributions, Git & code review, process | Slides 3, 9-10, 12-13, 16 |
| **Orateur 3** | ADR, architecture, CI/CD, QA, accessibilité | Slides 4-6, 14-15, 17 |

## 1. Trame minutée (45 min)

| Temps | Section | Orateur |
|---|---|---|
| 0:00–0:20 | Ouverture | 1 |
| **Partie 1 — Sprint 3 & bilan final (15 min)** | | |
| 0:20–1:50 | Contexte du projet | 1 |
| 1:50–3:50 | Organisation finale de l'équipe | 2 |
| 3:50–6:50 | Décisions techniques (ADR) + architecture finale + modèle de données | 3 |
| 6:50–10:20 | Périmètre produit final : livré / manquant | 1 |
| 10:20–13:20 | Stats générales + contributions par personne | 2 |
| 13:20–15:20 | Insights personnels (les 3 orateurs) | 1, 2, 3 |
| **Partie 2 — Deep dive (25 min)** | | |
| 15:20–18:20 | Dépôt Git | 2 |
| 18:20–21:20 | Revue de code | 2 |
| 21:20–24:20 | CI/CD | 3 |
| 24:20–27:20 | Stratégie de tests / QA | 3 |
| 27:20–29:20 | Process de travail | 2 |
| 29:20–31:50 | Gestion du handicap : RGAA | 3 |
| 31:50–39:50 | Démo live : une fonctionnalité complète, tout le process | 1 |
| 39:50–40:30 | Ce qu'il reste, honnêtement | 1 |
| 40:30–41:00 | Transition questions | 1 |
| **Partie 3 (41:00–45:00)** | Feedback du coach | — |

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
même, dans une issue ou un commentaire de PR. Si ce n'est pas écrit, ça n'a pas eu lieu.

Un exemple concret de cette discipline, au Sprint 2 : deux personnes ont ouvert, chacune de son
côté, une PR pour la même fonctionnalité frontend, avec deux architectures différentes. Plutôt que
de merger les deux et se retrouver avec une app incohérente, on a tranché en équipe — qui est lead
sur le frontend — et fermé l'autre PR proprement, sans reproche sur le travail fait, juste un
doublon d'effort assumé. »

### 3. Décisions techniques (ADR) + architecture finale + modèle de données — Orateur 3 (~3 min)

> 📄 Support : slides 4, 5, 6 — `docs/architecture/adr/`, `docs/architecture/target-architecture.md`

« Cinq décisions structurantes ont été tracées en ADR, au format Nygard — contexte, au moins deux
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

Maintenant, ce qui manque, et on préfère le dire clairement plutôt que de le laisser découvrir en
Q&A : le Dockerfile ne construit toujours pas le frontend — une image Docker fraîche ne sert rien
d'utilisable sur `/`, c'est en cours de correction, prévu pour demain. Le flux événementiel reste
limité à `TaskCreated` déclenchant une notification, sans aller jusqu'à une vraie conséquence
métier persistée au-delà de ça. Côté accessibilité — on y revient en détail plus loin — un audit
partiel a été fait, pas un audit RGAA complet, et le drag & drop n'a toujours aucune alternative
clavier. Et l'image Docker n'est pas publiée sur un registre. »

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

## Partie 2 — Deep dive (25 min)

### 7. Dépôt Git — Orateur 2 (~3 min)

> 📄 Support : slide 12 — montrer `git log --oneline --graph` en direct

« Conventional Commits imposés par un hook pre-commit — `husky` et `commitlint` — donc pas une
convention sur le papier qu'on peut oublier, une vérification automatique à chaque commit. Une
branche par issue, nommée d'après elle. Quand une PR dépend vraiment d'une autre pas encore
mergée, on l'empile explicitement dessus et on le documente dans la description de la PR, plutôt
que de laisser la dépendance implicite.

Ce qui se voit vraiment dans l'historique, c'est la méthode contrat-d'abord : sur chaque brique
majeure — persistance utilisateur, persistance Kanban, canaux de notification — le commit qui pose
l'interface JSDoc pure précède systématiquement celui qui l'implémente. [Montrer un exemple
concret sur 2-3 PR.] »

### 8. Revue de code — Orateur 2 (~3 min)

> 📄 Support : slide 13 — `CONTRIBUTING.md` §4, template de PR

« La Definition of Done est appliquée sans exception : une approbation minimum, une issue liée via
`closes #X`, des tests pour toute nouvelle logique métier, un quality gate vert, démontrable en
revue. Et ce ne sont pas des cases cochées automatiquement : les revues sont réelles, pas des
tampons — on relance les tests soi-même, on relit le diff, parfois on teste en direct contre un
serveur qui tourne plutôt que de se fier au seul badge CI vert. »

### 9. CI/CD — Orateur 3 (~3 min)

> 📄 Support : slide 14 — `.github/workflows/ci.yml`

« Le pipeline fait tourner lint, format, tests unitaires, puis surtout construit et démarre
**toute la stack Docker** — l'app, la base, Prometheus, Grafana — et vérifie que chacun répond,
pas seulement l'API isolée. Ça a un objectif concret : rattraper en CI un problème qui, sinon,
n'apparaîtrait qu'au moment d'une démo en direct.

Il y a une limite qu'on assume : la CI vérifie que l'API répond, pas encore que le frontend est
réellement servi par l'image — c'est exactement le point encore ouvert dont on parlait
tout à l'heure. »

### 10. Stratégie de tests / QA — Orateur 3 (~3 min)

> 📄 Support : slide 15

« 381 tests automatisés entre le backend et le frontend. Mais les deux bugs les plus sérieux du
projet n'ont pas été trouvés par ces tests-là — ils ont été trouvés en testant la vraie
infrastructure : le schéma de base vide dans l'image Docker, et le jeton JWT d'un compte supprimé
qui restait accepté. Aucun test unitaire mocké n'aurait vu ça, parce que le mock, par construction,
ne reproduit pas l'environnement réel qui a révélé le problème.

La leçon qu'on en tire concrètement : avant de dire "tous les tests sont verts, c'est prêt", on
vérifie aussi à la main contre la vraie infrastructure — vrai Docker, vrais webhooks — pas
uniquement contre des mocks. »

### 11. Process de travail — Orateur 2 (~2 min)

> 📄 Support : slide 16 — board GitHub Projects

« Le rythme n'a pas changé depuis le Sprint 1 : daily stand-up, sprint planning, sprint review,
rétrospective, tout tracé sur le board GitHub Projects avec ses colonnes Backlog → Ready → In
progress → In review → Done. La priorisation MoSCoW reste explicite et à jour sur les trois
sprints — on peut montrer le board maintenant et voir exactement où en est chaque item. La
coordination entre deux moments de revue passe par les commentaires d'issue ou de PR, jamais
uniquement par une décision verbale qu'on ne retrouve nulle part ensuite. »

### 12. Gestion du handicap : RGAA — Orateur 3 (~2 min 30)

> 📄 Support : slide 17 — issue `#107`

« Une exigence est arrivée à la suite de la deuxième soutenance intermédiaire : tendre vers la
conformité RGAA. On va d'abord dire ce que c'est, pour montrer qu'on a compris le sujet, puis ce
qu'on en a fait concrètement aujourd'hui.

Le RGAA, c'est le Référentiel Général d'Amélioration de l'Accessibilité — la déclinaison française
des WCAG 2.1 niveau AA, 106 critères répartis en 13 thématiques : images, couleurs, formulaires,
navigation, scripts, et ainsi de suite. Il repose sur les mêmes quatre principes que WCAG :
perceptible, utilisable, compréhensible, robuste. C'est une obligation légale — loi du 11 février
2005, article 47 — historiquement pour le secteur public, et depuis le 28 juin 2025, avec
l'European Accessibility Act, étendue aux entreprises privées de plus de dix salariés ou de plus de
deux millions d'euros de chiffre d'affaires. Un détail qui compte pour la suite : l'outil officiel
d'audit du RGAA, Ara, développé par la DINUM, n'est **pas automatique** — il demande un jugement
d'expert sur un échantillon représentatif de pages. Un outil ne suffit jamais à lui seul.

Concrètement, aujourd'hui : un scan automatisé avec Lighthouse et axe sur la page de connexion et
d'inscription — score de 100 %, aucune violation détectée. Puis une revue manuelle du tableau
Kanban, parce qu'aucun outil automatique ne remplace ça — exactement pour la même raison
qu'Ara ne l'est pas. On a vérifié que la priorité d'une tâche n'est jamais indiquée par la couleur
seule — il y a toujours un texte à côté. Et on a trouvé un vrai problème : deux des trois badges de
priorité avaient un contraste de 3.19:1 et 3.09:1 entre le texte blanc et le fond, alors que le
seuil WCAG AA pour du texte de cette taille est de 4.5:1. Corrigé aujourd'hui même en assombrissant
la même teinte, sans changer le sens ni le comportement.

Ce qu'on n'a pas corrigé, et qu'on assume : le drag & drop n'a aucune alternative clavier —
déplacer une carte entre colonnes demande obligatoirement une souris ou un écran tactile. C'est une
vraie non-conformité, ça demanderait de repenser l'interaction, pas un correctif de dernière
minute, et on préfère le dire plutôt que de laisser croire que c'est réglé. »

### 13. Démo live : une fonctionnalité complète, tout le process — Orateur 1 (~8 min)

> 📄 Support : slides 18, 19 — **choisir la PR à l'avance, la plus complète et propre à raconter**

« Pour finir cette partie, on va vous montrer une fonctionnalité de bout en bout, en respectant
tout notre process : l'issue de départ, la branche, les commits — contrat avant implémentation —
la pull request, la revue avec la Definition of Done, le merge, puis la démonstration dans l'app.

[Dérouler en direct sur GitHub : l'issue → la branche → 2-3 commits significatifs → la PR avec sa
checklist DoD cochée → l'approbation → le merge.]

Et maintenant, l'application elle-même, en direct : inscription, connexion, création d'un projet,
création d'une tâche, déplacement par drag & drop dans une autre colonne, ajout d'une priorité et
d'une échéance, rechargement de la page pour montrer que tout persiste. Et pendant qu'on fait ça,
on regarde le dashboard Grafana bouger en quasi temps réel, et on vérifie que la notification
arrive bien sur Discord et Telegram. »

### 14. Ce qu'il reste, honnêtement — Orateur 1 (~40 s)

> 📄 Support : slide 20 — **actualiser juste avant de présenter**

« Ce qui reste ouvert, à l'instant où on vous parle, côté Must Have : `#102`, le Dockerfile qui ne
sert pas encore le frontend, et `#69`, l'extension du flux événementiel — les deux en cours. Le
reste — `#73`, `#74`, `#96`, `#103` — reste en Should Have, avec un état qu'on va vérifier une
dernière fois juste avant de monter sur scène pour
vous donner le chiffre exact, pas une estimation d'hier. »

### 15. Transition — Orateur 1 (~20 s)

« Voilà pour notre bilan. On est prêts pour vos questions, et n'importe qui dans l'équipe peut
reprendre la main sur un point technique précis. »

---

## Après la présentation — à préparer avant le jour J

- **Preuve de réalisation** : historique Git complet, prêt à montrer sur n'importe quelle PR
  demandée par le jury, pas seulement celle choisie pour la démo.
- **PR choisie pour la démo live** : décider à l'avance laquelle est la plus complète et la plus
  propre à raconter (candidats sérieux : `#78`/`#66` CRUD Kanban, `#94`/`#65` suppression de compte
  RGPD, `#105`/`#76` export RGPD une fois mergée).
- **Environnement de démo** : lancer la stack avant l'entrée en salle (`npm run local:start` si
  Docker est stable ce jour-là), vérifier que Grafana affiche des données récentes, vérifier que le
  webhook Discord/le bot Telegram utilisés sont toujours valides.

## Q&A à anticiper — RGAA (nouvelle exigence, questions probables)

| Question probable | Réponse |
|---|---|
| C'est quoi le RGAA exactement ? | Référentiel Général d'Amélioration de l'Accessibilité, déclinaison française des WCAG 2.1 AA, 106 critères / 13 thématiques, loi du 11/02/2005 art. 47 |
| Vous êtes conformes ? | Non, et on ne le prétend pas — audit partiel (scan automatisé + revue manuelle ciblée), pas les 106 critères sur un échantillon représentatif de pages (méthodologie RGAA complète) |
| Pourquoi pas un audit complet ? | Reçu en cours de Sprint 3, temps réaliste pour comprendre le référentiel + un audit ciblé + un correctif, pas pour une conformité totale sur 3 sprints |
| Un exemple concret de ce que vous avez trouvé ? | Contraste insuffisant sur 2 badges de priorité (3.19:1 et 3.09:1 vs. 4.5:1 requis), corrigé le jour même — issue `#107` |
| Et ce qui reste non conforme ? | Le drag & drop n'a aucune alternative clavier — assumé, pas caché, nécessiterait une réécriture de l'interaction |
| Un outil suffit pour être conforme RGAA ? | Non — même l'outil officiel (Ara, DINUM) n'est pas automatique, il demande un jugement d'expert sur un échantillon de pages |

## Feedback du coach (5 min)

Un membre de l'équipe hors des 3 orateurs prend des notes écrites — elles alimentent la
rétrospective finale, pas seulement la note.
