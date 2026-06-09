# Greenfield Setup

> *Stand up a fresh federation from nothing: two repos, stamped tiers, a first axis declaration, a bus inbox layout. About a day of setup, then you're ready for [first boot](first-boot.md).*

This page assumes you've cleared the [prerequisites](prerequisites.md). It walks the greenfield path — a brand-new project with no prior doctrine and no legacy obligations. (If you have an existing codebase, go to [brownfield onboarding](brownfield-onboarding.md) instead.)

The whole setup is seven steps. Each produces real artifacts on disk that you commit and push. Nothing load-bearing stays in your head.

---

## Step 1 — Create the two repos as siblings

The substrate (your project) and the reviewer-state (federation meta-state) are **two distinct repos in two distinct sibling directories**. They never cross-commit; that separation is the [firewall](../01-axioms/firewall.md).

```bash
# substrate — the thing you build
git init /path/to/substrate
git -C /path/to/substrate remote add origin <substrate-remote-url>

# reviewer-state — the federation's judicial / coordination state
git init /path/to/reviewer-state
git -C /path/to/reviewer-state remote add origin <reviewer-state-remote-url>
```

!!! warning "Sibling, never nested"
    `/path/to/reviewer-state` must be **outside** `/path/to/substrate`'s working tree. If reviewer-state lived inside the substrate, reviewer commits could land on a substrate branch and the structural firewall would collapse. Keep them side by side.

---

## Step 2 — Drop the master into reviewer-state

The master protocol holds every substantive rule, stated once. Your axes inherit from it.

```bash
# copy the CompassAlpha master into the reviewer-state root
cp COMPASS_ALPHA_FRAMEWORK_v0.1.md /path/to/reviewer-state/
```

You do not edit the master to customise your project. You customise through **tunables** and **axis declarations** that layer on top. See [Tunables overview](../03-tunables/tunables-overview.md).

---

## Step 3 — Author your canonical state artifacts

These live at the reviewer-state root. They are the federation's running memory.

```
/path/to/reviewer-state/
├── COMPASS_ALPHA_FRAMEWORK_v0.1.md     ← the master (copied in step 2)
├── CLAUDE.md                           ← root boot orientation
├── LEDGER.md                           ← live federation state
├── LEFTOVERS.md                        ← deferred items register
├── HANDOVER_LOG.md                     ← tier-rotation audit
├── HANDOVER_PROTOCOL.md                ← how rotations happen
└── memory/
    └── MEMORY.md                       ← index of cross-cycle learnings
```

Minimal starting content for each:

