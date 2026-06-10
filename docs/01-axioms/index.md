---
description: "The 7 invariant axioms of CompassAlpha: tier grammar, firewall, persistence law, hard-labour rule, bus protocol, provenance law, and git foundations."
---

# 01 · Axioms (the INVARIANT constitution)

> The 7 foundational rules. **Cannot be modified without forking the framework.** Read once, internalize forever.

Every axiom defends against one or more of the [four pathologies](../02-guardrails/index.md). If you violate an axiom, you re-introduce the pathology.

## The 7 axioms

| # | Axiom | Defends against | Page |
|---|---|---|---|
| 1 | **Tier grammar** | Role confusion | [→](tier-grammar.md) |
| 2 | **Firewall + state-tracking scope** | Context pollution, stale-snapshot drift | [→](firewall.md) |
| 3 | **Persistence law (trust anchor)** | Trust erosion, power-down data loss | [→](persistence-law.md) |
| 4 | **Hard labour rule** | Mentor-tier context pollution, role confusion | [→](hard-labour-rule.md) |
| 5 | **Bus protocol** | Coordination loss, message routing errors | [→](bus-protocol.md) |
| 6 | **Provenance law** | Hallucination drift, false-positive recall | [→](provenance-law.md) |
| 7 | **Git foundations** | Cross-session contamination, parallel-doer races | [→](git-foundations.md) |

## Why these are invariant

Each axiom emerged from a real incident in a reference implementation where someone tried the shortcut and the consequence was costly. The axioms are not abstract theorizing — they are scar tissue. Trying to weaken them re-opens the wounds.

## What "axiom" means in CompassAlpha

In CompassAlpha, axioms are not mathematical axioms (logical foundations). They are **structural axioms** — protocols that, if violated, cause predictable failures. You can technically violate them, just as you can technically violate physics; the consequences are equally predictable.

## How to read this section

Each axiom page follows the same structure:

1. **TL;DR** — one paragraph
2. **The rule** — exact specification
3. **Why it exists** — the failure mode it prevents
4. **What violating it looks like** — concrete failure example
5. **Implementation details** — how to enforce in practice
6. **Variations / tunables on top** — what you can still configure

## Start with the most foundational

If you can only read one axiom, read [Tier Grammar](tier-grammar.md). Everything else builds on it.

If you can read three, read **Tier Grammar** + **Firewall** + **Persistence Law**. Those three are the spine.

If you can read all seven, do so. They're each ~5 minutes.

---

## Next: [Tier Grammar →](tier-grammar.md)
