# Axis Declarations — defining your own work axes

> *An axis is a thin declaration: four fields + three tier roles. Everything substantive is inherited from the master.*

`[TUNABLE]`

## TL;DR

A CompassAlpha federation is structured by **inheritance**: one master protocol holds every substantive rule, and each **work axis** is a thin declaration that names its tiers and a handful of settings, then inherits everything else. The default federation ships with two axes — **build** (produces code) and **doctrine** (produces governing documents). Adding a third axis (review, ops, AI-training, pen-test, …) is mechanical: name three tier roles, fill the declaration template, inherit the rest. You author no parallel rule sections. This page is the customization surface for declaring axes.

## The dial

Most projects start with one axis (`build`) and add a second (`doctrine`) once the rhythm is proven. Some never need more than one. Some grow to four. The dial is **how many axes you declare and what each one produces** — every axis inherits the same firewall, bus, hard-labour, and persistence rules from the master, so the marginal cost of an axis is a declaration, not a rewrite.

## The inheritance model

```
                        MASTER PROTOCOL
                 (every substantive rule, once)
                              ▼
            ┌─────────────────┼─────────────────┐
            ▼                 ▼                 ▼
        BUILD AXIS       DOCTRINE AXIS      FUTURE AXIS
       (declaration)    (declaration)     (declaration)
```

The master holds each rule **once, axis-agnostic**, with tier-variable substitution. When a rule changes, it changes in the master; every axis picks it up automatically. When you add an axis, the master is unchanged — the new axis is a new declaration file.

**Why inheritance, not duplication.** Parallel per-axis rule sections produce three costs: duplication (the same firewall stated twice with role names swapped), update burden (every refinement touches both copies), and cognitive load (which section applies?). Inheritance collapses all three.

## The declaration template

Each axis declares — explicitly, in writing — these fields. Everything else is inherited.

```
AXIS NAME:               <e.g. "build", "doctrine", "review", "ops">
PURPOSE:                 <one-paragraph summary of what this axis produces>
TIER ROLE NAMES:
  Mentor-1:              <name>      ← ratifies completion; surfaces founder-calls
  Mentor-2:              <name>      ← orchestrates one unit of work; slices for the Doer
  Doer:                  <name>      ← the only tier that touches substrate
DELIVERABLE TYPE:        <e.g. "code", "governing document + primitives", "audit findings">
CYCLE GRANULARITY:       <unit of work + stage sequence>
                         <e.g. "module dispatch · CP1 → CP2 → CP3 → close">
                         <e.g. "entity dispatch · S1 → S2a → S2b → S3a → S3b → S4 → S5 → close">
CHARTER POSTURE:         <LOCKED | UNLOCKED | DECOUPLED>
CYCLE ACTIVATOR:         <what fires a new cycle on this axis>
RATIFICATION PATTERN:    <per-dispatch sub-bump / per-unit sub-bump / cycle-end major bump>
LOCALITY:                <where each tier physically lives — host, paths>
                         (defaults to host-of-substrate; override if needed)
```

## The five declarable dimensions

These are the choices an axis declaration actually makes. The first four are the load-bearing ones; locality is a deployment detail.

### 1. Deliverable type

What the axis produces. Code, a governing document, audit findings, a test plan, a migration script. The deliverable type determines the axis's exit-gate definition (what "complete" means) and whether the document-structure doctrine (the 60K/30K/10K tiering) applies.

### 2. Cycle granularity

The unit of work plus its stage sequence. A build axis works in **module dispatches** with `CP1 → CP2 → CP3`. A doctrine axis works in **entity dispatches** with `S1 → S2a → S2b → S3a → S3b → S4 → S5`. The granularity sets what a single dispatch covers and how its lifecycle is staged. See [Stage taxonomies](stage-taxonomies.md) for the full vocabulary.

### 3. Charter posture

Whether the axis runs while the Charter is `LOCKED`, `UNLOCKED`, or is `DECOUPLED` from Charter state entirely.

- **LOCKED** — runs only while the Charter is locked (the build axis: code is written against stable doctrine).
- **UNLOCKED** — runs only during an amendment epoch (the doctrine axis: it *is* the amendment).
- **DECOUPLED** — runs independently of Charter state, **continuously**, never entering the LOCKED↔UNLOCKED alternation. It consumes the Charter **read-only**, never locks or blocks it, and may only *request* a Charter amendment through the doctrine axis. (A Day-2 review / audit / ops axis.)

LOCKED and UNLOCKED axes **alternate** — they do not run concurrently, because that would race the amendment (Charter primitives could change mid-build). DECOUPLED axes may run alongside whatever is active, with the rule that they do not gate the main axes.

### 4. Cycle activator

What fires a new cycle on this axis. The build axis is fired by a module dispatch trigger (founder-initiated). The doctrine axis is fired by a founder **walk** plus sufficient deferral-queue depth. A review axis might be fired on a schedule or on a release tag.

