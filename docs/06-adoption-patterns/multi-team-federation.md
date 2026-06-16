---
description: "A worked example of CompassAlpha across multiple teams: distinct teams each owning a different component (sub-project), all under one Charter, coordinated through git — staged team-by-team, coherent across teams, without the lead becoming a per-decision bottleneck. Shows how founder/relay load scales with cross-team coupling, not team count, and how different teams can sit on different adoption rungs at the same time."
---

# Multi-Team Federation

> *Several teams, each owning a different component, all building one coherent codebase under one Charter — staged team-by-team, with no big-bang and no single person turning into the bottleneck.*

**In plain terms:** most real adoptions aren't one person or one team — they're *several* teams, each responsible for a different part of the product, who somehow have to not drift apart. This page shows what CompassAlpha looks like at that scale: distinct teams, distinct components, one shared rulebook, git as the thing that keeps them coherent. It answers the question a manager asks first — *"can I roll this out across my teams without it becoming chaos, or without every decision routing through me?"*

New here? Start with [the mental model](../00-foundation/mental-model.md), then [codebase coherence](../00-foundation/codebase-coherence.md) — this page assumes both.

## The setup: four teams, four components, one Charter

We reuse the [Northwind](index.md#the-example-application-used-throughout) example — but instead of one team building four modules, picture **four separate teams**, each owning one component as its own sub-project:

| Team | Owns (its component / sub-project) | Its Compass |
|---|---|---|
| **Team Identity** | Auth — accounts, sessions, roles, SSO | `auth` |
| **Team Revenue** | Billing — subscriptions, invoices, payments | `billing` |
| **Team Insights** | Reporting — dashboards, exports, warehouse | `reporting` |
| **Team Reach** | Notifications — email/SMS/in-app delivery | `notifications` |

Each team runs its **own** federation tiers (Mentor-1 / Mentor-2 / Doer) and its **own** cycles on its **own** Compass. What binds them into one codebase rather than four drifting ones is the layer above them:

![Team federation — one Charter at the top, distributed teams inheriting it, with Git as the glue binding them into one coherent codebase](../assets/team-federation.svg)

<small>*One Charter at the top; each team builds its component beneath it; git is the glue. The teams are independent in their day-to-day, identical in the rules they're bound to.*</small>

## What keeps four teams coherent (and not four codebases)

Three things, all from the [doctrine substrate](../00-foundation/constitution.md#the-doctrine-substrate-charter-compasses-and-axis-annexes):

1. **One Charter, not one per team.** Every team is bound to the *same* federation Charter — the same [invariants](../00-foundation/glossary.md#invariants) (rules that must hold everywhere) and the same [primitives](../00-foundation/glossary.md#primitives) (the one canonical definition of each shared concept). Team Revenue and Team Insights both reuse the *same* `Money` primitive and the *same* `Account` definition — they can't each invent their own, because there's one canonical place each is defined.
2. **Each component is a Compass under that Charter.** A team has full design latitude *inside* its own Compass, and zero latitude to redefine a shared concept. Tight at the center, flexible at the edges.
3. **Git is the glue.** Every team's state — decisions, cycles, frozen tags — lives in git, so coherence is verifiable across teams the same way it is within one: cite by substrate, not by what some team *says* it did.

The result is the thing that's almost impossible to hold by hand at multi-team scale: **physical distribution without divergence.** Without the shared Charter, several teams is just distributed drift; the Charter is what makes the distribution safe.

## The bottleneck question — answered

The most common multi-team fear is *"if I'm the relay, do I become the bottleneck — N teams, N× the decisions through me?"* The framework's answer is **no, and structurally so:**

- **Within-team decisions never reach you.** Each team's **Mentor-1 owns its own cycles** and arbitrates its own component-level calls. A choice that lives entirely inside Billing is settled inside Team Revenue — it never lands on the founder's desk.
- **You relay, you don't arbitrate.** The [founder is a low-cognitive-load relay](../00-foundation/constitution.md) — one-liner pings and a lost-and-found backstop — *not* a per-decision authority. (This is an axiom, not a style choice.)
- **So your load scales with cross-team *coupling*, not team count.** The only things that need you are (a) a hand-off *between* two teams and (b) a [GO-UP-BUMP](../00-foundation/glossary.md#bump) — a charter-level change that affects everyone. The one Charter + shared primitives are designed to *minimize* exactly that coupling. Ten loosely-coupled teams generate less founder traffic than two tangled ones.

If you find yourself in every decision, that's a signal the work is mis-sliced (components too entangled), not that the framework demands it — the fix is cleaner component boundaries, not more of your time.

## Teams can sit on different rungs at the same time

Onboarding is not synchronized. Because [adoption is per-unit](../00-foundation/constitution.md#layer-1-the-7-axioms-invariant), each team climbs the [adoption ladder](../05-getting-started/the-adoption-ladder.md) at its own pace:

- **Team Identity** is mature — running multiple axes (build + a Day-2 QA axis): **Rung 3, Federate.**
- **Team Revenue** stood up its first federation last month: **Rung 2, Bootstrap.**
- **Team Reach** is a legacy module still being brought in [non-destructively](../05-getting-started/brownfield-onboarding.md): pre-Rung-2, on the parallel track.

All three coexist **under the one Charter**, indefinitely. A team graduates a rung when *it's* ready — there is no estate-wide cutover, and no team is held back by another.

## Worked moment: a cross-team change

Team Revenue discovers that invoice line-items and Reporting's exports need a shared `TaxRule` concept — today each is about to grow its own. That's a **cross-cutting** change, so it does **not** get solved twice, ad hoc, inside two teams:

1. The need is surfaced as a **doctrine** concern, not a build task — a candidate new **primitive** for the Charter.
2. A **doctrine cycle** runs: `TaxRule` is defined once, the Charter is amended, and the change closes with a **GO-UP-BUMP** (`charter-v<n+1>`).
3. Both Team Revenue and Team Insights now **inherit** the one `TaxRule` definition and build against it. Neither invented a private version; the codebase stays coherent.

Contrast the without-CompassAlpha path: each team ships its own `TaxRule`, the two subtly diverge, and six months later a tax change has to be made — differently — in two places. The GO-UP-BUMP discipline is what prevents *"someone had an idea and shipped it"* from fracturing a multi-team codebase.

## Who fills the tiers — humans, AI, or a mix

The framework cares about **positions, not persons**. A "team" here is a set of tier roles, and each role can be filled by a human, an AI session, or a combination:

- A team might be **one human lead + AI sessions** playing Mentor-2 and Doer.
- Or **several humans** splitting the tiers, with AI assisting the Doer.
- The founder/relay is usually one human (or a small group acting as one role) across *all* teams.

Nothing in this page changes based on that choice — the coordination, the Charter, and the bus work identically whether a tier is a person or a session. That's what lets a federation scale across many human teams without changing its shape.

## Remember this

- **One Charter, many teams.** Each team owns its component's Compass; all are bound to the same invariants and primitives — that shared center is what keeps the codebase coherent across teams.
- **You won't become the bottleneck.** Teams settle their own internal decisions; you relay only cross-team hand-offs and charter-level changes — so your load tracks coupling, not headcount.
- **Teams climb independently.** Different teams sit on different [rungs](../05-getting-started/the-adoption-ladder.md) at the same time; there is no big-bang.
- **Cross-cutting changes go through a GO-UP-BUMP**, defined once at the Charter, never reinvented per team.
- **Positions, not persons** — a tier can be a human or an AI session; the structure is identical either way.

---

## Next: [Sample doctrine cycle →](sample-doctrine-cycle.md)
