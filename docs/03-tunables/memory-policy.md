# Memory Policy

> *What carries forward across cycles, how fast it accumulates, and what (if anything) ever retires.*

`[TUNABLE — memory content + accumulation rate; INVARIANT — append-mostly, never silently deleted]`

## TL;DR

**Memories** are durable, cross-cycle, cross-axis learnings — discrete files that every tier reads at boot, so a future tier inherits a lesson without re-learning it. Memory is **append-mostly**: superseded memories are marked HISTORICAL, never silently deleted (`[INVARIANT]`). What's tunable is the **accumulation rate** (how readily you capture a memory), the **scope** (cross-axis vs per-axis), and the **garbage-collection policy** (whether anything ever fully retires at major-version boundaries). The conservative default is **liberal capture + cross-axis scope + retire-never (HISTORICAL-mark only)**. The trade is learning speed against memory-noise.

## The dial

Memory is how the federation gets smarter across rotations and cycles. The dials control how fast that knowledge grows and how it's pruned. Capturing too eagerly buries signal in noise; capturing too rarely forces future tiers to re-learn lessons the federation already paid for once.

## What a memory is

A memory is a single file, named for what it teaches (kebab-case), stored in the reviewer-state repo's `memory/` folder and indexed in `MEMORY.md`. Every tier on every axis reads them at boot. To qualify, a learning must be:

- **Incident-derived** — it emerged from a real event, not abstract theorizing.
- **Forward-binding** — it applies across cycle rotations, so a future tier inherits it.
- **Atomic** — one file per memory; cross-references use `[[memory-name]]` link syntax.

Memories differ from the [enrichment surfaces](invariants-toolings-agents.md): an invariant is *enforced*, a tooling *automates*, an agent *specializes* — a memory simply *informs*. A memory may later graduate into an invariant or tooling if the pattern proves load-bearing enough.

## What carries forward across cycles

Not everything survives a cycle. The memory layer is specifically the **durable, cross-cycle** knowledge — distinct from per-cycle judicial state that's archived at close:

| Artifact | Lifespan | Carries to next cycle? |
|---|---|---|
| Memories (`memory/*.md`) | durable | **Yes** — read at every boot. |
| Project invariants | durable (locked-per-cycle or rolling) | Yes — part of the Charter. |
| Toolings + specialised agents | durable | Yes — maintained across cycles. |
| Per-dispatch judicial folders | per-dispatch | No — archived FROZEN at close. |
| Doer worktree scratch | per-slice | No — discarded at slice close. |
| Deferral queue items | until triaged | Carried until a doctrine cycle resolves them. |

This is the inheritance boundary: memories + invariants + toolings + agents form the federation's accumulating intelligence; everything else is cycle-local and archived.

## The accumulation-rate dial

- **Liberal** (default). Capture a memory for every meaningful learning. The federation matures fast; the file count grows, and so does the boot-read cost.
- **Conservative**. Capture only patterns proven across two or more incidents. Less noise; slower maturation.

**The trade:** learning speed (liberal) versus memory-noise and boot cost (conservative). Liberal suits a federation early in its life that's actively discovering its patterns; conservative suits a mature federation where the high-value lessons are already captured and new captures are mostly noise.

## The scope dial

- **Cross-cycle + cross-axis** (default). One memory pool; every tier on every axis reads all of it. Maximum knowledge sharing.
- **Per-axis** (alternative). Memories scoped to an axis; build-axis tiers read build memories, doctrine-axis tiers read doctrine memories. Less cross-pollination; smaller boot reads per tier.

Cross-axis is the default because most hard-won lessons (e.g. about provenance, stale snapshots, brief completeness) apply regardless of axis. Per-axis scoping makes sense only when a project's axes are genuinely disjoint in their failure modes.

## The garbage-collection dial (memory hygiene)

This is where the `[INVARIANT]` floor sits. Memory is **append-mostly**:

- **Superseded memories are marked HISTORICAL** — in their own content and in the index — and **kept for audit**. They are never silently deleted. `[INVARIANT]`
- New memories land via the same commit-and-push cadence as all other state.

What's tunable is whether anything ever **fully retires**:

| Policy | Behavior | Trade |
|---|---|---|
| **Retire-never** (default) | Everything kept forever; superseded items marked HISTORICAL. | Complete audit trail; growing boot-read cost over years. |
| **Major-version retirement** | At a major version boundary, HISTORICAL memories may be moved to a cold archive (still in git history, out of the boot-read set). | Smaller boot reads; audit trail preserved in git history but not in the live index. |

Even under major-version retirement, nothing is *deleted* — it moves out of the live read-set into git history. The append-mostly invariant means the lesson is always recoverable; garbage collection is about boot-read economy, not erasure.

## Defaults

| Dial | Default | Range |
|---|---|---|
| Accumulation rate | liberal | liberal / conservative |
| Scope | cross-cycle + cross-axis | cross-axis / per-axis |
| Garbage collection | retire-never (HISTORICAL-mark) | retire-never / major-version retirement |
| Deletion | never (append-mostly) | `[INVARIANT]` |

## How to choose

- **New federation → liberal capture.** You're discovering your patterns; capture them. Costs little when the pool is small.
- **Mature federation → consider conservative.** Once the high-value lessons are captured, raise the bar to two-incident-proven to keep noise down.
- **Cross-axis unless your axes have genuinely disjoint failure modes.** Most lessons transfer.
- **Retire-never until boot reads get heavy** (multi-year federations). Then adopt major-version retirement — move HISTORICAL items to cold archive, never delete.
- **A memory that recurs as a correctness need → graduate it** into an invariant or tooling per the [enrichment rule-of-three](invariants-toolings-agents.md).

## How this connects

- [Persistence law](../01-axioms/persistence-law.md) (axiom) — memories flush under the same commit-and-push cadence as all state.
- [Context patterns](context-patterns.md) — accumulation rate is also a context dial (boot-read cost).
- [Invariants, toolings & agents](invariants-toolings-agents.md) — a recurring memory may graduate into a durable enrichment artifact.
- [Provenance law](../01-axioms/provenance-law.md) (axiom) — a memory is *informational*, never authoritative over substrate; recall is verified against the substrate before action.

---

## Next: [Full parameter matrix →](full-parameter-matrix.md)
