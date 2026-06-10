# Stage grammar

> *The consolidated stage vocabulary across every axis and lane. Look up a marker; find what it means and where it's used.*

`[TUNABLE — stage names per axis + per lane]`

Stages are the lifecycle markers a unit of work moves through. They appear in four places: [Tier-2 status grids](status-grids.md) (each item carries its stage), inbox file naming and [hierarchy-tag](hierarchy-tags.md) status fields, ratification-gate definitions, and the audit trail. This page consolidates every reference stage taxonomy in one lookup.

The specific names below are the framework's reference defaults. They are `[TUNABLE]` — a project declares its own. But the **stage machinery** itself has invariant constraints (see [the rules](#what-the-framework-requires) at the bottom).

---

## Build axis · Phase 3 dispatch stages

```
PRE-STAMP → STAMPED → LAUNCHED → WIP-CP1 → WIP-CP2 → WIP-CP3 →
  CP-FREEZE → GATE-CHECK → GO-TAG → TAGS-APPLIED → CLOSED → FROZEN
```

| Stage | Meaning |
|---|---|
| `PRE-STAMP` | Mentor-1 composing the stamp; nothing fired yet |
| `STAMPED` | Stamp authored + launch relay pushed (T1) |
| `LAUNCHED` | Mentor-2 session booted via bus relay |
| `WIP-CP1` | Planning + premise check (re-measure baseline; inherit charter; surface founder-calls) |
| `WIP-CP2` | Implementation, slice by slice; invariant enforcement; per-stage substantive review |
| `WIP-CP3` | Exit-report assembly + audit reconciliation |
| `CP-FREEZE` | Slices finished; freeze candidate (T7 — leftover onboarding) |
| `GATE-CHECK` | Mentor-1 triages the four gates GREEN |
| `GO-TAG` | Mentor-1 authorized the tag-apply (T1) |
| `TAGS-APPLIED` | Mentor-2 applied the exit tag + refspec-pushed + remote-verified (T2) |
| `CLOSED` | Tier-2 closed; close-record committed; stand-down acknowledged |
| `FROZEN` | Judicial folder archived per the firewall (terminal) |

---

## Doctrine axis · entity dispatch stages

```
PRE-STAMP → STAMPED → LAUNCHED → WIP-S1 → WIP-S2a → WIP-S2b → WIP-S3a → WIP-S3b → WIP-S4 → WIP-S5 →
  CP-FREEZE → GATE-CHECK → GO-SUB-BUMP → TAGS-APPLIED → STAND-DOWN-ACK → FROZEN
```

| Stage | Meaning |
|---|---|
| `WIP-S1` | Substrate recon + 60K ideology; cite-by-substrate per the provenance law |
| `WIP-S2a` | 30K higher altitude — the entity's mechanics at altitude |
| `WIP-S2b` | 30K mechanics — compass-conjoined (sibling cross-references explicit) |
| `WIP-S3a` | 10K schema + lifecycle / state machines |
| `WIP-S3b` | 10K routes + engine + events |
| `WIP-S4` | Grass-root walks + lift-anchor evidence gathering |
| `WIP-S5` | Close package + reconciliation (orchestrator-direct) |
| `CP-FREEZE` | Slices finished; freeze candidate (T7) |
| `GATE-CHECK` | Mentor-1 triages the four gates GREEN |
| `GO-SUB-BUMP` | Mentor-1 authorized the dual-tag apply (per-entity sub-bump) |
| `TAGS-APPLIED` | Exit + sub-bump tags applied · remote-verified (T2) |
| `STAND-DOWN-ACK` | Mentor-1 sent the stand-down ack; Mentor-2 stood down |
| `FROZEN` | Judicial folder archived per the firewall (terminal) |

