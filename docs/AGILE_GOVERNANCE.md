# Gouvernance agile — Sprint 1

## 1. Organisation de l'équipe (6 personnes)

Le Sprint 1 démarre par une **phase de cadrage, avant tout code** : comprendre l'existant, décider, organiser — pas développer. Cette phase est répartie en 3 ateliers de 2 personnes, chacun responsable d'un livrable de cadrage précis. Les rôles de Product Owner et de Scrum Master sont des responsabilités **additionnelles** portées par deux membres de ces binômes (pas des postes à part, pas de 7e/8e personne) — à désigner par l'équipe au lancement du sprint.

### 1.1 Répartition — phase de cadrage

| Binôme | Membres | Atelier | Livrables |
|---|---|---|---|
| **Binôme 1 — Cadrage Agile & Backlog initial** | Cédric, Etienne | Décortiquer les exigences Must Have / Should Have du cahier des charges ; initialiser le GitHub Project (labels, colonnes, jalons, modèles d'issues) ; rédiger la charte d'équipe (dailies, communication, DoD). | Board GitHub Projects opérationnel, `docs/AGILE_GOVERNANCE.md` (§1.3, §1.4, §2) |
| **Binôme 2 — Audit de la dette technique & Architecture cible** | Naem, Rayan | Analyser le dépôt `docker/getting-started-app` fourni ; lister précisément les faiblesses (tests, couplage/structure monolithique, typage, gestion des données) ; rédiger les premières propositions d'architecture (modèle de données, communication synchrone vs asynchrone). | `docs/AUDIT_REPORT.md`, propositions pour `docs/adr/ADR-001` à `ADR-003` |
| **Binôme 3 — Outillage, Qualité & Stratégie CI/CD** | Florian, Evan | Définir le Quality Gate (seuil de couverture, linter, analyse statique) ; préparer les gabarits de configuration CI (GitHub Actions, build Docker, politique de branches protégées) ; cadrer le périmètre du flux événementiel minimal attendu dès le premier sprint. | `.github/workflows/ci.yml`, proposition pour `docs/adr/ADR-004` |

Les propositions d'architecture (Binôme 2) et de flux événementiel (Binôme 3) sont ensuite **discutées et validées par l'équipe complète** avant de devenir des ADR au statut « Accepté » — un binôme propose, l'équipe décide collectivement, conformément à la règle d'or n°2 (traçabilité et justification).

> Cette répartition couvre la phase de cadrage. Pour la phase d'exécution qui suit (une fois le cadrage validé), la continuité naturelle est que chaque binôme implémente ce qu'il a scopé : Binôme 2 implémente les corrections de persistance/architecture qu'il a proposées, Binôme 3 met en œuvre le pipeline CI et le flux événementiel qu'il a cadrés, Binôme 1 continue le pilotage agile (board, templates, suivi de la DoD) sur toute la durée du sprint.

### 1.2 Rôles additionnels

| Rôle | Porté par | Responsabilités |
|---|---|---|
| **Product Owner (PO)** | 1 membre, désigné parmi les 6, **fixe sur les 3 sprints** | Priorisation du backlog, rédaction des critères d'acceptation, arbitrage MoSCoW, porte-parole des besoins métier en Sprint Review. |
| **Scrum Master (SM)** | 1 membre, **en rotation à chaque sprint** parmi les 5 membres hors PO | Animation des cérémonies, suivi des blocages, garant du respect du process (DoD, conventions Git). Ne fait pas de choix techniques à la place de l'équipe. |

#### Politique de rotation du Scrum Master

- Le SM change à **chaque sprint** (Sprint 1, 2, 3 = 3 titulaires différents), toujours choisi parmi les membres hors PO.
- L'ordre de rotation est fixé au lancement du Sprint 1 et communiqué à toute l'équipe ; le SM sortant désigne officiellement le suivant lors de la Sprint Review, avec confirmation de l'équipe.
- Le SM d'un sprint conserve, pendant sa rotation, ses responsabilités au sein de son binôme d'origine — rôle de service ponctuel, pas un poste à temps plein.

### 1.3 Charte d'équipe (produite par le Binôme 1)

- **Daily stand-up** : quotidien, 15 min max, horaire fixe à définir en Sprint Planning (proposition par défaut : 9h30) ; animé par le SM. Trois questions par personne : fait hier / prévu aujourd'hui / bloqué par quoi.
- **Canal de communication synchrone** : un canal de messagerie d'équipe unique (Discord, Slack ou Teams — au choix de l'équipe, mais un seul canal officiel pour éviter la dispersion), réservé aux échanges rapides et à la coordination informelle.
- **Traçabilité écrite obligatoire** : toute décision, blocage ou changement de scope discuté à l'oral doit être reporté par écrit dans une Issue ou un commentaire de PR GitHub — le canal de messagerie ne remplace jamais la traçabilité Git/GitHub exigée par la DoD (§2, point 2).
- **Sprint Planning / Review / Rétrospective** : cf. §1.4 cérémonies.
- **Definition of Done** : cf. §2 — rappelée en ouverture de chaque Sprint Planning par le SM.

