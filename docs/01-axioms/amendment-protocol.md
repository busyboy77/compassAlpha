---
description: "Discoveries flow up; ratified truth flows down. The constitution learns from field discoveries — gathered at a barrier, ratified by a council. The framework illuminates the choice; the federation decides it."
---

# Axiom 8: Amendment Protocol

> *Discoveries flow up; ratified truth flows down. The constitution learns from what the field discovers — gathered at a barrier, ratified by a council, never amended below it. The framework illuminates the choice; the federation decides it.*

`[INVARIANT — discoveries flow up, ratified truth flows down; ratification gathers at a barrier]` `[TUNABLE — train cadence, council composition, tie-break + straggler rules]`

The other seven axioms describe a constitution that *holds*. This one describes how it *learns*. As teams work, the framework keeps finding small truths the Charter never wrote down — a rule everyone already obeys, a concept nobody named, two components that quietly disagree. This page is the law for what happens to those findings: how they travel **upward** to amend the shared constitution, who ratifies them, and — crucially — why the framework surfaces the decision but never makes it for you.

## TL;DR

While the framework enforces coherence, it keeps **discovering** things about your codebase. Most discoveries are fixed on the spot. But some are bigger than a local fix — they belong in the shared constitution (the [Charter, its Invariants and Primitives](../00-foundation/constitution.md#the-doctrine-substrate-charter-compasses-and-axis-annexes)). Those don't get applied quietly. They are **nominated upward**, **gathered** at the end of a coherence cycle, **ratified** by a small council of team leads, and then **floated back down** as a new Charter version that every team adopts.

Two rules make this safe:

- **The engine that enforces coherence never edits the constitution itself.** It *fixes and aligns* code, and it *nominates* upward — but legislating is a separate, human act. Enforcer and legislature are kept apart on purpose.
- **The framework illuminates; it does not dictate.** When a discovery is contested, the framework lays out the situation, the evidence, the options, and the consequences — in full light — and the federation decides. Provisioning the verdict would make it a tool. It is a framework.

![The federated amendment loop — per-team doctrine cycles fix and align coherence in place while nominating bigger findings upward; nominations gather at a barrier at cycle-end, a representative council ratifies them into a Charter version bump, and the ratified truth floats back down to every team for staggered adoption](../assets/amendment-loop.svg)

<small>*Discoveries flow **up**, ratified truth flows **down**, and nothing crosses sideways. Per-team coherence work fixes and aligns in place; the findings worth keeping nominate upward; they pool at the cycle-end barrier (where the same finding from many teams is the strongest signal); a council ratifies them into a `GO-UP-BUMP`; the new Charter floats down for staggered adoption. With no new input the loop quiets — it is driven by change, not by its own output. Click to open full size.*</small>

## The rule

### Discoveries flow up; ratified truth flows down

There is exactly one direction of travel for each kind of thing, and it never reverses:

- **Findings travel up.** A team's coherence work can *nominate* a change to the shared constitution. It cannot push that change to a sibling team, and it cannot apply it to the Charter on its own authority.
- **Ratified truth travels down.** Once ratified, an amendment becomes the new Charter version and propagates to **every** team. There is one constitution, and it changes in one place.
- **Nothing travels sideways.** A team never hands doctrine to another team directly. Everything routes through the center and comes back as law. This single rule is what keeps many teams building **one** coherent codebase instead of many dialects.

### The coherence engine nominates; it does not legislate

The [doctrine axis](../03-tunables/axis-declarations.md) runs its stages (S1→S5) to do the utmost [codebase coherence](../00-foundation/codebase-coherence.md): it **fixes and aligns** the code to the current Charter. That is its whole job. It does **not** amend the Charter, the Invariants, or the Primitives — even when it discovers that one of them is wrong or missing. It records the discovery and **nominates** it upward.

This is separation of powers. The body that *enforces* the rules is not the body that *writes* them. Fuse the two and you lose auditability: a coherence pass could silently rewrite the constitution it is supposed to be checking against.

### Recurrence is the promotion signal

Not every discovery deserves to reach the constitution. The honest, measurable filter is **recurrence**: if the same class of incoherence is discovered and fixed in many places, that is evidence the missing rule belongs in the Invariants — and the count of fixes *is* its credibility. A finding seen once is a candidate to defer; a finding seen everywhere is overdue.

In a federation this signal gets stronger: when **several independent teams** nominate the same finding, that is the highest-confidence evidence there is. The same fix is bought **once**, upstream, instead of paid for separately by every team.

### The barrier and the train

Nominations are not ratified the moment they appear — they are **gathered**, then ratified together on a cadence called a **train**:

- **The standing trigger is the end of the doctrine cycle.** When the coherence cycle closes, its discoveries are ready. More precisely, the whistle blows at the **federation barrier** — the point where every team (or a quorum) has closed its cycle and the findings are pooled — because you cannot tell that *several* teams discovered the same thing until their findings sit side by side.
- **An emergency train is the rare exception.** A finding urgent enough can call a train early, but it is always lower priority: an unscheduled train forces every team to converge regardless of where they are in their own work, so you pay drift for it. Standing trigger: cycle-end. Emergency: rare, and costly.

### The council ratifies — a few, not all

Ratification happens in a **representative council**: one lead per team, not an all-hands. A room of everyone does not converge. In a single-team federation the council collapses to its one lead — in the reference walkthrough, that lead is the founder. The council **disposes** of each nomination, and every disposition is recorded:

| Disposition | What it means | Where it goes |
|---|---|---|
| **Accept** | the finding becomes shared law | amends the Charter via `GO-UP-BUMP` |
| **Defer** | legitimate, but not yet | enters the [settlement cascade](#deferred-work-the-settlement-cascade) |
| **Reject** | declined, with a recorded reason | stays decided — it does not re-nominate |

The third row is load-bearing: a rejection that isn't *written down as rejected* gets re-raised by the recurrence signal next cycle, and the council re-litigates the same item forever. Decided is decided.

### Ratify together, adopt staggered, sunset the old

When the council accepts amendments, they merge into the constitution and the Charter version bumps — a [`GO-UP-BUMP`](../00-foundation/constitution.md#version-bumps-go-up-bump-vs-sub-bump), `charter-v<n>` → `charter-v<n+1>`. The new version then floats down. The danger is doing the float **all at once**: the instant a new Charter lands, every team's code is potentially out of conformance, and every team's next coherence pass surfaces an alignment wave *simultaneously*. That is a flag day. Split the one event into three:

- **Ratify once, centrally** — the new version is the single truth the moment the council closes. No team gets a different answer.
- **Adopt on each team's cadence** — old and new coexist in a compatibility window. Each receiving **team lead** owns that team's [delta-scoped re-run](#delta-scoped-re-runs), and writes a `charter-v<n+1>-adopted` marker to substrate once its segment reaches conformance — that marker is the *adoption-complete* artifact the federation tracks against the deadline.
- **Sunset the old version on a deadline** — set centrally at ratification (the same train that bumps the Charter fixes the date the old version expires). Without a hard expiry, teams never migrate and the federation forks. The deadline is what makes "staggered" converge instead of drift apart.

Make the version number carry the cost, like semantic versioning: a new **Primitive** is additive (a free upgrade — nothing breaks); a new **Invariant** existing code violates is breaking (a migration). A team reading the bump knows whether it is a free ride or a flag day *before* pulling it.

### Contested discoveries: illuminate, never dictate

Sometimes two teams discover opposite things — Team A finds that rule X should hold, Team B finds that ¬X should. The framework's job here is **clarity, not judgment**. It presents the full decision surface and stops:

- **the situation** — who discovered X, who discovered ¬X, each traced to its [substrate](provenance-law.md)
- **the evidence** — cross-team recurrence, shown *as data, not as a verdict* (e.g. "X: 7 teams · ¬X: 3 teams")
- **the menu** — the moves available, *named, not chosen*: settle on a single solution for everyone, or define a new Invariant
- **the consequences** — what each move costs, *shown, not weighted* — including that minting new Invariants to paper over every disagreement bloats the constitution until coherence cycles stop converging

Then the council decides. The framework never picks up a fork. This is the [framework-not-tool](../00-foundation/framework-not-tool.md) line drawn at its sharpest: maximal clarity, zero dictation.

![Contested-discovery illumination and the convergence mirror — the framework presents the situation, the cross-team evidence, the menu of moves, and the consequences of each as a decision surface, while the council alone chooses between a single shared solution or a new Invariant; a separate health mirror shows whether recent amendments are bloating the constitution and slowing convergence](../assets/amendment-illumination.svg)

<small>*When a finding is contested, the framework lays the table and the council eats. It surfaces situation, evidence (recurrence as data, not a ruling), the named menu of moves, and the projected consequences of each — then chooses nothing. The **convergence mirror** is the one consequence worth making vivid: it shows, without judging, when amendments are growing the constitution faster than the doctrine axis can settle it. A mirror, not a verdict.*</small>

### The convergence mirror

The one consequence a federation is least able to see for itself is **non-convergence** — a constitution that keeps growing flexible, conditional Invariants until coherence cycles never settle. No single council session feels like the one that broke it; the damage is emergent across many trains. So the framework holds up a **mirror**: a health signal that simply reports *"the last K trains added M Invariants; cycles are catching more and settling less."* It does not tell the federation to stop. It makes sure that when they don't stop, they did it with their eyes open. Surfacing the risk, choosing nothing.

This works because the loop is **damped, not perpetual**. For a fixed codebase it is *contractive*: every amendment codifies one class of incoherence, that class stops recurring, and the supply of nominations drains toward zero. The only thing that re-opens it is **external change** — new features, a new team, a post-launch surprise. It is a thermostat: quiet when the world is quiet, awake when the world changes.

## Why this exists

### Reason 1: Field discoveries are otherwise lost

Without an upward path, a discovery that is really a *constitutional* fact — a missing Invariant, an unnamed Primitive — gets consumed as a local fix and forgotten. The same class of incoherence is then re-discovered and re-fixed forever, in team after team, because the constitution never learned. The amendment protocol is the feedback edge that turns a one-time fix into a permanent law.

### Reason 2: Trust is built by candor, not by claims

A federation trusts a framework that can show it, months after launch, an honest living map: *here is what surfaced, here is what we aligned, here is what is queued and why, here is what your constitution should learn.* That candor — including openly tracked deferred and post-launch items nobody anticipated — builds more trust than any claim of perfection. The protocol's whole purpose is served the day it surfaces something real that the adopter never saw coming, and shows it being handled in the open.

### Reason 3: One codebase, many teams

Strict upward-only flow with one central constitution is what lets a federation scale *physically* across many teams without the codebase fracturing. Ratify together and everyone lands on the same truth; that shared landing is exactly what makes it **one** product instead of ten diverging ones. (See [Multi-team federation](../06-adoption-patterns/multi-team-federation.md) for the worked shape.)

### Reason 4: Decisions survive, so loops terminate

Because every disposition — accept, defer, reject — is recorded as [substrate](persistence-law.md), the council never re-argues a settled question, and the recurrence signal only ever counts *undecided* recurrence. Persisted decisions are what keep the learning loop convergent instead of circular.

## What violating this looks like

### Violation 1: The coherence engine amends the Charter directly

A doctrine-axis pass discovers a missing Invariant and writes it straight into the Charter mid-cycle. The enforcer just legislated. There was no ratification, no council, no version bump — and the next audit cannot tell which "constitution" any prior work was checked against.

**Fix:** the pass records the discovery and **nominates** it. The Charter changes only through a ratified `GO-UP-BUMP`.

### Violation 2: A finding floats sideways

Team A, having solved something cleanly, hands its new rule directly to Team B to adopt. Now two teams share a rule the Charter doesn't know about, and the other teams don't have it. The federation has begun to fork into dialects.

**Fix:** Team A nominates the finding upward. If ratified, it floats down to *all* teams as one Charter version — never team-to-team.

### Violation 3: The flag-day bump

A new Charter is ratified and pushed to every team as live-now. Ten teams, mid-feature, are all yanked onto alignment work in the same hour.

**Fix:** ratify once centrally, let teams adopt on their own cadence within a compatibility window, and sunset the old version on a deadline.

### Violation 4: The framework picks a winner

Faced with X-from-A versus ¬X-from-B, the framework auto-resolves the conflict by rule and applies its choice. It just dictated a constitutional decision that was the federation's to make.

**Fix:** the framework presents the situation, the evidence, the menu, and the consequences — and the council decides. Illuminate, never dictate.

### Violation 5: A rejection that wasn't recorded

The council declines a nomination but no one writes down the rejection. Next cycle the recurrence signal raises it again, and the council re-litigates the same item — every train, forever.

**Fix:** record every disposition as substrate. Decided is decided; recurrence counts only undecided findings.

## Implementation details

### Delta-scoped re-runs

After a Charter bump, a team does **not** re-run the whole doctrine axis. It re-runs only against the **amendment delta** — the slice the new Invariant or Primitive touches. A full S1→S5 sweep after every ratification is the treadmill that exhausts teams; a delta check is small, and shrinks each cycle. This is what makes *staggered adoption* affordable enough to actually stagger.

### Deferred work: the settlement cascade

Deferred nominations are not dropped — they are tracked as a **dependency cascade** so nothing is silently lost: *X settles when J.1 settles, which itself needs K.5*. Past three items this is unreadable as prose and obvious as a graph, so it is kept as one: plain-worded nodes, dependency edges, and a visible "ready now vs. blocked-by" frontier. The cascade is kept **acyclic by invariant**: a deferred item whose `blocked-by` would close a loop (X waits on Y while Y waits on X) is never left to stall silently — it is surfaced as a contested item for the council to break, and the [convergence mirror](#the-convergence-mirror) flags any deferred item with no reachable *ready-now* root. Items discovered **after go-live** — the ones nobody anticipated — enter the same cascade, in the same substrate, and survive every rotation because they live in git, not in a session. This is [GitAI](../00-foundation/gitai-category.md) doing its job: the audit layer remembering not just discoveries but the work still owed.

### Recording dispositions

Each council decision is written to substrate with its rationale and a [citation](provenance-law.md):

```
NOMINATION-<id>  <one-line finding>
  evidence:    recurrence <n> · teams [<team>...]
  disposition: ACCEPT → charter-v<n+1> (<invariant|primitive|charter-line>)
             | DEFER  → cascade, blocked-by [<nomination-id>...]
             | REJECT → reason: <...>
  ratified-at: <train-id> @ <commit/tag>
```

A later reader reconstructs *why* the constitution is the way it is from these records alone — no council member in the room required.

### This amends the federation's doctrine, not the framework's axioms

A clarifying boundary: this protocol governs how an adopter's **doctrine** (its Charter, Invariants, Primitives) amends. It is **not** the procedure for changing CompassAlpha's own seven-plus-this axioms — those still change only by forking the framework (see [Versioning the constitution](../00-foundation/constitution.md#versioning-the-constitution)). The amendment protocol is itself invariant: the *process* by which a constitution learns is fixed, even though the constitution's *content* changes every train.

## Variations / tunables on top

| Tunable | Default | Range |
|---|---|---|
| Train trigger | doctrine-cycle end (federation barrier) | cycle-end / fixed clock / emergency-threshold |
| Council composition | one lead per team | one-per-team / rotating quorum / weighted |
| Straggler rule | train sails at quorum; stragglers catch the next | sail-at-quorum / wait-for-all |
| Tie-break authority | federation's own governance (framework only illuminates) | recurrence-as-evidence / council vote / charter-defined |
| Charter version semantics | semantic (additive=minor, breaking=major) | semantic / monotonic / dated |
| Adoption model | staggered with sunset deadline | staggered+sunset / synchronized / advisory |
| Convergence mirror | on (report, don't gate) | on / on-with-warning / off |

The framework provides the *surface* for tie-breaks and dispositions; it never provides the verdict. What a deadlock resolves to is the federation's call — see [framework, not tool](../00-foundation/framework-not-tool.md).

[→ Tunables overview](../03-tunables/tunables-overview.md) for the trade-offs behind cadence and adoption stringency.

## How this connects to other axioms

- **[Persistence law](persistence-law.md)** puts every nomination, disposition, and deferred item on disk — which is what lets the loop terminate instead of circling.
- **[Provenance law](provenance-law.md)** is why discoveries are cited to substrate and why a reader can reconstruct *why* the constitution learned each thing.
- **[Bus protocol](bus-protocol.md)** is the channel nominations travel up on (as up-bumps) and ratified truth travels down on — never sideways.
- **[Tier grammar](tier-grammar.md)** + **[hard labour rule](hard-labour-rule.md)** are why the coherence engine can fix-and-align but not legislate: enforcing and ratifying are different tiers of authority.

## Remember this

- **Two directions, never crossed.** Findings flow *up* to the shared constitution; ratified truth flows *down* to every team; nothing goes team-to-team. That one rule is what keeps many teams building a single coherent codebase.
- **The enforcer doesn't write the law.** The coherence engine fixes code and *nominates* changes — a council *ratifies* them. Keeping those apart is what keeps the system auditable.
- **Gather, ratify, then float down — gently.** Discoveries pool at the end of a cycle, a small council decides, the Charter bumps, and teams adopt on their own cadence before the old version sunsets. Ratify together; never flag-day everyone at once.
- **The framework shows; it doesn't choose.** On a contested finding it lays out the situation, the evidence, the options, and the costs — including when the constitution is bloating — and then the federation decides. That restraint is the whole point of a framework over a tool.
- New here? See [the mental model](../00-foundation/mental-model.md) for how this axiom fits the bigger picture.

---

## Next: [Guardrails →](../02-guardrails/index.md)
