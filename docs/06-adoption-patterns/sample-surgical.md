---
description: "The lightest lane. Single-concern, ideally single-file. Mentor-2 is skipped entirely; Mentor-1 briefs a fresh Doer directly; the Doer makes one commit and dies. Minutes, not hours."
---

# Sample Surgical Strike — fix the login button colour

> *The lightest lane. Single-concern, ideally single-file. Mentor-2 is skipped entirely; Mentor-1 briefs a fresh Doer directly; the Doer makes one commit and dies. Minutes, not hours.*

**In plain terms:** this page walks through the simplest possible job CompassAlpha can run — a tiny one-file fix — from request to shipped, so a newcomer can see the whole loop end to end without any of the heavier ceremony getting in the way.

CompassAlpha organises work into *lanes* of increasing weight; the **Surgical Strike** is the lightest. Two roles do the work: a **Mentor** (the reviewer who briefs and checks) and a **Doer** (the worker who edits code). For a small fix, you only need one Mentor (Mentor-1) and one Doer — a second reviewer (Mentor-2) would just be overhead, so it is skipped.

This is the worked example for the **Surgical Strike** lane (see [Work Granularity Lanes](../03-tunables/work-granularity-lanes.md)) — the smallest complete loop CompassAlpha supports. It is the irreducible core of the framework: strip away everything that can be stripped, and *this* is what remains. If you read only one worked example, read this one.

## Setup

The primary button on Northwind's login page renders in the wrong brand colour after a design-token rename — it's a single-line fix in one file. No behaviour change, no schema, no new feature. This is textbook Surgical Strike.

- **Charter posture:** LOCKED — the *charter* is the project's constitution of foundational rules; "LOCKED" means those rules are frozen for now. (It wouldn't matter here anyway — Surgical can run even during an UNLOCKED doctrine epoch, since it never touches those foundational rules, the "primitives".)
- **Tiers in play:** Mentor-1 → Doer. **Mentor-2 is SKIPPED.**
- **Deliverable:** the corrected button colour.
- **Tag plan:** none — Surgical commits directly on trunk, no tag.

Northwind uses the default Surgical stage taxonomy: `REQUEST → EXECUTE → COMMIT → DONE` (see [Stage taxonomies](../03-tunables/stage-taxonomies.md)). Four stages, one turn, one Doer.

## Stage-by-stage walkthrough

### REQUEST — founder one-liner

The founder asks for the fix verbally. The *persistence law* says anything that matters to the work must live on disk, not just in a chat window (**nothing load-bearing in chat**) — so before doing anything, Mentor-1 writes the request down into its own *inbox*, a plain file where messages between roles are dropped:

```
/path/to/reviewer-state/tier-1-mentor/inbox/surgical/from-founder-request.md
  [[FROM-FOUNDER→TO-MENTOR1 · surgical · request]]
  Login page primary button is grey, should be brand-blue. One-line fix.
  [[/FROM-FOUNDER→TO-MENTOR1]]
```

Mentor-1 triages: single-concern, single-file, cosmetic → Surgical Strike.

### EXECUTE — Mentor-1 briefs a fresh Doer directly

No Mentor-2. Mentor-1 stamps a **one-paragraph brief** with the exact file and line range into a fresh Doer's inbox:

```
/path/to/reviewer-state/tier-1-mentor/surgical/login-button/inbox/from-mentor1-brief.md
  [[FROM-MENTOR1→TO-DOER · surgical/login-button · brief]]
  Change the primary button colour on the login page from the stale grey token to brand-blue.
  File:  /path/to/substrate/auth/views/login.tsx
  Lines: L88–L92 (the <PrimaryButton> style prop)
  No behaviour change. Smoke-check the page renders.
  [[/FROM-MENTOR1→TO-DOER]]
```

This is the **lightest brief in the framework** — file path + line range + the one change.

### COMMIT — Doer edits, smoke-checks, commits on trunk

The fresh Doer pulls, makes the one-line edit, confirms the page renders, and commits directly on trunk via commit-discipline. **No tag** — the commit on the trunk *is* the record.

```bash
git -C /path/to/substrate add auth/views/login.tsx
git -C /path/to/substrate commit -m "auth: login primary button → brand-blue token"
git -C /path/to/substrate push origin main:main
```

