---
description: "The CompassAlpha adoption ladder — a you're-here → next-safe-step map of how to adopt the framework at your own pace. Four named rungs (Borrow, Bootstrap, Federate, Scale), each with what you adopt, what you get, and the signal to climb. Start on the rung that fits you today; it is the same framework all the way up, never a different product."
---

# The Adoption Ladder

> *Start on the rung that fits you today. Climb when — and only when — your project tells you to.*

A common worry on first contact with CompassAlpha is *"this looks like a lot — is it all-or-nothing?"* It is **not**. Adoption is a ladder you climb at your own pace, one rung at a time, and you start wherever your project actually is right now. Each rung is a complete, safe place to stand: you get real value there, and you only climb when a concrete signal tells you the next rung will pay for itself.

This page is your map: **find your rung, see what it gives you, and know the single signal that means it's time for the next one.** The same framework runs all the way up — climbing means *adopting more of it*, never switching to a different product.

## The four rungs at a glance

![The adoption ladder — five rising rungs starting from Rung 0 'Sketch' (just an idea, no code) through Borrow, Bootstrap, Federate, and Scale. Each rung shows who it's for, what you do or adopt, what you get, and the signal to climb. A red marker on the ground reads 'start where you fit — no code? Rung 0; one dev? Rung 1; both fine.' One Charter plus cite-by-substrate carries up every rung above 0.](../assets/adoption-ladder.svg)

<small>*Left to right is "just an idea, no code" → full-framework. You don't skip rungs and you don't have to reach the top — most adopters get lasting value partway up. The one thread that runs through every building rung: keep a **Charter** and **cite decisions to git**.*</small>

## Find your rung

Read down this table and stop at the first row that sounds like you today:

| If this is you… | You're on | What changes when you climb |
|---|---|---|
| You have only an **idea** and you **don't write code** | **Rung 0 — Sketch** | You hand your plan to an AI assistant or a developer, who stands it up |
| Solo, one AI assistant, a small or one-off project | **Rung 1 — Borrow** | A second agent or a growing codebase makes coherence hard to hold in one head |
| Ready to run your first real project *on the framework*, want it gentle | **Rung 2 — Bootstrap** | Your first cycle closes cleanly and the rhythm feels natural |
| Running build **and** doctrine work, want a steady cadence | **Rung 3 — Federate** | More modules or contributors than one cadence can hold |
| A multi-module estate, a brownfield system, or several contributors | **Rung 4 — Scale** | You're running the full framework — now you *tune*, you don't climb |

Nobody is turned away — not even someone who doesn't write code. There's no shame in a low rung: **many builders start at Rung 1, and non-technical idea-owners start at Rung 0**, and plenty get everything they need without ever reaching the top.

---

## Rung 0 — Sketch

*Just an idea · no code · non-technical.*

The ground floor. You have a project in your head and you can describe it, but you don't build software yourself. You don't touch git, a repo, or a terminal here. You do the one part only you can do — **shape the idea into a plain-language plan** — and then hand that plan to someone (or something) that does the technical part.

**What you get:** a clear **plan you own** — the vision, the parts, and the rules — written in your own words, so you can read it, change it, and explain it.

**Climb when:** you hand the plan off — to an AI assistant (with a ready-made kickoff) or to a developer (with a one-line brief), who stands the project up for you.

→ **This rung is written for you, step by step, with no code anywhere:** [Start with just an idea](start-with-an-idea.md).

---

## Rung 1 — Borrow

*Solo · one AI assistant · no federation.*

The lightest possible start. You don't stand up any of the federation machinery — no second repo, no tiers. You **borrow the two ideas that do the most work** and apply them by hand:

- **Keep a Charter** — one short document that records *the one canonical way to do each recurring thing* in your project. (A **Charter** is the project's rulebook; here it's a single page you grow as you go.)
- **Cite by substrate** — let decisions live in **git** (commits, files), not in a chat window you'll lose. The state of your project is the state of your repo.

**What you get:** most *coherence drift* — the slow sprawl of three slightly-different ways to do the same thing — disappears, for almost no ceremony.

**Climb when:** a second agent joins, or the codebase grows past what one person can keep coherent in their head.

→ **This rung is fully written up, step by step:** [Borrow CompassAlpha (solo)](borrow-compassalpha-solo.md). New to the vocabulary? Read [the mental model](../00-foundation/mental-model.md) first.

---

## Rung 2 — Bootstrap

*Your first real project on the full framework — tuned slow and safe.*

Here you stand up the actual framework: **two repos** (one for code, one as the state-of-record) and the **three tiers** (a senior planner, a coordinator, and the hands-on builder). You run it under the **Bootstrap preset** — the leanest *posture*, not a stripped-down framework. It's the full setup with every dial turned to slow-and-safe so nothing moves faster than you can follow.

!!! tip "Coming from Rung 1? This is a step, not a wall."
    The jump from Rung 1 can look bigger than it is, because two new ideas arrive at once. In plain words:

    - **Two repos** — one holds your **code**, the other is the federation's **notebook** (who decided what, what's pending). Keeping them apart means the record of *why* never gets tangled with the *what*. You make two folders; you don't learn anything new to do it.
    - **Three tiers** — instead of one assistant juggling everything, the work splits across a **planner**, a **coordinator**, and a **builder**. That's not more for *you* to do; it's how the machinery keeps each part focused so nothing gets muddled.

    On **Bootstrap** these run slow and quiet while you find your feet, and you don't memorize any of it — [the mental model](../00-foundation/mental-model.md) explains the ideas, and [greenfield setup](greenfield-setup.md) walks the steps one at a time. Nobody stands this up in one sitting.

