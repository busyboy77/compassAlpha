---
description: "Running your first piece of work end-to-end through the bus: Mentor-1 → Mentor-2 → Doer and back. Flush-before-disclose at every step, gates at every seam. This is the federation's heartbeat."
---

# First Dispatch

> *Running your first piece of work end-to-end through the bus: Mentor-1 → Mentor-2 → Doer and back. Flush-before-disclose at every step, gates at every seam. This is the federation's heartbeat.*

**In plain terms:** this page walks you through getting one small task done by the AI team for the very first time — who hands work to whom, where the code gets written, and how every step is saved to git before anyone says a word about it. Do it once and the whole rhythm clicks.

You've booted a clean session ([first boot](first-boot.md)). Now you move a real piece of work all the way through the federation and watch state land on disk + at origin before anyone discusses it. By the end you'll have one completed dispatch and a working mental model of the whole rhythm.

We'll use the small first dispatch you chose during setup — say, **scaffold an `auth/` module skeleton** in the substrate.

---


![One full dispatch across the three tiers, with a flush-before-disclose gate at every seam and the T0–T7 flush triggers](../assets/dispatch-flow-sequence.svg)

<small>*The federation's heartbeat: brief flows down, labour happens in substrate, the digest flows up — and state lands at origin before any seam is disclosed.*</small>

## The cast

| Tier | In this dispatch | Touches substrate? |
|---|---|---|
| **Mentor-1** | Decides the dispatch is worth doing; composes the dispatch brief; ratifies the close. | Never |
| **Mentor-2** | Orchestrates this one dispatch; slices it; triages the Doer's return; applies gates. | Never |
| **Doer** | Reads its slice brief; writes the actual code; commits to substrate; returns a tagged digest. | **Only this tier** |
| **Founder** | Spawns each session; relays one-line pings. Carries zero content. | No |

---

## The flow, end to end

```
Mentor-1 ──brief──▶ Mentor-2 ──slice brief──▶ Doer
                                                │
                                          (writes code,
                                       commits to substrate)
                                                │
Mentor-1 ◀──close pkg── Mentor-2 ◀──tagged digest──┘
```

Each arrow is a **bus message** — the federation's word for one unit of hand-off. In practice it's just a file: written into the recipient's inbox, committed and pushed to reviewer-state (the shared git repo the tiers coordinate through), then followed by a one-line founder ping. The real content never travels in chat. See the [bus protocol](../01-axioms/bus-protocol.md).

---

## Step 1 — Mentor-1 composes the dispatch brief

The booted Mentor-1 decides what to dispatch and writes a **complete** brief into Mentor-2's inbox. Complete means no placeholders for the founder to fill — the dispatching tier owns the fill ([brief completeness](../02-guardrails/brief-completeness.md)).

Write to `tier-1-mentor/tier-2-orchestrator/inbox/from-mentor1-auth-brief.md`:

```markdown
[[MENTOR-1→MENTOR-2 · auth · dispatch-brief]]

DISPATCH: scaffold the auth/ module skeleton.
SCOPE:    create auth/ package dir + an empty entrypoint + a placeholder test.
          Do NOT implement auth logic — skeleton only.
CHARTER:  v0.1 LOCKED. No Charter-touching changes.
DELIVERABLE: code on a feature branch; one slice expected.
GATE:     CP1 (skeleton compiles / lints) → close.

[[/MENTOR-1→MENTOR-2]]
```

Then Mentor-1 flushes and publishes — **flush before disclose**:

```bash
git -C /path/to/reviewer-state pull --ff-only
```

First, sync your local copy of reviewer-state with origin (the canonical copy on the server). `-C /path/to/reviewer-state` runs the command in that repo without changing directory; `--ff-only` means only accept changes that fast-forward cleanly — if someone else's work would collide, git stops rather than guessing. This guarantees you build on top of the latest shared state.

```bash
git -C /path/to/reviewer-state add -A
```