The S1–S5 stages map to the three compass altitudes (60K / 30K / 10K) plus evidence-gathering and close. See [deliverable structure](manifesto-full.md#23-deliverable-doctrine-structure-the-compass-tiers).

---

## Polish lane stages

```
BRIEF → ASSIGNED → IMPLEMENTING → SMOKE → COMMIT → DONE
```

| Stage | Meaning |
|---|---|
| `BRIEF` | Founder request received in Mentor-1's inbox; triaged to Polish |
| `ASSIGNED` | Mentor-1 stamps a slim Mentor-2 (or routes direct to Doer) |
| `IMPLEMENTING` | Doer executes the bounded change |
| `SMOKE` | Smoke test + critic-agent review (no full audit) |
| `COMMIT` | Doer commits via commit-discipline + a lightweight tag (`polish-<topic>-v<x.y>`) |
| `DONE` | Founder confirmation; loop closes |

No CP sub-stages — the whole lane is single-stage execution.

---

## Surgical strike stages

```
REQUEST → EXECUTE → COMMIT → DONE
```

| Stage | Meaning |
|---|---|
| `REQUEST` | Founder one-liner to Mentor-1's inbox (verbal → transcribed to inbox per the persistence law) |
| `EXECUTE` | Mentor-1 stamps a one-paragraph brief into a fresh Doer's inbox; Doer pulls, edits, commits |
| `COMMIT` | Doer commits via commit-discipline (no tag; commit on trunk) |
| `DONE` | Founder ping; loop closes |

Mentor-2 is entirely skipped; the Doer dies after the one commit.

---

## Cycle-level stages (shared across axes)

```
ENGAGED → DISPATCH-LOOP → AMENDMENT-PKG (doctrine only) → RATIFIED → CLOSED
```

| Stage | Meaning |
|---|---|
| `ENGAGED` | Cycle started; Charter posture set; walk done (doctrine) or founder triggered (build) |
| `DISPATCH-LOOP` | Running per-entity / per-module dispatches (most of the cycle) |
| `AMENDMENT-PKG` | (Doctrine only) cycle-end package assembly |
| `RATIFIED` | Founder ratified the cycle output |
| `CLOSED` | Charter-level bump (**GO-UP-BUMP**) applied + Charter re-locked (doctrine) or Phase 3 closed (build) + cycle home frozen |

---

## Rotation stages (Mentor-N → Mentor-N+1)

```
ROTATION-PREP → INCOMING-BOOT → DUAL-SIGN → RELEASED
```

| Stage | Meaning |
|---|---|
| `ROTATION-PREP` | Outgoing tier END certification + END status grid |
| `INCOMING-BOOT` | Incoming tier T0 boot-integrity (incl. sync check) |
| `DUAL-SIGN` | Incoming Layer-B PASS + original observation + countersign |
| `RELEASED` | Outgoing released; incoming LIVE |

→ [Handover certificate template](templates/index.md)

---

## Per-tier operational micro-states (in-tenure)

For any tier at any moment, independent of the work-unit stage:

```
IDLE / PREPARING / DISPATCHING / TRIAGING / RATIFYING / SURFACING / STANDBY
```

| Marker | Meaning |
|---|---|
| `IDLE` | No dispatch in flight; no founder-call queued |
| `PREPARING` | Composing a stamp / founder-call package / brief |
| `DISPATCHING` | Bus relay active (launch or post-launch waiting) |
| `TRIAGING` | Ingesting a sub-tier return |
| `RATIFYING` | Applying GO-SUB-BUMP / GO-TAG or accepting a close |
| `SURFACING` | Composing a founder-call package |
| `STANDBY` | Waiting on a founder relay / founder ruling |

---

## What the framework requires {#what-the-framework-requires}

The names above are `[TUNABLE]`. The **stage machinery** is constrained:

1. **Monotonic progression.** A unit cannot un-advance a stage without an explicit rollback. State moves forward or rolls back deliberately — never silently drifts backward.
2. **A defined freeze→gate→apply tail.** Every dispatch taxonomy must include a `CP-FREEZE → GATE-CHECK → TAGS-APPLIED` (or equivalent) tail that gates ratification. This is where the four exit gates are checked.
3. **A terminal FROZEN state.** A unit ends in a state that signals archival per the firewall, so no closed unit lingers as ambiguous WIP.

Within those three constraints, stage names, counts, and sub-stages are a project's to declare during adoption.

→ [Stage taxonomies (tunable)](../03-tunables/stage-taxonomies.md) · [Status grids](status-grids.md) · [Hierarchy tags](hierarchy-tags.md) · [Work granularity lanes](../03-tunables/work-granularity-lanes.md)

---

## Next: [CLI conventions →](cli-conventions.md)
