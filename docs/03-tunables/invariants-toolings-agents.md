---
description: "The three enrichment surfaces. Each compounds intelligence against cost across cycles. Start lean; add when a pattern repeats."
---

# Invariants, Toolings & Specialised Agents

> *The three enrichment surfaces. Each compounds intelligence against cost across cycles. Start lean; add when a pattern repeats.*

`[TUNABLE — federation enrichment]`

This page is about the three ways a project gets smarter as it grows — the rules it enforces, the scripts it automates, and the AI helpers it specialises — and how to add them without paying for more than you need.

## TL;DR

**In short:** a project can buy quality by adding rules, automation, and specialised AI roles — but each one also costs time to maintain, so add them slowly and only when they earn their keep.

A federation gets smarter over time through three **enrichment surfaces**: project **invariants** (correctness rules enforced everywhere), **toolings** (automation — audits, validators, dashboards), and **specialised agents** (AI roles tuned for specific work types). All three compound the **intelligence ↔ cost** trade-off: more of each raises the deliverable's quality and the per-cycle cost. The recommended evolution is **start lean and add when a pattern repeats three times** and the marginal benefit is observable. A mature federation accumulates many invariants, several toolings, and a handful of agents over many cycles — biased toward intelligence; a lean federation stays cheap and fast with a lower quality floor.

## The dial

How much of each surface a project invests in is the dial. The three surfaces are independent levers but they **compound** — investing in all three yields a high-intelligence, high-cost federation; investing in none yields a lean, cheap, lower-floor one. Every project at every cycle decides how much of each to add.

## Surface 1 — Invariants

**Invariants** are project-level rules that hold across all axes — domain truths like "this entity is the system's center of gravity" or federation-contract rules in the Charter. Each invariant is a correctness gate, enforced wherever it applies (document authoring, code review, audit chains).

**The trade:**

- **More invariants** → more correctness gates → higher deliverable quality + higher per-cycle cost to enforce and verify each.
- **Fewer invariants** → less enforcement overhead → faster cycles + lower quality floor.

**Sub-dials:**

| Sub-dial | Range | Notes |
|---|---|---|
| Invariant count | minimal → many | How many the project declares. |
| Enforcement strictness | strict / spot-check / trusted | Verify every artifact / sample-based / declared-but-not-gate-checked. |
| Invariant scope | universal / axis-specific | Every axis vs one axis. |
| Evolution rate | locked-per-cycle / rolling | Amend at cycle close, or continuously. |

## Surface 2 — Toolings

**Toolings** are the federation's automation infrastructure — audit scripts, validators, baseline checkers, dashboards, telemetry. Examples (generic): a route-coverage audit, a forbidden-pattern checker, a baseline-drift detector, a code-writer agent template.

**The trade:**

- **More toolings** → more automation → lower long-run per-cycle cost + better catch rate + higher upfront authoring cost.
- **Fewer toolings** → manual verification (founder + AI cycles) → lower upfront cost but higher per-cycle cost.

**Sub-dials:**

| Sub-dial | Range | Notes |
|---|---|---|
| Tool count | few → many | How many automation artifacts are maintained. |
| Tool coverage | low → high | What share of correctness checks is automated. |
| Tool sophistication | grep-based / AST-aware / semantic-AI | Increasing capability and cost. |
| Maintenance burden | kept-current / allowed-to-drift | Drifted tools give false confidence. |

Toolings have a distinctive cost shape: **high upfront, low marginal.** A tool authored once runs every cycle for free. This makes toolings the best long-run investment for a recurring check — but only if maintained; a drifted tool is worse than none.

## Surface 3 — Specialised Agents

**Specialised agents** are AI roles tuned for specific work types — for example a UI/UX-focused authoring persona for slices with interface content, or a code-writer template versus a doc-writer template. Each is a chunk of doctrine encoded as an AI boot prompt + behavior contract.

**The trade:**

- **More specialised agents** → finer specialization → higher per-slice intelligence + better task-fit + more boot/maintenance cost (more templates to keep current).
- **Fewer specialised agents** → generalist agents handle everything → lower maintenance + lower per-slice fit.

**Sub-dials:**