- **`CLAUDE.md`** — "This is the reviewer-state for `<project>`. Boot read order: this file → `LEDGER.md` → `memory/MEMORY.md`. Persistence law in force." (Your tier stamps in step 5 extend this per tier.)
- **`LEDGER.md`** — an empty state grid scaffold (the [Tier 1 six-line grid](first-boot.md#the-start-status-grid)).
- **`LEFTOVERS.md`** — `# Leftovers` and an empty table with columns: ID · Description · Type · Origin · Target · Status.
- **`HANDOVER_LOG.md`** — `# Handover Log` and an empty append-only list.
- **`memory/MEMORY.md`** — `# Memory Index` and an empty list. Memories accrue from real incidents, not theory.

Commit and push:

```bash
git -C /path/to/reviewer-state add -A
git -C /path/to/reviewer-state pull --ff-only
git -C /path/to/reviewer-state commit -m "scaffold: master + canonical state artifacts"
git -C /path/to/reviewer-state push origin main:main
```

---

## Step 4 — Lay out the bus inbox tree

The [bus protocol](../01-axioms/bus-protocol.md) is inbox-in-destination-folder: a sender writes into the *recipient's* inbox. Lay the folders out now so the first dispatch has somewhere to land. The default layout (tunable):

```
/path/to/reviewer-state/
├── tier-1-mentor/                          ← Mentor-1 home
│   ├── inbox/                              ← Mentor-1's inbox
│   │   └── <scope>/
│   ├── CLAUDE.md  LEDGER.md  LEFTOVERS.md  HANDOVER_LOG.md
│   └── tier-2-orchestrator/                ← Mentor-2 home (confined under Mentor-1)
│       ├── inbox/                          ← Mentor-2's inbox
│       ├── CLAUDE.md  LEDGER.md  LEFTOVERS.md  HANDOVER_LOG.md
│       └── <slice>/
│           └── inbox/                      ← Doer's inbox for this slice
```

Inbox filenames follow `from-<sender-tier>-<event>[-<discriminator>].md`, e.g. `from-mentor1-rulings.md`, `from-mentor2-s1-brief.md`, `from-doer-s1-digest.md`. Each filename is single-writer by construction, so parallel writers never collide.

!!! note "Git doesn't track empty folders"
    Add a `.gitkeep` to each `inbox/` so the tree survives a fresh clone.

---

## Step 5 — Stamp your three tiers

Each tier boots from a `CLAUDE.md` that tells a generic AI session who it is. This is how the harness becomes a specific tier. The three stamps, dropped into the homes from step 4:

### Mentor-1 stamp (`tier-1-mentor/CLAUDE.md`)

```markdown
# YOU ARE: Mentor-1 (build axis)

ROLE: Top of the chain. Mentor at unit-of-work granularity. Ratify completion.
      Surface founder-calls. NEVER touch substrate.
SESSION: Long-lived in tenure (one per major cycle); rotate at clean seams.
HOME: /path/to/reviewer-state/tier-1-mentor/
MAY WRITE: own folder + Mentor-2's inbox.
READS INBOX AT: own inbox/<scope>/.
BOOT (T0): read master → this file → LEDGER → memory/MEMORY.md;
           verify disk==understanding; print START status grid; GH-sync check.
COMMIT DISCIPLINE: GIT_INDEX_FILE + commit-tree + explicit refspec push;
                   pull --ff-only before push; separate git -C per plane.
```

### Mentor-2 stamp (`tier-1-mentor/tier-2-orchestrator/CLAUDE.md`)

```markdown
# YOU ARE: Mentor-2 (build axis) — orchestrator of ONE unit of work

ROLE: Slice the dispatch into Doer-sized chunks. Triage tagged returns.
      Apply ratification gates. NEVER touch substrate.
SESSION: Fresh per dispatch.
HOME: /path/to/reviewer-state/tier-1-mentor/tier-2-orchestrator/
MAY WRITE: own folder + Mentor-1's inbox + Doer's inbox.
READS INBOX AT: own inbox/.
COMMIT DISCIPLINE: as Mentor-1, control-plane only (reviewer-state).
```

### Doer stamp (composed per slice into `<slice>/`)

The Doer is fresh-per-slice and disposable, so its brief is **composed by Mentor-2** at dispatch time rather than living statically. The shape:

```markdown
# YOU ARE: a Doer for <entity>/<slice>. The ONLY tier that touches substrate.

OPERATIONAL PRECONDITIONS:
  branch:          feat/<scope>-<slice>
  base HEAD:       <cycle-tip-SHA>
  GIT_INDEX_FILE:  /path/to/substrate/.work-tmp/<scope>/<slice>/index
  worktree:        /path/to/substrate/.work-tmp/<scope>/<slice>/wt
YOUR SLICE: <the bounded brief>
RETURN: tagged digest into Mentor-2's inbox (control plane).
COMMIT DISCIPLINE: commit deliverable to substrate via worktree + commit-tree
                   + refspec push; NEVER mix planes in one git command.
```

See [git foundations](../01-axioms/git-foundations.md) for why the Doer never runs in the main working tree and never uses plain `git add` + `git commit`.

---

## Step 6 — Declare your first axis

Most greenfield projects start with `build`. The axis declaration is **thin** — it names tiers and bindings; everything substantive is inherited. Save as `/path/to/reviewer-state/AXIS_BUILD.md`:

```
AXIS NAME:            build
PURPOSE:              Produce and evolve the project's code.
TIER ROLE NAMES:
  Mentor-1:           Mentor-1
  Mentor-2:           Mentor-2
  Doer:               Doer
DELIVERABLE TYPE:     code
CYCLE GRANULARITY:    dispatch · CP1 → CP2 → CP3 → close
CHARTER POSTURE:      LOCKED
CYCLE ACTIVATOR:      founder request for a build dispatch
RATIFICATION PATTERN: per-dispatch sub-bump
LOCALITY:             host-of-substrate (default)
```

You can keep the generic role names or rename them — the framework cares about the three *positions* (Mentor-1 / Mentor-2 / Doer), not the labels. See [axis declarations](../03-tunables/axis-declarations.md).

Commit + push the axis declaration the same way as step 3.

---

## Step 7 — Keep the first dispatch deliberately small

Resist the urge to dispatch something ambitious first. The point of dispatch #1 is to **prove the rhythm** — that the bus moves a file, the Doer commits to substrate, the digest comes back, the gate closes. A one-file change is ideal.

Good first dispatches:

- Add a `README.md` to the substrate.
- Scaffold an empty module directory (e.g. an `auth/` package skeleton).
- Wire a single trivial function with a single test.

This is LAYGO pacing — *lay the rhythm before you go fast*. Once dispatch #1 closes cleanly, you trust the machinery.

---

## Setup checklist

```
[ ] substrate + reviewer-state created as SIBLING repos, each with its own remote
[ ] master copied into reviewer-state root
[ ] canonical state artifacts authored + pushed
[ ] bus inbox tree laid out (with .gitkeep)
[ ] Mentor-1 + Mentor-2 stamps written; Doer brief shape understood
[ ] AXIS_BUILD.md declared + pushed
[ ] a small first dispatch chosen
```

With all boxes ticked, boot your first session.

## Next: [First boot →](first-boot.md)
