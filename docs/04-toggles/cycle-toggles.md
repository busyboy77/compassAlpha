---
description: "What may change only at a cycle boundary — including the charter posture state machine, the most consequential switch in the framework."
---

# Cycle Toggles

> *What may change only at a cycle boundary — including the charter posture state machine, the most consequential switch in the framework.*

`[TOGGLES — class: CYCLE]`

These are the settings you can only change at the start or end of a work cycle — never in the middle — because they decide the basic shape of how a whole cycle runs. Get the timing right and the team flows; flip one too early and half the work runs by different rules than the other half.

## TL;DR

A "cycle" is one full round of work (think: a sprint with a clear opening and closing). A **cycle toggle** governs the *shape of a whole cycle*: how dispatches interleave, which axis is active, what "closed" means, what the stages are called. You cannot flip it mid-cycle, because half the cycle would run under one shape and half under another. Cycle toggles flip only at a **clean seam** — a dispatch close, a cycle close, or a charter posture transition.

The headline cycle toggle is the **charter posture** (`LOCKED ↔ UNLOCKED`). It is not a dial you nudge; it is a state machine with exactly two stable states and two named transitions. Getting its timing wrong races the active axis against the very work meant to govern it.

## The switches

| Setting | Default | Other value(s) | Flips at |
|---|---|---|---|
| **Charter posture** | `LOCKED` | `UNLOCKED` | the walk / the cycle close |
| Active axis | build (under LOCKED) | doctrine (under UNLOCKED) | follows posture |
| Concurrency mode | LAYGO | Pipelined / Parallel-independent / Parallel-doer | cycle boundary |
| Cycle-tail acceptance | strict (all close) | liberal (N-of-M) | cycle boundary |
| §9 depth for cycle activation | ~20–30 soft | 10–50 | between cycles |
| Stage taxonomy (per axis) | per axis declaration | project-defined | cycle boundary |
| Mentor-2 lifecycle | fresh-per-event | per-dispatch | cycle boundary |
| Rotation cadence | 2–4 weeks | 1–6 weeks | cycle boundary |

## The charter posture state machine

This is the spine of the whole section, so it gets the full treatment.

The "charter" is the federation's rulebook. A **state machine** here just means it lives in one of a fixed set of named states and moves between them only through named, deliberate transitions — never by drifting. A CompassAlpha federation has a charter state machine with two stable states and two transitions:

```
                   ┌────────────────────────────────────────┐
                   ▼                                          │
      ┌──────────────────────────┐               ┌──────────────────────┐
      │   Charter LOCKED         │ ─── walk ───▶ │  Charter UNLOCKED    │
      │   (axes whose posture    │               │  (axes whose posture │
      │   = LOCKED are ACTIVE)   │               │  = UNLOCKED active)  │
      └──────────────────────────┘               └──────────────────────┘
                   ▲                                          │
                   │             ┌─── cycle close ────────────┘
                   └─────────────┤    + re-lock
                                 │    (charter-v<n+1> issued)
                                 ▼
```

### The two transitions

- **LOCKED → UNLOCKED = the walk.** The founder reviews the platform/output state, surfaces feedback into a persisted walk-feedback artifact, and fires the doctrine axis. Two gates must both be met: the deferral queue has sufficient depth (default `~20–30 items`) **and** a recent build-axis close threshold has been reached.
- **UNLOCKED → LOCKED = the cycle close.** The doctrine axis ratifies the amendment package, issues the cycle-end charter bump (`charter-v<n+1>`), and re-locks. The build axis resumes under the new charter version.

### Why this can only flip at a seam

The alternation is **structural**, not stylistic:

- Letting the build axis run under an `UNLOCKED` charter **races the amendment** — the charter primitives the build is relying on can change mid-build. Work started against one rulebook, finished against another.
- Letting the doctrine axis run under a `LOCKED` charter **prevents the very amendments** the doctrine cycle exists to author.

So the two main axes *do not run concurrently when they share a charter state.* The posture flip is the act of handing the federation from one axis to the other. It can only happen when the outgoing axis is at a clean close — never mid-dispatch.

An axis declared `DECOUPLED` (e.g. a future review/audit axis independent of charter state) MAY run alongside whatever's active — but by declaration it never *gates or blocks* the main two. That's the only exception to the no-concurrency rule.

