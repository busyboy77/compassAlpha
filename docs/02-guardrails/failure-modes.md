# Failure Modes + Recovery

> *The known ways a federation breaks — each with its symptom and its recovery. If a failure isn't on this list, it's a gap in the framework, not just bad luck.*

`[INVARIANT — these are the known failure classes]`

## TL;DR

CompassAlpha enumerates the failure classes a multi-tier AI federation actually hits and pins a recovery to each: **power-down**, **rotation mid-flight**, **firewall leak**, **delegated-context pollution**, **AI memory drift**, and **brief-incomplete improvisation**. The list is a contract — naming a failure mode is committing to a deterministic recovery for it. A federation that hits a failure *not* on this list has found a framework gap worth reporting; a federation that hits one *on* it should already know exactly what to do.

## Why an explicit failure list

Most AI-collaboration setups treat failures as surprises and recover by improvisation — which means recovery quality depends on who is at the keyboard and how alert they are. CompassAlpha treats failures as a finite, enumerated set with rehearsed recoveries, for the same reason aviation uses checklists: the moment you need the recovery is the moment you are least able to invent one. Each class below is **symptom → recovery**, written so a fresh session can execute the recovery from disk alone.

## The failure classes

### Power-down

**Symptom.** A running session is killed mid-turn (host cycles, process dies). In-memory context is lost; any uncommitted in-flight work is lost with it.

**Recovery.** A fresh session pulls the state-of-record repo — the last pushed commit is the source of truth — reads its own folder and inbox, and resumes from the last clean checkpoint (or reconciles and continues). **Loss is bounded to the current in-flight turn**, and only if the flush=push cadence was honored. This is exactly what the [persistence law](../01-axioms/persistence-law.md) buys: frequent small commits mean a power-down is a shrug, not a catastrophe.

### Rotation mid-flight

**Symptom.** A mentor fatigues mid-cycle and must rotate while in-flight sub-tier dispatches exist. Naïve rotation would either lose the cycle's state or strand the running dispatches.

**Recovery.** The outgoing tier emits its END certification and pushes. The incoming tier pulls, runs T0 boot-integrity (including a sync check against origin), self-administers the Layer-B grounding battery from `LEDGER.md`, surfaces at least one original (non-parroted) observation, and obtains the outgoing tier's countersign. Only then does jurisdiction transfer. In-flight sub-tier dispatches simply continue under the new holder — they never had to know the parent rotated, because the firewall kept them decoupled.

### Firewall leak (stale snapshot treated as live)

**Symptom.** A mentor's notes name a sub-tier WIP that has long since moved on; the mentor makes decisions on, or reports, a stale view as if it were current.

**Recovery.** Apply the state-tracking-scope rule: every "current WIP" note is stamped `as of <return-date>`, never `live`. Forensic-descend to re-verify before acting. Re-anchor decisions made against the stale value. Full treatment in [Stale-snapshot detection](stale-snapshot-detection.md).

### HYBRID DELEGATED context pollution

**Symptom.** Sub-agent *isolation* turns out to be insufficient — a delegated sub-agent's full return passes back through the parent's context on retrieval, polluting the parent that was supposed to stay clean.

**Recovery.** Use **pure RELAY**: separate sessions, handing off by paste-relay or bus-mediated inbox. Sub-agent spawning at mentor tiers is not used *unless* (a) recursive sub-agent spawning is available **and** (b) sub-agent returns are summarized at a separate tier before they reach the parent. The containment is topological — see [Pollution containment](pollution-containment.md).

### Doer/consultant false-positive (AI memory drift)

**Symptom.** A tier's recall about historical artifact state is wrong, and the work proceeds treating the false-positive as truth.

**Recovery.** Verify every institutional-memory recall against substrate cycle-tip tags **before** accepting it. The [provenance law](../01-axioms/provenance-law.md) is the structural defense; the operational procedure is in [Hallucination defense](hallucination-defense.md).

### Brief-incomplete improvisation

**Symptom.** A Doer receives a brief with unfilled operational preconditions (missing branch, base HEAD, index path, exit tag) and *improvises* the missing values instead of escalating.

**Recovery.** Enforce the brief-completeness rule plus the Doer escalation duty: improvising is forbidden; the brief MUST be complete at relay, and an incomplete field triggers an escalation back to the dispatching tier. Full treatment in [Brief completeness](brief-completeness.md).

## Recovery at a glance

| Failure class | Pathology served | One-line recovery |
|---|---|---|
| Power-down | Trust erosion | Fresh session pulls last push; resume from clean checkpoint; loss ≤ one turn. |
| Rotation mid-flight | Role confusion | END-cert + push, then Layer-B grounding + countersign before jurisdiction transfers. |
| Firewall leak | Hallucination drift | Stamp `as of <date>`; forensic-descend before acting. |
| Delegated pollution | Context pollution | Pure RELAY; summarize at a separate tier before the parent sees it. |
| AI memory drift | Hallucination drift | Verify recall against substrate tags before accepting it. |
| Brief-incomplete | Role confusion / trust erosion | Forbid improvisation; escalate the unfilled field back to the dispatcher. |

!!! note "The list is a living contract"
    These are the *known* classes as of v0.1. The framework's commitment is that each has a deterministic recovery — and that any failure encountered in the field which is *not* reducible to one of these is treated as a discovery, documented, and folded into a future revision. The goal is a federation where "what do we do now?" always has a pre-written answer.

## How this connects to other axioms and guardrails

- **[Persistence law](../01-axioms/persistence-law.md)** is what bounds power-down loss and makes mid-flight rotation safe — every recovery here assumes state is durable on origin.
- **[Firewall](../01-axioms/firewall.md)** is what lets in-flight dispatches survive a parent rotation untouched, and is the axiom the firewall-leak class defends.
- **[Stale-snapshot detection](stale-snapshot-detection.md)**, **[Hallucination defense](hallucination-defense.md)**, **[Pollution containment](pollution-containment.md)**, and **[Brief completeness](brief-completeness.md)** each expand one row of the table above into its full treatment.

---

## Next: [Brief Completeness →](brief-completeness.md)
