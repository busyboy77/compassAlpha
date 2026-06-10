---
description: "How much context each tier carries, across what scope, and for how long. The pollution-vs-continuity surface."
---

# Context Patterns

> *How much context each tier carries, across what scope, and for how long. The pollution-vs-continuity surface.*

`[TUNABLE — context usage]`

## TL;DR

Several independent dials control how much context each tier holds and over what scope: **mentor session lifecycle**, **doer context depth**, **cross-tier visibility**, **memory accumulation rate**, **digest verbosity**, and **rotation cadence**. These trade pollution-containment and cost against continuity and intelligence. The conservative defaults bias toward containment (fresh-per-event sessions, own-folder-only visibility, verbose digests). They are largely independent — combining them differently yields the [operating presets](../04-toggles/operating-presets.md). The [firewall](../01-axioms/firewall.md) and [hard labour rule](../01-axioms/hard-labour-rule.md) are `[INVARIANT]` underneath all of them.

## The dials

### 1. Mentor session lifecycle

How long a tier keeps one session before refreshing.

| Lifecycle | Applies to | Pollution | Boot overhead | Continuity |
|---|---|---|---|---|
| **Fresh-per-event** (default for Mentor-2 + Doer) | mid + bottom tiers | lowest | highest per event | lowest |
| **Per-dispatch** (alt for Mentor-2) | mid tier | moderate | lower | moderate |
| **Long-running** (default for Mentor-1) | top tier | managed via down-tier freshness | lowest | highest |

The structural rule ([context health hygiene](../02-guardrails/pollution-containment.md)) is **fresh-session bias increases down-tier**: the top mentor runs long (continuity matters there), the mid mentor rotates per dispatch or event, and the Doer is **always** fresh-per-slice. The Doer's fresh-per-slice rule is `[INVARIANT]` — reusing a Doer session across slices is an anti-pattern (fatigue + cross-slice pollution). What's tunable is the mid-tier choice (fresh-per-event vs per-dispatch) and the top-tier rotation cadence.

### 2. Doer context depth

How much the Doer reads to do its slice.

- **Wide / liberal** (default). The Doer reads what it needs to triangulate — sibling documents, cross-files in substrate, related memories. Maximum intelligence; highest token cost.
- **Narrow / declared-only**. The Doer reads only the files explicitly listed in its brief. Lower cost; risk of missing critical context.

Wide is the right default for substantive work where the Doer must reason across the codebase. Narrow suits cosmetic or tightly-scoped slices where the brief genuinely contains everything.

### 3. Cross-tier visibility scope

What each tier is allowed to read of other tiers.

- **Own-folder only** (default). Each tier sees only its own folder + the inboxes it receives. Maximum pollution containment. This is the [firewall](../01-axioms/firewall.md) at its strictest.
- **Parent-folder-summary**. A lower tier may read its parent's summary state. Higher continuity awareness; a small, deliberate pollution leak.
- **Full visibility** (anti-pattern — not recommended). All tiers read all folders. Maximum continuity, pollution chaos. Documented only so adopters recognize and avoid it.

Note the relationship to the firewall axiom: own-folder-only *is* the firewall. Loosening to parent-summary is a deliberate, bounded relaxation; full visibility breaks the axiom and is off the table.

### 4. Memory accumulation rate

How readily the federation captures durable cross-cycle learnings.

- **Liberal** (default). Capture a memory for every meaningful learning. The federation matures fast; the memory file count grows.
- **Conservative**. Capture memories only for patterns proven across two or more incidents. Less noise; slower maturation.

This dial is covered in depth on the [Memory policy](memory-policy.md) page; it lives here too because it is fundamentally a context dial.

### 5. Audit / digest verbosity

How much detail a tagged return carries up-tier.

- **Verbose** (default). Tagged returns include full digests — findings, open questions, surprising reads. Rich audit trail; higher cost.
- **Concise**. Tagged returns include only deltas + status. Thinner audit trail; lower cost.

Verbose pays off where the audit trail is load-bearing (regulated work, post-hoc forensics). Concise suits high-throughput, lower-stakes work.

### 6. Rotation cadence

How often the long-running top mentor is preventively rotated to a fresh session at a clean seam.

- **Default: 2–4 weeks preventive**, plus reactive rotation on any context-health signal.
- **Range: 1–6 weeks.** Tighter cadence (1–2 weeks) lowers pollution risk at the cost of continuity and rotation overhead; looser cadence (4–6 weeks) preserves continuity but accumulates more session fatigue.

Rotation is always *also* reactive: the moment a tier shows context-health signals (responses lengthening without added content, recognition fuzziness, needing to re-read what should be known), it flushes and rotates regardless of the calendar. **Do not push through fatigue.**

## Defaults

| Dial | Default | Range |
|---|---|---|
| Mentor-1 lifecycle | long-running (per-cycle) | per-cycle / per-epoch |
| Mentor-2 lifecycle | fresh-per-event | fresh-per-event / per-dispatch |
| Doer lifecycle | fresh-per-slice | `[INVARIANT]` — not tunable |
| Doer context depth | wide / liberal | wide / narrow / declared-only |
| Cross-tier visibility | own-folder only | own-only / parent-summary / full (anti-pattern) |
| Memory accumulation rate | liberal | liberal / conservative |
| Digest verbosity | verbose | verbose / concise |
| Rotation cadence | 2–4 weeks preventive | 1–6 weeks |

## How to choose

- **Stay at the defaults for regulated/high-stakes work.** Containment and audit depth are worth the cost.
- **Loosen Doer context to narrow** only when slices are genuinely self-contained (cosmetic, single-file). Otherwise wide.
- **Switch digests to concise** only for high-throughput lanes where you don't need forensic depth.
- **Tighten rotation cadence** if you observe fatigue signals before the calendar; loosen if rotations feel premature.
- **Never go to full cross-tier visibility.** It breaks the firewall axiom; use parent-summary if you genuinely need more continuity awareness.

## How this connects

- [Firewall](../01-axioms/firewall.md) (axiom) — cross-tier visibility is the firewall's tunable dial; own-folder-only is the firewall at strictest.
- [Hard labour rule](../01-axioms/hard-labour-rule.md) (axiom) — keeps mentor context clean regardless of lifecycle choice.
- [Pollution containment](../02-guardrails/pollution-containment.md) (guardrail) — the down-tier freshness bias these lifecycle dials implement.
- [Memory policy](memory-policy.md) — the memory accumulation dial in full.
- [Concurrency modes](concurrency-modes.md) — parallel concurrency pressures the top mentor's context, interacting with lifecycle + rotation.

---

## Next: [AI model choices →](ai-model-choices.md)
