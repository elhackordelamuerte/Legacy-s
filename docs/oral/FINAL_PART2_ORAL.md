# Script — Soutenance finale, Partie 2 : Deep dive & démo live (3 orateurs)

**Partie 2 sur 2, ~25 min de deep dive + démo live, plus clôture (~30 min au total), suivie de
5 min de feedback du coach.** Enchaîne directement après la Partie 1 (`FINAL_PART1_ORAL.md` /
`FINAL_PART1_SLIDES.md`). Slides en anglais (`FINAL_PART2_SLIDES.md`), script en français. Mêmes
3 orateurs, même règle : n'importe qui dans l'équipe peut reprendre la main sur une question
technique pointue à tout moment.

> ⚠️ **Statut à la date de rédaction (29-30/09)** : à revérifier juste avant de présenter —
> `#69`, `#96`, `#97`, `#99`, `#102`, `#105`. Ce document dépend aussi de la PR choisie pour la
> démo live (à décider en équipe, voir en bas de ce fichier).

---

## 0. Répartition des 3 orateurs (Partie 2)

| Orateur | Porte | Contenu |
|---|---|---|
| **Orateur 1** | Démo live, clôture | Slides 8-11 |
| **Orateur 2** | Git & code review, process | Slides 2-3, 6 |
| **Orateur 3** | CI/CD, QA, accessibilité | Slides 4-5, 7 |

## 1. Trame minutée (~30 min de présentation + 5 min coach)

| Temps (depuis le début de la Partie 2) | Section | Orateur |
|---|---|---|
| 0:00–3:00 | Dépôt Git | 2 |
| 3:00–6:00 | Revue de code | 2 |
| 6:00–9:00 | CI/CD | 3 |
| 9:00–12:00 | Stratégie de tests / QA | 3 |
| 12:00–14:00 | Process de travail | 2 |
| 14:00–16:30 | Gestion du handicap : RGAA | 3 |
| 16:30–24:30 | Démo live : une fonctionnalité complète, tout le process | 1 |
| 24:30–25:10 | Ce qu'il reste, honnêtement | 1 |
| 25:10–25:40 | Transition questions | 1 |
| 25:40–30:40 | Feedback du coach | — |

---

## 2. Contenu détaillé

### 1. Dépôt Git — Orateur 2 (~3 min)

> 📄 Support : slide 2 — montrer `git log --oneline --graph` en direct

« Conventional Commits imposés par un hook pre-commit — `husky` et `commitlint` — donc pas une
convention sur le papier qu'on peut oublier, une vérification automatique à chaque commit. Une
branche par issue, nommée d'après elle. Quand une PR dépend vraiment d'une autre pas encore
mergée, on l'empile explicitement dessus et on le documente dans la description de la PR, plutôt
que de laisser la dépendance implicite.

Ce qui se voit vraiment dans l'historique, c'est la méthode contrat-d'abord : sur chaque brique
majeure — persistance utilisateur, persistance Kanban, canaux de notification — le commit qui pose
l'interface JSDoc pure précède systématiquement celui qui l'implémente. [Montrer un exemple
concret sur 2-3 PR.] »

### 2. Revue de code — Orateur 2 (~3 min)

> 📄 Support : slide 3 — `CONTRIBUTING.md` §4, template de PR

« La Definition of Done est appliquée sans exception : une approbation minimum, une issue liée via
`closes #X`, des tests pour toute nouvelle logique métier, un quality gate vert, démontrable en
revue. Et ce ne sont pas des cases cochées automatiquement : les revues sont réelles, pas des
tampons — on relance les tests soi-même, on relit le diff, parfois on teste en direct contre un
serveur qui tourne plutôt que de se fier au seul badge CI vert. »

### 3. CI/CD — Orateur 3 (~3 min)

> 📄 Support : slide 4 — `.github/workflows/ci.yml`

« Le pipeline fait tourner lint, format, tests unitaires, puis surtout construit et démarre
**toute la stack Docker** — l'app, la base, Prometheus, Grafana — et vérifie que chacun répond,
pas seulement l'API isolée. Ça a un objectif concret : rattraper en CI un problème qui, sinon,
n'apparaîtrait qu'au moment d'une démo en direct.

Il y a une limite qu'on assume : la CI vérifie que l'API répond, pas encore que le frontend est
réellement servi par l'image — c'est exactement le point encore ouvert dont on parlait en
première partie. »

### 4. Stratégie de tests / QA — Orateur 3 (~3 min)

> 📄 Support : slide 5