> Les horaires précis restent à confirmer par l'équipe selon les disponibilités réelles ; ce qui est non négociable, c'est la règle de traçabilité écrite.

### 1.4 GitHub Project — checklist d'initialisation (Binôme 1)

- **Labels** : `must-have`, `should-have`, `could-have`, `wont-have` (MoSCoW) ; `type:bug`, `type:chore`, `type:docs`, `type:feature` ; `area:ci`, `area:persistence`, `area:governance`, `area:events`.
- **Colonnes du board** : `Backlog` → `Ready` → `In Progress` → `In Review` → `Done`, avec automatisation (une PR ouverte déplace son Issue liée en `In Review`, une PR mergée la déplace en `Done`).
- **Jalons (Milestones)** : un par sprint (`Sprint 1`, `Sprint 2`, `Sprint 3`), avec date de fin.
- **Modèles d'issues** : `Bug report`, `User Story` (avec critères d'acceptation), `Tâche technique` — chacun doit forcer le lien vers l'Issue dans la PR (`closes #X`), conformément à la DoD.

### Cérémonies

- **Daily stand-up** : quotidien, 15 min max, animé par le SM (cf. §1.3).
- **Sprint Planning** : en début de sprint, PO + équipe, découpage et engagement sur le backlog du sprint.
- **Sprint Review** : fin de sprint, démonstration du travail Done (pas du travail « presque fini »).
- **Rétrospective** : fin de sprint, après la Review, animée par le SM sortant.

Les traces de ces cérémonies (comptes-rendus courts, board GitHub Projects, historique Git) constituent une preuve de fonctionnement agile, au même titre que le code livré.

---

## 2. Definition of Done (DoD)

Une User Story ou une tâche technique n'est **Done** que si **tous** les points suivants sont vérifiés — un item qui fonctionne en local mais ne les remplit pas n'est pas Done :