**What you get:** the complete safety net, dialled gentle — cycles that **lock** the rulebook while code is written, and gates that check work before it lands.

**Climb when:** your first cycle closes cleanly and the alternating rhythm (settle the rules → lock → build) feels natural rather than effortful.

→ Stand it up with [greenfield setup](greenfield-setup.md) (new project) or [brownfield onboarding](brownfield-onboarding.md) (existing codebase); choose your posture in [operating presets](../04-toggles/operating-presets.md).

---

## Rung 3 — Federate

*Multiple axes, taking turns.*

Now more than one *track of work* runs — a **build axis** (writes code) and a **doctrine axis** (changes the rulebook) alternating in bounded cycles, and you can add day-2 axes like QA or ops. The tiers coordinate across them; the bus carries the hand-offs; git records every step.

**What you get:** *vision → coherent code* at a steady, **auditable** cadence — the framework's core promise, running for real.

**Climb when:** you have more modules or contributors than a single cadence can comfortably hold.

→ See it work end-to-end in [the sample doctrine cycle](../06-adoption-patterns/sample-doctrine-cycle.md) and [the day-2 cycles](../06-adoption-patterns/sample-day2-qa.md).

---

## Rung 4 — Scale

*A multi-module estate · brownfield systems · several contributors.*

The top of the ladder. You onboard modules **one at a time**, add axes as new kinds of work appear, and run a different posture per lane (a heavyweight doctrine change and a one-line fix don't deserve the same ceremony — see [work-granularity lanes](../03-tunables/work-granularity-lanes.md)).

**What you get:** a large codebase that **stays coherent as both it and the team grow** — the thing that's almost impossible to hold by hand at scale.

**You're at the top:** from here you *tune*, you don't climb. The remaining surface is the [tunables](../03-tunables/) and [toggles](../04-toggles/).

→ For existing large systems, the safe path in is [cutover from a pre-AI project](cutover-from-pre-AI-project.md) — non-destructive, parallel-track, revertible. Coordinating **several teams across several components**? See [multi-team federation](../06-adoption-patterns/multi-team-federation.md) — including how the relay avoids becoming a bottleneck and how teams sit on different rungs at once.

---

## The thread that runs up every rung

Notice that **Rung 1's two habits never leave you**: a Charter and cite-by-substrate are still the spine at Rung 4 — the higher rungs add federation, axes, and tiers *around* that same core. That's why borrowing them solo is a genuine first rung and not a throwaway: you're already doing the most load-bearing part of CompassAlpha, just by hand. Climbing automates and enforces what you were already doing. (Rung 0 sits *below* that thread: there you produce the plain-language plan the Charter and the parts are later grown from — the thinking the whole spine rests on.)

## Remember this

- **Adoption is a ladder, not a cliff** — start on the rung that fits your project *today*.
- **Each rung is a complete place to stand** — real value, not a half-installed version of the next one.
- **Climb on a signal, not a schedule** — each rung names the one concrete thing that means it's time.
- **It's the same framework all the way up** — climbing adds more of it; it's never a different product.
- **The lowest rung is real** — a Charter + cite-by-substrate is the spine that carries all the way to the top.

---

## Next: [Borrow CompassAlpha (solo) →](borrow-compassalpha-solo.md)