« 381 tests automatisés entre le backend et le frontend. Mais les deux bugs les plus sérieux du
projet n'ont pas été trouvés par ces tests-là — ils ont été trouvés en testant la vraie
infrastructure : le schéma de base vide dans l'image Docker, et le jeton JWT d'un compte supprimé
qui restait accepté. Aucun test unitaire mocké n'aurait vu ça, parce que le mock, par construction,
ne reproduit pas l'environnement réel qui a révélé le problème.

La leçon qu'on en tire concrètement : avant de dire "tous les tests sont verts, c'est prêt", on
vérifie aussi à la main contre la vraie infrastructure — vrai Docker, vrais webhooks — pas
uniquement contre des mocks.

Un gap qu'on assume aussi : le sujet distingue explicitement, dans sa Definition of Done, un
niveau de couverture de tests requis du quality gate général. Chez nous, la couverture est
mesurée à chaque run, mais aucun seuil n'est imposé pour merger — on ne l'a pas mis en place. »

### 5. Process de travail — Orateur 2 (~2 min)

> 📄 Support : slide 6 — board GitHub Projects

« Le rythme n'a pas changé depuis le Sprint 1 : daily stand-up, sprint planning, sprint review,
rétrospective, tout tracé sur le board GitHub Projects avec ses colonnes Backlog → Ready → In
progress → In review → Done. La priorisation MoSCoW reste explicite et à jour sur les trois
sprints — on peut montrer le board maintenant et voir exactement où en est chaque item. La
coordination entre deux moments de revue passe par les commentaires d'issue ou de PR, jamais
uniquement par une décision verbale qu'on ne retrouve nulle part ensuite. »

### 6. Gestion du handicap : RGAA — Orateur 3 (~2 min 30)

> 📄 Support : slide 7 — issue `#107`

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

### 7. Démo live : une fonctionnalité complète, tout le process — Orateur 1 (~8 min)

> 📄 Support : slides 8, 9 — **choisir la PR à l'avance, la plus complète et propre à raconter**

« Pour finir, on va vous montrer une fonctionnalité de bout en bout, en respectant tout notre
process : l'issue de départ, la branche, les commits — contrat avant implémentation — la pull
request, la revue avec la Definition of Done, le merge, puis la démonstration dans l'app.

[Dérouler en direct sur GitHub : l'issue → la branche → 2-3 commits significatifs → la PR avec sa
checklist DoD cochée → l'approbation → le merge.]

Et maintenant, l'application elle-même, en direct : inscription, connexion, création d'un projet,
création d'une tâche, déplacement par drag & drop dans une autre colonne, ajout d'une priorité et
d'une échéance, rechargement de la page pour montrer que tout persiste. Et pendant qu'on fait ça,
on regarde le dashboard Grafana bouger en quasi temps réel, et on vérifie que la notification
arrive bien sur Discord et Telegram. »

### 8. Ce qu'il reste, honnêtement — Orateur 1 (~40 s)

> 📄 Support : slide 10 — **actualiser juste avant de présenter**

« Ce qui reste ouvert, à l'instant où on vous parle, côté Must Have : `#102`, le Dockerfile qui ne
sert pas encore le frontend, `#73`, la publication de l'image sur un registre, et `#69`,
l'extension du flux événementiel — étant précisé que l'exigence de base du sujet sur ce dernier
point est déjà satisfaite, il s'agit d'approfondir, pas de combler un trou. Le reste — `#74`, l'écran
d'accueil complet, `#96`, `#103`, l'absence de seuil de couverture — reste en Should Have, avec un
état qu'on va vérifier une dernière fois juste avant de monter sur scène pour vous donner le chiffre
exact, pas une estimation
d'hier. »

### 9. Transition — Orateur 1 (~20 s)

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

## Q&A à anticiper — points relevés en recroisant le sujet du projet

| Question probable | Réponse |
|---|---|
| Quel est votre seuil de couverture de tests ? | Aucun seuil imposé pour merger — la couverture est mesurée à chaque run mais pas gatée. Gap assumé face au sujet, qui la distingue explicitement du quality gate général |
| L'écran d'accueil personnalisé est fait ? | À moitié : la liste des projets, oui ; la vue agrégée des tâches assignées tous projets confondus, non — l'issue avait été fermée par erreur comme complète, corrigé dans ce bilan |
| Vous avez bien un flux événementiel démontrable ? | Oui, en production : `TaskCreated` → EventBus → notifieur multi-canaux, vérifié avec de vrais Discord/Telegram. `#69` est une extension au-delà de cette exigence de base, pas la brique elle-même |
| L'image Docker est publiée sur un registre ? | Pas encore — en cours (`#73`), reclassé Must Have suite à la relecture du sujet, initialement mal classé en Should Have |

## Feedback du coach (5 min)

Un membre de l'équipe hors des 3 orateurs prend des notes écrites — elles alimentent la
rétrospective finale, pas seulement la note.