| Sub-dial | Range | Notes |
|---|---|---|
| Agent count | none → many | How many specialised roles are maintained. |
| Agent depth | thin (one-page brief) / deep (multi-page persona) | More depth = better fit, more maintenance. |
| Reuse rate | sparse → frequent | Sparse agents may not pay back their maintenance. |
| Scope | cross-axis / axis-specific | Validator-style agents reuse across axes; others bind to one. |

## The compound surface

All three compound. A mature federation with rich invariants + extensive toolings + many specialised agents has:

- **High intelligence** — catches more, specializes better, automates more.
- **High per-cycle cost** — boot, maintenance, verification overhead.
- **High upfront cost** — to author all three.

A lean federation has a lower intelligence floor but lower cost, lower upfront cost, and faster cycles — at the price of more manual checking.

```
        intelligence
            ▲
            │        ● rich (many invariants + toolings + agents)
            │      ╱
            │    ╱     ← the compounding curve: each surface
            │  ╱          multiplies the others
            │╱
            ●─────────────────────────▶  cost
          lean
```

## The recommended evolution — start lean, earn each addition

**Start lean. Add an invariant / tooling / agent when a pattern repeats AND the marginal benefit is observable.** Concretely:

- The same bug class is caught three times → it's worth a **tooling**.
- The same agent boot brief drifts or is hand-reconstructed three times → it's worth a **specialised agent** doctrine.
- The same correctness rule is violated across scopes → it's worth a **project invariant**.

A regulated multi-tenant profile may accumulate roughly twenty invariants, several toolings, and a few specialised agents over a year of build cycles — a deliberate bias toward intelligence appropriate to expensive-to-roll-back doctrine. A small source-available project may stay near zero on all three for a long time and be entirely correct to do so.

There is no settled economic curve for the optimal investment level given project size and risk profile — it's currently practitioner-driven, and ripe for shared guidance as more source-available CompassAlpha projects accumulate comparable data.

## Defaults

| Surface | Bootstrap default | Conservative default |
|---|---|---|
| Invariants | minimal | many |
| Toolings | minimal | many |
| Specialised agents | none | several |
| Enforcement strictness | strict | strict |

Note: enforcement strictness is strict even at Bootstrap. You start with *few* invariants, but you enforce the ones you have strictly. Leanness is about count, not rigor.

## How to choose

1. **New adoption → minimal everything, strict enforcement.** Don't author toolings for bugs you haven't seen.
2. **Earn each addition with the rule-of-three.** A surface artifact that doesn't pay back its maintenance is net-negative.
3. **Toolings before agents** when in doubt — toolings have the better long-run cost shape (author once, run free).
4. **Keep what you have current.** A drifted tooling or stale agent gives false confidence; retire it or fix it.
5. **Bias rich for regulated/high-stakes work; bias lean for small/exploratory work.**

## Remember this

- A project gets smarter through three surfaces: **invariants** (rules it always enforces), **toolings** (scripts that check things automatically), and **specialised agents** (AI helpers tuned for one kind of work).
- Each one raises quality but also costs effort to keep current — so start with almost none and earn each addition.
- The **rule of three** is your guide: when the same problem shows up three times, that's when it's worth automating or codifying.
- Toolings are the best bargain over time — write the check once, and it runs free every cycle after that. See how these dials fit the bigger picture in [the mental model](../00-foundation/mental-model.md).

## How this connects

- [AI model choices](ai-model-choices.md) — specialised agents are model configurations tuned per work type.
- [Stage taxonomies](stage-taxonomies.md) — toolings often run at specific stages (e.g. an audit at CP3).
- [Provenance law](../01-axioms/provenance-law.md) (axiom) — toolings that verify against substrate enforce provenance automatically.
- [Hallucination defense](../02-guardrails/hallucination-defense.md) (guardrail) — strict-enforcement invariants are a primary defense.
- [Tunables overview](tunables-overview.md) — the intelligence-vs-cost axis these surfaces move.
- [Codebase coherence](../00-foundation/codebase-coherence.md) — toolings mechanize the conformance checks that keep code coherent with doctrine.

---

## Next: [Memory policy →](memory-policy.md)
