# Slides — Final Project Defense, Part 2: Deep Dive & Live Demo

Part 2 of 2 (~25 min deep dive + live demo, plus closing — ~30 min total — followed by 5 min coach
feedback). Follows directly after Part 1: `FINAL_PART1_SLIDES.md` / `FINAL_PART1_ORAL.md`.
Minimal text on screen — the script (`FINAL_PART2_ORAL.md`, in French) carries the spoken content.
Each slide is tagged with the speaker and rough duration.

> Update before the defense day: slide 10 (what's left) and the live demo feature choice (slide 8)
> depend on the exact state of issues `#69`, `#96`, `#97`, `#99`, `#102`, `#105` at that time.

---

## Slide 1 — Title

**Legacy TodoList Rework — Final Defense**
Part 2: Deep Dive & Live Demo

> Speaker 2 · ~10s

---

## Slide 2 — Git repository

- Conventional Commits enforced by a pre-commit hook (`husky` + `commitlint`)
- One branch per issue, named after it; stacked branches when a PR genuinely depends on another
  unmerged one (documented in the PR body, not left implicit)
- Contract-first pattern visible in the history itself: a pure JSDoc interface commit precedes its
  implementation on every major feature (user persistence, Kanban persistence, notification
  channels)

> Speaker 2 · ~3 min · *show `git log --oneline --graph` live*

---

## Slide 3 — Code review

- Definition of Done, enforced without exception: **1 approval minimum**, linked issue
  (`closes #X`), tests for new business logic, green quality gate, demonstrable in review
- Reviews are real, not rubber-stamped: reviewers verify independently — re-running tests,
  checking the diff, sometimes testing manually against a live server — rather than trusting a
  green CI alone

> Speaker 2 · ~3 min

---

## Slide 4 — CI/CD process

- Pipeline: lint → format check → unit tests → **full Docker Compose stack** (`app`, `db`,
  `prometheus`, `grafana`) built and health-checked, not just unit tests in isolation
- Feedback loop: a broken Docker build fails CI before it fails a live demo
- Gap disclosed: CI validates the API responds, but not yet that the frontend is actually served
  (`#102`) — CI is honest about what it does and doesn't cover

> Speaker 3 · ~3 min

---

## Slide 5 — QA strategy

- 381 automated tests (backend + frontend) — but the two most serious bugs of the project were
  found by **testing the real stack**, not by unit tests:
  1. Docker image shipped with an empty database schema (migrations never copied)
  2. A deleted user's JWT stayed valid and could crash the server, leaking a SQL stack trace
- Lesson taken into practice: verify manually against real infrastructure (real Docker, real
  webhooks) before trusting "all tests green"
- Gap disclosed: the brief's Definition of Done names a required code coverage level as its own
  criterion, separate from the general quality gate — ours doesn't enforce a threshold; coverage
  is measured, not gated

> Speaker 3 · ~3 min 30

---

## Slide 6 — Work process

- Same rhythm since Sprint 1: daily stand-up, sprint planning, sprint review, retrospective —
  traced in the GitHub Project board (Backlog → Ready → In progress → In review → Done)
- MoSCoW prioritization kept explicit and current on the board across all 3 sprints
- Async coordination between reviews: relevant context handed off in PR/issue comments, so no
  decision only exists as a verbal memory

> Speaker 2 · ~2 min

---

## Slide 7 — Disability management: RGAA

**What RGAA is** (new requirement from the 2nd intermediate jury, added this Sprint 3): the French
legal accessibility standard — 106 criteria across 13 themes (images, colors, forms, navigation,
scripts…), the French translation of WCAG 2.1 AA's POUR principles (Perceivable/Operable/
Understandable/Robust). Legal basis: Law of 11/02/2005 (art. 47). Historically mandatory for
public-sector sites; since the European Accessibility Act (28/06/2025), also for private companies
over 10 employees or €2M revenue. Official audit tool (Ara, by DINUM) is **not automated** — it
requires expert human judgment on a representative page sample.

**What we actually did today, not a claim of full compliance:**
- Automated scan (Lighthouse/axe) on login/register: **100% accessibility score**
- Manual review of the Kanban board (the automated tool can't replace this — same reason Ara isn't
  automated): priority already used text + color together, never color alone
- **Found and fixed**: 2 of 3 priority badges failed WCAG AA color contrast (3.19:1 and 3.09:1 vs.
  the 4.5:1 required) — darkened, same color family, same meaning, no behavior change
- **Found, not fixed, disclosed**: drag & drop has no keyboard alternative — a real RGAA gap,
  would need a non-trivial interaction redesign, not a same-day fix

> Speaker 3 · ~2 min 30 · *own this gap, don't oversell it — see issue #107*

---

## Slide 8 — Live demo: full feature, full process

About to show one feature end-to-end, respecting the whole team process:

**Issue → branch → commits (contract first) → PR → review (Definition of Done) → merge → demo**

Feature chosen: *[pick the cleanest, most complete example available at defense time — e.g. the
Kanban CRUD (#66/#78) or the GDPR account deletion (#65/#94)]*

> Speaker 1 · ~1 min intro, then live · total ~8 min

---

## Slide 9 — Live demo: the app itself

Register → log in → create a project → create a task → drag it to another column → set a priority
and due date → reload to prove persistence → check the Grafana dashboard move in near real time →
check the Discord/Telegram notification arrive.

> Speaker 1 · continued from slide 8

---

## Slide 10 — What's left, honestly

Must-have gaps, in progress: `#102` (Docker not serving the frontend), `#73` (registry publication),
`#69` (event-driven flow extension — baseline requirement already met, this is additional depth).
Should-have items (`#74`, `#75` home screen, `#96`, `#103`, no coverage threshold) — status as of
defense day, updated live if needed.

> Speaker 1 · ~40s

---

## Slide 11 — Questions

**Thank you.**

Ready to show: full Git history · any merged PR from issue to merge · the running app, Docker
stack, Grafana dashboard, live notification

> Speaker 1 · transition to Q&A / coach feedback

---

## Annex (not projected by default)

- **A1**: `git log --oneline --graph` on 2-3 major PRs, contract-before-implementation visible
- **A2**: pre-chosen complete-feature PR for the live demo
- **A3**: Grafana dashboard full screen, real data
- **A4**: full ADR texts (0001–0005) if the jury wants to read one in detail