Stage every change in the repo (`-A` = all: new, modified, and deleted files) so git knows exactly what goes into the next snapshot. Here that's the brief file you just wrote into Mentor-2's inbox.

```bash
git -C /path/to/reviewer-state commit -m "mentor-1: auth dispatch brief"
```

Record the staged changes as a permanent, timestamped snapshot (a commit) in the local history. `-m` supplies the commit message inline — a short label describing what this snapshot is.

```bash
git -C /path/to/reviewer-state push origin main:main   # verify GH-sync 0/0 after
```

Upload your local commit to origin so the rest of the team can see it. `main:main` pushes your local `main` branch to the remote `main` branch. The comment reminds you to confirm the GH-sync indicator reads 0/0 afterwards — meaning nothing is left un-pushed.

Only **after** the file is on disk and at origin does Mentor-1 ping the founder: *"ready for Mentor-2."* The founder relays: *"pull + read your inbox."*

---

## Step 2 — Mentor-2 boots, slices, and briefs the Doer

The founder spawns a fresh Mentor-2 session in `tier-1-mentor/tier-2-orchestrator/`. It [boots](first-boot.md) (T0), then:

1. `git -C /path/to/reviewer-state pull --ff-only` — picks up the new brief.
2. Reads its inbox; finds `from-mentor1-auth-brief.md`.
3. Slices the dispatch. This one is small — a single slice, `s1`.
4. Composes a **complete Doer brief** with operational preconditions, written to the Doer's inbox at `tier-2-orchestrator/s1/inbox/from-mentor2-s1-brief.md`:

```markdown
[[MENTOR-2→DOER · auth/s1 · slice-brief]]

YOU ARE: a Doer for auth/s1. The only tier that touches substrate.

OPERATIONAL PRECONDITIONS:
  branch:          feat/auth-s1-skeleton
  base HEAD:       <cycle-tip-SHA>
  GIT_INDEX_FILE:  /path/to/substrate/.work-tmp/auth/s1/index
  worktree:        /path/to/substrate/.work-tmp/auth/s1/wt

YOUR SLICE:
  - create auth/ package dir
  - add an empty entrypoint file
  - add one placeholder test that asserts the module imports

RETURN: tagged digest into Mentor-2's inbox (control plane).
COMMIT DISCIPLINE: worktree + commit-tree + refspec push; NEVER mix planes.

[[/MENTOR-2→DOER]]
```

5. Flush + push reviewer-state (as in step 1). Ping founder: *"ready for the auth/s1 Doer."*

---

## Step 3 — The Doer does the labour

