---
description: "The CompassAlpha mental model — the core ideas the framework rests on: framework-not-tool, the four failures it prevents, the three tiers, the two axes, the altitude descent, the five-stage cycle, git as the bus and memory, and the four layers."
---

# The Mental Model

> *The core ideas the framework rests on. Once they're in your head, every other page is just detail hanging off them.*

**In plain terms:** CompassAlpha is a way to get several AI coding agents to build one codebase together without tripping over each other — you describe each part of your project in plain words, and the agents build it against one shared rulebook so the code stays consistent as it grows. You bring your own AI agents, your own git, and your own host; CompassAlpha is the rulebook for how they collaborate.

It rests on eight ideas. Hold these, and every other page in the portal reads as detail hanging off one of them.

![The CompassAlpha mental model on one page — four failures it prevents, the three-tier machine over git, the two alternating axes, the altitude descent through five stages, and the four-layer rulebook](../assets/mental-model.svg)

<small>***Why** the framework exists (four failures), **the machine** (three tiers over git), **the rhythm** (two axes alternating), **the work** (vision descending through five stages), and **the rulebook** (four layers, hardest to softest). Every deep-dive page is detail hung on one of these.*</small>

## The eight ideas

1. **Framework, not tool.** You bring your own AI agents, your own git, your own host. CompassAlpha guards *how they collaborate* — it is a constitution + conventions, not a runnable artifact. [→ Framework, not tool](framework-not-tool.md)

2. **It exists to stop four failures.** Context pollution · hallucination drift · role confusion · trust erosion. Every rule in the framework traces to preventing one of these — when a rule seems fussy, ask which failure it guards. [→ Guardrails](../02-guardrails/index.md)

3. **Three tiers, one toucher.** **Mentor-1** (the senior planner) → **Mentor-2** (the coordinator) → **Doer** (the hands-on builder). Only the Doer touches the *substrate* (your actual codebase and files); the mentors plan and review but never do the labour themselves. This is what keeps the upper tiers' judgment clean. [→ Tier grammar](../01-axioms/tier-grammar.md)

4. **Two axes that take turns.** A **build axis** writes code while the rulebook is **LOCKED**; a **doctrine axis** changes the rulebook while it is **UNLOCKED**. They *alternate* — never at once, or the build races the very rules being changed. [→ Axis declarations](../03-tunables/axis-declarations.md)

5. **Vision descends into code.** Each layer is one zoom level lower than the last: **60K (the *why*) → 30K (how the parts move) → 10K (exact schema) → code.** Say a component's vision in plain words and the federation grows a coherent codebase down from it. [→ Codebase coherence](codebase-coherence.md)

6. **The heaviest lane is five stages.** A full doctrine cycle runs **S1 → S5** (substrate recon + ideology → mechanics → schema → grass-roots evidence → close). **Every lighter kind of work is a *relaxation* of this one** — learn it once, and the rest of the framework is subtraction. [→ Sample doctrine cycle](../06-adoption-patterns/sample-doctrine-cycle.md)

7. **Git is the bus and the memory.** State crosses tiers through git, and nothing load-bearing lives in chat. *State of the federation = state of git.* [→ Git foundations](../01-axioms/git-foundations.md) · [Persistence law](../01-axioms/persistence-law.md)

8. **Four layers, hardest to softest.** [**AXIOMS**](../01-axioms/index.md) (invariant) · [**GUARDRAILS**](../02-guardrails/index.md) (invariant) · [**TUNABLES**](../03-tunables/index.md) (configurable) · [**TOGGLES**](../04-toggles/index.md) (live switches). Know which layer a thing lives in and you know whether you may change it.

## Where each idea expands

| When you want… | Read |
|---|---|
| Why it's not a tool | [Framework, not tool](framework-not-tool.md) |
| The failures it was forged against | [Origin — why GitAI](origin-story.md) · [Guardrails](../02-guardrails/index.md) |
| The invariant rules in full | [The Constitution](constitution.md) · [Axioms](../01-axioms/index.md) |
| How vision becomes coherent code | [Codebase coherence](codebase-coherence.md) |
| The heaviest lane, worked end-to-end | [Sample doctrine cycle](../06-adoption-patterns/sample-doctrine-cycle.md) |
| Every term, defined | [Glossary](glossary.md) |

## Remember this

- **CompassAlpha coordinates several AI agents building one codebase** — you describe each part in plain words; they build it against one shared rulebook.
- **The payoff is coherence:** one canonical way to do each thing, so a growing codebase doesn't drift into duplicated, divergent code.
- **You bring your own agents, git, and host.** CompassAlpha is the rulebook for how they collaborate — not software you install.
- **Everything load-bearing lives in git, not chat** — and only the hands-on *Doer* tier edits the code.

---

## Next: [Framework, not tool →](framework-not-tool.md)
