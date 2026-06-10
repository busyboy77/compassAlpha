---
description: "Copy-pasteable boilerplate for the load-bearing artifacts. Fill the <placeholders>, then commit."
---

# Stamp templates

> *Copy-pasteable boilerplate for the load-bearing artifacts. Fill the `<placeholders>`, then commit.*

These are generic, ready-to-use templates for the artifacts a CompassAlpha federation produces. Every value in `<angle brackets>` is a placeholder you replace for your project. All templates assume the [bus protocol](../../01-axioms/bus-protocol.md), the [persistence law](../../01-axioms/persistence-law.md) (flush = write + commit + push + read-back), and the [commit discipline](../cli-conventions.md).

!!! tip "Two planes"
    Anything below that is a **brief or a return** travels in the reviewer-state repo (control plane). Only the actual deliverable travels in the substrate repo (data plane). They never cross-commit. See [CLI conventions](../cli-conventions.md).

---

## 1. Tier boot stamp (`CLAUDE.md` identity stamp)

The boot file a mentor stamps into a sub-tier's folder. It is the sub-tier's deterministic boot: read this and you know who you are, what you own, and what to read next. Composing a stamp is mentor orchestration, not labour.

````markdown
# <ROLE-NAME> · <tier-instance, e.g. Mentor-2-7> · BOOT STAMP

> Identity stamp for the <AXIS> axis, <SCOPE> dispatch. Auto-loads at session start.
> Stamped by <STAMPING-TIER> on <UTC-DATE> from <TEMPLATE-NAME>.

## Who you are
- **Tier:** <Mentor-1 | Mentor-2 | Doer>  (generic) · **<axis role name>** (this axis)
- **Axis:** <build | doctrine | …>
- **Scope:** <the one unit of work you own>
- **Labour?** <NEVER (mentor) | ALL substrate labour (Doer)>

## Your home + write permissions
- **Home folder:** <reviewer-state-repo>/<your-folder>/
- **Your inbox:** <reviewer-state-repo>/<your-folder>/inbox/
- **You MAY write to:** <own folder + listed recipient inboxes>
- **You MUST NOT write to:** any other tier's folder (firewall).

## Read-on-boot (T0)
1. This file.
2. <reviewer-state-repo>/<your-folder>/LEDGER.md
3. <reviewer-state-repo>/<your-folder>/LEFTOVERS.md
4. <reviewer-state-repo>/memory/MEMORY.md  (+ any indexed memories)
5. The shared master protocol: <path-to-master>
6. Your inbox. New files = this turn's work.

## Boot integrity
- Verify mutual consistency of the above.
- Run the sync check: local == origin (0/0).
- Print the START status grid (see Status grids reference).
- Any mismatch with disk = drift → halt and reconcile before acting.

## Standing conventions (named, per brief-completeness rule)
- Branch convention: <e.g. feat/<scope>-<deliverable>-v<x.y>>
- Commit discipline: GIT_INDEX_FILE + commit-tree + refspec push (see CLI conventions).
- Stage taxonomy for this axis: <S1…S5 | CP1…CP3 | …>

## Your turn loop (bus iteration ritual)
pull --ff-only → read inbox → do work → (Doer: commit deliverable) →
write outbound into recipient inbox → flush own folder → pull --ff-only →
add/commit/push reviewer-state → verify sync 0/0 → ping founder "ready for <next>" → end turn.

## What you escalate to the founder (founder-call boundary)
Only: charter-tier proposals · scope-shifts · gate-count changes · genuine value/intent
you cannot resolve internally. Everything else is tier-managed.
````

---

## 2. Dispatch brief (boilerplate)

A complete-at-relay brief. Per the [brief completeness rule](../../02-guardrails/brief-completeness.md), every operational precondition carries a concrete value — never a placeholder at relay. (The placeholders below are for *you* to fill before sending.)

````markdown
[[<SENDER-TIER>→<RECIPIENT-TIER> · <scope>/<slice>]]

# DISPATCH BRIEF · <scope>/<slice> · <UTC-DATE>

## Objective (one paragraph)
<What this slice/dispatch must produce, in plain terms.>

## Deliverable + done-definition
- Deliverable: <file(s) / compass section / code module>
- Done when: <objective, checkable completion criteria — the per-axis gate 1>

## Operational preconditions  (ALL concrete — no placeholders at relay)
- Substrate repo:        <path/to/substrate>
- Dispatch branch:       feat/<scope>-<deliverable>-v<x.y>
- Base commit (HEAD):    <full-SHA>           ← cut your worktree from this
- Worktree path:         <path/to/substrate>/.doer-tmp/<scope>/<slice>/wt
- Index file:            <path/to/substrate>/.doer-tmp/<scope>/<slice>/index
- Exit tag (on close):   <module-v<x.y> | none>
- Commit-discipline:     GIT_INDEX_FILE + commit-tree + refspec push (see CLI conventions)
- Reviewer-state repo:   <path/to/reviewer-state>
- Return inbox:          <path/to/reviewer-state>/<sender-folder>/inbox/

## Context to read (Doer context scope = <wide | narrow>)
- <files / sibling compasses / memories the Doer should triangulate against>