The Doer is **fresh-per-turn** here — meaning it spins up clean for this one request and is discarded afterward, carrying no memory forward. That is even lighter than *fresh-per-slice* (a Doer that lives across a few related steps). It did one request and dies; nothing carries forward.

### DONE — ping closes the loop

The Doer pings the founder (via Mentor-1). The button is blue. Loop closed.

## What's relaxed vs Polish

| Aspect | Polish | Surgical Strike |
|---|---|---|
| Tiers | Mentor-1 → slim Mentor-2 → Doer | Mentor-1 → Doer (**Mentor-2 skipped**) |
| Doer lifecycle | fresh-per-slice | **fresh-per-turn** (one request, then dies) |
| Stages | BRIEF → … → DONE (6) | REQUEST → EXECUTE → COMMIT → DONE (4) |
| Brief depth | bounded change spec | one paragraph: file + line range |
| Gate | smoke + UX review | smoke pass + commit-discipline |
| Tag | lightweight polish tag | **no tag** — commit on trunk |
| Tier-1 status grid | mandatory | **optional** (one-turn Doer needs no ceremony grid) |
| Turnaround | hours to a day | minutes to hours |

## What's still preserved (even here)

This is the critical lesson of the Surgical lane — even at the absolute floor of ceremony, the irreducible rules do not bend:

- **Firewall** — the founder did **not** edit the file. The change went through a tier. (See [Firewall](../01-axioms/firewall.md).) *Even in Surgical Strike, the founder never authors code.*
- **Bus protocol** — the request and brief travelled as inbox files (see [Bus Protocol](../01-axioms/bus-protocol.md)).
- **Persistence + commit discipline** — committed and pushed; the trunk commit is durable.
- **Hard labour rule** — only the Doer touched substrate (see [Hard Labour Rule](../01-axioms/hard-labour-rule.md)).

This is why Surgical Strike is the best single example: it shows that the framework's *value* (durable, audited, firewalled work) survives even when its *ceremony* drops to almost nothing.

## Anti-patterns

The triage discipline matters most at this lane, because the temptation to over-use it is highest:

- **Surgical-striking a schema change** — a schema change touches primitives; it belongs at [Phase 3](sample-phase3.md) minimum, possibly a [doctrine cycle](sample-doctrine-cycle.md). Don't smuggle structural change through the lightest lane.
- **Founder editing the file "because it's just one line"** — the firewall holds regardless of size. One-line edits still go through a Doer.

## What the status grid shows (optional, abbreviated)

Surgical Strike makes the Tier-1 grid optional. If Northwind prints one anyway:

```
STATUS GRID — 2026-06-09 · END · Mentor-1 · MODE: RELAY · cycle stage DONE
GATE        Charter v0.6 LOCKED · smoke pass · 1/1 surgical done
DISPATCH    none — last: surgical login-button (trunk, no tag)
LEFTOVERS   0 open
NEXT        idle
DISK        1 commit on trunk · read-back ✓ · GH-sync 0/0 @ d0c8e51
```

## Outcome

- A one-line cosmetic fix shipped in minutes, through a fresh single-turn Doer, with Mentor-2 skipped.
- No tag, optional grid, one-paragraph brief — the lightest possible ceremony.
- Firewall, bus, persistence, and hard labour rule still held. **That is the framework working as designed: minimum ceremony, zero compromise on the load-bearing rules.**

The four lanes — [Doctrine Cycle](sample-doctrine-cycle.md), [Phase 3](sample-phase3.md), [Polish](sample-polish.md), Surgical — cover **building**. The next three examples cover **operating** a shipped product: the Day-2 axes.

## Remember this

- The **Surgical Strike** is the smallest complete job: one Mentor briefs one short-lived Doer, who makes a single commit and is done. Minutes, not hours.
- "Lighter ceremony" never means "weaker rules." Even here, the founder doesn't touch code, messages travel as files, and the change is committed and pushed — the load-bearing rules hold.
- Match the job to the lane: a tiny cosmetic fix belongs here, but anything structural (like a schema change) is too big for this lane and goes to a heavier one.
- If any of these roles or rules feel unfamiliar, start with [the mental model](../00-foundation/mental-model.md) — it explains the moving parts this example puts to work.

---

## Next: [Sample Day-2 QA →](sample-day2-qa.md)
