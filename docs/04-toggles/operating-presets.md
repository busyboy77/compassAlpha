---
description: "Named bundles of settings. Pick one to start, then tune from there — and avoid the anti-presets."
---

# Operating Presets

> *Named bundles of settings. Pick one to start, then tune from there — and avoid the anti-presets.*

`[TOGGLES — named preset bundles]`

## TL;DR

Rather than setting every [tunable](../03-tunables/index.md) individually and then reasoning about every [flip-timing class](toggle-reference.md), a project can start from a **named preset** — a coherent bundle of toggle values that have been chosen to work together. Pick the preset that matches your context, adopt its values, then tune from there.

Each preset *locks* certain settings (you commit to them for the project's posture) and leaves others *flippable* (you adjust as you learn). There are also three **anti-presets** — combinations that look tempting but trade away CompassAlpha's correctness guarantees for marginal gains. Don't use them.

## The seven presets

| Preset | When to use | Concurrency | Doer effort | Doer context | Founder involve | Provenance | Memory | Rotation | Models |
|---|---|---|---|---|---|---|---|---|---|
| **Conservative** (reference default) | Multi-tenant, regulated, doctrine-heavy | LAYGO | xhigh | wide | RELAY + lost+found | strict | liberal | 2–4w | top-tier all |
| **Balanced** | Most projects after first cycle | Pipelined | xhigh | wide | RELAY + lost+found | strict | liberal | 2–4w | top-tier all |
| **Throughput** | Mature project, time-pressured | Parallel-independent | xhigh | wide | RELAY + occasional | strict | liberal | 2–3w | top-tier all |
| **Cost-optimized** | Smaller project, budget-conscious | Pipelined | mid (simple slices) | narrow | RELAY only | spot-check | conservative | 3–4w | mixed |
| **Risk-averse** | Compliance-critical, high-stakes | LAYGO | xhigh | wide | RELAY + frequent | strict + double-verify | liberal | 1–2w | top-tier + verifier |
| **Research** | Doctrine churns fast, rapid iteration | LAYGO or Pipelined | xhigh | wide | RELAY + minimal | strict | liberal | 2w | top-tier all |
| **Bootstrap** | Brand-new CompassAlpha adoption | LAYGO | xhigh | wide | RELAY + frequent | strict | liberal | 2w | top-tier all |

Presets are **starting points, not commitments.** A project that starts Conservative graduates to Balanced once the first cycle proves the rhythm; a Bootstrap project sheds its training wheels and becomes whatever its steady-state posture demands.

## What each preset locks vs flips

Reading this against the flip-timing classes: a preset's *runtime* values you can revisit any turn; its *cycle* values move only at a seam; nothing here touches *lifecycle* settings (those are fixed at adoption regardless of preset).

### Conservative (the reference default)
- **Locks (cycle-class):** LAYGO concurrency, strict cycle-tail. One unit at a time; everything closes before the cycle does.
- **Flips freely (runtime-class):** none, by design — every runtime dial is already at its safest value. This is the maximally-correct baseline.
- **Use it when** correctness dominates and you're early. It's deliberately slow.

### Balanced
- **Locks:** Pipelined concurrency — dispatches overlap at their seams, but the [firewall](../01-axioms/firewall.md) and [git foundations](../01-axioms/git-foundations.md) keep them isolated.
- **Flips freely:** founder lean-in per request; provenance stays strict but spot-checks are acceptable on trivial returns.
- **Use it when** the rhythm is proven and you want throughput without parallel-execution risk.

### Throughput
- **Locks:** Parallel-independent concurrency — multiple independent units run at once. Requires mature [git-foundations](../01-axioms/git-foundations.md) discipline (per-session index, isolated worktrees, explicit refspec push).
- **Flips:** rotation can tighten to 2–3w to manage the higher session churn.
- **Use it when** mature and time-pressured. Not for first cycles.

### Cost-optimized
- **Locks:** Pipelined concurrency, conservative memory rate.
- **Flips freely:** Doer effort drops to mid-tier *for simple slices* (flip back to xhigh per hard slice — this is a runtime toggle, use it), context narrows, models go mixed, provenance to spot-check.
- **Use it when** budget-bound. Watch the correctness cost of loosened provenance — see anti-presets.

### Risk-averse
- **Locks:** LAYGO, strict + double-verify provenance, a dedicated verifier model tier, frequent rotation (1–2w).
- **Flips:** founder leans in frequently — and here that elevated involvement is a *justified standing posture*, the one context where it doesn't count against the [hard-labour rule](../01-axioms/hard-labour-rule.md).
- **Use it when** the cost of an error dwarfs the cost of the federation. Slow and thorough on purpose.

### Research
- **Locks:** minimal toolings/agents/invariants — the doctrine surface churns too fast to ossify them.
- **Flips:** concurrency between LAYGO and Pipelined as iteration speed demands; founder involvement minimal.
- **Use it when** you're exploring doctrine, not hardening it.

### Bootstrap (first-cycle)
- **Locks:** LAYGO, minimal toolings/agents, **no specialized agents yet**, frequent founder involvement.
- **Flips:** nothing aggressively — the whole point is to *prove the rhythm* before tuning.
- **Use it when** you're brand-new to CompassAlpha. Graduate to Conservative or Balanced after cycle one. See [Getting started](../05-getting-started/index.md).

## The anti-presets — what NOT to do

These are real combinations adopters reach for. Each trades a structural guarantee for a marginal gain. **Do not use them.**

| Anti-preset | The tempting bundle | Why it's a trap |
|---|---|---|
| **"Maximum speed"** | Parallel-doer + concise digests + trusted provenance + minimal founder + per-dispatch Mentor-2 | Trades 2–3 correctness dimensions for a marginal speed gain. The trusted-provenance + concise-audit combination removes your ability to catch the drift that parallel execution makes more likely. |
| **"Maximum frugality"** | Parallel-doer + low-tier Doer + trusted provenance + no toolings | Minimal cost, *maximum* risk. Under-powered Doers running in parallel with no verification and no audit trail — the failure modes compound. |
| **"Maximum founder gate"** | Every transition founder-approved | High founder load, *no* speed gain, and it undermines the [trust anchor](../01-axioms/persistence-law.md) — the founder becomes the persistence layer, which is exactly what CompassAlpha exists to spare them. |

The through-line: each anti-preset stacks loosened settings *multiplicatively*. Any one of those loosenings alone might be a reasonable runtime tune; combined, they dismantle the guardrails that keep the federation honest.

## The line presets cannot cross

Presets and tuning operate on the **performance / cost / risk surface only.** The structural rules — the seven [axioms](../01-axioms/index.md), the [guardrails](../02-guardrails/index.md), the load-bearing invariants — remain fixed across *every* preset and every combination. No preset can toggle the [firewall](../01-axioms/firewall.md), the [hard-labour rule](../01-axioms/hard-labour-rule.md), the [persistence law](../01-axioms/persistence-law.md), the [bus protocol](../01-axioms/bus-protocol.md), or the [provenance law](../01-axioms/provenance-law.md). Tuning changes how fast and how cheap; it never changes what is correct.

## Connections

- Each preset is a bundle of values drawn from the [Tunables](../03-tunables/index.md) surface.
- The runtime portions of a preset follow [Runtime toggle](runtime-toggles.md) timing; the concurrency/cadence portions follow [Cycle toggle](cycle-toggles.md) timing.
- Bootstrap is the on-ramp described in [Getting started](../05-getting-started/index.md).
- For the full per-setting classification behind these bundles, see the [Toggle reference](toggle-reference.md).

---

## Next: [Getting started →](../05-getting-started/index.md)
