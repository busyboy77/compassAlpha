# Framework, not tool

> *The single most important framing in CompassAlpha. If you skip this page and assume CompassAlpha is a tool, you will fail to adopt it.*

## TL;DR

CompassAlpha is a **constitution + protocol specification + a set of conventions** for coordinating multi-tier AI-agent federations. It is **not**:

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

If CompassAlpha were a tool, it would be something like:
- `compassalpha init` to scaffold a project
- `compassalpha dispatch` to launch a tier session
- A daemon running on your host
- A web UI showing dashboards
- An API your code calls into

It would **constrain you** to using its specific implementation.

### What a framework means

CompassAlpha specifies:
- **WHAT** roles exist (Mentor-1 / Mentor-2 / Doer)
- **WHAT** the bus protocol looks like (inbox-in-destination)
- **WHAT** the persistence law requires (flush-before-disclose)
- **WHAT** the firewall enforces (confined-not-banished)
- **WHAT** the trade-off space looks like (speed × intelligence × cost × risk × predictability)

It does **NOT** specify:
- Which AI agent you use
- Which git host you push to
- Which language your codebase is in
- Which monitoring stack you run
- Which CI/CD pipeline you have

You bring all those. The framework governs how the AI tiers you assemble interact — using your existing infrastructure as the substrate.

---

## What "no installation" looks like in practice

Adopting CompassAlpha looks like this:

```bash
# Step 1: Create a reviewer-state repository
mkdir -p ~/projects/MyProjectReviewer && cd ~/projects/MyProjectReviewer
git init
git remote add origin git@github.com:you/MyProjectReviewer.git

# Step 2: Read the CompassAlpha constitution + axioms (in this portal)
# Step 3: Author your axis declarations (~30 lines of markdown)
# Step 4: Stamp the boot template for your top-tier mentor (~50 lines)
# Step 5: Start your AI agent in that folder, point it at this portal

# That's it. No CompassAlpha binary, no daemon, no API key.
```

What you've done: created a folder, added some markdown files, started an AI agent. The framework's value is in **what those markdown files contain** — the protocols, conventions, and rules — not in any executable.

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

If you specifically want a runnable tool that implements CompassAlpha for you, that's a valid market gap — but it's NOT what CompassAlpha is. Such a tool would be a downstream project — one of many possible implementations of CompassAlpha (the way nginx and Apache are both implementations of HTTP).

CompassAlpha-as-a-tool is `[OPEN]` for the community to build, post v1.0 stable release. The framework itself stays specification-only.

---

## Why the framework path is the right choice

If CompassAlpha were a tool, it would have these problems:

!!! danger "Why tool-form fails for this category"

    - **Lock-in to a single AI agent** — your tool needs to integrate with one or two AI providers; switching is hard.
    - **Lock-in to a single host** — your tool runs on someone's infrastructure; switching is migration.
    - **Tool author becomes the bottleneck** — every framework refinement has to be coded by tool maintainers.
    - **Adopters can't tune deeply** — they get whatever the tool exposes; not the full surface.
    - **Audit/security review is harder** — tools are black boxes; protocols are inspectable.

By staying framework-form, CompassAlpha avoids all of these. Adopters tune as deeply as they need; switch AI agents freely; switch hosts freely; build their own tooling on top.

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

If you wanted plug-and-play, **this is not for you yet** — wait for the community tooling layer (`[OPEN]` post-v1.0).

---

## Why this framing was hard-won

Framework-form is explicitly **chosen** over tool-form for these reasons:

1. **Multi-vendor AI portability** — a federation might run on one AI agent today and another tomorrow. A protocol survives vendor changes; a tool doesn't.
2. **Host portability** — a federation may move hosts mid-cycle. A tool would require reinstallation; a protocol just requires path updates.
3. **Tier specialization** — each project's tiers carry domain-specific names and responsibilities that wouldn't fit cleanly into a one-size-fits-all tool. Specialization-by-stamping is what makes the framework work.

CompassAlpha exports these decisions to other projects.

---

## Next: [The Constitution →](constitution.md)