1. ✅ Revue de code via Pull Request, **au moins 1 approbation obligatoire**.
2. ✅ Issue liée (`closes #X`), Conventional Commits respectés (`feat:`, `fix:`, `refactor:`, `test:`, `docs:`, `chore:`).
3. ✅ Tests unitaires ajoutés pour toute logique métier introduite (pas de PR de logique métier sans test associé).
4. ✅ Quality Gate vert : lint (ESLint) + format (Prettier) + seuil de couverture respecté.
5. ✅ Pipeline CI complet passé sur la PR (`.github/workflows/ci.yml` : lint, tests, build Docker).
6. ✅ Image Docker construite avec succès (le build multi-stage ne doit jamais être laissé rouge).
7. ✅ Documentation associée mise à jour (ADR si décision d'architecture, README si usage, ce fichier si processus).
8. ✅ Démontrable en Sprint Review (pas seulement « ça compile »).


**Aucune exception** : une PR qui ne remplit pas ces 8 points n'est pas mergée, quel que soit l'avancement du sprint.

---

## 3. Backlog Sprint 1 — Découpage MoSCoW

Le principe directeur du Sprint 1 (règle d'or n°1) : **corriger le legacy existant, pas développer de fonctionnalité finale** (pas de Kanban, pas de nouveau CRUD applicatif). Le backlog ci-dessous couvre la phase de cadrage (déjà réalisée) et la phase d'exécution qui en découle.

### Must Have

| ID | Item | Binôme | Phase | Références |
|---|---|---|---|---|
| S1-M1 | Audit technique complet du legacy | Binôme 2 | Cadrage | `docs/AUDIT_REPORT.md` |
| S1-M2 | ADR-001 à ADR-004 proposés par les binômes, validés par toute l'équipe | Binôme 2 (001-003) + Binôme 3 (004) | Cadrage | `docs/adr/` |
| S1-M3 | GitHub Project initialisé (labels, colonnes, jalons, modèles d'issues) + charte d'équipe | Binôme 1 | Cadrage | Ce fichier §1.3-1.4 |
| S1-M4 | Pipeline CI bloquant (lint + tests + build Docker) | Binôme 3 | Exécution | `.github/workflows/ci.yml` |
| S1-M5 | `Dockerfile` multi-stage (le dépôt n'en a actuellement aucun) | Binôme 3 | Exécution | Constat #2 de l'audit |
| S1-M6 | Validation d'entrée sur les 4 routes existantes (corrige le bug `name: undefined`) | Binôme 2 | Exécution | Constat #4 de l'audit, ADR-002 |
| S1-M7 | Contraintes PK/UNIQUE + script de migration SQL versionné sur `todo_items` | Binôme 2 | Exécution | Constat #5 de l'audit, ADR-003 |
| S1-M8 | Couche de service partagée supprimant la duplication CRUD SQLite/MySQL | Binôme 2 | Exécution | Constat #5 de l'audit, ADR-002/003 |
| S1-M9 | Endpoint de health-check HTTP | Binôme 3 | Exécution | Constat #14 de l'audit |
| S1-M10 | Walking skeleton : un flux événementiel de bout en bout démontrable (`EventBus` in-process) | Binôme 3 | Exécution | ADR-004 |

### Should Have

| ID | Item | Binôme |
|---|---|---|
| S1-S1 | `docker-compose.yml` orchestrant l'app avec sa persistance existante (SQLite dev / MySQL prod-like), sans nouveau moteur de base de données | Binôme 3 |
| S1-S2 | Template de PR embarquant la checklist DoD | Binôme 1 |
| S1-S3 | Règles de protection de branche (`main`) : PR obligatoire, CI verte requise | Binôme 3 |
| S1-S4 | Seuil de couverture de tests bloquant en CI | Binôme 3 |
| S1-S5 | Annotations JSDoc + `tsc --noEmit` (mode `checkJs`) sur les fichiers corrigés ce sprint | Binôme 2 |
| S1-S6 | Activation du mode WAL + `busy_timeout` sur le driver SQLite | Binôme 2 |

### Could Have

| ID | Item | Binôme |
|---|---|---|
| S1-C1 | Hooks pre-commit (Husky) reproduisant les checks CI en local | Binôme 3 |
| S1-C2 | `commitlint` pour forcer les Conventional Commits dès le commit local | Binôme 3 |
| S1-C3 | Outillage de génération/numérotation automatique des ADR | Binôme 2 |

### Won't Have (ce sprint)

Explicitement hors périmètre, pour éviter la dérive de scope (règle d'or n°1) :

- Authentification / gestion RGPD des utilisateurs.
- CRUD projets/tâches et workflow Kanban.
- Notifications utilisateur, priorités, échéances.
- Tout changement de langage (TypeScript) ou de moteur de base de données (PostgreSQL) — écarté explicitement par ADR-001 et ADR-003, hors mandat de l'exercice.
- Publication de l'image Docker sur un registre distant (le build est validé en CI, la publication est différée).

Ces items restent dans le backlog produit global, planifiés pour les Sprints 2 et 3, et ne doivent pas être improvisés « pour avancer plus vite » — c'est une violation directe de la règle d'or du projet.
