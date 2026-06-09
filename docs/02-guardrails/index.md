# 02 · Guardrails (what the framework prevents)

> Where the [Axioms](../01-axioms/index.md) state the invariant *rules*, **Guardrails** document the concrete *failure modes* those rules exist to prevent — what each failure looks like, how the framework detects it, and how to recover when it happens anyway.

## Axioms vs. guardrails

The two sections are companions, read from opposite directions:

| | Axioms | Guardrails |
|---|---|---|
| **Direction** | The rule, stated affirmatively | The pathology, stated as a failure |
| **Question answered** | "What must always be true?" | "What goes wrong when it isn't — and what do I do?" |
| **Form** | Invariant specification | Symptom → detection → recovery |
| **When you reach for it** | Designing or onboarding | Debugging, auditing, or recovering |

An axiom tells you to keep load-bearing state on disk. A guardrail tells you what a lost decision looks like three sessions later, how to notice the loss, and how to rebuild. You need both: the rule to follow, and the failure signature to recognize when the rule slipped.

## The four pathologies

Every guardrail in this section defends one or more of the four pathologies that multi-tier AI-agent federations fall into. These are the same four pathologies the axioms defend — the guardrails are the failure-facing view of the same defenses.

### 1. Context pollution

A tier's context fills with detail it does not own — sibling churn, sub-tier reasoning, integration noise. Judgment degrades (cognitive overhead) and biases (saw the trees, lost the forest). Worst form: a parent that *delegated* work still absorbs the delegate's full context on retrieval, so isolation buys nothing.

> Guarded by: [Pollution containment](pollution-containment.md), [Single-live-writer](single-live-writer.md).

### 2. Hallucination drift

An AI tier's institutional memory ("I remember we decided X") is confidently wrong. Acted upon, the federation drifts away from its actual history one plausible-but-false fact at a time. The drift compounds: each fabricated premise becomes the basis for the next decision.

> Guarded by: [Hallucination defense](hallucination-defense.md), [Stale-snapshot detection](stale-snapshot-detection.md).

### 3. Role confusion

A tier acts outside its jurisdiction — a mentor does labour, a doer improvises authority, a sub-tier writes into a parent's folder, a message is consumed by the wrong tier because the voice matched. Coordination integrity dissolves.

> Guarded by: [Brief completeness](brief-completeness.md), [Single-live-writer](single-live-writer.md).

### 4. Trust erosion

The founder observes a claim that doesn't match disk, a decision that evaporated, or a "done" that wasn't pushed. Once observed, the founder can no longer hold the narrow relay-and-lost+found posture and must return to micromanaging — which is exactly the cost the framework exists to spare them.

> Guarded by: [Failure modes](failure-modes.md), [Brief completeness](brief-completeness.md), and the persistence discipline behind every page here.

## The six guardrail pages

| Page | Pathology guarded | Core mechanism |
|---|---|---|
| [Pollution containment](pollution-containment.md) | Context pollution | Firewall + state-tracking scope confine each tier to its own granularity. |
| [Hallucination defense](hallucination-defense.md) | Hallucination drift | Verification-at-citation: every load-bearing claim verified against substrate before action. |
| [Stale-snapshot detection](stale-snapshot-detection.md) | Hallucination drift (the firewall-leak class) | "As of last tagged return" discipline; forensic descent before action. |
| [Failure modes](failure-modes.md) | Trust erosion (all classes) | The five documented failure classes, each with symptom → recovery. |
| [Brief completeness](brief-completeness.md) | Role confusion, trust erosion | No placeholders at the relay boundary; escalate, never improvise. |
| [Single-live-writer](single-live-writer.md) | Context pollution, role confusion | One writer holds jurisdiction; fetch-before-push for everyone else. |

## How to read this section

If you are **operating** a federation, read [Failure modes](failure-modes.md) first — it is the index of everything that can go wrong, with the recovery for each.

If you are **designing or auditing** one, read [Pollution containment](pollution-containment.md) and [Hallucination defense](hallucination-defense.md) — they explain why the structural choices in the axioms are not negotiable.

Each page reads standalone in about five minutes and cross-links to the axiom it operationalizes.

---

## Next: [Pollution Containment →](pollution-containment.md)
