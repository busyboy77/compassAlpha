---
description: "The lifecycle vocabulary each axis and lane uses. The words your status grids speak."
---

# Stage Taxonomies

> *The lifecycle vocabulary each axis and lane uses. The words your status grids speak.*

`[TUNABLE — stage names per axis + per lane]`

## TL;DR

Each axis and lane declares its own **lifecycle stage vocabulary** — the named states a unit of work passes through from launch to FROZEN. These stages drive Tier-2 status grids, inbox file naming, ratification-gate definitions, and the audit trail. The build axis uses `CP1 → CP2 → CP3`; the doctrine axis uses `S1 → S5`; Polish and Surgical lanes use slim taxonomies. Project-specific stage names are `[TUNABLE]`; the framework requires only three structural properties: monotonic progression, a defined freeze-to-tag tail, and a terminal FROZEN state. The stage taxonomy is one of the most important things a new project authors at adoption.

## The dial

Stage names, counts, and sub-stages are yours to choose per axis and per lane. What's fixed is the *shape* — a monotonic march toward a gated freeze, then a tag, then archival. You fill in the names that fit your deliverable.

## Why stages exist

Stages are the federation's shared clock. They let every artifact agree on "where is this work":

- **Status grids** ([see Status grids reference](../07-reference/status-grids.md)) tag every item with its current stage.
- **Inbox file names** encode the stage (`from-<sender>-<stage>-<event>.md`), so a return is self-describing.
- **Ratification gates** are defined relative to stages (gates check at GATE-CHECK; tags apply at TAGS-APPLIED).
- **The audit trail** reconstructs a unit's full lifecycle from its stage transitions in the git log.

## Build axis · Phase 3 dispatch stages

```
PRE-STAMP → STAMPED → LAUNCHED → WIP-CP1 → WIP-CP2 → WIP-CP3 →
  CP-FREEZE → GATE-CHECK → GO-TAG → TAGS-APPLIED → CLOSED → FROZEN
```

| Stage | Meaning |
|---|---|
| `PRE-STAMP` | Top mentor composing the stamp; nothing fired yet. |
| `STAMPED` | Stamp authored + launch relay pushed. |
| `LAUNCHED` | Orchestrator session booted via bus relay. |
| `WIP-CP1` | Planning + premise check (baseline re-measure; charter inheritance; founder-calls surfaced). |
| `WIP-CP2` | Implementation, slice by slice; invariant enforcement; per-stage substantive review. |
| `WIP-CP3` | Exit-report assembly + audit reconciliation. |
| `CP-FREEZE` | Orchestrator finished slices; freeze candidate (leftover onboarding). |
| `GATE-CHECK` | Top mentor triages the exit gates green. |
| `GO-TAG` | Top mentor authorizes tag-apply. |
| `TAGS-APPLIED` | Orchestrator applied the exit tag + refspec-pushed + verified. |
| `CLOSED` | Dispatch closed; close-record committed; stand-down acknowledged. |
| `FROZEN` | Judicial folder archived per firewall (final). |

## Doctrine axis · entity dispatch stages

```
PRE-STAMP → STAMPED → LAUNCHED → WIP-S1 → WIP-S2a → WIP-S2b → WIP-S3a → WIP-S3b → WIP-S4 → WIP-S5 →
  CP-FREEZE → GATE-CHECK → GO-SUB-BUMP → TAGS-APPLIED → STAND-DOWN-ACK → FROZEN
```

| Stage | Meaning |
|---|---|
| `WIP-S1` | Substrate recon + the top-altitude ideology section; cite-by-substrate. |
| `WIP-S2a` | Higher-altitude mechanics — the entity at altitude. |
| `WIP-S2b` | Mechanics with explicit sibling cross-references. |
| `WIP-S3a` | Schema + lifecycle / state machines. |
| `WIP-S3b` | Routes + engine + events. |
| `WIP-S4` | Glossary walks + evidence gathering for cross-cutting promotion. |
| `WIP-S5` | Close package + reconciliation. |
| `CP-FREEZE` → `FROZEN` | Same freeze-to-archive tail as the build axis, with a per-entity sub-bump instead of a single tag. |

