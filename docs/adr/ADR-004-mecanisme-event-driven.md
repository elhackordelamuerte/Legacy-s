# ADR-004 : Mécanisme event-driven

**Statut** : Accepté
**Date** : 2026-09-02
**Proposé par** : Binôme 3 — Outillage, Qualité & Stratégie CI/CD (Florian, Evan)
**Décideurs** : Équipe (6) — validé en revue d'architecture Sprint 1

## Contexte

Le cadrage du projet exige un flux événementiel **démontrable de bout en bout dès le Sprint 1**, dans le cadre du walking skeleton, sans attendre les sprints suivants. L'application reste, après ADR-002, un **monolithe à process unique** (correction incrémentale en place, pas de découpage en services) — c'est un paramètre de contexte déterminant pour cette décision : il n'y a, à ce stade, ni scalabilité horizontale à assurer, ni plusieurs services indépendants à faire communiquer sur le réseau.

Le besoin fonctionnel est de découpler un module producteur d'un module consommateur (ex. la création d'une tâche déclenche une notification), sans que le producteur connaisse l'implémentation du consommateur.

## Alternatives considérées

### Option A — EventEmitter in-process (Node natif), encapsulé derrière un port `EventBus`

Un bus d'événements interne au process, basé sur l'API `EventEmitter` de Node, exposé aux modules via une interface `EventBus` (publish/subscribe) définie dans la couche applicative.

- **Pour** : zéro dépendance d'infrastructure supplémentaire, démontrable en test unitaire pur (aucun mock réseau nécessaire), coût de mise en place quasi nul, testable en CI sans service additionnel.
- **Contre** : les événements sont perdus si le process s'arrête avant traitement (pas de persistance, pas de retry) ; pas de scalabilité horizontale (un seul process traite tous les événements).

### Option B — Broker léger externe (Redis Pub/Sub ou RabbitMQ)

Introduire un service de message broker dès le Sprint 1 pour la communication inter-modules.

- **Pour** : durabilité potentielle des événements, scalabilité horizontale native, prépare une éventuelle décomposition en microservices.
- **Contre** : ajoute une dépendance opérationnelle (service à déployer, sécuriser, monitorer, gérer en CI et dans `docker-compose`) alors que l'application reste un monolithe à process unique après ADR-002 — le bénéfice de la durabilité/scalabilité n'est pas exploitable à ce stade et le coût de setup consommerait du temps du Sprint 1 sans valeur fonctionnelle immédiate. C'est aussi une dépendance nouvelle non requise par le mandat « corriger en place ».

## Décision

**Option A — EventEmitter in-process typé**, encapsulé derrière un port `EventBus` défini dans la couche de service introduite en ADR-002 (`src/services/`), avec une implémentation `InMemoryEventBus` pour le Sprint 1.

Le contrat d'interface (`publish(event)`, `subscribe(eventType, handler)`) est conçu dès le départ pour permettre le remplacement futur par une implémentation `RedisEventBus` sans modifier le code appelant (producteurs et consommateurs ne dépendent que du port, jamais de l'implémentation).

## Conséquences

**Positives :**

- Aucune dépendance d'infrastructure supplémentaire pour le Sprint 1 : le walking skeleton reste démontrable en CI sans service externe.
- Découplage producteur/consommateur démontré de bout en bout (ex. `TaskCreated` → `NotificationHandler`) avec un coût de mise en place minimal.
- Testable unitairement sans mock réseau.

**Négatives :**

- Aucune garantie de livraison : un événement émis pendant que le process redémarre est perdu (pas de retry, pas de persistance).
- Pas de scalabilité horizontale : si l'application doit un jour tourner sur plusieurs instances, l'`EventEmitter` in-process ne suffit plus.
- La migration vers Redis Pub/Sub (ou équivalent) devra alors traiter explicitement la question de la garantie de livraison (*at-least-once*), absente du modèle actuel. Cette limite est documentée comme dette technique assumée et planifiée en Should Have pour un sprint ultérieur (voir `docs/AGILE_GOVERNANCE.md`), pas ignorée silencieusement.
