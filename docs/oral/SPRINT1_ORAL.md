# Texte oral — Soutenance Sprint 1 (phase de cadrage)

**Durée cible** : ~9-10 minutes. Découpage par binôme, à ajuster selon le temps réellement imparti.
**Équipe** : Binôme 1 — Cadrage Agile & Backlog (Cédric, Etienne) · Binôme 2 — Audit & Architecture cible (Naem, Rayan) · Binôme 3 — Outillage, Qualité & CI/CD (Florian, Evan) · PO et SM désignés parmi les 6.

> Ce script couvre la **phase de cadrage** du Sprint 1 — le travail réalisé *avant le code*. Il ne décrit aucune fonctionnalité implémentée : aucun endpoint, aucun flux événementiel n'a encore été codé à ce stade. Ce qui est présenté, ce sont des analyses, des décisions documentées et des gabarits prêts à être exécutés par l'équipe dans la phase suivante.
> Les passages entre crochets `[...]` sont des indications de mise en scène (slide), pas du texte à dire.
> Chaque section liste sous **📄 Supports** les documents à avoir ouverts (sur son propre écran ou en partage) pendant qu'on parle — c'est là que se trouve tout ce qu'on cite (constats, extraits, tableaux), pas besoin de l'apprendre par cœur.

---

## 0. Introduction — porté par le PO (~1 min)

> [Slide : titre du projet + équipe]
> 📄 **Supports** : aucun document technique à l'écran pour cette partie. Avoir en tête le sommaire des livrables au cas où le jury interromprait tôt avec une question (`docs/AUDIT_REPORT.md`, `docs/adr/`, `docs/AGILE_GOVERNANCE.md`, `.github/workflows/ci.yml`, `CONTRIBUTING.md`).

« Bonjour, nous sommes l'équipe en charge de la reprise du projet legacy `docker/getting-started-app`. Avant de vous montrer quoi que ce soit, on veut être clairs sur un point : l'objectif de ce Sprint 1, et en particulier de ce qu'on vous présente aujourd'hui, n'était **pas** de développer. Pas de Kanban, pas de nouveau CRUD, et à ce stade, pas encore de code du tout sur les corrections qu'on a identifiées.

Notre mandat, c'est de reprendre un projet existant, imparfait, et de le **piloter** — comprendre ce qui ne va pas, décider comment le corriger, et le justifier, sans le réécrire et sans changer de langage ni de base de données. Ce qu'on va vous présenter, c'est la phase de cadrage : trois ateliers de deux personnes, chacun avec un livrable précis, qui posent les fondations avant qu'on écrive la moindre ligne de correction. »

---

## 1. Binôme 1 — Cadrage Agile & Backlog initial (Cédric, Etienne) (~2 min)

