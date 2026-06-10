---
description: "Different tiers can run on different models. The per-tier intelligence-vs-cost dial."
---

# AI Model Choices per Tier

> *Different tiers can run on different models. The per-tier intelligence-vs-cost dial.*

`[TUNABLE — model selection]`

## TL;DR

Each tier can run on a different AI model, traded by cost against intelligence. The conservative default is **top-tier everywhere** — maximum intelligence floor, and consistency as part of the trust anchor. Cost-optimized projects route mid-tier models to lighter work (simple Doer slices, formulaic orchestration) while keeping top-tier where architectural judgment matters. Multi-provider setups are possible but carry real integration cost. CompassAlpha is **protocol-first and tool-agnostic** — it specifies how tiers behave, not which model runs them — so model choice is a genuine dial, not a fixed dependency.

## The dial

The framework names a reference harness (a top-tier coding agent at high effort) but mandates none. Any harness qualifies if it supports three things:

1. An **effort-level setting** (so the Doer can be given the horsepower it needs).
2. **Fresh-session-per-slice** (so the Doer can be disposable per the fresh-per-slice rule).
3. **Deterministic boot from a stamped file** (so a session can be recreated from on-disk state).

Given that contract, the model behind each tier is yours to choose.

## Two sub-dials

Model choice is really two coupled dials:

- **Model tier** — top / mid / low. The raw capability of the model running a tier.
- **Effort level** — how much reasoning budget the harness allocates per turn (e.g. high / normal / low in agent parlance).

The Doer typically runs at the highest effort the harness offers, because it must triangulate across substrate and sibling deliverables. Effort and model tier together set a tier's "IQ" for its work.

## Default — top-tier everywhere

All tiers run on a top-tier model at high effort. Rationale:

- **Maximum intelligence floor** — every tier reasons at full capability.
- **Consistency is part of the trust anchor.** When every tier runs the same model, the founder reasons about one quality bar, not three.
- Simplest to operate — one harness, one set of session semantics.

The trade is cost: top-tier-everywhere is the most expensive configuration in tokens and API spend.

## Cost-optimized configurations

Three patterns shave cost while protecting the intelligence floor where it matters.

### Mid-tier Doer for light slices, top-tier for complex

The Doer's model is chosen **per slice**, based on slice complexity declared in the brief. The orchestrator routes simple slices (a copy change, a bounded layout fix) to a mid-tier model and complex slices (cross-module logic, schema reasoning) to top-tier.

- Saves cost on the many simple slices.
- Preserves intelligence where it actually matters.
- Requires the brief to carry a complexity signal the orchestrator can route on.

### Mid-tier Mentor-2, top-tier Mentor-1

Orchestration is somewhat formulaic — slice composition, tagged-return integration, gate application. A mid-tier model may suffice for the mid mentor, while the top mentor stays top-tier for architectural judgment and ratification.

- Saves cost on the higher-frequency orchestration turns.
- Keeps the irreducible judgment (Mentor-1) at full capability.

### Top-tier everywhere except the Doer

The inverse bias: mentors use top-tier for clean judgment; Doers use mid-tier for raw output, paired with **stricter verification gates** to catch the lower-quality output.

- Cheapest of the cost-optimized patterns (the Doer is the highest-volume tier).
- Only safe if verification is genuinely strict — otherwise mid-tier Doer escapes slip through.

## Multi-provider integration

| Pattern | Cost | Consistency | Integration cost |
|---|---|---|---|
| **Single provider** (default) | baseline | maximum | none — one harness |
| **Mixed providers** (e.g. one vendor for mentors, another for Doers) | possible savings | lower | real — different harnesses, different fresh-session semantics, different effort scales |

Mixed providers can capture cost savings, but the integration cost is genuine: each provider has its own harness, its own session semantics, and its own effort-level scale. **Effort-level translation across providers is an open question** — there is no settled mapping between one vendor's "high effort" and another's. Treat mixed-provider setups as advanced, and only after a single-provider cycle proves the rhythm.

## Trade-off summary

| Configuration | Intelligence | Cost | Consistency | Operational complexity |
|---|---|---|---|---|
| Top-tier everywhere (default) | highest | highest | highest | lowest |
| Mid-tier Doer (simple slices) | high | medium | high | low–medium |
| Mid-tier Mentor-2 | high | medium | high | low |
| Mid-tier Doer + strict gates | medium–high | low | medium | medium |
| Mixed providers | varies | potentially low | lowest | highest |

## Defaults

| Setting | Default | Range |
|---|---|---|
| Doer model tier | top-tier | top / mid / low |
| Doer effort level | high | high / normal / low |
| Mentor-1 model tier | top-tier | top / mid |
| Mentor-2 model tier | top-tier | top / mid |
| Provider strategy | single provider | single / mixed |

## How to choose

1. **First cycle → top-tier everywhere, single provider.** Don't optimize cost before you understand your workload.
2. **If cost is the pain → mid-tier Doer for simple slices.** Highest savings-to-risk ratio; the brief carries the complexity signal.
3. **If orchestration volume is the pain → mid-tier Mentor-2**, keeping Mentor-1 top-tier.
4. **Mid-tier Doer with relaxed gates → never.** If you drop the Doer's model, raise the verification gates to compensate.
5. **Mixed providers → only when single-provider savings are exhausted** and you can absorb the integration cost.

## How this connects

- [Framework, not tool](../00-foundation/framework-not-tool.md) — the protocol-first, tool-agnostic stance that makes model choice a dial.
- [Context patterns](context-patterns.md) — model tier interacts with context depth; a mid-tier Doer with wide context may underperform.
- [Hallucination defense](../02-guardrails/hallucination-defense.md) — stricter verification gates are how you safely run a cheaper Doer.
- [Invariants, toolings & agents](invariants-toolings-agents.md) — specialised agents are model configurations tuned per work type.

---

## Next: [Work granularity lanes →](work-granularity-lanes.md)
