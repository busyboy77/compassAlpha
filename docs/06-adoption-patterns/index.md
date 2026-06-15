---
description: "Worked examples of CompassAlpha in action: doctrine cycles, Phase 3 dispatches, polish and surgical lanes, and Day-2 QA / Ops / incident response."
---

# 06 · Adoption Patterns (worked examples)

> *Theory tells you the rules. Worked examples show you the rhythm. This section walks a single fictional project through every lane the framework supports.*

In plain terms: this is the "show, don't tell" section — step-by-step stories of a made-up project getting real work done with CompassAlpha, so you can see what a normal day actually looks like before you try it yourself. It's for anyone who has skimmed the concepts and now wants to watch them in motion.

New here? Start with [the mental model](../00-foundation/mental-model.md).

The [Axioms](../01-axioms/index.md) (the framework's fixed rules) and [Guardrails](../02-guardrails/index.md) (the mistakes it blocks) tell you what CompassAlpha **prevents**. The [Tunables](../03-tunables/index.md) tell you what you can **adjust**. This section answers the question every adopter actually asks first:

> *"OK — but what does a day of running this thing actually look like?"*

Each page below is a **fully worked example**: setup, stage-by-stage walkthrough, the exact bus messages and tags and commands involved, the gates hit, what the status grid shows at the end, and the outcome. They are written to be read in order, but each stands alone.

## The example application used throughout

To keep the examples concrete (and unmistakably hypothetical), every page in this section is anchored to one invented project:

> **Northwind** — a fictional B2B SaaS application. A back-office platform with four modules:
>
> | Module | What it does |
> |---|---|
> | **Auth** | accounts, sessions, roles, SSO |
> | **Billing** | subscriptions, invoices, payment-provider integration |
> | **Reporting** | dashboards, scheduled exports, the analytics warehouse |
> | **Notifications** | email/SMS/in-app delivery, templates, preferences |

Northwind is **not a real product**. It exists only to give the worked examples something to bite into. Any resemblance to a real system is coincidental.

Northwind has adopted CompassAlpha and declared its tier role names. The framework's universal vocabulary is **Mentor-1 / Mentor-2 / Doer** (see [Tier Grammar](../01-axioms/tier-grammar.md)); throughout these examples Northwind uses those generic names directly so the mapping to doctrine is unambiguous.

Northwind's federation lives in two repos:

```
/path/to/substrate         ← the Northwind application code (the data plane)
/path/to/reviewer-state    ← the federation's judicial folders, inboxes, ledgers (the control plane)
```

These are kept structurally separate — the [Bus Protocol](../01-axioms/bus-protocol.md) forbids cross-committing them.

## The lanes, mapped to pages

CompassAlpha supports work at four granularity levels (the [Work Granularity Lanes](../03-tunables/work-granularity-lanes.md)), plus three **Day-2 axes** for projects that have shipped and now need to *operate*. Each worked example below sits in exactly one lane or axis.

| Page | Lane / axis | Ceremony | Northwind scenario |
|---|---|---|---|
| [Sample doctrine cycle](sample-doctrine-cycle.md) | Doctrine Cycle | Heaviest — full S1→S5 | Author the **Billing** compass (60K/30K/10K) |
| [Sample Phase 3 dispatch](sample-phase3.md) | Phase 3 (build) | Full CP1→CP3 | Add **scheduled exports** to Reporting |
| [Sample Polish Lane](sample-polish.md) | Polish | Slim — single CP | Add a status-filter dropdown to the invoices table |
| [Sample Surgical Strike](sample-surgical.md) | Surgical Strike | Lightest — Mentor-2 skipped | Fix a button colour on the login page |
| [Sample Day-2 QA](sample-day2-qa.md) | QA axis (DECOUPLED) | Per-build + regression | Verify the scheduled-exports release |
| [Sample Day-2 Ops](sample-day2-ops.md) | Ops axis (DECOUPLED) | Per-release + per-incident | Deploy the release and watch it |
| [Sample Incident Response](sample-incident-response.md) | Incident Response lane | Reduced — founder post-fact | Billing webhook outage at 02:00 |

## How to read these

If you read **one**, read the [Surgical Strike](sample-surgical.md) — it is the smallest complete loop and shows the irreducible core of the framework in a few minutes.

If you read **three**, read **Surgical Strike → Phase 3 → Doctrine Cycle**, in that order. That progression shows how the *same* primitives (bus, tiers, persistence, gates) scale from a one-line fix up to a weeks-long structural change. The ceremony grows; the rules underneath never change.

If you read **all seven**, you will have seen every operating mode CompassAlpha supports on a single coherent example.

## What stays constant in every example

No matter how light the lane, these never relax (see [Work Granularity Lanes §40.3](../03-tunables/work-granularity-lanes.md)):

- **Firewall** — even a one-line fix goes through a tier; the founder never edits substrate directly.
- **Persistence law** — every load-bearing change is on disk + pushed + read back before it is disclosed (see [Persistence Law](../01-axioms/persistence-law.md)).
- **Hard labour rule** — only the Doer touches substrate.
- **Bus protocol** — even a surgical brief travels through an inbox file, not the chat window.
- **Commit discipline** — the same git mechanics apply in all lanes.

What *does* change between lanes is **ceremony**: how many tiers, how many checkpoints, how heavy the gate package, whether a tag is cut. The examples make that gradient visible.

---

## Next: [Sample doctrine cycle →](sample-doctrine-cycle.md)
