# CompassAlpha

> **A framework, not a tool.** Source-available federation framework for multi-tier AI-agent collaboration on substantial codebases. The reference framework for **GitAI** — using git as the coordination, durability, and audit layer for multi-agent AI operations.

[![License: BSL 1.1](https://img.shields.io/badge/license-BSL%201.1-blue.svg)](LICENSE)
[![Commercial use](https://img.shields.io/badge/commercial%20use-license%20required-orange.svg)](COMMERCIAL.md)
[![Docs](https://img.shields.io/badge/docs-mkdocs--material-blue.svg)](https://busyboy77.github.io/compassAlpha/)
[![Status](https://img.shields.io/badge/status-v0.1%20draft-orange.svg)](docs/08-community/changelog.md)

> *A source-available federation framework — free for non-commercial use; [commercial use requires a license](COMMERCIAL.md).*
>
> Free for non-commercial & evaluation use · **[commercial use requires a license](COMMERCIAL.md)**.

[![CompassAlpha — the federation framework on one page](docs/assets/federation-diagram.svg)](docs/assets/federation-diagram.svg)

<sub>*The whole framework at a glance: inheritance · the two axes + future-axis slot · work-granularity lanes · stage taxonomies · the bus protocol · load-bearing rules · trade-offs · tunables. Click to open full size.*</sub>

---

## What is CompassAlpha?

CompassAlpha provides a **protocol** — not a tool — for coordinating multiple AI agents (e.g. Claude Code instances) across two or more parallel work axes, with a single human "founder" acting as a low-cognitive-load relay bus. The framework's value lies in the **protocols, conventions, and load-bearing rules** that govern how agent tiers communicate, persist state, hand off work, and avoid the four pathologies of multi-agent AI work: context pollution, hallucination drift, role confusion, and trust erosion.

**Design pillars:**

1. **Framework, not tool.** CompassAlpha is a constitution + a set of conventions. You bring your own AI agents, your own git, your own host. The framework guards how they collaborate.
2. **Tier-hierarchy with mentor/orchestrator/doer roles** — minimizes context pollution; mentor tiers never touch substrate.
3. **Git as the durability and audit layer** — no specialized databases. State persistence = `git commit + push` to a dedicated state-of-record remote.
4. **Human-in-the-loop relay**, NOT autonomous agents. The founder is a load-bearing relay (one-liner pings) and lost-and-found backstop — not a per-decision arbiter.
5. **Doctrine evolution as a first-class concern.** Build cycles AND doctrine cycles, in alternating epochs.
6. **Extensible by inheritance.** Two axes (build, doctrine) are the default; new axes (review, ops, AI-training, pen-test, …) plug in.

## What CompassAlpha is NOT

- ❌ A SaaS product
- ❌ A library you `npm install`
- ❌ An AI agent itself
- ❌ A monitoring dashboard
- ❌ A replacement for your CI/CD, IDE, or git host

## What CompassAlpha IS

- ✅ A constitution + protocol specification
- ✅ A set of conventions for naming, structuring, and coordinating
- ✅ A pattern proven by a production multi-agent federation
- ✅ A documentation portal with worked examples
- ✅ A growing ecosystem of stamp templates, status grids, and operating presets

---

## Quick start

**For first-time visitors:** read [What is CompassAlpha](docs/00-foundation/framework-not-tool.md) → [The Constitution](docs/00-foundation/constitution.md) → [Glossary](docs/00-foundation/glossary.md) → [GitAI category](docs/00-foundation/gitai-category.md). About 15 minutes.

**For someone evaluating adoption:** read [Getting Started](docs/05-getting-started/) — pick greenfield or brownfield depending on your project's state.

**For someone adopting on an existing codebase:** see [Adoption Patterns](docs/06-adoption-patterns/) for worked examples.

---

## Portal structure

| Section | What's there |
|---|---|
| **00 Foundation** | What CompassAlpha is, the constitution, GitAI category, glossary |
| **01 Axioms** | The 7 INVARIANT rules — cannot be tuned away |
| **02 Guardrails** | What the framework PREVENTS · failure modes |
| **03 Tunables** | The customization surface · 5-axis trade-off |
| **04 Toggles** | Live switches · when each can flip |
| **05 Getting Started** | Onboarding for greenfield AND brownfield projects |
| **06 Adoption Patterns** | Worked examples · Day 2 cycles |
| **07 Reference** | Technical reference · manifesto · templates |
| **08 Community** | Contributing · roadmap · governance |

---

## Build the docs locally

```bash
# Install MkDocs Material
pip install mkdocs-material

# Serve locally with live reload
mkdocs serve

# Build static site
mkdocs build

# Deploy to GitHub Pages
mkdocs gh-deploy
```

---

## Project philosophy

CompassAlpha emerged from one stark observation: **multi-agent AI collaboration on substantial codebases fails predictably, in ways that are NOT about model intelligence**. Failures are about coordination — context pollution between agents, snapshot vs live-state drift, mentor agents tempted to "help" by doing labour, trust eroding when claims diverge from disk. CompassAlpha addresses these failures with **structural guardrails** rooted in git and protocol, not in heroics.

The framework grew out of a real production multi-agent federation that hit each of these failure modes and engineered solutions cycle by cycle. CompassAlpha is the abstraction of those patterns.

---

## Status

This is **v0.1 DRAFT** — the framework is in active development, released source-available under BSL 1.1. **The framework will reach v1.0 stable after:**

1. A full doctrine cycle close + re-lock
2. Community review pass
3. Adoption by at least one greenfield + one brownfield project

Track progress in the [Roadmap](docs/08-community/roadmap.md) and [Changelog](docs/08-community/changelog.md).

---

## License

**[Business Source License 1.1](LICENSE)** — source-available. Free for non-commercial, evaluation, research, and internal non-production use; **commercial or production use requires a commercial license** from gradus (see **[COMMERCIAL.md](COMMERCIAL.md)**). Each version converts to the **Apache License 2.0** on its Change Date (2030-06-09 for v0.1). "CompassAlpha" and "gradus" are trademarks — see [NOTICE](NOTICE).

---

## Acknowledgments

CompassAlpha is built and maintained at **[gradus.pk](https://gradus.pk)** with a series of Claude (Anthropic) sessions, and published source-available.

**With recognition of the categories CompassAlpha builds upon:** GitOps (DevOps community), AIOps (operations + AI community). CompassAlpha is **GitAI** — the same pattern applied to AI agent federations.

---

> *"State of the federation = state of git."* — the GitAI insight.
