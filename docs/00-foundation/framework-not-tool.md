---
description: "CompassAlpha is a framework, not a tool: a constitution and protocol for multi-tier AI-agent collaboration. Bring your own AI agents, your own git, your own host."
---

# Framework, not tool

> *The single most important framing in CompassAlpha. If you skip this page and assume CompassAlpha is a tool, you will fail to adopt it.*

In plain terms: this page explains that CompassAlpha is a set of rules and conventions you read and apply — not a program you download and run. Get this distinction right and everything else in the portal will make sense.

## TL;DR

The short version: you don't install CompassAlpha; you adopt its rules and use them with the tools you already have.

CompassAlpha is a **constitution + protocol specification + a set of conventions** (a written rulebook plus shared vocabulary, not software) for coordinating multi-tier AI-agent federations — that is, teams of AI agents working together in defined roles. It is **not**:

- A tool you `pip install` or `npm install`
- A SaaS you subscribe to
- An AI agent itself
- A monitoring dashboard
- A library that runs your code

It **is**:

- A protocol specification (read-only doctrine)
- A vocabulary for naming tiers, axes, lanes, cycles, stages
- A set of `[INVARIANT]` rules and `[TUNABLE]` parameters
- A reference implementation pattern
- Templates you stamp into your own files
- This portal

When you adopt CompassAlpha, **you don't install anything**. You bring your own git, your own AI agent (Claude Code is the reference), your own host. CompassAlpha governs how they collaborate.

---

## Why framework vs tool matters

### What a tool would mean

Were CompassAlpha a tool, it would arrive as machinery: a `compassalpha init` that scaffolds a project, a `compassalpha dispatch` that launches a tier session, a daemon humming on your host, a web UI showing dashboards, an API your code calls into. Each of those is a decision made *for* you — and together they would constrain you to one specific implementation of the idea.

### What a framework means

CompassAlpha takes the opposite shape. It specifies the *what*, not the *how*: which roles exist (Mentor-1 / Mentor-2 / Doer), what the bus protocol looks like (inbox-in-destination), what the persistence law requires (flush-before-disclose), what the firewall enforces (confined-not-banished), and what the trade-off space looks like (speed × intelligence × cost × risk × predictability).

What it deliberately leaves open is everything that should stay yours — which AI agent you use, which git host you push to, which language your codebase is written in, which monitoring stack and CI/CD pipeline you already run. You bring all of those. The framework governs how the AI tiers you assemble interact, using your existing infrastructure as the substrate.

---

## What "no installation" looks like in practice

Adopting CompassAlpha looks like this:

**Step 1: Create a reviewer-state repository.**

```bash
mkdir -p ~/projects/MyProjectReviewer && cd ~/projects/MyProjectReviewer
```