### 5. Lanes (work granularity)

Which of the [four work-granularity lanes](work-granularity-lanes.md) the axis enables — Doctrine Cycle, Phase 3, Polish, Surgical Strike. Most axes host the heavier lanes; the build axis additionally hosts the light lanes (Polish, Surgical) for day-to-day requests. Lane availability is a per-preset tunable.

## The two reference axes

| Field | Build axis | Doctrine axis |
|---|---|---|
| Deliverable type | code | governing document + primitives/invariants |
| Tier roles (generic) | Mentor-1 / Mentor-2 / Doer | Mentor-1 / Mentor-2 / Doer |
| Cycle granularity | module dispatch · CP1 → CP2 → CP3 | entity dispatch · S1 → S5 |
| Charter posture | LOCKED | UNLOCKED (amendment epoch only) |
| Cycle activator | module dispatch trigger | walk + deferral-queue depth |
| Ratification | per-module tag (`<module>-v<x.y>`) | per-entity sub-bump + cycle-end major bump |

The generic tier vocabulary is **Mentor-1 / Mentor-2 / Doer**. Each axis is free to give its tiers project-specific names; the rules always speak in the generic vocabulary and each reader substitutes their own.

## Adding a third axis (worked sketch)

Suppose you want a **review axis** that audits closed modules:

```
AXIS NAME:            review
PURPOSE:              Independent audit of closed build-axis modules against
                      declared invariants; produces findings, not fixes.
TIER ROLE NAMES:
  Mentor-1:           Audit-Lead
  Mentor-2:           Audit-Orchestrator
  Doer:               Auditor
DELIVERABLE TYPE:     audit findings (report + finding tally)
CYCLE GRANULARITY:    module-audit dispatch · RECON → CHECK → REPORT → close
CHARTER POSTURE:      DECOUPLED (audits don't gate build/doctrine alternation)
CYCLE ACTIVATOR:      a module reaches FROZEN on the build axis
RATIFICATION PATTERN: per-audit tag (audit-<module>-v<x.y>)
LOCALITY:             host-of-substrate (default)
```

That declaration is the entire axis. The firewall, bus protocol, hard-labour rule, persistence law, dual validation, status grids, and flush triggers all apply automatically by inheritance.

## Incorporating an axis (the gate)

Adding an axis is cheap, but it is **recorded** — a small, deliberate act, not an ad-hoc spawn:

1. **Declare** — author the declaration above (the fields + three tier roles).
2. **Review** — the founder and the doctrine axis's Mentor-1 review the declaration at a **cycle seam** (never mid-cycle): it must violate no axiom, and if `DECOUPLED`, it must gate nothing.
3. **Register** — record the axis in the federation's **`AXES` manifest** (the list of every declared axis + its declaration), committed to the reviewer-state repo. The axis becomes an **annex under the one Charter** — see [the doctrine substrate](../00-foundation/constitution.md#the-doctrine-substrate-charter-compasses-and-axis-annexes).

Because incorporation is **additive and read-only against existing state**, a new axis (axis-N) can be added at **any stage of a running project** without disturbing in-flight work — the integrity of the current state is preserved. A `DECOUPLED` axis can begin immediately; a `LOCKED` / `UNLOCKED` axis takes its turn in the alternation.

## Defaults

| Setting | Default | Notes |
|---|---|---|
| Number of axes at adoption | 1 (`build`) | Add `doctrine` once rhythm is proven. |
| Generic tier vocabulary | Mentor-1 / Mentor-2 / Doer | Always 3 tiers; names are tunable per axis. |
| Charter posture for first axis | LOCKED | Build against stable doctrine. |
| Locality | host-of-substrate | Override only if a tier must run elsewhere. |

## How to choose

- **Start with one axis.** Don't declare axes you won't run in your first cycle.
- **Add the doctrine axis when** deferred structural changes accumulate faster than a single build axis can absorb them.
- **Add a DECOUPLED axis when** you need work that shouldn't gate the main alternation (independent audit, ops, security review).
- **Keep tier counts at three.** Two under-contains pollution; four multiplies relay surface for marginal benefit. (This part is `[INVARIANT]` — see [Tier grammar](../01-axioms/tier-grammar.md).)

## How this connects

- [Tier grammar](../01-axioms/tier-grammar.md) (axiom) fixes the three-tier structure every axis inherits.
- [Stage taxonomies](stage-taxonomies.md) is where an axis declares its cycle-stage vocabulary.
- [Work granularity lanes](work-granularity-lanes.md) is where an axis declares which lanes it enables.
- The [full parameter matrix](full-parameter-matrix.md) lists the axis-level tunables alongside project, operational, cultural, and tech-stack ones.

---

## Next: [Concurrency modes →](concurrency-modes.md)
