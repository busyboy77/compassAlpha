# Full Parameter Matrix

> *Every tunable in one place — five categories, with defaults and ranges. The reference table for the whole customization surface.*

`[TUNABLE]`

## TL;DR

This is the consolidated reference for **every** `[TUNABLE]` parameter in CompassAlpha, grouped into five categories: **project-level**, **axis-level**, **operational**, **cultural**, and **tech-stack**. Each row gives the default and the range. Defaults shown are the conservative defaults (a regulated multi-tenant profile bias: intelligence + low risk). The structural rules ([firewall](../01-axioms/firewall.md), [hard labour](../01-axioms/hard-labour-rule.md), [bus](../01-axioms/bus-protocol.md), [persistence](../01-axioms/persistence-law.md), dual validation) are `[INVARIANT]` and appear here only where a *bounded* sub-choice exists.

## How to read this table

- **Default** = the conservative starting value. Most projects can adopt these wholesale and tune from there.
- **Range** = the legal values. Where a range includes an anti-pattern, it's marked.
- **`[INVARIANT]`** = the parameter's *shape* is fixed; only the named sub-choice is tunable.
- Most adopters touch three or four parameters in their first year. Don't tune everything up front.

## Category 1 — Project-level tunables

Set once at adoption. They establish the federation's identity and physical layout.

| Parameter | Default | Range / notes |
|---|---|---|
| Project name | (your project) | Used in paths, namespaces, branding. |
| Reviewer-state repo | `/path/to/reviewer-state` | Dedicated remote; sibling of substrate. |
| Substrate repo | `/path/to/substrate` | The project being built/governed. |
| Host | (your host) | Where tiers run; determines NO-TMP + flush cadence. |
| AI agent / harness | reference top-tier agent at high effort | Any harness meeting the [3-point contract](ai-model-choices.md). |
| Founder identity | one person | One person, or a small team treated as a single founder-role. |
| Canonical state-artifact count | 5 (boot / ledger / handover-protocol / handover-log / leftovers) | Smaller projects may collapse to 3. |

## Category 2 — Axis-level tunables

Set per axis. Each [axis declaration](axis-declarations.md) fills these in.

| Parameter | Build-axis default | Doctrine-axis default | Range / notes |
|---|---|---|---|
| Axis name | `build` | `doctrine` | Free-text. |
| Mentor-1 name | (project's name) | (project's name) | Generic vocabulary: Mentor-1. |
| Mentor-2 name | (project's name) | (project's name) | Generic vocabulary: Mentor-2. |
| Doer name | (project's name) | (project's name) | Generic vocabulary: Doer. |
| Deliverable type | code | governing document + primitives | Any deliverable. |
| Cycle stages | CP1 → CP2 → CP3 | S1 → S5 | Project-defined ([stage taxonomies](stage-taxonomies.md)). |
| Charter posture | LOCKED | UNLOCKED (amendment only) | LOCKED / UNLOCKED / DECOUPLED. |
| Cycle activator | dispatch trigger | walk + queue depth | Per axis. |
| Ratification pattern | per-module tag | per-entity sub-bump + cycle-end major bump | Per axis. |
| Lanes enabled | all four | Doctrine Cycle + light lanes | Per [work-granularity lanes](work-granularity-lanes.md). |
| Locality | host-of-substrate | host-of-substrate | Override if a tier runs elsewhere. |

## Category 3 — Operational tunables

Tuned per cycle. These are the performance/cost dials that move the [5-axis trade-off](tunables-overview.md) most.

