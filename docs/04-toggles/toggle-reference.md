# Toggle Reference

> *The complete switch list. Every changeable setting, classified by **when** it may flip.*

`[TOGGLES — the master classification table]`

## TL;DR

This is the map. Every tunable that CompassAlpha exposes appears here exactly once, tagged with its **flip-timing class** — Runtime, Cycle-boundary, or Project-lifecycle — plus a one-line note on *why* it sits in that class and what breaks if you flip it early.

Read the [overview](index.md) first for what the three classes mean. Read the per-class pages ([Runtime](runtime-toggles.md), [Cycle](cycle-toggles.md), [Project-lifecycle](project-lifecycle-toggles.md)) for the detailed reasoning. This page is the lookup table you return to.

## How to read each row

- **Setting** — the tunable, named as it appears in [Tunables](../03-tunables/index.md).
- **Class** — `RUNTIME` / `CYCLE` / `LIFECYCLE`.
- **Earliest safe flip** — the seam at or before which the change may land.
- **Default** — the reference default.
- **Why this class** — the hazard that pins it there.

## Master classification table

### Performance, cost & intelligence dials

| Setting | Class | Earliest safe flip | Default | Why this class |
|---|---|---|---|---|
| Doer effort level | `RUNTIME` | Before next dispatch | `xhigh` | Governs only the *next* Doer spawn; in-flight slices unaffected. |
| Doer context scope | `RUNTIME` | Before next dispatch | wide | Set when the Doer is spawned; never changes a live Doer. |
| Doer model tier | `RUNTIME` | Before next dispatch | top-tier | Bound at spawn; the running slice keeps its model. |
| Provenance verification stringency | `RUNTIME` | Before next return triage | strict | Applies per-return; tightening mid-cycle is always safe. |
| Memory accumulation rate | `RUNTIME` | Any boot | liberal | Affects what *future* boots write; no retroactive effect. |
| Audit / digest verbosity | `RUNTIME` | Any flush | verbose | Cosmetic on the audit trail; no work depends on it. |
| Founder involvement level | `RUNTIME` | Any time | RELAY + lost+found | The founder can lean in or out per request; see [§18 caveats](#caveats). |

### Cycle-shape dials

| Setting | Class | Earliest safe flip | Default | Why this class |
|---|---|---|---|---|
| Concurrency mode | `CYCLE` | Cycle boundary | LAYGO | Defines how dispatches interleave; can't change shape mid-flight. |
| **Charter posture** (`LOCKED ↔ UNLOCKED`) | `CYCLE` | Walk / cycle-close only | LOCKED | The alternation state machine; flipping mid-cycle races the active axis. |
| Active axis | `CYCLE` | Posture transition | build (LOCKED) | Follows the posture; only one main axis runs per posture. |
| Cycle-tail acceptance (strict / N-of-M) | `CYCLE` | Cycle boundary | strict | Defines what "closed" means for the cycle now ending. |
| §9 depth for cycle activation | `CYCLE` | Between cycles | ~20–30 soft | The gate threshold for *firing* a cycle; meaningless mid-cycle. |
| Stage taxonomy (per axis) | `CYCLE` | Cycle boundary | per axis decl. | Renaming stages mid-cycle invalidates in-flight status grids. |
| Mentor-2 lifecycle (per-event / per-dispatch) | `CYCLE` | Cycle boundary | fresh-per-event | Changes the spawn contract; settle it at a seam. |
| Rotation cadence | `CYCLE` | Cycle boundary | 2–4 weeks | The clock for preventive rotation; adjust between cycles. |

### Set-once foundations

| Setting | Class | Earliest safe flip | Default | Why this class |
|---|---|---|---|---|
| Project name | `LIFECYCLE` | Adoption only | — | Embedded in paths, namespaces, branding. |
| Reviewer-state repo path | `LIFECYCLE` | Adoption (migration) | `/path/to/reviewer-state` | Every artifact lives here; moving it is a migration. |
| Substrate repo path | `LIFECYCLE` | Adoption (migration) | `/path/to/substrate` | The governed codebase; bound at declaration. |
| Tier names (per axis) | `LIFECYCLE` | Adoption only | Mentor-1 / Mentor-2 / Doer | Bus inbox names, homes, and logs encode these. |
| VCS choice | `LIFECYCLE` | Never | git | `[INVARIANT — git is the bus]`; not a toggle, a foundation. |
| Number of canonical state artifacts | `LIFECYCLE` | Adoption only | 5 | Boot reads assume the artifact set; changing it re-tools boot. |
| Mentor-1 lifecycle (per-cycle / per-epoch) | `LIFECYCLE` | Adoption (rare cycle-boundary) | per-cycle long-running | Defines the spine of continuity; treat as foundational. |
| Single-live-writer enforcement | `LIFECYCLE` | Never | strict | `[INVARIANT — keep strict]`; not tunable downward. |
| Host power-down resilience model | `LIFECYCLE` | Host migration | volatile-local / durable-origin | Determined by the host; sets flush cadence semantics. |

## Invariants are not on this table

Note what's *absent*: the seven [axioms](../01-axioms/index.md) and the [guardrails](../02-guardrails/index.md). They are `[INVARIANT]` — they don't flip at any timing, ever, without forking the framework. The firewall, hard-labour rule, persistence law, bus protocol, and provenance law have no flip-timing class because they have no "off" and no "later." If you find yourself wanting to toggle one, you want a different framework.

The two `[INVARIANT]` rows that *do* appear above (VCS = git, single-live-writer) are listed only to mark them explicitly as `LIFECYCLE` / never — so adopters don't go looking for a dial that isn't there.

## Caveats {#caveats}

- **Founder involvement** is classed `RUNTIME` because the founder can always choose to lean in on a specific request — but per the [hard-labour rule](../01-axioms/hard-labour-rule.md) and §18, *standing* involvement above RELAY + lost+found bloats founder cognitive load and erodes the [trust anchor](../01-axioms/persistence-law.md). Flip it situationally, not structurally.
- **Charter posture** is the most consequential cycle toggle in the framework. It gets its own detailed treatment on the [Cycle toggles](cycle-toggles.md) page — it is *not* a dial you nudge.
- **Mentor-1 lifecycle** appears under both Cycle and Lifecycle framings deliberately: it's foundational enough to treat as set-once, but a mature project may revisit it at a cycle boundary. When in doubt, treat it as `LIFECYCLE`.

## Connections

- The values for every row come from [Tunables](../03-tunables/index.md).
- Several rows bundle together into named [Operating presets](operating-presets.md) — pick a preset and these flip as a coherent set.
- The `CYCLE`-class rows are gated by the [cross-axis temporal posture](cycle-toggles.md) state machine.

---

## Next: [Runtime toggles →](runtime-toggles.md)
