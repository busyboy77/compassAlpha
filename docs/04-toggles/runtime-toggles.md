---
description: "What you can safely change mid-cycle, without pausing the work."
---

# Runtime Toggles

> *What you can safely change mid-cycle, without pausing the work.*

`[TOGGLES — class: RUNTIME]`

This page lists the settings you're allowed to change *while the work is happening* — the dials you can turn without stopping anything, because they only affect the next piece of work, never the piece already underway. If you've ever wished you could ease off the gas mid-journey without pulling over, this is the page for you.

## TL;DR

In plain terms: these are the safe-to-change-anytime settings. Here's why they're safe.

A **runtime toggle** is a setting that governs only work *not yet started*. You can flip it any time — mid-cycle, mid-dispatch, between turns — and the change lands cleanly because nothing currently in flight depends on the old value. The mechanism that makes this safe is the [hard-labour rule](../01-axioms/hard-labour-rule.md): the Doer is *fresh-spawned per unit of work*, so each new spawn simply reads the current value. The slice already running keeps the value it was born with.

If you remember one rule: **runtime toggles bind at spawn / at the next event, never retroactively.**

## The switches

| Setting | Default | Range | Binds at |
|---|---|---|---|
| Doer effort level | `xhigh` | xhigh / high / normal / low | Next Doer spawn |
| Doer context scope | wide | wide / narrow / declared-only | Next Doer spawn |
| Doer model tier | top-tier | top / mid / low | Next Doer spawn |
| Provenance verification stringency | strict | strict / spot-check / trusted | Next return triage |
| Memory accumulation rate | liberal | liberal / conservative | Next boot |
| Audit / digest verbosity | verbose | verbose / concise | Next flush |
| Founder involvement (situational) | RELAY + lost+found | low / medium / high | Per request |

## When each can flip — and why it's safe

### Doer effort, context scope, and model tier

These three are bound **at the moment a Doer is spawned**. A Doer is a fresh session created for one slice of work; it reads its effort level, context scope, and model assignment at birth and holds them for its lifetime. Changing any of them affects only the *next* spawn.

This is the cleanest kind of toggle: there is no shared mutable state to race. The slice in flight finishes under its original settings; the next slice picks up the new ones. You can dial effort down for a stretch of cheap, mechanical slices and back up for a hard one, with zero coordination.

### Provenance verification stringency

The [provenance law](../01-axioms/provenance-law.md) is `[INVARIANT]` — *that* verification happens never changes. *How strictly* a mentor verifies a return (strict cite-by-substrate vs spot-check vs trusted) is a runtime dial that applies at the next triage. Tightening it is always safe. Loosening it is safe in mechanism but carries a correctness cost — see risks below.

### Memory accumulation rate

How liberally the federation writes durable cross-cycle memories binds at boot. Each tier reads the current rate when it starts. Changing it has no retroactive effect — past memories stay; only the rate of *future* writes shifts.

### Audit / digest verbosity

Purely about how much detail the audit trail and digests carry. No unit of work depends on it. Flip it at any flush.

### Founder involvement (situational only)

The founder can always choose to lean into a specific decision or step back to pure RELAY for a stretch. That *situational* lean is a runtime toggle. What is **not** a runtime toggle is making elevated involvement the *standing posture* — that bloats founder load and erodes the [trust anchor](../01-axioms/persistence-law.md). See the [hard-labour rule](../01-axioms/hard-labour-rule.md). For a worked example: the founder may rule on a single ambiguous Auth slice this turn, then return to RELAY — fine. Sitting in the loop for every Billing dispatch — not fine.

## Risks of flipping at the wrong time

Runtime toggles are low-risk *by construction* — they can't race in-flight work. The residual risks are about **value**, not timing:

- **Loosening provenance mid-cycle** (strict → trusted) raises hallucination-drift risk on every return that follows. The flip is mechanically safe; the consequence is real. Loosen only with eyes open.
- **Dropping Doer effort / model tier** on a slice that turns out to be hard yields weak work. The flip is safe; the under-powered output is not. Match the dial to the slice.
- **Narrowing Doer context** past what the slice needs starves the Doer of the substrate it must triangulate against. Safe to flip; degrades quality.
- **Standing founder involvement** — covered above. The toggle is runtime; the *habit* is the hazard.

There is one genuine timing subtlety: a runtime toggle changed **between a dispatch's creation and the Doer's spawn** binds to the spawn, so it *does* affect that dispatch. If you want a dispatch to run under the old value, flip after its Doer has spawned. In practice this window is small and rarely matters.

## Defaults

The reference defaults bias toward correctness and intelligence over cost: `xhigh` effort, wide context, top-tier model, strict provenance, liberal memory, verbose audit, RELAY-only founder. These are the [Conservative preset](operating-presets.md) values. Cost-conscious projects relax effort/scope/model and verbosity; see [Operating presets](operating-presets.md).

## Connections

- Runtime toggles are the per-spawn dials from the [Tunables](../03-tunables/index.md) performance/cost surface.
- They're safe *because* of the [hard-labour rule](../01-axioms/hard-labour-rule.md) (fresh-spawn-per-slice) and the [firewall](../01-axioms/firewall.md) (no shared mutable state across tiers).
- Contrast with [Cycle toggles](cycle-toggles.md), which *cannot* flip mid-cycle, and [Project-lifecycle toggles](project-lifecycle-toggles.md), which are set once.
- Several runtime toggles move together inside the named [Operating presets](operating-presets.md).

## Remember this

- **Runtime toggles are the safe ones.** Flip them whenever you like — the change lands on the *next* piece of work, never the one already running. Nothing in flight gets yanked out from under it.
- **"Safe to flip" isn't the same as "free to flip."** Loosening provenance checks or dropping effort on a hard slice won't break the machinery — but it can quietly lower the quality of what comes back. Match the dial to the moment.
- **The whole reason this works** is that each worker (the Doer) is born fresh for one slice and reads its settings at birth. If that idea is new to you, start with [the mental model](../00-foundation/mental-model.md).
- **Don't confuse these with the other toggle classes.** [Cycle toggles](cycle-toggles.md) can't change mid-cycle; [project-lifecycle toggles](project-lifecycle-toggles.md) are set once. Runtime toggles are the only ones you turn on the fly.

---

## Next: [Cycle toggles →](cycle-toggles.md)