| Parameter | Default | Range | Primary trade |
|---|---|---|---|
| Concurrency mode | Sequential (LAYGO) | LAYGO / Pipelined / Parallel-independent / Parallel-doer | Speed ↑ vs Risk ↑ |
| Mentor-1 lifecycle | per-cycle long-running | per-cycle / per-epoch | Cost ↓ vs Continuity ↓ |
| Mentor-2 lifecycle | fresh-per-event | fresh-per-event / per-dispatch | Cost ↓ vs Pollution ↑ |
| Doer lifecycle | fresh-per-slice | `[INVARIANT]` (fresh-per-turn in Surgical lane) | — |
| Doer effort level | high | high / normal / low | Intelligence ↑ vs Cost ↑ |
| Doer context scope | wide / liberal | wide / narrow / declared-only | Intelligence ↑ vs Cost ↑ |
| Doer model tier | top-tier | top / mid / low | Intelligence ↑ vs Cost ↑ |
| Mentor model tiers | top-tier | top / mid | Intelligence ↑ vs Cost ↓ |
| Provider strategy | single provider | single / mixed | Consistency ↑ vs Integration cost ↑ |
| Provenance verification | strict (cite-by-substrate) | strict / spot-check / trusted | Correctness ↑ vs Speed ↑ |
| Memory accumulation rate | liberal | liberal / conservative | Learning ↑ vs Noise ↑ |
| Memory scope | cross-axis | cross-axis / per-axis | Sharing ↑ vs Boot-read ↓ |
| Memory garbage collection | retire-never (HISTORICAL-mark) | retire-never / major-version retirement | Audit depth ↑ vs Boot-read ↓ |
| Rotation cadence | 2–4 weeks preventive | 1–6 weeks | Pollution ↓ vs Continuity ↑ |
| Deferral-queue depth for cycle activation | ~20–30 soft | 10–50 | Doctrine recency ↑ vs Cycle frequency ↓ |
| Cycle-tail acceptance | strict (all close) | strict / liberal (N-of-M) | Predictability ↑ vs Speed ↑ |
| Audit / digest verbosity | verbose | verbose / concise | Audit depth ↑ vs Cost ↑ |
| Cross-tier visibility | own-folder only | own-only / parent-summary / full (anti-pattern) | Containment ↑ vs Continuity ↓ |
| Invariant count | many (regulated) / minimal (bootstrap) | minimal → many | Intelligence ↑ vs Cost ↑ |
| Invariant enforcement strictness | strict | strict / spot-check / trusted | Correctness ↑ vs Speed ↑ |
| Tooling count + coverage | many (regulated) / minimal (bootstrap) | minimal → many | Catch-rate ↑ vs Upfront cost ↑ |
| Specialised-agent count | several / none | none → many | Per-slice fit ↑ vs Maintenance ↑ |
| NO-TMP rule | ON | ON / OFF (durable /tmp) | Durability ↑ vs Convenience ↓ |
| Flush cadence | every flush trigger pushes | every-trigger / lighter | Durability ↑ vs Push overhead ↓ |

## Category 4 — Cultural tunables

Set by the project's working culture. These shape how the founder relates to the federation.

| Parameter | Default | Range / notes |
|---|---|---|
| Founder role scope | RELAY + lost+found only | Expanding it bloats founder cognitive load; discouraged. |
| Founder involvement level | low (RELAY + lost+found) | low / medium / high — trades cost ↓ vs founder load ↑. |
| Founder-call boundary | charter proposals / scope-shifts / gate-count changes / genuine value-intent | The four-class shape is `[INVARIANT]`; the items in each class are tunable. |
| Lost+found protocol | one-liner ping → founder rules → one-liner ping back | The one-liner mechanism is `[INVARIANT]`. |
| Pacing | LAYGO (one unit at a time, learning expected) | Faster pacing acceptable after first cycle proves the rhythm. |
| Founder team protocol | single founder | single / small-team-as-one-role. |
| UX-vision ownership | founder (de facto UX lead) | The founder's irreducible taste exception — `[INVARIANT]` that it's founder-owned. |

## Category 5 — Tech-stack tunables

Mostly `[INVARIANT]` — git is the bus — with a few genuine choices.

| Parameter | Default | Range / notes |
|---|---|---|
| VCS | git | `[INVARIANT — git is the bus]` |
| Remote service | a hosted git remote | Could be self-hosted; just needs a push-target. |
| Commit discipline | isolated index + `commit-tree` + refspec push | `[INVARIANT — prevents sibling-session contamination]` |
| Worktree mechanism | one isolated worktree per slice | `[INVARIANT — pollution firewall]` |
| AI harness | reference top-tier agent | Must support effort-level, fresh-session-per-slice, deterministic boot. |
| Effort level for Doer | high | high / normal / low (intelligence vs cost). |

## Quick-start: the parameters most adopters actually touch

If you read nothing else, these are the dials with the highest leverage for a new adoption:

1. **Concurrency mode** — LAYGO first; graduate to Pipelined after first close.
2. **Doer model tier + effort** — top-tier/high to start; mid-tier-for-simple-slices to cut cost later.
3. **Enrichment level** (invariants/toolings/agents) — minimal first; earn each addition with the rule-of-three.
4. **Founder involvement** — keep it RELAY + lost+found; resist the urge to expand it.
5. **Lanes enabled** — enable all four, holding Surgical until first close.

Everything else can ride the conservative defaults until a specific pain motivates a change.

## How this connects

- [Tunables overview](tunables-overview.md) — the 5-axis trade-off each operational parameter moves.
- [Operating presets](../04-toggles/operating-presets.md) — named bundles that set many of these rows at once.
- Each parameter's detail page: [axis declarations](axis-declarations.md) · [concurrency modes](concurrency-modes.md) · [context patterns](context-patterns.md) · [AI model choices](ai-model-choices.md) · [work granularity lanes](work-granularity-lanes.md) · [stage taxonomies](stage-taxonomies.md) · [invariants, toolings & agents](invariants-toolings-agents.md) · [memory policy](memory-policy.md).
- [Axioms](../01-axioms/index.md) — the `[INVARIANT]` floor under every row.

---

## Next: [Toggles — the live switches →](../04-toggles/index.md)
