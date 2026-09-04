# SPRINT 1 SPECIFICATION: AUDIT, TRADEOFF ANALYSIS & FOUNDATIONS

## 1. Context & Philosophy (Mentor Guidance)
- The goal is **not** to rush into coding features, but to demonstrate technical maturity, quality engineering mindset, and project governance.
- Code is only the consequence of upstream analysis:
  * Understanding what currently exists (legacy).
  * Analyzing risks and impacts of every change.
  * Evaluating multiple alternatives before deciding.
  * Communicating decisions clearly via Architecture Decision Records (ADRs).
- Deliverable of Sprint 1: A justified transition plan, an audit report, a documented backlog, and an operational minimal end-to-end walking skeleton (including CI and an event-driven flow).

---

## 2. Sprint 1 Objectives & Deliverables Breakdown

### Phase 1: Legacy Technical Debt & Ecosystem Audit (Days 1 - 2)
**Goal:** Dissect the baseline (`docker/getting-started-app`) across multiple dimensions.
- **Language & Runtime:**
  * Node.js version, package manager, module system (CommonJS vs ESM).
  * Missing static typing (JavaScript vs TypeScript).
- **Dependencies & Libraries:**
  * Obsolete or vulnerable packages (e.g., outdated SQLite wrappers, express, outdated frontend libraries).
  * Security assessment (`npm audit` / dependency vulnerability review).
- **Architecture & Coupling:**
  * Tight coupling between routing, persistence, and business logic.
  * Lack of separation of concerns (Layered vs Clean/Hexagonal Architecture).
- **Data Persistence:**
  * Current SQLite flat-file structure, lack of migrations, concurrency limitations, data integrity issues.
- **Testing & Quality:**
  * Current absence of test pyramid (no unit tests, no integration tests, no contract tests).
  * Lack of linters, code formatters, and static analyzers.
- **Build & Packaging:**
  * Current Dockerfile evaluation (layer caching, image size, non-root user execution, multi-stage builds).

**Deliverable 1.1:** `AUDIT_REPORT.md` (detailed diagnosis with severity ratings: High / Medium / Low).

---

### Phase 2: Trade-off Analysis & Architectural Decision Records (ADRs) (Days 2 - 3)
**Goal:** For each identified limitation, propose at least 2 alternatives, evaluate trade-offs, and record decisions.
- **ADR-001: Language & Typing Strategy**
  * *Option A:* Stay on Plain JS + JSDoc.
  * *Option B:* Migrate to TypeScript (Strict mode).
  * *Choice & Justification:* Impact on developer velocity vs maintenance safety.
- **ADR-002: Backend Architecture & Modularity**
  * *Option A:* Refactored Modular Monolith (Clean/Hexagonal Architecture).
  * *Option B:* Microservices architecture.
  * *Choice & Justification:* Rationale based on team size (6 devs), cognitive load, and operational overhead.
- **ADR-003: Persistence & Data Management**
  * *Option A:* PostgreSQL + ORM/Query Builder (Prisma/TypeORM/Kysely).
  * *Option B:* MongoDB / NoSQL.
  * *Choice & Justification:* Relational needs for Projects, Tasks, Users, GDPR constraints.
- **ADR-004: Event-Driven Mechanism (Sprint 1 Requirement)**
  * *Option A:* In-process Event Emitter / MediatR pattern.
  * *Option B:* Lightweight Message Broker (Redis Pub/Sub, RabbitMQ).
  * *Choice & Justification:* Feasibility, end-to-end verification, and demonstration scope.

**Deliverable 1.2:** `/docs/adr/` containing formatted ADRs (Context, Alternatives, Decision, Consequences, Impact).

---

### Phase 3: Agile Backlog & Team Governance Setup (Days 3 - 4)
**Goal:** Establish the operational framework for the 6-person team.
- **Role Distribution (Sprint 1):**
  * 1 Product Owner (PO): Backlog priority, acceptance criteria, MoSCoW enforcement.
  * 1 Scrum Master (SM - Rotation #1): Ceremony tracking, unblocking, process adherence.
  * 4 Core Developers (Pair A: DevOps/Quality; Pair B: Core API/Event Skeleton).
- **GitHub Projects Setup:**
  * MoSCoW labels: Must Have, Should Have, Could Have, Would Have.
  * Status columns with automation: Backlog -> Ready -> In Progress -> In Review -> Done.
- **Agile Conventions & Definition of Done (DoD):**
  * PR rules: Min 1 approving review, mandatory linked Issue (`closes #X`).
  * Conventional Commits (`feat:`, `fix:`, `refactor:`, `test:`, `docs:`).
  * DoD checklist embedded in PR templates.

**Deliverable 1.3:** `AGILE_CHARTER.md` + Fully populated GitHub Project Backlog for Sprint 1 and Sprint 2.

---

### Phase 4: Walking Skeleton & CI Quality Gate (Days 4 - 5)
**Goal:** Prove the target architecture end-to-end without writing business features yet.
- **CI Pipeline (`.github/workflows/ci.yml`):**
  * Code linting & formatting check (e.g., ESLint + Prettier).
  * Unit test runner with coverage reporting.
  * Multi-stage Docker build producing an optimized image artifact.
- **Walking Skeleton (Minimal End-to-End):**
  * Minimal API endpoint responding to health checks and a dummy event trigger.
  * Operational event-driven proof of concept (e.g., triggering a task event and handling it asynchronously).
  * Docker Compose environment running the app and its required service (DB/Event bus).

**Deliverable 1.4:** Functional CI pipeline passing all checks on pull requests; Docker Compose setup operational.

---

## 3. Sprint 1 Roadmap & Timeline (10 Business Days)

| Milestone | Key Activity | Assigned Pairs | Artifacts Produced |
| :--- | :--- | :--- | :--- |
| **Day 1 - 2** | Full Legacy Codebase & Ecosystem Audit | All (Pairs 1, 2, 3) | `docs/AUDIT_REPORT.md` |
| **Day 3** | Alternatives Benchmarking & ADR Drafting | Pair 1 (Infra), Pair 2 (App) | `docs/adr/ADR-001` to `ADR-004` |
| **Day 4** | Backlog Grooming, MoSCoW Mapping & DoD | PO + SM + Team | GitHub Project Boards & Templates |
| **Day 5 - 7** | CI Pipeline, Quality Gate & Docker Setup | Pair 1 (DevOps/Infra) | `.github/workflows/`, `Dockerfile` |
| **Day 5 - 7** | Walking Skeleton & Event-Bus PoC | Pair 2 & 3 (Backend/Arch) | Minimal running core architecture |
| **Day 8 - 9** | Integration, Review Verification & Dry Run | All Team Members | Tested PRs meeting 100% DoD |
| **Day 10** | Sprint Review Prep & Sprint Retrospective | SM + All Team Members | Demo script + `RETROSPECTIVE_S1.md` |

---

## 4. Claude Code Execution Prompts

To generate the supporting project documents with Claude Code, use the following directives:

1. **Audit Document Generation:**
   `claude "Analyze docker/getting-started-app. Generate docs/AUDIT_REPORT.md focusing on technical debt, outdated dependencies, architectural flaws, lack of tests, and security weaknesses."`

2. **ADR Generation:**
   `claude "Generate ADR-001 through ADR-004 in markdown format under docs/adr/ following the Michael Nygard template. Compare at least two real alternatives for language, backend pattern, database, and event-driven architecture."`

3. **CI/CD & Governance Generation:**
   `claude "Create .github/workflows/ci.yml with linting, unit tests, and Docker build steps. Also generate CONTRIBUTING.md detailing branch naming, Conventional Commits, and Definition of Done."`