## The other cycle toggles

### Concurrency mode

How much work runs at once. LAYGO (one unit at a time) / Pipelined / Parallel-independent / Parallel-doer. This defines how dispatches interleave across the cycle. You cannot switch from sequential to parallel halfway through — the in-flight dispatches were planned under the old interleaving. Settle it at the boundary, run the whole cycle under one mode.

### Cycle-tail acceptance

Whether a cycle closes only when *all* units close (strict) or accepts N-of-M (liberal). This is the definition of "done" for the cycle *now ending* — so it must be fixed before that cycle's close, i.e. at the prior boundary.

### §9 depth for cycle activation

The queue-depth gate that *fires* a doctrine cycle. It only has meaning *between* cycles, at the activation decision. Changing it mid-cycle is a no-op until the next activation.

### Stage taxonomy

Each axis declares its stage names. Renaming or re-structuring stages mid-cycle invalidates every in-flight status grid and breaks the [persistence-law](../01-axioms/persistence-law.md) read-back (disk says one stage vocabulary, the session thinks in another). Change only at a boundary, where no dispatch is mid-stage.

### Mentor-2 lifecycle

Whether the orchestrator tier spawns fresh-per-event (bus-native) or persists per-dispatch. This is the spawn contract for the next cycle's orchestrators; flip it at the seam so a single cycle has a consistent contract.

### Rotation cadence

The preventive-rotation clock. Adjust between cycles based on observed session-fatigue rate.

## Risks of flipping at the wrong time

- **Charter posture flipped early** (firing doctrine before gates, or resuming build before re-lock): the active axis races the charter. This is the single most damaging timing error in CompassAlpha — it can corrupt the primitives both axes depend on. The gates exist precisely to prevent it.
- **Concurrency mode changed mid-cycle**: in-flight dispatches planned for sequential execution suddenly overlap, risking races the [git foundations](../01-axioms/git-foundations.md) were sized for the old mode.
- **Stage taxonomy changed mid-cycle**: status grids and ledger entries reference stage names that no longer exist; boot-integrity checks flag false drift.
- **Cycle-tail acceptance loosened mid-cycle**: a cycle that was going to close strict suddenly closes loose, leaving units half-done and unaccounted in [leftovers](../01-axioms/persistence-law.md).

The common thread: a cycle toggle changed mid-cycle splits the cycle into two incompatible halves. Always wait for the seam.

## Defaults

Reference defaults: `LOCKED` posture (build axis active), LAYGO concurrency, strict cycle-tail, §9 depth ~20–30, fresh-per-event Mentor-2, 2–4 week rotation. These are the [Conservative preset](operating-presets.md). The [Balanced](operating-presets.md) and [Throughput](operating-presets.md) presets relax concurrency to Pipelined / Parallel after the first cycle proves the rhythm.

## Remember this

- **A cycle toggle is a "between-rounds" setting.** It shapes how an entire cycle runs, so changing it mid-cycle would split that cycle into two halves running by different rules. Always wait for a clean seam — a dispatch close, a cycle close, or a charter posture transition.
- **The charter posture (`LOCKED ↔ UNLOCKED`) is the big one.** It hands the federation between the build axis and the doctrine axis. Flipping it at the wrong moment is the most damaging timing mistake in the framework, which is why two gates guard the transition.
- **Defaults are deliberately conservative.** Start locked, one-thing-at-a-time, strict "done." You only relax these once the team's rhythm has proven itself.
- New here? These switches make the most sense once you have [the mental model](../00-foundation/mental-model.md) of axes, cycles, and tiers.

## Connections

- The charter posture machine is the framework's [cross-axis temporal posture](../01-axioms/index.md) — see also [tier grammar](../01-axioms/tier-grammar.md) for how axes and tiers relate.
- Cycle activation gating (the walk, the §9 queue) is detailed in the activation tunables under [Tunables](../03-tunables/index.md).
- Contrast with [Runtime toggles](runtime-toggles.md) (flip anytime) and [Project-lifecycle toggles](project-lifecycle-toggles.md) (set once).
- Concurrency mode and Mentor-2 lifecycle move together inside named [Operating presets](operating-presets.md).

---

## Next: [Project-lifecycle toggles →](project-lifecycle-toggles.md)