The `S1 → S5` altitudes map to the document-structure doctrine (60K ideology / 30K mechanics / 10K schema-routes-events). For axes whose deliverable is code, that document tiering doesn't apply — substitute the deliverable's own structure.

## Polish Lane stages

```
BRIEF → ASSIGNED → IMPLEMENTING → SMOKE → COMMIT → DONE
```

| Stage | Meaning |
|---|---|
| `BRIEF` | Founder request received and triaged to Polish. |
| `ASSIGNED` | Top mentor stamps a slim orchestrator or routes direct to the Doer. |
| `IMPLEMENTING` | Doer executes the bounded change. |
| `SMOKE` | Smoke test + UX-critic review pass (no full audit). |
| `COMMIT` | Doer commits via commit discipline + lightweight polish tag. |
| `DONE` | Founder receives confirmation; loop closes. |

No CP sub-stages — the whole lane is single-stage execution.

## Surgical Strike stages

```
REQUEST → EXECUTE → COMMIT → DONE
```

| Stage | Meaning |
|---|---|
| `REQUEST` | Founder one-liner request lands in the top mentor's inbox. |
| `EXECUTE` | Top mentor stamps a one-paragraph brief to a fresh Doer; Doer pulls, edits. |
| `COMMIT` | Doer commits via commit discipline (no tag; commit on trunk). |
| `DONE` | Founder pinged; loop closes. |

The mid mentor is skipped entirely; the Doer dies after the one commit.

## Cycle-level stages (shared across axes)

```
ENGAGED → DISPATCH-LOOP → AMENDMENT-PKG (doctrine only) → RATIFIED → CLOSED
```

These wrap the per-dispatch stages: a cycle is `ENGAGED`, runs a `DISPATCH-LOOP` of per-unit dispatches, assembles an `AMENDMENT-PKG` (doctrine cycles only), is `RATIFIED` by the founder, then `CLOSED` with a bump tag.

## Cycle-tail acceptance (a tunable on the freeze tail)

How the freeze-to-tag tail handles incomplete items is itself a dial:

- **Strict** (default) — every item in the dispatch must close before the tag applies. Maximum predictability of what a tag means.
- **Liberal (N-of-M)** — a tag may apply with N of M items closed and the rest onboarded as leftovers. Faster cycle close, less predictable tag semantics.

Strict trades speed for predictability; liberal trades the reverse. This is the **cycle-tail acceptance** parameter in the [full matrix](full-parameter-matrix.md).

## The three structural requirements (the invariant shape)

A project may rename, recount, and re-substage freely, provided the taxonomy satisfies:

1. **Monotonic stage progression** — state cannot un-advance without an explicit rollback.
2. **A defined freeze-to-tag tail** — a `CP-FREEZE → GATE-CHECK → TAGS-APPLIED` sequence that gates ratification.
3. **A terminal FROZEN state** — signals archival; nothing happens to the unit after it.

Beyond those, stage vocabulary is fully tunable.

## Defaults

| Setting | Default | Range |
|---|---|---|
| Build-axis stages | CP1 / CP2 / CP3 | project-defined (≥1 WIP stage) |
| Doctrine-axis stages | S1 → S5 | project-defined |
| Cycle-tail acceptance | strict (all close) | strict / liberal (N-of-M) |
| Freeze-to-tag tail | required | `[INVARIANT]` shape |

## How to choose

- **Author your stage taxonomy at adoption**, alongside the axis declarations. It's load-bearing from the first dispatch.
- **Fewer stages for simpler deliverables.** A code axis with no document-tiering needs fewer WIP stages than a doctrine axis.
- **Keep the freeze-to-tag tail intact** — it's what makes a tag mean "ratified."
- **Stay strict on cycle-tail acceptance** for regulated work; go liberal only when speed outranks predictable tag semantics.

## How this connects

- [Axis declarations](axis-declarations.md) — an axis declares its cycle granularity, i.e. its stage sequence.
- [Work granularity lanes](work-granularity-lanes.md) — each lane runs a different taxonomy (heavy vs slim).
- [Status grids](../07-reference/status-grids.md) — consume stage markers to render where work stands.
- [Full parameter matrix](full-parameter-matrix.md) — cycle-tail acceptance and stage choices listed as tunables.

---

## Next: [Invariants, toolings & specialised agents →](invariants-toolings-agents.md)
