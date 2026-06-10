---
description: "Mentors never touch substrate. The Doer is the only tier that does labour."
---

# Axiom 4: Hard Labour Rule

> *Mentors never touch substrate. The Doer is the only tier that does labour.*

`[INVARIANT]`

## TL;DR

Mentor-1 and Mentor-2 **never** touch the substrate (the project's actual codebase or doctrine source repo). The Doer is the **only** tier that does labour — code, doctrine, surveys, audits, recon, all of it. This is what keeps mentor context clean across the long cycle horizon.

## The rule

**Labour** = recon, substrate reads, code surveys, document writes, deliverable production, any operation against the project's substrate repo.

**Mentor-1 and Mentor-2 never do labour.** Their work product is orchestration + ratification, not substrate change.

**The Doer does ALL labour.** Doers are fresh-per-slice by design (see [tier grammar](tier-grammar.md)) — disposable context. Labour belongs at the disposable tier.

### Mentor-allowed edge cases (NOT labour; these are mentor-orchestration)

- Own-tier artifact reads (own LEDGER / LEFTOVERS / HANDOVER_LOG / stamped CLAUDE.md / shared master protocol / memories)
- Protocol / template editing (master, axis declarations, stamp templates)
- Stamp composition (writing the next sub-tier's boot file from a template)
- T0-boot one-shot origin-verification of immutable tags

Everything else touching the substrate = Doer work. Dispatch a Doer; don't do it yourself.

## Why this exists

Three connected reasons:

### Reason 1: Mentor-context-pollution defense

Substrate detail (specific function names, file contents, ASTs, code patterns) is **noise** to a mentor's orchestration judgment. A mentor that reads substrate accumulates this noise over the cycle's horizon (weeks to months). The accumulated noise:

- Slows mentor responses (more context to process)
- Biases mentor decisions toward what was recently seen
- Degrades mentor token-budget efficiency
- Reduces the value of the mentor's contextual position (high-altitude orchestration)

Doers are fresh-per-slice — their context starts clean every time. Labour belongs there.

### Reason 2: Role clarity

If mentors can do labour "just this once," the line erodes quickly. Mentors find more and more reasons to do labour ("it's faster than dispatching a Doer," "this is too small to bother with," "I'm right here anyway"). Within a few cycles, mentors are de facto doers, and the framework's tier separation collapses.

The `[INVARIANT]` marker prevents this drift.

### Reason 3: Substrate-knowledge distribution

When the Doer is the only labour tier, substrate knowledge naturally distributes across many Doer spawns — none of them retain it; the **inbox-as-state-of-record** retains it. This is what makes the federation's substrate knowledge auditable rather than concentrated in a long-running mentor session.

A long-running persistent single-writer session (a legacy anti-pattern) was the workaround used before this axiom was formalized. The axiom retires it.

## What violating this looks like

### Violation 1: Mentor runs `git log` on substrate

A Mentor-1 wants to "quickly check" recent commits in the substrate to verify a sub-tier's claim. They run `git -C /path/to/substrate log --since=1day`.

Result: substrate context (commit messages, author names, file lists) lands in mentor's context. Pollution accumulates over the cycle.

**Fix:** mentor sees only what arrives in the inbox via tagged returns. If verification is needed, dispatch a Doer for a brief "verify last day's commits in module X" recon.

### Violation 2: Mentor "helps debug" a failing Doer

A Mentor-2 sees its Doer is stuck. Mentor-2 opens the Doer's worktree, examines the code, finds the bug, fixes it.

Result: Mentor-2's context now has the bug, the fix, the surrounding code structure, the test output, etc. Pollution.

**Fix:** the Doer escalates. Mentor-2 ratifies a new brief (with hints if appropriate). New fresh Doer spawn picks it up.

### Violation 3: Mentor-direct Bash for recon

A Mentor-1, mid-cycle: directly ran a Bash session to do recon on a module's code before stamping the dispatch. The findings were correct; the method violated the rule.

**Outcome:** the hard hierarchical labour rule was set the same session and encoded into the protocol. Recon thereafter dispatched as a Doer at the Mentor-2's first slice.

## Implementation details

### The dispatch pattern

When a mentor needs substrate information:

```
1. Mentor identifies what's needed (e.g., "verify routes in module X conform to pattern Y")
2. Mentor composes a Doer brief (uses inbox file format)
3. Mentor commits + pushes brief to recipient inbox
4. Mentor pings founder: "ready for Doer dispatch"
5. Founder triggers fresh Doer session
6. Doer reads brief, does the work, returns tagged digest
7. Mentor reads digest, ratifies, continues
```

The mentor never touches substrate directly. Every substrate operation is a Doer dispatch.

### Recon-first pattern

Pre-stamp recon (surveying substrate to inform a dispatch brief) is a common need. The axiom requires this to be **Doer work**, not Mentor-direct.

```
Mentor-2 first-slice stage:
  1. Compose recon brief: "Survey substrate for module X. Report on: ..."
  2. Dispatch a Doer for recon
  3. Receive recon digest
  4. Use digest to inform subsequent slice briefs (S2a, S2b, ...)
```

This is the recon-first pattern, where the first slice of a dispatch is dedicated to recon.

### The legacy-consultant pattern

A legacy anti-pattern used a long-running persistent in-repo single-writer session as the substrate-knowledge holder + ad-hoc consult source. The hard labour rule reframes such a knowledge holder as a **Doer-class consultant** — not a mentor-direct labour escape hatch.

When a mentor wants that consult input (e.g., "what's the historical reason for X?"), the pattern is:

1. Mentor composes a "consult" brief
2. Dispatch a Doer that knows how to interrogate the knowledge source
3. Doer does the consult, returns digest
4. Mentor ingests digest

The consult is never mentor-direct. It is Doer-mediated.

## Variations / tunables on top

The `[INVARIANT]` is the no-labour rule itself. The following are `[TUNABLE]`:

| Tunable | Default | Range |
|---|---|---|
| Edge case scope | own-artifact reads / template edits / stamp composition / T0-boot tag verify | adjustable; new edge cases require axiom amendment via fork |
| Recon dispatch granularity | per-entity-first-slice by Mentor-2 | per-entity / per-slice / per-need |
| Legacy-consult pattern | Doer-mediated only | Doer-mediated / direct (anti-pattern) |

## How this connects to other axioms

- **[Tier grammar](tier-grammar.md)** defines who's a mentor and who's a Doer; this axiom specifies what each can and can't do.
- **[Firewall](firewall.md)** isolates contexts; this axiom prevents mentors from bypassing the firewall by doing labour themselves.
- **[Bus protocol](bus-protocol.md)** is how dispatch happens (mentors compose briefs, Doers consume them via inboxes).
- **[Brief completeness](../02-guardrails/brief-completeness.md)** ensures Doer briefs are complete so Doers don't have to ask mentors mid-execution.

## The "fatigue across the long horizon" framing

A subtle aspect of this axiom: mentor sessions are **long-lived**. Mentor-1 can be the same session for an entire multi-week amendment cycle. Mentor-2 can run an entire entity dispatch (multiple weeks if persistent mode is enabled).

Across that horizon, accumulated substrate detail in mentor context becomes substantial. The first slice's surface fact (which the mentor learned by quickly checking substrate) is still in mentor context at the cycle's last slice. **Fatigue + degradation accumulates.**

By contrast, Doers are fresh-per-slice. Each slice starts with a clean Doer context. The substrate detail accumulates for one slice's worth of work, then dies. **No fatigue across the horizon.**

This is the engineering reason the axiom is non-negotiable. It's not philosophical; it's about preserving mentor judgment quality across a long cycle.

## Next: [Axiom 5 — Bus Protocol →](bus-protocol.md)