This makes a new folder for your reviewer state and then moves you into it. `mkdir -p` creates the folder (the `-p` flag means it won't complain if parent folders are missing and quietly creates them too), and `cd` ("change directory") is what makes that folder your current working location so the next commands act inside it.

```bash
git init
```

This turns the current folder into a git repository — that is, it tells git to start tracking the history of everything in here. Git is the version-control system that records every change over time; CompassAlpha uses it as the durable, auditable record of the federation's work.

```bash
git remote add origin git@github.com:you/MyProjectReviewer.git
```

This links your local repository to a copy hosted online (here, on GitHub). A "remote" is just a named pointer to that hosted copy; by convention the main one is called `origin`. Adding it lets you later push your local history up to the host so it's backed up and shareable. Swap in your own host and path.

Then, with the folder in place:

- **Step 2:** Read the CompassAlpha constitution + axioms (in this portal).
- **Step 3:** Author your axis declarations (~30 lines of markdown).
- **Step 4:** Stamp the boot template for your top-tier mentor (~50 lines).
- **Step 5:** Start your AI agent in that folder, point it at this portal.

That's it. No CompassAlpha binary, no daemon, no API key.

All you have done is create a folder, add some markdown files, and start an AI agent. The framework's value lives entirely in **what those markdown files contain** — the protocols, conventions, and rules — not in any executable.

---

## The reference implementation pattern

CompassAlpha is similar in shape to other widely-known frameworks:

| Framework | What you install | What you bring |
|---|---|---|
| **HTTP/REST** (the protocol) | nothing | your server, your client, your data |
| **The Twelve-Factor App** (the methodology) | nothing | your runtime, your infra |
| **GitOps** (the pattern) | nothing | your CI, your k8s cluster |
| **CompassAlpha** (this framework) | nothing | your AI agents, your git, your host |

In each case, the **specification is the value**. Implementations come from many sources.

---

## "But I want a tool"

There is a real appetite for a runnable tool that implements CompassAlpha for you — and that's a genuine market gap, just not the thing CompassAlpha itself is. Such a tool would be a downstream project: one of many possible implementations of the specification, the way nginx and Apache are both implementations of HTTP.

That space is `[OPEN]` for the community to build, post v1.0 stable release. The framework itself stays specification-only — which is exactly what lets many such tools exist without any of them owning the standard.

---

## Why the framework path is the right choice

The framework form is not a hedge against shipping a tool — it is the form the problem actually demands. Cast as a tool, CompassAlpha would inherit a familiar set of failures:

!!! danger "Why tool-form fails for this category"

    - **Lock-in to a single AI agent** — your tool needs to integrate with one or two AI providers; switching is hard.
    - **Lock-in to a single host** — your tool runs on someone's infrastructure; switching is migration.
    - **Tool author becomes the bottleneck** — every framework refinement has to be coded by tool maintainers.
    - **Adopters can't tune deeply** — they get whatever the tool exposes; not the full surface.
    - **Audit/security review is harder** — tools are black boxes; protocols are inspectable.

Staying framework-form sidesteps every one of these. Adopters tune as deeply as they need, switch AI agents freely, switch hosts freely, and build their own tooling on top — none of which a bundled tool could grant them.

---

## The framework-tool spectrum (where CompassAlpha sits)

```
                          PURE TOOL                           PURE FRAMEWORK
                          (everything bundled)                (specification only)
                          |
                          v
GitHub Copilot            Claude Code             HTTP        CompassAlpha          The Constitution
(IDE plugin)              (CLI tool)              (RFC 7230)  (this portal)         of any nation
                                                              ^
                                                              |
                                                              CompassAlpha lives here
```

CompassAlpha sits firmly on the framework end. Closer to HTTP and constitutional documents than to IDE plugins. This is **deliberate**.

---

## Implications for adopters

If you're considering adoption:

!!! tip "Set your expectations right"

    - Expect to **read** more than you **install** (this portal exists for that reason).
    - Expect to **decide** more than you **configure** (the [Tunables](../03-tunables/) section has the choices).
    - Expect to **integrate** more than to **deploy** (CompassAlpha works alongside your existing CI/CD, not instead of it).
    - Expect adoption to take **weeks to months** for a brownfield project (see [Brownfield Onboarding](../05-getting-started/brownfield-onboarding.md)).

If what you want is plug-and-play, the community tooling layer is where that will live (`[OPEN]` post-v1.0) — the framework is the foundation it will be built on.

---

## Why this framing was hard-won

Framework-form was chosen over tool-form deliberately, and three forces made the choice unavoidable:

1. **Multi-vendor AI portability** — a federation might run on one AI agent today and another tomorrow. A protocol survives vendor changes; a tool does not.
2. **Host portability** — a federation may move hosts mid-cycle. A tool would demand reinstallation; a protocol asks only for path updates.
3. **Tier specialization** — each project's tiers carry domain-specific names and responsibilities that no one-size-fits-all tool could hold cleanly. Specialization-by-stamping is what makes the framework work.

These are the decisions CompassAlpha makes once, and then exports to every project that adopts it.

---

## Remember this

- **CompassAlpha is something you read and apply, not something you install.** No binary, no daemon, no API key — just markdown files you write and an AI agent you already use.
- **The value lives in the rules, not in any executable.** Think HTTP or a constitution: the specification is what's worth having, and many implementations can be built on top of it.
- **You keep your own tools.** Your git, your AI agent, your host, your CI/CD all stay yours; the framework only governs how the pieces collaborate.
- If the difference between "framework" and "tool" still feels abstract, [the mental model](mental-model.md) page lays out the bigger picture it fits into.

---

## Next: [Origin — why GitAI →](origin-story.md)
