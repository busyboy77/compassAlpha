---
description: "Getting started with CompassAlpha: prerequisites, greenfield setup, and brownfield onboarding for adopting the multi-agent AI framework."
---

# 05 · Getting Started

> *Two ways in: stand up a fresh federation (greenfield) or adopt CompassAlpha over a codebase you already have (brownfield). Both land in the same place — a federation whose state of record is git.*

This section takes you from zero to your first piece of work flowing through the bus. Everything here is practical: repos to create, files to stamp, commands to run, gates to pass. The conceptual grounding lives in [Foundation](../00-foundation/index.md) and [Axioms](../01-axioms/index.md) — if a term here is unfamiliar, those are the place to look it up.

!!! note "Source-available licensing"
    CompassAlpha is distributed under the **Business Source License 1.1** — *source-available*. You may read, modify, and evaluate the framework freely. **Commercial / production use requires a license.** See [COMMERCIAL.md](https://github.com/busyboy77/compassAlpha/blob/main/COMMERCIAL.md) before you put a CompassAlpha federation into production. The framework is published by **gradus** ([gradus.pk](https://gradus.pk)).

## The two adoption paths

CompassAlpha meets you wherever your project is today.

| Path | You start with | Your first weeks are about | Go to |
|---|---|---|---|
| **Greenfield** | An empty (or near-empty) substrate repo. No prior doctrine, no legacy obligations. | Standing up two repos, stamping tiers, declaring your first axis, running a small first dispatch to prove the rhythm. | [Greenfield setup](greenfield-setup.md) |
| **Brownfield** | A pre-existing codebase — code, culture, obligations, tooling — but **no doctrine layer**. The rules are buried in code and tribal knowledge. | A phased journey: extracting doctrine from what exists, writing a first Charter, running pilot modules under CompassAlpha while the rest stays on your old workflow. | [Brownfield onboarding](brownfield-onboarding.md) |

If you're not sure which you are: do you have a codebase with users, history, and obligations you can't drop? You're brownfield. Starting from a blank slate? You're greenfield. Most real adoptions are brownfield — and that path is the harder, more interesting one. CompassAlpha treats it as a first-class journey, not an afterthought.

## What "getting started" actually delivers

By the end of this section you will have:

1. **Two repositories** — a *substrate* repo (the thing you build or govern) and a *reviewer-state* repo (the federation's judicial / coordination state). They are structurally separate and never cross-commit. See [Locality](../01-axioms/git-foundations.md) and the [firewall](../01-axioms/firewall.md).
2. **Stamped tier identities** — boot files (`CLAUDE.md`) for Mentor-1, Mentor-2, and the Doer that tell each session who it is, what it may touch, and the commit discipline it follows.
3. **A first axis declaration** — usually `build`. A thin file naming your three tiers, your deliverable type, your cycle stages, and your Charter posture. Everything substantive is inherited from the master, not restated. See [Axis declarations](../03-tunables/axis-declarations.md).
4. **A working bus** — inbox folders laid out so a sender can drop a file into a recipient's inbox, push, and ping the founder. See the [bus protocol](../01-axioms/bus-protocol.md).
5. **One completed dispatch** — a real piece of work that flowed Mentor-1 → Mentor-2 → Doer and back, with state on disk and at origin before it was ever discussed.

## Reading order

Work through the pages in nav order — each builds on the last:

1. [**Prerequisites**](prerequisites.md) — the four things you need before you touch a repo: a git host, an AI agent harness, a founder/relay, and a state-of-record remote. Concrete checklist.
2. [**Greenfield setup**](greenfield-setup.md) *or* [**Brownfield onboarding**](brownfield-onboarding.md) — pick your path. Brownfield adopters should also read [Cutover from a pre-AI project](cutover-from-pre-AI-project.md) for a concrete, revertible worked walkthrough.
3. [**First boot**](first-boot.md) — booting your first tier session: the T0 boot-integrity ritual, reading order, the START status grid.
4. [**First dispatch**](first-dispatch.md) — running one piece of work end-to-end through the bus, with flush-before-disclose and the gates that protect it.

## The one rule to internalise before you start

Everything in CompassAlpha rests on the **persistence law**: *every load-bearing artifact is on disk and at origin BEFORE it is disclosed to the founder.* Nothing load-bearing lives in chat. If you remember nothing else from this section as you set up, remember that — it changes how you build every file below.

## Next: [Prerequisites →](prerequisites.md)
