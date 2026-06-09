# Sample Surgical Strike — fix the login button colour

> *The lightest lane. Single-concern, ideally single-file. Mentor-2 is skipped entirely; Mentor-1 briefs a fresh Doer directly; the Doer makes one commit and dies. Minutes, not hours.*

This is the worked example for the **Surgical Strike** lane (see [Work Granularity Lanes](../03-tunables/work-granularity-lanes.md)) — the smallest complete loop CompassAlpha supports. It is the irreducible core of the framework: strip away everything that can be stripped, and *this* is what remains. If you read only one worked example, read this one.

## Setup

The primary button on Northwind's login page renders in the wrong brand colour after a design-token rename — it's a single-line fix in one file. No behaviour change, no schema, no new feature. This is textbook Surgical Strike.

- **Charter posture:** LOCKED (and it wouldn't matter — Surgical can run during an UNLOCKED doctrine epoch too, since it never touches primitives).
- **Tiers in play:** Mentor-1 → Doer. **Mentor-2 is SKIPPED.**
- **Deliverable:** the corrected button colour.
- **Tag plan:** none — Surgical commits directly on trunk, no tag.

Northwind uses the default Surgical stage taxonomy: `REQUEST → EXECUTE → COMMIT → DONE` (see [Stage taxonomies](../03-tunables/stage-taxonomies.md)). Four stages, one turn, one Doer.

## Stage-by-stage walkthrough

### REQUEST — founder one-liner

The founder asks for the fix verbally. Per the persistence law (**nothing load-bearing in chat**), Mentor-1 transcribes the request into its own inbox before acting:

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

The Doer is **fresh-per-turn** here — even lighter than fresh-per-slice. It did one request and dies; nothing carries forward.

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

---

## Next: [Sample Day-2 QA →](sample-day2-qa.md)
