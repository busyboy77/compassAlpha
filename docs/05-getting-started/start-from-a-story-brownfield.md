---
description: "Bring an existing, pre-AI-era project into CompassAlpha from a plain-English story. You describe the project you already have; the federation converts it into a CompassAlpha structure non-destructively — compatible compasses, a Charter extracted from what already exists, amendment-axis first to ratify it, then the build axis. The brownfield story-driven onboarding playbook."
---

# Start From a Story — Existing Project

> *Describe the project you already have. Get it brought into CompassAlpha without breaking what already works.*

This is the companion to [Start From a Story](start-from-a-story.md). That page is for a brand-new project (**greenfield**); this one is for a project that **already exists** — code, users, history, obligations — that you want to bring under CompassAlpha **without disrupting it**. As before, you start in plain English and the structure is the output, not a prerequisite. (Brand-new to the framework? Read [the mental model](../00-foundation/mental-model.md) first.)

## TL;DR

In plain terms: you point at the project you already have and say *"convert this to work with CompassAlpha and tell me the plan."* The framework reads what exists, gives each part its own planning document, **writes down the rules your project already lives by** (rather than inventing new ones), confirms those rules before any new building happens, and keeps your current system running untouched the whole time.

The order matters and is different from greenfield: for an existing project you **settle the rulebook first, then build** — because the rulebook has to be *discovered* from your existing code, and a discovery is a guess until it's confirmed.

## A few words you'll meet (defined once, here)

