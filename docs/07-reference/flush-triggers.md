---
description: "The exhaustive list of moments when state must go to disk + origin. If you hit a trigger, you flush before you do anything else."
---

# Flush triggers T0–T7

> *The exhaustive list of moments when state must go to disk + origin. If you hit a trigger, you flush before you do anything else.*

`[INVARIANT]`

A **flush** is the [persistence law](../01-axioms/persistence-law.md) in action: write + commit + push + read-back. The flush triggers are the named moments at which a flush is mandatory. They exist so that "when should I persist?" is never a judgment call — it's a lookup. Every trigger has a number (`T#`) used in [status grids](status-grids.md) (`NEXT` line) and in operational reasoning ("relay the GO — that's a T1").

!!! note "Flush ≠ file-write"
    On hosts with abrupt power-down risk, a flush is `git commit + push` to the state-of-record remote, then a read-back from disk. A write that has not been pushed-and-read-back is **not flushed**. See the [persistence law](../01-axioms/persistence-law.md).

---

## The table

| # | Trigger | Fires when | Required action |
|---|---|---|---|
| **T0** | **Boot** | A tier session starts | Read all canonical state artifacts; verify their mutual consistency; print the START [status grid](status-grids.md); run the sync check (local == origin). Any mismatch with disk = drift → halt and reconcile. |
| **T0e** | **Session end / standby-into-cutover** | A tier ends its turn or goes to standby for a handover | Print the END status grid; certify disk == understanding; confirm nothing unflushed. |
| **T1** | **State change** | A GO is relayed · a checkpoint freezes · a founder-call is ruled · a dispatch advances a stage | Flush the change to `LEDGER.md` + read-back. |
| **T2** | **Triage return** | After handing back a ratification / GO / freeze decision | Flush the resulting state *before* going to standby. |
| **T3** | **End-of-turn sweep** | Before ending any turn that advanced state | Confirm the ledger reflects every advance this turn. **Unflushed state = incomplete turn** (you may not end the turn). |
| **T4** | **Context-health signal** | A self-monitor signal appears (responses lengthening without content, recognition fuzziness, re-reading what should be known) | Flush *everything*; initiate cutover prep. Do not push through fatigue. |
| **T5** | **Cutover / onboarding** | A tier rotates (Mentor-N → Mentor-N+1) | Run the full Layer-B dual validation; append the result to `HANDOVER_LOG.md`. |
| **T6** | **Doctrine change** | The master / an axis declaration / a template changes | Update the affected artifact; version-bump it. |
| **T7** | **CP-freeze** | A checkpoint freezes with pending items | Onboard *every* leftover to `LEFTOVERS.md` **before** reporting the freeze as ratification-ready. |

---

## Each trigger, in detail

### T0 — Boot
Deterministic boot from the stamped `CLAUDE.md`. The tier reads its canonical artifacts (LEDGER, LEFTOVERS, memories, the master), confirms they agree with each other, and prints the START grid. The START grid **is** the boot-integrity check: if it can't be reconciled against disk, the session halts rather than building on drifted state. The sync check (local == origin, 0/0) confirms the session is starting from the true tip.

### T0e — Session end / standby-into-cutover
The mirror of T0. The outgoing thread prints the END grid, which certifies that disk equals the tier's understanding and that nothing load-bearing remains in chat. This is the gate that makes a session safely discardable.

### T1 — State change
The workhorse trigger. Any *advance* in federation state — a GO relayed to a sub-tier, a checkpoint frozen, a founder-call ruled, a dispatch moving a stage — is flushed to `LEDGER.md` immediately and read back. State changes are never held in session memory pending a later batch write.

### T2 — Triage return
After a mentor hands back a decision (ratification, GO, freeze), the resulting state is flushed before the tier stands by. This prevents the failure where a mentor rules on something, goes idle, and the ruling lives only in the now-dormant session.

### T3 — End-of-turn sweep
A turn-closing checklist: before ending *any* turn that advanced state, confirm the ledger reflects it. The rule is sharp — **unflushed state means the turn is incomplete and may not be ended.** T3 is the backstop that catches a T1 or T2 that slipped.

### T4 — Context-health signal
The fatigue trigger. The [context-health hygiene](../02-guardrails/pollution-containment.md) self-monitor signals — lengthening responses, fuzzy recognition, needing to re-read known material — mean the session's judgment is degrading. The response is to flush everything and prepare a cutover, never to keep working through it.

### T5 — Cutover / onboarding
A rotation. The full Layer-B dual validation runs: the incoming tier self-administers the grounding battery and surfaces an original observation; the outgoing tier scores it against live artifacts and certifies no unflushed state. Both must pass; the result is appended to `HANDOVER_LOG.md`. See the [handover certificate template](templates/index.md).

### T6 — Doctrine change
When doctrine itself changes — the master protocol, an axis declaration, or a stamp template — the artifact is updated and version-bumped. This keeps the inheritance model coherent: a rule changes in one place, version-stamped, and every axis inherits it.

### T7 — CP-freeze
At a checkpoint freeze with pending items, *every* leftover is onboarded to `LEFTOVERS.md` before the freeze is reported as ratification-ready. This is what makes gate 4 (nothing untracked) checkable: a freeze cannot be declared ready while items are still loose.

---

## How the triggers map to the persistence law

Each trigger is a *when*; the [persistence law](../01-axioms/persistence-law.md) is the *how*:

| Persistence law layer | Triggers it governs |
|---|---|
| **Flush-before-disclose** (state on disk before discussed) | All — no trigger's output reaches the founder before it's flushed |
| **Layer A** (write + read-back every flush) | T1, T2, T3, T6, T7 |
| **Layer B** (two-party handover validation) | T5 (and T4 → T5) |
| **Boot / certification grids** | T0 (START), T0e (END) |

---

## Triggers across the work-granularity lanes

The lighter [lanes](../03-tunables/work-granularity-lanes.md) preserve the persistence law but touch fewer triggers:

| Lane | Touches |
|---|---|
| **Doctrine cycle / Phase 3** | All of T0–T7 |
| **Polish lane** | T0, T0e, T1, T3 (+ T7 if it freezes with leftovers) |
| **Surgical strike** | T1 (the commit) + T3; T0/T0e grids optional for a one-turn Doer |

The load-bearing flush-before-disclose discipline holds in every lane; only the ceremony of the heavier triggers (T5 rotations, T6 doctrine changes) is absent from the light lanes that don't reach those events.

→ [Persistence law](../01-axioms/persistence-law.md) · [Status grids](status-grids.md) · [Single-live-writer](../02-guardrails/single-live-writer.md) · [CLI conventions](cli-conventions.md)

---

## Next: [Stage grammar →](stage-grammar.md)