## Named conventions in force (not restated)
- Branch per build-axis convention; commit discipline; stage taxonomy <…>.

## Out of scope (do NOT touch)
- <explicit exclusions to prevent scope creep>

## On an unfilled load-bearing field
Escalate back with [[<RECIPIENT-TIER>→<SENDER-TIER> · <slice> · BRIEF-INCOMPLETE]].
Do NOT improvise. "Create per convention" is forbidden unless granted here in writing.

[[/<SENDER-TIER>→<RECIPIENT-TIER>]]
````

---

## 3. Status-grid template (Tier 1)

The mandatory 6-line grid, printed at session START and END. Full doctrine and the other two tiers are on the [status grids reference](../status-grids.md).

````text
STATUS GRID — <UTC-DATE> · <START|END> · <tier-instance> · MODE: <RELAY|DELEGATED> · stage <CYCLE-STAGE>
GATE        Charter v<x> <LOCKED|UNLOCKED> → v<y> · gates closed · <N>/<M> units done
DISPATCH    <unit @ stage @ commit  |  "none — last: <tag>">
LEFTOVERS   <N open>  (top: <ids>)
NEXT        <single immediate next action — one T# event>
DISK        <K state artifacts · read-back ✓ · no unflushed state · sync 0/0 @ <SHA>>
````

---

## 4. Handover / rotation certificate

The Layer-B dual-validation record, appended to `HANDOVER_LOG.md` when a tier rotates. A handover passes only when both halves confirm.

````markdown
# HANDOVER CERTIFICATE · <OUTGOING tier-instance> → <INCOMING tier-instance>
· axis <…> · scope <…> · <UTC-DATE>

## Incoming self-administered grounding battery
(Answered from artifacts ALONE — no oral coaching.)
- Q1 <grounding question>  → A: <answer>
- Q2 …                     → A: …
- Q3 …                     → A: …
- ORIGINAL observation (≥1 required, non-parroted):
  <a genuine, new observation the incoming tier surfaced about live state>

## Outgoing certification
- [ ] Scored incoming answers against LIVE artifacts: <PASS | FAIL + gaps>
- [ ] Certified NO unflushed state remains (Layer-A clean; sync 0/0 @ <SHA>)
- [ ] END status grid printed and committed
- [ ] LEFTOVERS handed over (count: <N>; top: <ids>)

## Result
- Incoming battery: <PASS | FAIL>
- Outgoing certification: <PASS | FAIL>
- RELEASE: <GRANTED — incoming is now LIVE | WITHHELD — reason: …>

Signed (committed) by outgoing <tier-instance> at <SHA>.
````

---

## 5. Cycle-end ratification package

Assembled by the orchestrator for founder ratification at a doctrine cycle close. Shape is `[INVARIANT]`; fields are `[TUNABLE]`. See the [sample doctrine cycle](../../06-adoption-patterns/sample-doctrine-cycle.md) for a worked example.

````markdown
# CYCLE-END RATIFICATION PACKAGE · cycle <charter-v<X> → v<X+1>> · <UTC-DATE>

## 1. Triage table  (deferral-queue + walk-feedback items)
| Item | Origin scope | Decision | One-line rationale |
|------|--------------|----------|--------------------|
| <id> | <scope>      | FOLD-IN / DEFER / DROP | <why> |

## 2. Per-scope sub-bump list
| Scope/entity | Sub-bump tag | Entity tag | Exit SHA |
|--------------|--------------|------------|----------|
| <entity>     | <sub-bump>   | <tag>      | <SHA>    |

## 3. Cross-cutting primitives lifted into Charter  (from LIFT-WATCH)
- <primitive/invariant> — anchors: <count> — strength: <high|decisive|…>

## 4. Charter diff  (amendments accepted)
- CHARTER-A-<n>: <what changed> (e.g. configurable cap X → tunable)

## 5. Protocol-amendment candidates  (to ratify into the master)
- (i)   <rule> — <why>
- (ii)  <rule> — <why>

## 6. Open founder-calls
- <unresolved cycle-tail decision needing founder ruling>

## On ratification (mechanical, after founder signoff)
- Issue cycle-end major bump: annotated tag <charter-v<X+1>>, refspec push.
- RE-LOCK the Charter.
- Wire up cycle home: Layer-A clean, END status grid, sync 0/0.
- The other axis resumes under the new Charter version.
````

---

## How these fit together

| Template | Written by | Lands in | Trigger |
|---|---|---|---|
| Tier boot stamp | The mentor above | sub-tier's folder | At dispatch creation |
| Dispatch brief | Dispatching tier | recipient's inbox | At each dispatch / slice |
| Status grid (T1) | Every tier | its own folder | Session START + END (T0 / T0e) |
| Handover certificate | Outgoing + incoming | `HANDOVER_LOG.md` | Rotation / cutover (T5) |
| Ratification package | The orchestrator | cycle folder | Cycle close |

→ [Status grids](../status-grids.md) · [Hierarchy tags](../hierarchy-tags.md) · [Flush triggers](../flush-triggers.md) · [CLI conventions](../cli-conventions.md)

---

## Next: [Status grids →](../status-grids.md)