> [Slide : board GitHub Projects, colonnes MoSCoW]
> 📄 **Supports** :
> - `docs/AGILE_GOVERNANCE.md` §3 — backlog MoSCoW (Must/Should/Could/Won't Have) à montrer à l'écran quand on parle du découpage des exigences.
> - `docs/AGILE_GOVERNANCE.md` §1.4 — checklist labels/colonnes/jalons/modèles d'issues, pour justifier la structure du board GitHub Projects réel.
> - `docs/AGILE_GOVERNANCE.md` §1.3 (charte d'équipe) et §2 (Definition of Done) — pour le passage sur les dailies, le canal de communication et la DoD.
> - Le board GitHub Projects réel, en partage d'écran si possible — plus parlant qu'une slide statique.

« Notre rôle, c'était de transformer le cahier des charges en un backlog exploitable, et de poser le cadre de fonctionnement de l'équipe.

On a d'abord décortiqué les exigences Must Have et Should Have du document, pour savoir précisément ce qui devait être livré ce sprint et ce qui pouvait attendre. Ça a donné notre backlog MoSCoW, découpé en Must Have, Should Have, Could Have, et surtout un Won't Have explicite — parce que dire clairement ce qu'on ne fait pas ce sprint, c'est aussi important que dire ce qu'on fait, pour éviter qu'on nous glisse du scope en cours de route.

Ensuite, on a initialisé le GitHub Project : les labels — priorité MoSCoW, type de tâche, domaine technique — les colonnes du board de Backlog jusqu'à Done, les jalons pour chaque sprint, et des modèles d'issues pour que chaque bug, chaque tâche technique soit tracé de la même façon par tout le monde.

Enfin, on a rédigé la charte d'équipe : horaire du daily, canal de communication unique pour éviter que les décisions se perdent entre trois outils différents, et surtout une règle simple — tout ce qui est décidé à l'oral doit être réécrit dans une Issue ou une PR. Si ce n'est pas écrit, ça n'a pas eu lieu. C'est aussi là qu'on a formalisé notre Definition of Done : une Pull Request n'est acceptée que si elle a une revue, des tests, un quality gate vert et un build Docker qui passe — sans exception. »

---

## 2. Binôme 2 — Audit de la dette technique & Architecture cible (Naem, Rayan) (~2,5 min)

> [Slide : matrice de sévérité de l'audit]
> 📄 **Supports** :
> - `docs/AUDIT_REPORT.md` §2.6 (frontend React compilé via Babel Standalone) et §2.5 (tests Jest présents mais non exécutables) — pour les deux surprises citées.
> - `docs/AUDIT_REPORT.md` §2.1 (bug `name: undefined`) et §3 (matrice de sévérité complète, à projeter) — pour les constats critiques.
> - `docs/adr/ADR-001-strategie-langage-typage.md`, `ADR-002-architecture-applicative.md`, `ADR-003-persistance-donnees.md` — ouvrir en particulier le bandeau **« Note de révision »** en tête de chacun, c'est la preuve écrite du changement d'avis assumé dont on parle à l'oral.

« Notre rôle, c'était d'analyser le dépôt fourni sans a priori, et de proposer des pistes d'architecture cible à partir de ce qu'on y a réellement trouvé.

On a d'abord fait un audit ligne par ligne du code existant. Ça nous a permis de trouver des choses qu'on n'attendait pas. Par exemple, on pensait au départ que le frontend était en JavaScript natif. En fait, c'est du React, mais compilé **dans le navigateur** avec Babel, sans build, sans bundler.

Plus important : il existe déjà des fichiers de tests dans le dépôt, écrits avec la syntaxe Jest. On aurait pu croire que le projet était testé. En réalité, `jest` n'est même pas déclaré comme dépendance, et il n'y a aucun script `npm test` — ces tests n'ont probablement jamais tourné dans un pipeline. On a aussi trouvé un vrai bug de fiabilité : la route qui crée un item ne vérifie jamais que le champ `name` envoyé existe.

On a classé chaque constat par sévérité — Faible, Moyenne, Critique — dans notre rapport d'audit. À partir de ces constats critiques — zéro tests exécutables, zéro CI, persistance dupliquée sans contrainte d'intégrité, couplage direct entre les routes et la base de données — on a rédigé nos premières propositions d'architecture cible, comparant à chaque fois au moins deux alternatives réelles.

Petit point important, assumé : nos premières pistes étaient plus radicales — migrer vers TypeScript, migrer vers PostgreSQL. En reprécisant le mandat de l'exercice — piloter un legacy, pas le remplacer — on a révisé nos propositions vers des corrections **en place** : garder JavaScript avec du JSDoc, garder SQLite et MySQL mais corriger leurs défauts concrets, garder la structure de dossiers existante et juste extraire une fine couche de service pour supprimer la duplication qu'on avait trouvée entre les deux drivers de base de données. Ces propositions ont ensuite été discutées et validées par toute l'équipe, elles ne sont pas restées un avis de binôme. »

---

## 3. Binôme 3 — Outillage, Qualité & Stratégie CI/CD (Florian, Evan) (~2,5 min)

> [Slide/démo : gabarit ci.yml]
> 📄 **Supports** :
> - `.github/workflows/ci.yml` — ouvrir le fichier réel (les 3 jobs `lint`/`test`/`docker-build` et le commentaire d'en-tête qui explique pourquoi il est rouge) plutôt qu'une capture, plus convaincant si le jury demande à voir.
> - `docs/AGILE_GOVERNANCE.md` §2 (Quality Gate = points 4 et 6 de la DoD) et backlog `[S1-S3]`/`[S1-S4]` (branch protection, seuil de couverture).
> - `docs/adr/ADR-004-mecanisme-event-driven.md` — pour justifier le choix EventEmitter in-process vs Redis/RabbitMQ.

« Notre rôle, c'était de définir les garde-fous de qualité et de préparer les gabarits techniques, sans attendre que le code existe pour les écrire — c'est délibéré : on définit d'abord l'exigence, l'équipe la fait passer au vert ensuite.

On a défini le Quality Gate : un seuil de couverture de tests, un linter, une analyse statique. On a ensuite préparé le gabarit de pipeline CI en GitHub Actions — trois étapes qui s'enchaînent : lint et format, tests avec couverture, puis build Docker multi-stage. Si une étape casse, les suivantes ne se lancent pas, pour ne pas perdre de temps.

[Si démo possible : montrer le fichier `.github/workflows/ci.yml`.]

Ce pipeline est volontairement rouge aujourd'hui : il attend un `Dockerfile` qui n'existe pas encore dans le dépôt — on l'a vérifié, il n'y en avait aucun — et des scripts `lint`/`test` que l'équipe ajoutera dans la phase d'exécution. On a aussi défini la politique de protection de la branche principale : Pull Request obligatoire, CI verte requise avant de merger.

Enfin, on a cadré le périmètre du flux événementiel minimal attendu dès ce premier sprint : pas un flux codé aujourd'hui, mais une décision d'architecture — un bus d'événements interne à l'application, sans service externe, parce qu'on n'a qu'un seul process à faire tourner à ce stade. Ce choix est documenté avec ses alternatives et ses limites assumées, prêt à être implémenté dans la phase suivante. »

---

## 4. Conclusion — porté par le SM (~1,5 min)

> [Slide : les 4 ADR, board GitHub Projects]
> 📄 **Supports** :
> - `docs/adr/` (les 4 fichiers) — pour le rappel des décisions comparées et justifiées.
> - `docs/AGILE_GOVERNANCE.md` §2 (DoD complète, 8 points) — à garder affichée pendant la phrase sur « aucune exception, même en fin de sprint ».
> - Le board GitHub Projects réel — pour clore sur une preuve visuelle plutôt qu'une affirmation.

« Pour résumer : ce Sprint 1, dans sa phase de cadrage, ne livre aucune fonctionnalité et aucune ligne de correction encore mergée. Ce qu'il livre, c'est un audit vérifié sur le code réel, quatre décisions d'architecture comparées et justifiées — y compris un changement d'avis assumé et documenté plutôt que caché — un backlog MoSCoW avec un board GitHub Projects opérationnel, une charte d'équipe, et des gabarits de qualité et de CI prêts à être activés.

Notre Definition of Done s'applique dès la première Pull Request de la phase suivante : revue obligatoire, tests, quality gate vert, build Docker qui passe. Aucune exception, même en fin de sprint.

Ce qu'on retient de cette phase de cadrage : comprendre avant de corriger, comparer avant de décider, documenter chaque choix — y compris quand on change d'avis. C'est ce mindset-là qu'on va garder pour la suite du Sprint 1, quand on passera à l'implémentation des corrections qu'on vient de vous présenter. Merci. »

