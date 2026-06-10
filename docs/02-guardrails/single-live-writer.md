---
description: "One writer holds jurisdiction at a time. Everyone else fetches before they push, and no one ever clobbers the live writer."
---

# Single-Live-Writer

> *One writer holds jurisdiction at a time. Everyone else fetches before they push, and no one ever clobbers the live writer.*

`[INVARIANT]`

## TL;DR

The **clobber** is the failure where two sessions write the state-of-record concurrently and one silently overwrites the other's work — a decision, a ledger update, a ratification, gone without a trace. CompassAlpha prevents it with **single-live-writer**: only the tier currently holding jurisdiction writes the state-of-record repo while it holds it. A rotation *transfers* jurisdiction; it does not create a second writer. Any out-of-jurisdiction party (an outgoing tier kept as backstop, a sibling parallel worker) **fetches before it pushes** and never clobbers the live writer. Combined with path-partitioned writes, this makes file-level conflicts structurally impossible and reduces the whole problem to ref-races that a fast-forward handles.

## The failure it prevents

A "persistent single-writer anti-pattern" is the naïve alternative: one long-lived session that never rotates, writing everything, because "then there's only one writer and nothing can clobber." It avoids clobber by accumulating unbounded context — and so it rots into [pollution](pollution-containment.md) and [stale snapshots](stale-snapshot-detection.md) instead. CompassAlpha wants the opposite: *aggressive* session refresh and rotation, which means many sessions over time and sometimes overlapping ones. That only stays safe if writing is governed.

Two clobber shapes are the targets:

1. **Rotation overlap.** An incoming tier takes jurisdiction, but the outgoing session is still alive as a backstop. If both push, the outgoing session can overwrite the incoming session's fresh state with its now-stale view.
2. **Parallel workers.** Multiple doers run simultaneously (parallel slices). If they push to overlapping paths without coordination, returns collide and integration state corrupts silently.

The harm is worse than a crash: a clobber leaves *no error*. The losing write simply vanishes, and the federation proceeds believing a decision was recorded that is no longer on disk — a direct hit to [trust](../01-axioms/persistence-law.md).

## What violating it looks like

### Example 1 — The backstop that clobbered the new holder

A Mentor-1 rotates. The incoming Mentor-1 takes jurisdiction, ratifies a checkpoint, and pushes. The outgoing Mentor-1 — still open in another window "just in case" — flushes a leftover note from before the rotation and pushes *without fetching first*. Its push cannot fast-forward and overwrites instead. The incoming holder's ratification is gone, and nobody sees an error.

### Example 2 — Two doers, one path

Two Doers work Billing slices in parallel. Both write their return into `tier-2-billing/inbox/return.md` — the same filename. The second push clobbers the first. One slice's entire return evaporates; the orchestrator integrates as though only one slice reported.

### Example 3 — Crossing the two planes

A Doer about to `git add` stages files from both the substrate deliverable repo and the reviewer-state repo in one command. The control-plane return and the data-plane deliverable risk landing on the wrong remote — a clobber across the structural firewall between the two repos.

## How it's enforced

### Rule 1 — Jurisdiction is single and transferable

Only the current jurisdiction-holder writes the state-of-record repo while holding it. A [rotation](failure-modes.md#rotation-mid-flight) is the *only* way the write-holder changes, and it is a clean transfer: outgoing emits END-certification + push, incoming completes Layer-B grounding + countersign, *then* jurisdiction moves. There is never a moment of two equal writers — only a handoff with a defined seam.

### Rule 2 — Fetch-before-push for everyone

Before any push, the session runs `git pull --ff-only` (or `git fetch` + `git merge --ff-only`). This catches updates from a sibling or a just-rotated-in holder:

- If a fast-forward is possible, the push proceeds.
- If it is **not**, the session **pauses, reconciles** (rebases its local change onto the new tip), and retries.

An out-of-jurisdiction backstop that fetches first will *see* the live writer's commits and rebase onto them rather than over them — the clobber becomes impossible by construction.

### Rule 3 — Path partitioning

Different writers touch different paths. Parallel doers write distinct filenames into a shared inbox (`return-slice-1.md`, `return-slice-2.md`), never a shared file. Combined with fetch-before-push, this is the key result:

> File-level conflicts are **structurally impossible** — different writers touch different paths — so only ref-level races remain, and fast-forward handles those.

Multi-writer safety is emergent: no single mechanism provides it. Single-live-writer governs the judicial folders, fetch-before-push handles ref-races, and path partitioning eliminates file collisions. Remove any one and the guarantee weakens.

### Rule 4 — Two planes, never cross-commit

The state-of-record repo and the substrate deliverable repo are physically separate — different directories, different remotes, different `.git/` databases. A tier about to `git add` across that boundary **halts**. Data-plane commits use `git -C /path/to/substrate ...`; control-plane commits use `git -C /path/to/reviewer-state ...`. Because the git contexts differ, a control-plane commit *cannot* land on a substrate branch — the firewall is enforced by the tooling, not by care.

!!! note "Parallelism is safe by construction, or not at all"
    The payoff of these four rules together is that you can run many parallel doers and the framework's correctness scales linearly with their count — each commits its deliverable from an isolated index to its own branch and writes a uniquely-named return. Without the rules, the same parallelism silently corrupts cross-worker state. The choice is not "parallel or safe"; it is "structured-and-safe-and-parallel" or "unstructured-and-corrupt."

## Detection and recovery

**Detection.** A push that *succeeds without a fetch* on an out-of-jurisdiction session is the smell. So is any two writers sharing a path, or any `git add` that spans the two repos. At the history level, a force-style overwrite or an unexpected non-fast-forward warning indicates a contended ref.

**Recovery.** If a clobber is suspected, the lost write is recoverable from git's reflog and the loser's local objects — fetch the overwritten commit by sha and re-apply it onto the current tip. Going forward, restore the discipline: confirm a single jurisdiction-holder, enforce `--ff-only` before every push, and re-partition any colliding paths. If two planes were crossed, audit both remotes for misplaced commits and move them to the correct repo.

## How this connects to other axioms and guardrails

- **[Persistence law §single-live-writer](../01-axioms/persistence-law.md)** is the axiom this guardrail operationalizes; fetch-before-push is part of flush discipline.
- **[Git foundations](../01-axioms/git-foundations.md)** supplies the mechanics — per-session `GIT_INDEX_FILE`, `commit-tree`, explicit refspec push — that make isolated, partitioned writes possible.
- **[Pollution containment](pollution-containment.md)** is why we rotate aggressively instead of using one immortal writer — which is exactly what makes write-governance necessary.
- **[Failure modes §rotation mid-flight](failure-modes.md#rotation-mid-flight)** is the rotation seam at which jurisdiction transfers cleanly.

---

## Next: [Tunables →](../03-tunables/index.md)
