# Prerequisites

> *Four things, no more: a git host, an AI agent harness, a founder/relay, and a state-of-record remote. If you have these, you can run a CompassAlpha federation.*

CompassAlpha is a [framework, not a tool](../00-foundation/framework-not-tool.md) — there is nothing to `npm install`. What you assemble instead is a small set of capabilities. This page is the checklist. Nothing here is exotic; most teams already have three of the four.

## The four prerequisites

| # | Prerequisite | What it provides | Reference choice |
|---|---|---|---|
| 1 | A **git host** for tier sessions | Where AI sessions actually run; where worktrees and indexes live | Any Linux/macOS machine you control |
| 2 | An **AI agent harness** | The thing that boots a fresh session per slice and reads a stamped boot file | A coding agent that supports fresh-session-per-task |
| 3 | A **founder / relay** | The one human in the loop — spawns sessions, relays one-line pings, arbitrates lost+found | One person (or a small team acting as one role) |
| 4 | A **state-of-record remote** | The durable origin for both repos; the audit trail; disaster recovery | Any git remote (a hosted service or self-hosted) |

If you can tick all four, you're ready. The rest of this page makes each concrete.

---

## 1. A git host

This is the machine where tier sessions run. It needs:

- [ ] **git** installed (any reasonably current version — you'll use `worktree`, `commit-tree`, `update-index`, `write-tree`, `update-ref`).
- [ ] A working directory you control for both repos as **sibling directories** (never nested):
  ```
  /path/to/substrate         ← your project's code or doctrine source
  /path/to/reviewer-state    ← the federation's judicial / coordination state
  ```
- [ ] Enough disk for per-session worktrees under `/path/to/substrate/.work-tmp/` (each parallel Doer gets its own).
- [ ] Predictable behaviour you can document: how `/tmp` survives a reboot, whether sessions persist across power-cycles, etc. The framework assumes **state survives** because it lives on disk + at origin, but you should know your host's quirks.

!!! tip "One host or many"
    Tiers default to living on the host of the substrate, but [locality is tunable](../01-axioms/git-foundations.md). You can run all tiers on one machine to start. Distribute later if you need to.

---

## 2. An AI agent harness

This is the thing that runs each tier session. CompassAlpha assumes a coding agent, but the framework only requires three capabilities of it. Verify each:

- [ ] **Fresh-session-per-slice.** You can spawn a brand-new session for a single bounded unit of work, with no carried-over context. This is non-negotiable — the [firewall](../01-axioms/firewall.md) depends on it. Doer sessions are *disposable and never reused across slices*.
- [ ] **Deterministic boot from a stamped file.** A session, when started in a folder, reads a `CLAUDE.md` (or equivalent boot file) and adopts that identity. This is how a generic agent becomes "Mentor-2 for dispatch X."
- [ ] **Persistent project context.** The harness can be pointed at a working directory and operate there across a turn (read files, run git, write files).

You do **not** need: nested sub-agent spawning, a proprietary message queue, or any special orchestration runtime. CompassAlpha deliberately routes coordination through git inboxes precisely so it needs *zero new infrastructure* (see the [bus protocol](../01-axioms/bus-protocol.md)).

!!! note "Why fresh-per-slice matters"
    A reused session accumulates context from prior work. That context contaminates the next slice — the agent "remembers" decisions that no longer apply and manufactures drift. Fresh-per-slice is the structural defence. Confirm your harness can do it before you go further.

---

## 3. A founder / relay

Exactly one human plays the **founder** role. It is a deliberately narrow job:

- [ ] **Trigger bus.** Spawns the right tier session when needed; delivers one-line pings: *"ready for Mentor-2"* / *"pull + read your inbox at `<path>`."* The founder's clipboard carries **zero substantive content** — all content moves through git.
- [ ] **Rotation rotater.** Initiates rotation of the Mentor-1 tier at clean seams.
- [ ] **Lost+found arbiter.** Decides genuine *founder-call* items only — scope / intent / agenda / value decisions that cannot be derived from substrate + AI consensus + the tier hierarchy. These are rare.

A small team may share the founder role, but they must act as a **single founder-role** — one voice into the bus, one lost+found backstop. The founder is *not* a per-decision arbiter and *not* a copy-paste relay of message bodies.

!!! warning "Founder over-engagement is the most common failure"
    Founders instinctively want to "help" by reading everything and deciding everything. Resist. The federation runs *better* when the founder stays on the bus + lost+found role and lets the tiers do their work.

---

## 4. A state-of-record remote

Both repos need a durable git remote. This is what makes *"state of the federation = state of git"* real.

- [ ] A remote for the **reviewer-state repo** (judicial / coordination state). This is the federation's audit trail and disaster-recovery anchor.
- [ ] A remote for the **substrate repo** (the project itself). Its own, separate remote.
- [ ] Push access for the founder/host over **https or ssh** (your choice — push protocol is tunable).
- [ ] A discipline of **`git pull --ff-only` before every push** — never `--rebase`, never `merge` for tier work. (Full rationale in [git foundations](../01-axioms/git-foundations.md).)

The two remotes are separate on purpose. The [firewall](../01-axioms/firewall.md) is *structural by directory and remote separation*: a reviewer-state commit physically cannot land on a substrate branch, because they are different repos with different `.git/` databases and different origins.

---

## Pre-flight checklist

Before moving on, confirm:

```
[ ] git installed on the host; worktree/commit-tree available
[ ] /path/to/substrate and /path/to/reviewer-state are SIBLING dirs (not nested)
[ ] AI harness can spawn fresh-session-per-slice
[ ] AI harness boots an identity from a stamped CLAUDE.md
[ ] one founder/relay identified; understands the narrow role
[ ] a remote for reviewer-state (audit trail)
[ ] a remote for substrate (the project)
[ ] push access over https or ssh
[ ] pull --ff-only discipline understood
```

If every box is ticked, choose your path:

- Blank slate → [**Greenfield setup**](greenfield-setup.md)
- Existing codebase → [**Brownfield onboarding**](brownfield-onboarding.md)

## Next: [Greenfield setup →](greenfield-setup.md)
