# Brief Completeness

> *No placeholders cross the relay boundary. The dispatching tier knows its dispatch's actuals; the doer does not — so the dispatcher fills them, every one, with concrete values.*

`[INVARIANT]`

## TL;DR

A **brief** is the package a dispatching tier hands down — Mentor-1 → Mentor-2, or Mentor-2 → Doer. The completeness rule says every operational precondition in that brief must be filled with a **concrete value** at the moment of relay: never a `<placeholder>`, never "founder provides at boot," never "create per convention" left to the receiver's judgment. The dispatching tier is the only party that *knows* the dispatch's actuals; the doer cannot reconstruct them. An incomplete brief is therefore not a small omission — it is a forced choice between two failures: the doer stalls, or the doer **improvises authority it was never given**.

## The rule

Every dispatch brief MUST be complete at relay. "Complete" means all operational preconditions are filled with concrete values:

- the **dispatch branch** (the actual branch name, not a pattern to be guessed),
- the **base HEAD / commit** the work starts from,
- the **index-file path** for the session's staging,
- the **exit tag** the deliverable will be sealed under,
- the **commit-discipline parameters** (how to commit, where to push).

Three sub-rules keep it honest:

1. **No founder-fills.** "Founder provides at boot" is *not* acceptable for an operational precondition. The founder is a relay bus, not a brief-filler — pushing a blank up to the founder violates their narrow role.
2. **Doer escalation duty.** An unfilled load-bearing field triggers an escalation back to the dispatching tier — `[[DOER→MENTOR-2 · <slice> · BRIEF-INCOMPLETE]]` — and **never** an improvisation. "Create per convention" by the Doer is forbidden unless the brief explicitly grants that authority in writing.
3. **Conventions named, not implied.** A brief MAY reference a standing convention instead of repeating it — *"branch per build-axis convention `feature/<module>-phase3-<vx.y>`"* — but the convention must be **named**. An implied convention is a placeholder wearing a disguise.

## What violating it looks like

### Example 1 — The placeholder that became a wrong branch

A Mentor-2 dispatches a Billing slice with the brief field `dispatch branch: <fill at boot>`. The Doer, eager to start, creates `feature/billing` — a plausible guess.

Reality: the dispatch was meant to target `feature/billing-phase3-v0.4`, which already had two prior slices on it. The Doer's work lands on an orphan branch, invisible to integration, discovered only at exit-gate when the deliverable can't be found where the orchestrator expects it.

### Example 2 — The founder-fill that erodes the narrow role

A brief reaches the Doer with `base HEAD: founder provides`. The Doer, blocked, asks the founder. The founder — who is supposed to be relaying, not filling briefs — now has to go find the right commit, becoming the persistence-and-dispatch layer the framework exists to spare them. One blank field quietly pulled the founder back into the machinery.

### Example 3 — "Per convention" with no convention named

A Reporting brief says `exit tag: per convention`. There are two plausible tagging conventions in play. The Doer picks one; the orchestrator expected the other. The deliverable is sealed under a tag nobody is watching, and the close-gate stalls while the mismatch is untangled.

## What a complete brief contains

A complete brief leaves nothing load-bearing to the receiver's discretion. Concretely:

| Field | Bad (incomplete) | Good (complete) |
|---|---|---|
| Dispatch branch | `<fill at boot>` | `feature/billing-phase3-v0.4` |
| Base HEAD / commit | "founder provides" | `a1b2c3d` (or `billing-v0.3` tag) |
| Index-file path | implied | `.work-tmp/billing/slice-2/index` |
| Exit tag | "per convention" | `billing-v0.4-slice2` |
| Commit discipline | "the usual" | `commit-tree from isolated index; push origin feature/billing-phase3-v0.4` |
| Scope / done-definition | "do the Billing thing" | the exact slice boundary + the four exit gates |
| Authority granted | silent | explicit: e.g. "you MAY create the exit tag; you may NOT widen scope" |

Two tests for completeness before relay:

- **The handoff test.** Could a *fresh* Doer session, reading only this brief and the named conventions, begin work without asking a single load-bearing question? If not, the brief is incomplete.
- **The authority test.** Does every action the brief expects appear either as a concrete instruction or as an explicitly granted authority? Anything the Doer would have to *assume* it is allowed to do is a missing grant.

!!! note "Completeness is the relay boundary's contract"
    The relay boundary exists so that the founder can hand off without supervising. That only works if each handoff is self-sufficient. A complete brief is the price of the founder's narrow role: every blank in a brief is a future interruption to the founder or a future improvisation by a doer — and both are the federation reaching back up for the human it was meant to free.

## Detection and recovery

**Detection.** Scan outbound briefs for any field containing a `<placeholder>`, the words "founder provides," "per convention" without a named convention, or "the usual." Each is a completeness defect. On the receiving side, the Doer's first act on any brief is a completeness check — an unfilled load-bearing field is caught *before* work starts, not after.

**Recovery.** The Doer escalates — `[[DOER→MENTOR-2 · <slice> · BRIEF-INCOMPLETE]]` — naming the missing field, and waits. It does **not** improvise. The dispatching tier fills the actual value (which it knows and the Doer does not) and re-relays the corrected brief. If a Doer already improvised before the check, treat the improvised artifact as suspect: verify its branch, base, and tag against what the brief *should* have said, and re-home it if it landed wrong.

## How this connects to other axioms and guardrails

- **[Tier grammar](../01-axioms/tier-grammar.md)** establishes the dispatcher/doer relationship; completeness is the contract on the message between them.
- **[Bus protocol](../01-axioms/bus-protocol.md)** carries the brief and the `BRIEF-INCOMPLETE` escalation; the edge tags are how an incomplete brief is bounced.
- **[Provenance law](../01-axioms/provenance-law.md)** applies the same "concrete value, not recall" principle to claims that this rule applies to brief fields.
- **[Failure modes §brief-incomplete improvisation](failure-modes.md#brief-incomplete-improvisation)** records this as a named failure class with its recovery.

---

## Next: [Single-Live-Writer →](single-live-writer.md)
