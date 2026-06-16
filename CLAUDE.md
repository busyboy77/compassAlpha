# CompassAlpha · Claude Code Project Orientation

> **Boot file for any Claude Code session opened in the CompassAlpha repository.** Auto-loads at session start. Read on T0.

## What this project is

**CompassAlpha** — a source-available federation framework for multi-tier AI-agent collaboration on substantial codebases. The reference framework for **GitAI** (using git as the coordination, durability, and audit layer for AI-agent federations).

This repository is the framework's **canonical home**. It is independent of any specific adopter project. Published source-available by [gradus.pk](https://gradus.pk).

## Project layout

```
README.md              ← GitHub landing page · project overview
mkdocs.yml             ← MkDocs Material config · builds the portal
CLAUDE.md              ← THIS FILE · session orientation
LICENSE                ← Business Source License 1.1 (source-available)
.github/workflows/     ← GH Pages auto-deploy
docs/                  ← portal content — ALL SECTIONS ✅ COMPLETE & LIVE
  index.md             ← portal home (4-layer model · "vision → coherent code" pitch)
  robots.txt           ← crawl-allow + sitemap pointer
  assets/              ← 8 concept SVGs (federation · team-federation · four-layer-model ·
                         charter-bump-ladder · codebase-coherence · delegation-modes ·
                         adoption-telemetry · compass-cycle)
  00-foundation/       ← orientation ✅ (incl. origin-story.md + codebase-coherence.md)
  01-axioms/           ← INVARIANT constitution ✅
  02-guardrails/       ← what the framework PREVENTS ✅
  03-tunables/         ← customization surface ✅
  04-toggles/          ← live switches ✅
  05-getting-started/  ← onboarding ✅
  06-adoption-patterns/← worked examples ✅
  07-reference/        ← manifesto + technical reference ✅
  08-community/        ← OSS community files ✅
overrides/             ← Material custom_dir · SEO/OG meta (extrahead block)
scripts/content-safety.sh ← deploy denylist gate (greps built site/ before Pages publish)
_internal/             ← gitignored author space · graduation-candidate captures (see Active context)
```

## Status at session boot

- **v0.1 — portal AUTHORED, VALIDATED, POLISHED, and LIVE:** https://busyboy77.github.io/compassAlpha/
- **All 9 sections complete** (~60 pages) + concept diagrams w/ lightbox + per-page SEO/OG meta + content-safety deploy gate + robots.txt/sitemap.
- **Onboarding is a named ladder, Rung 0→4** (Sketch · Borrow · Bootstrap · Federate · Scale), each a real page; idea-only non-coders enter at Rung 0 (`start-with-an-idea.md`). **9 guardrails.** A **dogfooded conformance gate** (`reference/conformance-gate/`, `07-reference/conformance-gate.md`) runs fail-closed in CI.
- **Repository:** https://github.com/busyboy77/compassAlpha (public)
- **License:** Business Source License 1.1 (source-available; converts to Apache 2.0 on 2030-06-09) · commercial use → `COMMERCIAL.md`
- **CI/build:** `.github/workflows/deploy.yml` = **conformance gate (dogfood, fail-closed)** → `mkdocs build --strict` → `scripts/content-safety.sh site` (denylist gate) → Pages deploy. Local build: `/tmp/ca-venv/bin/mkdocs build --strict`.

## Read-on-boot artifacts

1. **`README.md`** — GitHub landing · framework elevator pitch · "framework not tool" framing
2. **`docs/index.md`** — portal home · 4-layer mental model · navigation
3. **This file** — session orientation

## What's next (the build is DONE — remaining work is founder-gated)

- **Graduate `_internal/` captures — ONLY on founder's go:** `delegation-modes-vision.md` → Mode-2 refinement into `03-tunables/`. (Story-driven onboarding's no-code Rung 0 slice is built; the broader auto-derive mechanism stays **hold-until-go**.)
- **Open onboarding/enforcement follow-ons (founder-gated):** worked proof-of-value, front-door ordering, per-page enforced-vs-convention clarity, multi-team governance depth — **detail + rationale live in the private rotation handoff** (`_internal/SESSION-HANDOFF.md`).
- **The real unlock is non-doc: a first real adopter** — it moves the maturity / production-evidence ceiling; founder's to make.
- **Founder's external to-dos:** Google Search Console + sitemap submission; launch post.
- **Model:** Fable 5 deferred — stays on Opus 4.8 until founder says go.
- Cross-page redundancy is a **deliberate** layered-with-cross-links choice — not a gap; don't "consolidate" it blindly.

Persistence law in force throughout. Status grids at session START + END.

## Working rules (CompassAlpha dogfoods its own doctrine)

- **Persistence law:** every load-bearing artifact on disk before disclosure. Nothing load-bearing in chat.
- **Provenance law:** cite by substrate, never by recall.
- **Brief completeness:** fully scope a directive before starting.
- **Status grids** at session START + END.

## Founder role

Per the framework's own §18, the **founder** is RELAY + lost+found ONLY — plus the UX exception (§18.4): de facto Chief UX Officer. Founder taste matters for portal navigation, page voice, and examples chosen.

## Continue / rotation handoff

The portal is **built and live.** A fresh session should:

1. Read this file + `README.md` + `docs/index.md`.
2. Load the **auto-memory** (it loads at session start and carries the standing working rules — voice, framing, scope discipline; honour them before writing anything public).
3. Read the gitignored **`_internal/`** captures — the private rotation handoff (`_internal/SESSION-HANDOFF.md`) and the graduation-candidate material.

Then act on the pending items above **only as the founder directs** — do NOT re-author finished sections.

Standing by.
