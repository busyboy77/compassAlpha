---
description: "Borrow CompassAlpha solo — the lightest possible adoption, for a single developer with one AI assistant and no federation. Keep a one-page Charter and cite every decision to git, and most coherence drift disappears for almost no ceremony. Includes a copy-paste minimal Charter template, the cite-by-substrate habit shown once, and the signal that tells you it's time to climb to the full framework."
---

# Borrow CompassAlpha (Solo)

> *One developer, one AI assistant, no federation. Borrow the two habits that do the most work — and skip everything else until your project needs it.*

This is **Rung 1** of [the adoption ladder](the-adoption-ladder.md): the lightest possible way to use CompassAlpha. You don't stand up two repos, tiers, or cycles. You take the **two ideas that prevent the most damage** and apply them by hand, today, on the project you already have.

It works because most of what goes wrong when you build with an AI assistant isn't a lack of intelligence — it's **coherence drift**: three slightly-different ways to do the same thing accreting across a codebase because nothing wrote down *the one canonical way*, and because the decisions that explain "why" evaporated when the chat scrolled off. Two habits fix most of that.

## A 60-second mental model

- **Charter** — a short document that records *the one canonical way to do each recurring thing* in your project. Think "the rulebook," but for solo use it's a single page you grow as you learn.
- **Cite by substrate** — keep the *decision* in **git** (a commit, a file), not in a chat window you'll lose. The state of your project is the state of your repo — so the answer to "why is it like this?" always lives somewhere you can re-read.

That's the whole idea. The rest of this page makes it concrete.

## Step 1 — Create a one-page Charter

Drop a file named `CHARTER.md` at the root of your repo. Start it almost empty — it grows as your project teaches you its real rules. Here's a complete starter you can copy and trim:

```markdown
# Project Charter — <your project>

> The one canonical way to do each recurring thing here.
> When my AI assistant and I disagree with this file, this file wins —
> until we deliberately change it (and record why in a commit).

## Invariants (rules that must always hold)
- Every timestamp is stored in UTC.
- IDs are UUIDv4; never reuse or recycle an ID.
- Money is integer minor units (cents), never floats.

## Canonical ways (one blessed approach per recurring thing)
- HTTP errors: return the shared `ApiError` shape, never ad-hoc JSON.
- DB access goes through the repository layer, never raw SQL in handlers.
- Dates are formatted at the edge (UI), never in the domain layer.

## Vocabulary (so the same word means the same thing everywhere)
- "Account" = the billing entity. "User" = a person who logs in. Not interchangeable.

## Open questions (things not yet decided — decide before relying on them)
- Soft-delete vs hard-delete for accounts? (TBD)
```

Keep it short. A Charter that's a page long gets read; a Charter that's twenty pages long gets ignored. When you discover a new "canonical way" mid-build, add **one line** here.

### How you actually use it with one AI assistant

At the start of a working session, point your assistant at the file:

> *"Read `CHARTER.md` first. Everything you write must follow it. If something you need isn't covered, propose a one-line addition to the Charter before you write the code — don't just pick an approach silently."*

That single instruction is what turns a Charter from a dead document into a live guardrail. The assistant now has *one canonical source* to conform to, instead of guessing fresh each turn — which is exactly what produces drift.

## Step 2 — Cite every decision to git

The second habit costs almost nothing and saves you constantly: **when a decision gets made, the commit is where it gets recorded** — not the chat.

Concretely, when you (or your assistant) make a choice that someone might later ask "why?" about, put the *why* in the commit message:

```text
feat(billing): store money as integer cents

Decided against floats — rounding errors were corrupting invoice totals.
Charter updated: "Money is integer minor units, never floats."

Ref: the duplicate-charge bug on 2026-06-10.
```

Now the reasoning is **durable**. Six weeks later when your assistant (in a fresh session with no memory of that chat) suggests a `float` price field, you — or it, if you ask it to check `git log` — can point at the commit and the Charter line. The decision survives the conversation that produced it. That's *cite-by-substrate*: the substrate (git) is the source of truth, not your recollection. ([More on why this matters →](../00-foundation/codebase-coherence.md))

> **The one-line version of both habits:** *write down the canonical way (Charter), and keep the reasons in git (cite-by-substrate).* Everything else in CompassAlpha is built on top of these two.

## What you're deliberately skipping (and that's fine)

At this rung you are **not** doing any of the following — on purpose:

- No second repo, no state-of-record remote (your one repo is enough).
- No tiers (planner / coordinator / builder) — you *are* all three.
- No alternating build/doctrine cycles, no locking, no gates, no bus.
- No founder-relay protocol (there's no federation to relay between).

If that machinery sounds like a lot for what you're doing — it would be. The honest guidance is: **don't adopt it until you have a reason to.** ([Is CompassAlpha for you yet? →](../index.md#is-compassalpha-for-you-yet))

## When to climb

You'll know Rung 1 has done its job and it's time for [Rung 2 — Bootstrap](the-adoption-ladder.md#rung-2-bootstrap) when one of these is true:

- **A second AI agent enters the picture** — now there are two parties who can each guess differently, and you need coordination, not just a shared file.
- **The Charter is doing real work but you keep forgetting to consult it** — you want the *locking and gates* that make conformance automatic instead of a habit you maintain by willpower.
- **The codebase has grown past what you can hold coherent in your head** — multiple modules, cross-cutting rules, "wait, how do we do X again?" happening weekly.

None of those yet? Then you're on the right rung. Keep borrowing — it's genuinely CompassAlpha, just by hand.

## Remember this

- **Two habits do most of the work:** a one-page **Charter** (the canonical way) + **cite-by-substrate** (reasons live in git).
- **Point your assistant at the Charter every session** — that's what makes it a live guardrail, not a dead doc.
- **Put the "why" in the commit message** — decisions must outlive the chat that made them.
- **Skip the federation machinery until you have a concrete reason** to climb — and the [ladder](the-adoption-ladder.md) names exactly what those reasons are.

---

## Next: [The adoption ladder →](the-adoption-ladder.md) · or [stand up the full framework →](greenfield-setup.md)
