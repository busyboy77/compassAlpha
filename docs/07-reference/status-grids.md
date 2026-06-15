---
description: "Three levels of grid. Print Tier 1 at every session start and end; the heavier grids at seams."
---

# Status grids

> *Three levels of grid. Print Tier 1 at every session start and end; the heavier grids at seams.*

`[INVARIANT — three grid tiers exist]` · `[TUNABLE — stage taxonomy per axis]`

**New here?** A status grid is a tiny, fixed-shape status report an AI agent prints at the start and end of every work session — so anyone (a human or the next agent picking up the work) can see in seconds exactly where things stand, with no guessing and no long story to read.

Think of it like the dashboard you glance at when you sit down: what's done, what's in progress, what's left, what's next, and whether everything has actually been saved. This page shows the three sizes of that dashboard and when to use each one.

Status grids are the federation's at-a-glance state surface (the federation being the team of AI agents working together on the code). They serve two load-bearing functions. First, a **boot-integrity check**: the grid printed at session start must match what's actually saved on disk — if it doesn't, something has drifted out of sync and work pauses to reconcile. Second, a **handover certification**: the grid printed at session end confirms that what's on disk matches the agent's understanding, with nothing left unsaved (unflushed). A grid is never a narrative — it's a fixed-shape snapshot a founder or an incoming agent can scan in seconds.

The three tiers escalate in depth. You print the right one for the seam.

| Tier | Shape | Printed when | Saved as |
|---|---|---|---|
| **Tier 1** | 6-line fixed grid | Session START + END (mandatory) | inline in the turn + own folder |
| **Tier 2** | Categorical with stages | Significant seams (close, ruling, rotation prep, founder request) | `CATEGORICAL_STATUS_GRID_<date>.md` |
| **Tier 3** | Constitutional-hierarchical | Cycle-close prep, cross-rotation briefings, founder request | `TIER3_STATUS_GRID_<date>.md` |

---

## Tier 1 — the canonical 6-line grid

Mandatory at session START and END. The START grid doubles as the boot-integrity check (any mismatch with disk = halt and reconcile). The END grid is the outgoing thread's certification.

```text
STATUS GRID — <UTC-date> · <START|END> · <tier-instance> · MODE: <RELAY|DELEGATED> · stage <CYCLE-STAGE>
GATE        Charter v<x> <LOCKED|UNLOCKED> → v<y> · gates closed · <N>/<M> units done
DISPATCH    <unit @ stage @ commit  |  "none — last: <tag>">
LEFTOVERS   <N open>  (top: <ids>)
NEXT        <single immediate next action — one T# event>
DISK        <K state artifacts · read-back ✓ · no unflushed state · sync 0/0 @ <SHA>>
```

**Line-by-line.**