The founder spawns a fresh Doer session. It boots from its composed brief, then works under strict [git foundations](../01-axioms/git-foundations.md) discipline. The Doer keeps **two planes** apart and never crosses them: the *data plane* (the substrate repo, where the actual code lands) and the *control plane* (reviewer-state, where the team's messages and status go). One git command never reaches into both.

**Data plane — the deliverable goes to substrate:**

```bash
export GIT_INDEX_FILE=/path/to/substrate/.work-tmp/auth/s1/index
```

Point git at a private staging area (the *index*) just for this slice. The index is git's scratchpad of "what will go into the next commit"; by setting `GIT_INDEX_FILE` to a slice-specific path, this Doer's staging never collides with anyone else's. `export` makes the setting apply to the git commands that follow in this shell.

```bash
git -C /path/to/substrate worktree add /path/to/substrate/.work-tmp/auth/s1/wt <cycle-tip-SHA>
```

Create an isolated working folder (a *worktree*) checked out at `<cycle-tip-SHA>` — the exact commit the dispatch is built on. A worktree lets you edit files for this slice in their own directory without disturbing the main checkout, so parallel work stays cleanly separated.

```bash
# ...create auth/ dir, entrypoint, placeholder test in the worktree...
```

This is a placeholder comment, not a command — it marks where you actually write the slice's files (the `auth/` directory, its entry point, and a placeholder test) inside the worktree you just created.

```bash
git --work-tree=/path/to/substrate/.work-tmp/auth/s1/wt update-index --add auth/__init__ auth/entrypoint auth/test_imports
```

Stage the three new files into this slice's private index. `--work-tree=...` tells git to read the files from your slice worktree, and `update-index --add` records each named path as ready to commit. Naming the files explicitly keeps the commit tight — only intended files get in.

```bash
TREE=$(git -C /path/to/substrate write-tree)
```

Freeze the staged content into a *tree object* — git's immutable snapshot of the directory layout — and save its identifier in the shell variable `TREE`. The `$( )` captures the command's output so the next steps can reference it.

```bash
COMMIT=$(git -C /path/to/substrate commit-tree $TREE -p <cycle-tip-SHA> -m "auth/s1: skeleton")
```

Build a commit from that tree without touching any branch. `-p <cycle-tip-SHA>` sets the parent (so history links back to the dispatch base) and `-m` gives the message; the resulting commit's identifier is stored in `COMMIT`. This low-level approach is what keeps the two planes from accidentally mixing.

```bash
git -C /path/to/substrate update-ref refs/heads/feat/auth-s1-skeleton $COMMIT
```

Point the branch `feat/auth-s1-skeleton` at the commit you just created. `update-ref` writes the branch pointer directly, making the new commit the tip of that feature branch.

```bash
git -C /path/to/substrate push origin feat/auth-s1-skeleton:feat/auth-s1-skeleton
```

Upload the feature branch to origin so the deliverable lands in the shared substrate. The `local:remote` form pushes your `feat/auth-s1-skeleton` branch to a remote branch of the same name, where Mentor-2 can later review it.

**Control plane — the return goes to reviewer-state** (a *separate* `git -C`, never mixed with the above):

Write `tier-2-orchestrator/inbox/from-doer-s1-digest.md`:

```markdown
[[DOER→MENTOR-2 · auth/s1 · digest]]

DELIVERABLE: auth/ skeleton on feat/auth-s1-skeleton @ <commit-SHA>.
DONE: package dir + entrypoint + placeholder import test. Test passes.
GATE CP1: skeleton imports + lints clean. READY.
OPEN: none.

[[/DOER→MENTOR-2]]
```

```bash
git -C /path/to/reviewer-state pull --ff-only
```

Sync reviewer-state with origin before writing to it, accepting only clean fast-forward updates, so your digest goes on top of the latest shared state.

```bash
git -C /path/to/reviewer-state add -A
```

Stage all changes in reviewer-state — here, the digest file you just wrote into Mentor-2's inbox — so they're queued for the next commit.

```bash
git -C /path/to/reviewer-state commit -m "doer auth/s1: return digest"
```

Snapshot the staged digest into reviewer-state's history with a descriptive message, making the hand-off a permanent, auditable record.

```bash
git -C /path/to/reviewer-state push origin main:main
```

Upload that commit to origin so Mentor-2 can pull and read the digest. Note this is a separate `git -C` on reviewer-state, never combined with the substrate commands above — that separation is what keeps the control plane and data plane apart.

```bash
git -C /path/to/substrate worktree remove /path/to/substrate/.work-tmp/auth/s1/wt   # cleanup
```

Delete the temporary slice worktree now that its work is committed and pushed. The slice's commit lives safely in git history, so the scratch folder is no longer needed — removing it keeps the substrate tidy.

Ping founder: *"auth/s1 done, ready for Mentor-2."* The Doer session is now disposable — it is never reused for another slice.

---

## Step 4 — Mentor-2 triages and applies the gate

A fresh (or the same in-tenure) Mentor-2 pulls, reads the digest, and applies the **CP1 gate**: does the deliverable meet the slice brief? Here, the skeleton imports and the test passes — gate **closed**. Mentor-2 then writes a close package into Mentor-1's inbox (`tier-1-mentor/inbox/auth/from-mentor2-close.md`), flushes + pushes, pings the founder.

If the gate had *failed* (skeleton didn't import), Mentor-2 would compose a corrective slice brief for a fresh Doer instead — the loop repeats until the gate closes.

---

## Step 5 — Mentor-1 ratifies and tags

Mentor-1 pulls, reads the close package, ratifies the dispatch, and applies the immutable **tag** that marks the close — the federation's ratification artifact:

```bash
git -C /path/to/substrate tag -a auth-skeleton-v0.1 <commit-SHA> -m "auth skeleton dispatch closed"
```

Attach a permanent, named marker (an *annotated tag*, `-a`) to the exact commit that closed the dispatch. Unlike a branch, a tag never moves — it pins a fixed point in history. `-m` records why this point matters, giving the close a durable label anyone can find later.

```bash
git -C /path/to/substrate push origin auth-skeleton-v0.1
```

Upload the tag to origin (tags are not pushed by branch pushes, so this is a separate step) so the ratification marker is visible to the whole team, not just locally.

Mentor-1 updates the LEDGER (the dispatch is now `closed`), flushes + pushes reviewer-state, and prints an END status grid. Your first dispatch is complete — and every piece of it is reconstructable from git log.

---

## Flush-before-disclose, restated

At every step above, the pattern is identical and **non-negotiable**:

> **State on disk and at origin BEFORE it is disclosed to the founder.**

The ping always comes *after* the push. The founder's clipboard carries zero substantive content — just one-line triggers. This is the [persistence law](../01-axioms/persistence-law.md), and it's what makes rotation, recovery, and audit trivial: there is never load-bearing state trapped in a chat window.

---

## The gates that protect a dispatch

Work advances through **flush triggers T0–T7**. The ones you exercised in this dispatch:

| Trigger | Fired when | Action |
|---|---|---|
| **T0** | Each session boots | Read artifacts, verify consistency, print START grid, GH-sync check |
| **T1** | A state change (brief composed, gate ruled, dispatch advanced) | Flush to `LEDGER.md` + read back |
| **T2** | A return is triaged (Mentor-2 hands back a ruling) | Flush resulting state before standby |
| **T3** | End-of-turn sweep | Confirm the ledger reflects what the turn did — unflushed state = incomplete turn |
| **T7** | A checkpoint freezes with pending items | Onboard every leftover to `LEFTOVERS.md` *before* reporting the freeze as ratification-ready |

(T4 context-health, T5 cutover, T6 doctrine-change round out the set — you'll meet those as the project grows.)

---

## First-dispatch checklist

```
[ ] Mentor-1 composed a COMPLETE brief (no placeholders); flushed + pushed BEFORE pinging
[ ] Mentor-2 booted, sliced, composed a complete Doer brief with operational preconditions
[ ] Doer used worktree + GIT_INDEX_FILE + commit-tree + refspec push (no plain git add/commit)
[ ] Doer kept the two planes separate (substrate vs reviewer-state) — never one git command across both
[ ] Doer returned a tagged digest; worktree cleaned up; session not reused
[ ] Mentor-2 applied the CP1 gate (close or corrective re-slice)
[ ] Mentor-1 ratified, tagged the close, updated LEDGER, printed END grid
[ ] every ping followed a push — flush before disclose, every time
```

You now have a working federation with one closed dispatch behind it. From here, repeat the rhythm — and for a brownfield team, walk the revertible cutover.

## Remember this

- **Work flows down, the result flows up.** A brief goes Mentor-1 → Mentor-2 → Doer; the finished code and a short digest come back the same path. That loop is the whole job — everything else is detail. See [the mental model](../00-foundation/mental-model.md).
- **Only the Doer touches the code.** The mentors decide and check; the Doer writes. Keeping the two planes separate is what keeps the audit trail clean.
- **Save first, talk second.** Every hand-off lands on disk and at origin *before* anyone is pinged — so nothing important ever lives only in a chat window.
- **One dispatch teaches the rhythm.** Once you've run this small task end to end, every later one is the same beats, repeated.

## Next: [Cutover from a pre-AI project →](cutover-from-pre-AI-project.md)