In addition to the terms on the [greenfield page](start-from-a-story.md#a-few-words-youll-meet-defined-once-here) (component, compass, Charter, axis), brownfield adds a few:

- **Extracted doctrine** — the rules your project *already* follows but never wrote down: conventions buried in code and in people's heads (e.g. "a ticket is never deleted, only closed"). Brownfield onboarding's first job is to surface these.
- **Amendment axis** (the doctrine axis, in its brownfield role) — the track of work that *writes down and ratifies* the rulebook. You run it **first** here, to confirm the extracted rules before building on them.
- **Parallel track** — your existing project keeps running on its current workflow, unchanged, while CompassAlpha is applied alongside it. Nothing is rewritten in place until it's proven.
- **Pilot component** — the first, low-risk component you bring under CompassAlpha to prove the rhythm before expanding.

## The flow, at a glance

![Start from a story, brownfield — an existing project is read and decomposed into compatible compasses, a Charter v0.1 is extracted from the rules it already follows, the amendment axis ratifies that Charter first, then the build axis runs, all on a parallel track that leaves the live system untouched](../assets/story-to-structure-brownfield.svg)

<small>*The brownfield flow differs from greenfield in two ways: the Charter is **extracted** from rules the project already follows (not invented), and the **amendment axis runs first** to ratify that extracted Charter before any building. Throughout, your live system stays on its own **parallel track** — the incorporation is non-destructive and revertible.*</small>

## Step 1 — Write your story

The brownfield template names a project that already exists and asks for a conversion plan:

```
As a <role>, I have an existing <project> with the following components:
<comp1>, <comp2>, … <compN>.
Convert it to be CompassAlpha-compatible, and print the scope
for building under CompassAlpha.
```

### A worked example

Say you run an existing customer-support app:

> *"As a support lead, I have an existing app, **Helpdesk**, with the following components: **tickets** (support requests and their lifecycle), **agents** (the staff who answer them), and **knowledge-base** (self-serve articles). Convert it to be CompassAlpha-compatible and print the scope for building under CompassAlpha."*

Three existing components. Nothing about your running system changes by writing this; it's a request for a plan.

## Step 2 — Each component becomes a *compatible* compass

The federation reads your existing code for each component and writes **one compass per component** — but where greenfield *invents* the compass, brownfield *reverse-engineers* it from what's already there:

| Compass | 60K — extracted why | 30K — extracted how | 10K — extracted detail |
|---|---|---|---|
| **tickets** | "A ticket is a durable record of a customer's problem; it is never destroyed." | the lifecycle the code actually implements (open → pending → closed) | the real `ticket` schema + the (undocumented) rule that closing never deletes |
| **agents** | "An agent is a staff identity; tickets are assigned to agents." | how assignment and availability work today | the `agent` schema + the routing rule found in the code |
| **knowledge-base** | "Articles are public, versioned help content." | how articles are authored and published now | the `article` schema + the publish workflow |

These are **compatible** compasses: they describe your system *as it is*, anchored to real files, so nothing is misrepresented. Anything the code does that nobody can explain becomes an **open question** to resolve — not a fact to assert.

## Step 3 — A Charter v0.1 is *extracted* (not invented)

Here is the key brownfield difference. The **Charter** — the project-wide rulebook — is **derived from the rules your project already lives by**. As the compasses are reverse-engineered, recurring rules surface across components:

- "a ticket is never deleted, only closed" — found in `tickets`, but it's really a project-wide guarantee → candidate **invariant**.
- "every record is scoped to an agent or a customer" — found in all three → candidate **primitive**.

These get collected into a **Charter v0.1** — a *first draft of the rulebook the project already follows*, expressed in CompassAlpha terms. It is explicitly a **draft extracted from existing behaviour**, which is exactly why it has to be confirmed before anyone builds on it.

## Step 4 — The amendment axis runs *first*, then the build axis

This is the order that differs from greenfield, and here's the reasoning in full:

A greenfield Charter is something you *decide*. A brownfield Charter is something you *discovered* — and a discovery is a **guess until it's ratified**. If you let the build axis start writing new code against an unconfirmed rulebook, you'd be building on assumptions that might be wrong. So:

1. **Amendment axis first (rulebook UNLOCKED).** You run a doctrine pass whose job is to *review and ratify the extracted Charter v0.1*: confirm each extracted invariant is real, fix the ones that were misread, and resolve the open questions the reverse-engineering raised. The output is a Charter you *trust*, because a human confirmed it — not just code that implied it.
2. **Build axis next (rulebook LOCKED).** Only once the rulebook is ratified does new building begin, against compasses and a Charter you can now rely on.

Doctrine-first, because in a brownfield project the doctrine is the thing you are *least sure of*. (Greenfield is the opposite: you decide the rules, so a light doctrine pass suffices and building can begin sooner.)

## Step 5 — Your live system stays safe (integrity is preserved)

Incorporation is **non-destructive** by design. Concretely:

- **Parallel track.** Your existing Helpdesk keeps serving customers on its current workflow, unchanged, the entire time. CompassAlpha is applied *alongside* it, not by rewriting it in place.
- **Pilot first.** You bring one low-risk component under CompassAlpha first — say `knowledge-base` — prove the rhythm, then expand to `tickets` and `agents`. You don't convert everything at once.
- **Revertible.** Every step is reversible; nothing replaces the live system until it's proven. This is the same discipline the [Cutover from a pre-AI project](cutover-from-pre-AI-project.md) page walks through in detail.

The guarantee: at no point does adopting CompassAlpha put your running project at risk.

## Step 6 — Add more axes later, at your liberty

Once the build axis is running, you can incorporate **additional axes** — review, QA, ops, compliance, pen-test, and so on — **at any later stage**, whenever it suits you. They slot in without disturbing what's already running. See [axis declarations](../03-tunables/axis-declarations.md) for how a new axis is added.

## Step 7 — What you get out: the printed scope

```
PROJECT: Helpdesk  ·  mode: brownfield incorporation (non-destructive)
COMPASSES (3):  tickets · agents · knowledge-base   (compatible, each 60K/30K/10K)
CHARTER:        v0.1 EXTRACTED from existing behaviour — awaiting ratification
                candidate invariant: "a ticket is never deleted, only closed"
AXES:           amendment axis FIRST (ratify Charter) → build axis (LOCKED)
INTEGRITY:      live system on parallel track · pilot = knowledge-base · fully revertible
FIRST CYCLE:    amendment pass to ratify Charter v0.1
```

From here, follow [Brownfield onboarding](brownfield-onboarding.md) for the full phased journey and [Cutover from a pre-AI project](cutover-from-pre-AI-project.md) for the revertible, step-by-step walkthrough.

## Remember this

- **You start from the project you already have**, described in plain words — the conversion plan is the output.
- **Compasses are reverse-engineered**, not invented: each describes your system *as it is*, anchored to real code.
- **The Charter is *extracted*, not decided** — a first draft of the rules your project already follows.
- **Amendment axis runs first**, because an extracted rulebook is a guess until a human ratifies it; only then does the build axis run. (Greenfield is the reverse — you decide the rules, so building starts sooner.)
- **Your live system is never at risk**: parallel track, pilot-first, fully revertible.
- The brand-new-project version of this is the [greenfield Start From a Story](start-from-a-story.md).

---

## Next: [Brownfield onboarding →](brownfield-onboarding.md)
