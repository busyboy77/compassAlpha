---
description: "CompassAlpha glossary: Charter, Compass, Invariants, Primitives, axes, the Mentor-1/Mentor-2/Doer tier grammar, bus protocol, GO-UP-BUMP and sub-bump."
---

# Glossary

> Canonical vocabulary. Use these terms exactly. This glossary defines framework-level vocabulary, which applies universally; each adopting project names its own tiers, entities, and stages on top.

## Core vocabulary (framework-level, INVARIANT)

### Annex

The form in which a declared [axis](#axis) attaches to the federation [Charter](#charter): the axis's declaration plus any axis-specific invariants and primitives, registered in the `AXES` manifest. Axes are annexes under the **one** Charter — they never get a competing charter.

### Axis

A parallel work stream in the federation. Each axis has its own tier hierarchy, lifecycle stages, and **Charter posture** (`LOCKED` / `UNLOCKED` / [`DECOUPLED`](#decoupled)), and attaches to the one Charter as an [annex](#annex).

Default axes in CompassAlpha:
- **Build axis** — code-deliverable axis (Phase 3 dispatches)
- **Doctrine axis** — doctrine-deliverable axis (entity dispatches in amendment cycles)

Future axes are extensible: review, ops, AI-training, etc.

### Charter

The federation's **single** master constitutional document — one per federation, the source of truth every tier and human cohort is bound to. Components live under it as [Compasses](#compass); [axes](#axis) attach as [annexes](#annex). Raised by **GO-UP-BUMP** (see [Bump](#bump)). Has a state machine:
- **LOCKED** — read-only; the build axis runs
- **UNLOCKED** — editable; the doctrine axis runs

Axes alternate temporally based on Charter state.

### Bump

**GO-UP-BUMP** raises the federation [Charter](#charter) version (`charter-v<n+1>`) at a doctrine-cycle close — for cross-cutting / charter-level change. A **sub-bump** (`GO-SUB-BUMP`) raises a single [Compass](#compass)/entity version (`sub-v<n+1>-<entity>`) within a cycle. A cohort team releases only against the current chartered Compass; any cross-cutting change must flow through a GO-UP-BUMP, never an ad-hoc release.

### DECOUPLED

A [Charter posture](#axis) for an axis that runs **continuously**, outside the LOCKED↔UNLOCKED alternation. A DECOUPLED axis reads the Charter **read-only**, never locks or blocks it, and may only *request* a Charter amendment through the doctrine axis. Day-2 axes (ops, QA, audit) are typically DECOUPLED.

### Compass

A doctrine document for one component/entity/scope in the project, governed **under the single [Charter](#charter)**. Tiered at three altitudes:
- **60K** — Ideology section: principles, named theses, why-this-domain-matters
- **30K** — Mechanics: state machines, lifecycles, primitives, invariants
- **10K** — Schema + routes + engine + events

Plus auxiliary sections: Grass-root (glossary), Federation Contract (cross-entity), Cross-Compass refs, Open questions.

**Placement:** one per component, under the single [Charter](#charter). **Controls** a component's own doctrine; **loosens** per-component design latitude within the Charter — the flexible, local surface.

### Cycle

A bounded work period on an axis. Build cycles produce code (Phase 3 dispatches). Doctrine cycles produce compass + primitives/invariants amendments.

### Doer

The bottom tier of any axis. The only tier that touches substrate. Fresh-per-slice / fresh-per-invocation. Each axis names its own Doer tier.

### Federation

A complete CompassAlpha installation: a reviewer-state repo, an AI agent harness, a founder, and the tier instances that boot from the doctrine in the reviewer-state repo.

### Founder

The human in the loop. **Relay bus + lost+found backstop**, NOT a per-decision arbiter. The founder's role is deliberately narrow ([→](../03-tunables/full-parameter-matrix.md)).

### Inbox

A subfolder in each tier's home. Receives messages from other tiers via the bus protocol. Path-partitioned multi-writer.

### Invariants

Charter-level rules that must hold **everywhere, always** — the non-negotiables. **Placement:** the federation [Charter](#charter), cross-component. **Controls:** maximal — they lock down what can never break federation-wide and are **not tunable**. **Loosens:** nothing. **Why:** the bedrock of [codebase coherence](codebase-coherence.md). Marked `[INVARIANT]`.

### LIFT-WATCH

Items observed during a doctrine cycle that may warrant **lifting** into Charter-tier primitives or invariants. Candidates for cross-scope promotion at cycle-close.

### Mentor-1 / Mentor-2

The top and middle tiers of any axis. **Orchestrate, never touch substrate.** Each axis names its own Mentor-1 and Mentor-2 tiers.

### Pathology

One of the four predictable failures of multi-agent AI work that CompassAlpha defends against:

1. Context pollution
2. Hallucination drift
3. Role confusion
4. Trust erosion

### Primitives

Charter-level **shared contracts** — the one canonical definition of each shared concept (types, operations, vocabulary) every component reuses. **Placement:** the federation [Charter](#charter). **Controls:** the canonical definition (locked), so no two components re-implement the same concept differently. **Loosens:** a component's internal *use* of a primitive, and the set is **extensible** — new primitives may be proposed and lifted in (see [LIFT-WATCH](#lift-watch)). **Why:** the mechanism of cross-team [coherence](codebase-coherence.md).

### Reviewer-state repo

The dedicated git repository for federation meta-state. Holds judicial folders, doctrine artifacts, memories. **Separate from the substrate repo.**

### §9 (Section Nine)

The doctrine deferral queue. Items surfaced during build cycles but deferred to the next doctrine cycle. Drained at cycle-engage.

### Stamp / Stamping

Writing a tier's identity file (typically `CLAUDE.md`) from a template, filling in slot values. The framework provides templates; you stamp instances for each tier.

### Substrate

The project's actual codebase / doctrine source repo. **Separate from the reviewer-state repo.** The Doer touches substrate; mentors do not.

### Tag

Annotated git tag marking a dispatch close. Immutable. The federation's ratification artifact. Pushed via explicit refspec.

### Tier

A role in an axis's hierarchy. CompassAlpha uses three tiers per axis: Mentor-1, Mentor-2, Doer.

### Persistent-writer pattern *(historical)*

Pre-CompassAlpha pattern: a long-running persistent in-repo AI session as the sole substrate writer. **Now obsolete** — superseded by fresh-per-slice Doer spawns. Kept in glossary for historical reference.

### Trust anchor

The promise that state is on disk + at origin BEFORE it is discussed with the founder. The load-bearing guarantee that lets the founder step back to relay+lost+found mode. See [persistence law](../01-axioms/persistence-law.md).

### Walk

The founder's review of the project state preceding a doctrine cycle. Captures feedback that feeds the cycle's primary input (alongside §9).

---

## Lane vocabulary

### Work Granularity Lanes (4)

The framework supports work at four granularity levels. **All four lanes coexist within the existing axes.**

1. **Doctrine Cycle** — cross-module structural change. Weeks. Charter UNLOCKED → cycle. Tag: `charter-v<X+1>`.
2. **Phase 3** — single-module substantive change. Days-to-weeks. Full Mentor-1→Mentor-2→Doer ceremony. Tag: `<module>-v<x.y>`.
3. **Polish Lane** — bounded behavioral / cosmetic. Hours-to-day. Slim Mentor-2, single-CP. Tag: `polish-<topic>-v<x.y>`.
4. **Surgical Strike** — single-concern, single-file. Minutes-to-hours. Mentor-1→Doer direct (Mentor-2 skipped). No tag.

[→ Work granularity lanes detail](../03-tunables/work-granularity-lanes.md)

---

## Stage vocabulary (example)

Stage names are `[TUNABLE]` per axis. An example stage taxonomy:

### Build axis · Phase 3 stages

```
PRE-STAMP → STAMPED → LAUNCHED →
WIP-CP1 → WIP-CP2 → WIP-CP3 →
CP-FREEZE → GATE-CHECK → GO-TAG → TAGS-APPLIED → CLOSED → FROZEN
```

### Doctrine axis · entity dispatch stages

```
PRE-STAMP → STAMPED → LAUNCHED →
WIP-S1 → WIP-S2a → WIP-S2b → WIP-S3a → WIP-S3b → WIP-S4 → WIP-S5 →
CP-FREEZE → GATE-CHECK → GO-SUB-BUMP → TAGS-APPLIED → STAND-DOWN-ACK → FROZEN
```

### Polish Lane stages

```
BRIEF → ASSIGNED → IMPLEMENTING → SMOKE → COMMIT → DONE
```

### Surgical Strike stages

```
REQUEST → EXECUTE → COMMIT → DONE
```

### Operational micro-states (per-tier, any moment)

```
IDLE · PREPARING · DISPATCHING · TRIAGING · RATIFYING · SURFACING · STANDBY
```

[→ Stage taxonomies detail](../03-tunables/stage-taxonomies.md)

---

## Status Grid vocabulary

### Tier 1 / Tier 2 / Tier 3 grids

Three levels of status grid printing:

- **Tier 1** — canonical 6-line grid. **Mandatory** at session START and END.
- **Tier 2** — categorical with stages (DONE / WIP / QUEUED / LEFTOVER / DROPPED / MISSED / FORGOTTEN). Printed at significant seams.
- **Tier 3** — constitutional-hierarchical with stages. Deep visualization. On-demand.

[→ Status grids detail](../07-reference/status-grids.md)

---

## Operating preset vocabulary

Named bundles of tunable settings. Presets:

- **Conservative** — regulated, doctrine-heavy projects (the default preset)
- **Balanced** — most projects after first cycle
- **Throughput** — mature project, time-pressured
- **Cost-optimized** — smaller project, budget-conscious
- **Risk-averse / regulated** — medical, financial, compliance-critical
- **Research / high-churn** — doctrine churns rapidly
- **Bootstrap / first-cycle** — brand-new CompassAlpha adoption

[→ Operating presets detail](../04-toggles/operating-presets.md)

---

## Project-specific vocabulary

Each adopting project chooses its own tier role names and entity-naming convention; the framework only requires the tier positions (Mentor-1 / Mentor-2 / Doer per axis). A project might use thinker names for architect-named modules and functional names for domain modules, or any other convention it prefers.

---

## Tag vocabulary

### Per-dispatch tags

| Tag pattern | What it marks | Axis |
|---|---|---|
| `<module>-v<x.y>` | Phase 3 build dispatch close | Build |
| `arch-<entity>-v<x.y>` | Doctrine entity dispatch close | Doctrine |
| `sub-v<X+1>-<entity>` | Per-entity sub-bump (Mentor-1-issued) | Doctrine |
| `polish-<topic>-v<x.y>` | Polish Lane close | Build |

### Per-cycle tags

| Tag pattern | What it marks |
|---|---|
| `charter-v<X+1>` | Doctrine cycle close + Charter re-lock |

---

## Hierarchy-edge tags (the wire format)

Inbox files and paste-ready blocks carry tags identifying sender → recipient + scope:

- `[[MENTOR-1→MENTOR-2 · <scope>]] … [[/MENTOR-1→MENTOR-2]]` (down)
- `[[MENTOR-2→MENTOR-1 · <scope> · <status>]]` (up)
- `[[MENTOR-2→DOER · <scope>/<slice>]]` / `[[DOER→MENTOR-2 · <scope>/<slice>]]`
- Cross-axis: `[[<AXIS_A>→<AXIS_B>]]`

[→ Hierarchy tags detail](../07-reference/hierarchy-tags.md)

---

## Marker discipline

Every inbox file content opens with `[[<sender>→<recipient> · <scope> · <event>]]` and closes with the matching `[[/<sender>→<recipient> · ...]]` tag. **Tag-gated ingestion**: a tier consumes a block only if its edge terminates at that tier.

This is the framework's structural defense against misrouting.

---

## Annotated [INVARIANT] / [TUNABLE] / [OPEN] / [CANDIDATE]

Throughout the portal:

- `[INVARIANT]` — cannot be modified without forking the framework
- `[TUNABLE]` — adjustable per-project; default provided
- `[OPEN]` — known question, not yet resolved in the framework
- `[CANDIDATE]` — proposed for ratification at a specific future cycle

If you see one of these markers, you're at a decision or known-gap point.

---

## Next: [01 Axioms →](../01-axioms/)
