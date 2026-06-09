# The Constitution

> *Provisioned as a constitution: a small inviolable foundation + everything else explicitly tunable on top.*

CompassAlpha is structured constitutionally — like a written constitution for a polity. There's a small set of **inviolable principles** (axioms), a set of **protective rules** (guardrails), and then a wide surface of **decisions you make for your specific project** (tunables and toggles).

## The four-layer constitutional model

```
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 4: TOGGLES                                               │
│  Live switches · flip at runtime / cycle / project boundaries   │
│  Operating presets are named bundles of toggles                 │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 3: TUNABLES                                              │
│  Customization surface · the 5-axis trade-off space             │
│  Concurrency · context · AI model · lanes · stages · ...        │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 2: GUARDRAILS                                            │
│  What the framework PREVENTS                                    │
│  Pollution, hallucination, drift, trust erosion · failure modes │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 1: AXIOMS (the constitution)                             │
│  7 INVARIANT rules · cannot be tuned away                       │
│  Tier grammar · firewall · persistence · hard labour · ...      │
└─────────────────────────────────────────────────────────────────┘
```

**Higher layers DERIVE from lower layers.** Toggles bundle tunables. Tunables operate on top of guardrails. Guardrails defend the axioms. The axioms are the bedrock.

When you adopt CompassAlpha, you accept the axioms unchanged, you accept the guardrails as protection, and you make decisions on tunables + toggles for your specific project.

---

## Layer 1: The 7 Axioms (INVARIANT)

These rules **cannot be modified** without forking the framework. They define what CompassAlpha **is**.

| # | Axiom | One-line essence | Detail |
|---|---|---|---|
| 1 | **Tier grammar** | Mentor-1 / Mentor-2 / Doer per axis | [→](../01-axioms/tier-grammar.md) |
| 2 | **Firewall** | Confined, not banished. Mentors track only their granularity. | [→](../01-axioms/firewall.md) |
| 3 | **Persistence law** | Flush before disclose. State on disk + at origin BEFORE discussed. | [→](../01-axioms/persistence-law.md) |
| 4 | **Hard labour rule** | Mentors never touch substrate. Doer is the only labour tier. | [→](../01-axioms/hard-labour-rule.md) |
| 5 | **Bus protocol** | Inbox-in-destination-folder. Sender writes, founder pings, recipient pulls. | [→](../01-axioms/bus-protocol.md) |
| 6 | **Provenance law** | Cite by substrate. Never trust institutional memory unverified. | [→](../01-axioms/provenance-law.md) |
| 7 | **Git foundations** | `GIT_INDEX_FILE` + worktree + `commit-tree` per session. | [→](../01-axioms/git-foundations.md) |

Each axiom defends against one or more of the [four pathologies](framework-not-tool.md). If you try to weaken any axiom, you'll re-introduce the pathology it was preventing.

!!! warning "What 'invariant' means in practice"
    If you find yourself wanting to violate an axiom for short-term gain, **stop**. The axiom exists because that shortcut has been tried before and the consequence was costly. The framework's value is exactly in these constraints. If your project genuinely needs to violate an axiom, you're using the wrong framework — fork it or adopt a different one.

---

## Layer 2: Guardrails (PROTECTIVE)

These are the **failure modes the framework defends against**, with documented recovery patterns when failures occur anyway.

| Guardrail | Defends against | Detail |
|---|---|---|
| **Pollution containment** | Context bleed across tiers | [→](../02-guardrails/pollution-containment.md) |
| **Hallucination defense** | AI institutional-memory false-positives | [→](../02-guardrails/hallucination-defense.md) |
| **Stale snapshot detection** | Firewall leak (snapshot ≈ live) | [→](../02-guardrails/stale-snapshot-detection.md) |
| **Failure modes catalog** | 5 known classes + recovery | [→](../02-guardrails/failure-modes.md) |
| **Brief completeness** | Improvisation by Doers on incomplete briefs | [→](../02-guardrails/brief-completeness.md) |
| **Single-live-writer** | Cross-session clobber on shared state | [→](../02-guardrails/single-live-writer.md) |

Guardrails are NOT independent of axioms — they DERIVE from axioms. The single-live-writer guardrail derives from the firewall axiom. Stale snapshot detection derives from the firewall + persistence axioms.

---

## Layer 3: Tunables (CONFIGURABLE)

The customization surface. **Every tunable has a default, a range, and a documented trade-off.**

The five primary axes in tension (no combination optimizes all):

- ⏱ **SPEED** — wall-clock to deliverable
- 🧠 **INTELLIGENCE** — depth, correctness, coverage
- 💰 **COST** — tokens + founder cognitive load + maintenance
- ⚠ **RISK** — pollution, hallucination, drift, replay
- 📐 **PREDICTABILITY** — cycle/scope estimability

