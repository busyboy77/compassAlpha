# CompassAlpha · Claude Code Project Orientation

> **Boot file for any Claude Code session opened in the CompassAlpha repository.** Auto-loads at session start. Read on T0.

## What this project is

**CompassAlpha** — an open-source federation framework for multi-tier AI-agent collaboration on substantial codebases. The reference framework for **GitAI** (using git as the coordination, durability, and audit layer for AI-agent federations).

This repository is the framework's **canonical home**. It is independent of any specific adopter project. CompassAlpha was discovered and developed at **[gradus](https://gradus.pk)** — its parent company.

## Project layout

```
README.md              ← GitHub landing page · project overview
mkdocs.yml             ← MkDocs Material config · builds the portal
CLAUDE.md              ← THIS FILE · session orientation
LICENSE                ← Apache License 2.0
.github/workflows/     ← GH Pages auto-deploy
docs/                  ← portal content (the public-facing framework)
  index.md             ← portal home
  assets/              ← SVG diagram + supplementary
  00-foundation/       ← orientation layer ✅ COMPLETE (5 pages)
  01-axioms/           ← INVARIANT constitution ✅ COMPLETE (8 pages)
  02-guardrails/       ← what the framework PREVENTS ⏳ PENDING
  03-tunables/         ← customization surface ⏳ PENDING
  04-toggles/          ← live switches ⏳ PENDING
  05-getting-started/  ← onboarding ⏳ PENDING
  06-adoption-patterns/← worked examples ⏳ PENDING
  07-reference/        ← manifesto + technical reference ⏳ PENDING
  08-community/        ← OSS community files ⏳ PENDING
```

## Status at session boot

- **v0.1 DRAFT**, in active development
- **Portal build progress: ~13 of ~50 pages complete** (Foundation + Axioms done; 6 sections remaining)
- **Repository:** https://github.com/busyboy77/compassAlpha
- **License:** Apache 2.0

## Read-on-boot artifacts

1. **`README.md`** — GitHub landing · framework elevator pitch · "framework not tool" framing
2. **`docs/index.md`** — portal home · 4-layer mental model · navigation
3. **This file** — session orientation

## What's next

- **Turn 2:** Build `02-guardrails/` (6 pages)
- **Turn 3:** Build `03-tunables/` (10 pages)
- **Turn 4:** Build `04-toggles/` (5 pages)
- **Turn 5:** Build `05-getting-started/` (6 pages) — includes brownfield onboarding
- **Turn 6:** Build `06-adoption-patterns/` (8 pages) — worked examples + Day 2
- **Turn 7:** Build `07-reference/` (7 pages)
- **Turn 8:** Build `08-community/` (5 pages) + final polish

Each turn = a batch of related pages. Status grids per session. Persistence law in force throughout.

## Working rules (CompassAlpha dogfoods its own doctrine)

- **Persistence law:** every load-bearing artifact on disk before disclosure. Nothing load-bearing in chat.
- **Provenance law:** cite by substrate, never by recall.
- **Brief completeness:** fully scope a directive before starting.
- **Status grids** at session START + END.

## Founder role

**Nasir Mahmood Rajput** is the founder. Per the framework's own §18, the founder is RELAY + lost+found ONLY — plus the UX exception (§18.4): de facto Chief UX Officer. Founder taste matters for portal navigation, page voice, and examples chosen.

## Continue the portal build

Fresh sessions resuming the build: read this file, then `README.md` and `docs/index.md`, sample 2-3 pages in `docs/01-axioms/` to internalize the page template, then build the next pending section from the status above.

For now, **the build is paused at the end of Turn 1** (Foundation + Axioms complete). Next session resumes at Turn 2 (Guardrails).

Standing by.