| Line | Carries | Notes |
|---|---|---|
| Header | date · START/END · which tier instance · operating mode · cycle stage | MODE is RELAY (default) or DELEGATED (legacy/anti-pattern). |
| GATE | Charter posture + version + gate-close count + units-done tally | The cross-axis state-machine position. |
| DISPATCH | the in-flight unit, its stage marker, its commit — or "none" + last tag | "none" rows are valid (between dispatches). |
| LEFTOVERS | open-item count + top ids | Sourced from `LEFTOVERS.md`, not memory. |
| NEXT | exactly one immediate action, expressed as one flush-trigger (T#) event | One action, not a plan. |
| DISK | artifact count · read-back confirmed · no unflushed state · sync state @ SHA | The persistence-law certification line. |

### Worked example (generic)

```text
STATUS GRID — 2026-06-09 · START · Mentor-2-7 · MODE: RELAY · stage DISPATCH-LOOP
GATE        Charter v0.4 LOCKED → (no bump) · gates 1-4 open · 2/3 slices done
DISPATCH    Billing/slice-3 @ WIP-CP2 @ a1b2c3d
LEFTOVERS   2 open  (top: LO-114 rate-rounding, LO-119 empty-state copy)
NEXT        T1 — relay GO for slice-3 once typecheck passes
DISK        4 artifacts · read-back ✓ · no unflushed state · sync 0/0 @ 9f8e7d6
```

---

## Tier 2 — categorical with stages

Printed at significant seams — a dispatch/entity close, a founder-call ruling, rotation prep, or on founder request. Every item carries its stage marker from the axis's [stage taxonomy](stage-grammar.md). Saved to disk before disclosure (persistence law).

The seven categories:

| Category | Meaning |
|---|---|
| **DONE** | Closed + tagged; the deliverable shipped. |
| **WIP** | In flight right now; carries a live stage marker. |
| **QUEUED** | Briefed/triaged, not yet started. |
| **LEFTOVER** | Deferred and onboarded to `LEFTOVERS.md`. |
| **DROPPED** | Deliberately abandoned, with rationale. |
| **MISSED** | Should have been caught; surfaced late. |
| **FORGOTTEN** | Discovered after the fact to have fallen out of tracking. |

(MISSED and FORGOTTEN are deliberately in the vocabulary — naming them makes the federation honest about its own lapses rather than hiding them.)

### Worked example (generic)

```text
CATEGORICAL STATUS GRID — 2026-06-09 · Mentor-1 · Billing dispatch close
DONE       Billing/slice-1 [FROZEN]  ·  Billing/slice-2 [FROZEN]
WIP        Billing/slice-3 [WIP-CP3]  — exit report assembling
QUEUED     Billing/slice-4 [PRE-STAMP]  — invoice-export
LEFTOVER   LO-114 rate-rounding [DEFER→next cycle]  ·  LO-119 empty-state copy [POLISH]
DROPPED    Billing/legacy-csv [DROPPED — superseded by export slice]
MISSED     (none)
FORGOTTEN  (none)
```

---

## Tier 3 — constitutional-hierarchical

The deepest visualization. Printed at cycle-close prep, cross-rotation briefings, or explicit founder request. Two layers: a **Charter layer** on top (invariants / primitives / toolings / amendments accepted this cycle) and a **components layer** below (per-unit FROZEN / WIP / QUEUED / DROPPED / MISSED / FORGOTTEN with sub-states). Saved to disk.

### Worked example (generic)

```text
TIER-3 STATUS GRID — 2026-06-09 · cycle charter-v0.4 → v0.5 prep

╔═ CHARTER LAYER ════════════════════════════════════════════════╗
║ Invariants active:        18  (2 candidates lifting this cycle) ║
║ Primitives owned:         Auth, Billing, Reporting              ║
║ Toolings:                 access-coverage audit, click-budget   ║
║ Amendments accepted:      CHARTER-A-4 (configurable cap)        ║
╚════════════════════════════════════════════════════════════════╝
  COMPONENTS
  ├─ Auth        [FROZEN]    @ auth-v0.3      sub: gates 1-4 green
  ├─ Billing     [WIP]       @ billing-v0.2   sub: WIP-CP3, exit report
  ├─ Reporting   [QUEUED]    sub: PRE-STAMP
  ├─ legacy-csv  [DROPPED]   sub: superseded
  ├─ MISSED      (none)
  └─ FORGOTTEN   (none)
```

---

## When each grid is printed (summary)

| Event | Tier 1 | Tier 2 | Tier 3 |
|---|---|---|---|
| Session boot (T0) | ✓ (START) | — | — |
| Session end / standby (T0e) | ✓ (END) | — | — |
| Dispatch / entity close | — | ✓ | — |
| Founder-call ruling | — | ✓ | — |
| Rotation prep (T5) | ✓ (END) | ✓ | sometimes |
| Cycle-close prep | ✓ | ✓ | ✓ |
| Founder explicit request | ✓ | ✓ | ✓ |

A grid that hasn't been written to disk before being shown to the founder is a persistence-law violation — print, flush, *then* disclose.

→ [Persistence law](../01-axioms/persistence-law.md) · [Flush triggers](flush-triggers.md) · [Stage grammar](stage-grammar.md) · [Status-grid template](templates/index.md)

---

## Remember this

- A status grid is a small, fixed-shape report of where the work stands — printed so anyone can read the state in seconds instead of reconstructing it from memory.
- There are three sizes: **Tier 1** (the quick 6-line grid, printed every session start and end), **Tier 2** (a fuller categorized list, at bigger moments), and **Tier 3** (the deepest, for cycle-close and cross-team handovers). Use the smallest one that fits the moment.
- The start-of-session grid must match what's saved on disk, and the end-of-session grid certifies nothing was left unsaved — that's how the handover stays trustworthy.
- Always save the grid before showing it to anyone; a grid shown but not yet written down breaks the rule. See [the mental model](../00-foundation/mental-model.md) for how this fits the bigger picture.

---

## Next: [Hierarchy tags →](hierarchy-tags.md)
