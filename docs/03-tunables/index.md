# 03 · Tunables (the customization surface)

> *Everything in [Axioms](../01-axioms/index.md) and [Guardrails](../02-guardrails/index.md) is `[INVARIANT]`. Everything here is `[TUNABLE]` — the dials a project sets when it adopts CompassAlpha.*

`[TUNABLE]`

## What "tunable" means

CompassAlpha separates its surface into two halves:

- **`[INVARIANT]`** — the load-bearing rules ([firewall](../01-axioms/firewall.md), [hard labour](../01-axioms/hard-labour-rule.md), [bus protocol](../01-axioms/bus-protocol.md), [persistence law](../01-axioms/persistence-law.md), dual validation). These cannot be changed without forking the framework. They are structural correctness.
- **`[TUNABLE]`** — the performance/cost surface. Concurrency, context depth, model choice, work granularity, enrichment investment, memory rate. Each project sets these to fit its risk profile, budget, and maturity.

**Tuning operates only on the performance/cost surface — never on structural correctness.** A "speed-up" that violates the firewall isn't a faster federation; it's a different (more polluted) one. Whenever you read a tunable page, the invariants are still in force behind it.

## The 5-axis trade-off

Every tunable moves the federation along five axes that are **in tension**:

| Axis | What it measures |
|---|---|
| **Speed** | Wall-clock time from cycle activation to deliverable. |
| **Intelligence** | Depth, correctness, coverage — the federation's "IQ floor." |
| **Cost** | Compute (tokens, API calls) + founder cognitive load + maintenance burden. |
| **Risk** | Chance of pollution, hallucination, drift, replay, or stale-snapshot decisions. |
| **Predictability** | How accurately cycle duration and deliverable scope can be estimated up front. |

**No combination optimizes all five.** Push speed up and risk tends up + intelligence down. Push intelligence up and cost tends up + speed down. Push cost down and founder load or risk tends up. See [Overview](tunables-overview.md) for the full geometry.

## The pages in this section

| Page | The dial it covers |
|---|---|
| [Overview — the 5-axis trade-off](tunables-overview.md) | The tension space; why no combo wins everywhere. |
| [Axis declarations](axis-declarations.md) | Defining your own work axes (the 4-field + 3-role declaration). |
| [Concurrency modes](concurrency-modes.md) | Sequential / pipelined / parallel-independent / parallel-doer. |
| [Context patterns](context-patterns.md) | Mentor lifecycle, doer scope, cross-tier visibility, memory rate, digest verbosity. |
| [AI model choices](ai-model-choices.md) | Per-tier model selection; single vs mixed providers. |
| [Work granularity lanes](work-granularity-lanes.md) | The four lanes — matching ceremony to change size. |
| [Stage taxonomies](stage-taxonomies.md) | Per-axis lifecycle vocabularies used by status grids. |
| [Invariants, toolings & agents](invariants-toolings-agents.md) | The three enrichment surfaces; intelligence ↔ cost compounding. |
| [Memory policy](memory-policy.md) | What carries forward across cycles; inheritance + garbage collection. |
| [Full parameter matrix](full-parameter-matrix.md) | Every tunable in one table, with defaults and ranges. |

## Five categories of tunable

The [full matrix](full-parameter-matrix.md) groups every dial into five categories. Knowing the categories helps you reason about which decisions are one-time setup versus ongoing per-cycle choices:

1. **Project-level** — name, repos, host, agent harness, founder identity. Set once at adoption.
2. **Axis-level** — per-axis tier names, deliverable type, cycle stages, Charter posture. Set per axis.
3. **Operational** — concurrency mode, lifecycle, effort, provenance strictness, rotation cadence. Tuned per cycle.
4. **Cultural** — founder role scope, founder-call boundary, pacing. Set by the project's working culture.
5. **Tech-stack** — VCS, remote, commit discipline, worktree mechanism. Mostly invariant; a few choices.

## How to start

Most adopters do **not** tune individually. They pick a named **operating preset** (Conservative, Balanced, Throughput, Cost-optimized, Risk-averse, Research, Bootstrap) and adjust from there. Presets live in [Toggles → Operating presets](../04-toggles/operating-presets.md); the parameters each preset sets are documented across this section.

If you are brand new, start with **Bootstrap** (LAYGO concurrency, top-tier everywhere, minimal enrichment) and graduate as your first cycle proves the rhythm.

---

## Next: [Overview — the 5-axis trade-off →](tunables-overview.md)