A conservative profile biases toward **intelligence + low-risk** (LAYGO concurrency, pure RELAY, fresh-per-slice, xhigh effort, strict provenance). Other project profiles want other bias points.

Tunable categories:

- [Axis declarations](../03-tunables/axis-declarations.md) — declaring your own axes
- [Concurrency modes](../03-tunables/concurrency-modes.md) — LAYGO / Pipelined / Parallel-independent / Parallel-doer
- [Context patterns](../03-tunables/context-patterns.md) — mentor lifecycle, doer scope, memory rate, verbosity
- [AI model choices](../03-tunables/ai-model-choices.md) — per-tier model selection
- [Work granularity lanes](../03-tunables/work-granularity-lanes.md) — 4 lanes (Doctrine / Phase 3 / Polish / Surgical)
- [Stage taxonomies](../03-tunables/stage-taxonomies.md) — per-axis lifecycle stages
- [Invariants + Toolings + Agents](../03-tunables/invariants-toolings-agents.md) — enrichment surfaces
- [Memory policy](../03-tunables/memory-policy.md) — inheritance + retention
- [Full parameter matrix](../03-tunables/full-parameter-matrix.md) — every tunable in one place

---

## Layer 4: Toggles (LIVE)

Toggles are tunables seen from the **timing** perspective: when can each one flip?

- **Runtime toggles** — flip mid-cycle (rare; usually escalation-class) → [→](../04-toggles/runtime-toggles.md)
- **Cycle toggles** — flip at cycle boundaries → [→](../04-toggles/cycle-toggles.md)
- **Project-lifecycle toggles** — flip only at project-wide seams → [→](../04-toggles/project-lifecycle-toggles.md)
- **Operating presets** — named bundles of toggles (Conservative · Throughput · Risk-averse · ...) → [→](../04-toggles/operating-presets.md)

---

## How the layers compose

A worked example: a conservative profile biased toward intelligence + low-risk.

```
LAYER 1 (axioms):     all 7 axioms in force (always — invariant)
LAYER 2 (guardrails): all 6 guardrails active (always — derived from axioms)
LAYER 3 (tunables):
                      concurrency = LAYGO
                      context_patterns = {fresh-per-slice doer, verbose digests, liberal memory}
                      ai_model = top-tier all tiers
                      lanes_enabled = {Doctrine Cycle, Phase 3, Polish, Surgical}
                      ...
LAYER 4 (toggles):    operating_preset = Conservative
                      (this bundles the LAYER 3 settings above)
                      rotation_cadence = "2-4 weeks preventive"
                      ...
```

Same axioms, same guardrails. Different project = different tunables + toggles. The constitution stays; the customization changes.

---

## The "provisioned as a constitution" property

Nasir's exact framing: *"toggles with every possible detail provisioned as a constitution."*

What this means concretely:

- **Every detail is explicitly named.** Nothing implicit. Tunables are catalogued (LAYER 3). Toggles are catalogued (LAYER 4). Invariants are catalogued (LAYER 1).
- **Every detail has a default.** New adopters can be functional without making every decision; the Conservative preset's defaults work for most cases.
- **Every detail is documented.** The reasoning behind each default is recorded. Trade-offs are explicit.
- **Every detail is auditable.** A new team member can trace any decision to its layer.
- **Every detail respects the layer hierarchy.** Tunables defer to guardrails defer to axioms. No upper layer overrides a lower one.

This is what makes CompassAlpha constitutional rather than ad-hoc.

---

## Reading the constitution

A practical order:

1. **Now**: skim this page (you're here)
2. **Next 30 minutes**: read all 7 axioms ([→](../01-axioms/))
3. **Next hour**: read all 6 guardrails ([→](../02-guardrails/))
4. **Next 2-3 hours**: skim the tunables (don't memorize) ([→](../03-tunables/))
5. **As needed**: refer to toggles when you need a specific switch ([→](../04-toggles/))

You don't need to memorize tunables and toggles — those are reference material. You DO need to internalize the axioms and guardrails — those govern every interaction.

---

## Versioning the constitution

The constitution evolves. Like real-world constitutions, it has amendment cycles — but unlike real-world constitutions, the procedure is itself documented.

- **Axioms**: changed only by forking the framework (rare; if ever)
- **Guardrails**: changed by community consensus + reference-implementation validation
- **Tunables**: extended frequently; existing tunables are stable
- **Toggles**: extended in lockstep with tunables

A reference federation's doctrine cycle (e.g. Charter v0.4 → v0.5) is itself the amendment process for the framework. Each cycle is documented in the [Changelog](../08-community/changelog.md).

---

## Next: [GitAI category →](gitai-category.md)
