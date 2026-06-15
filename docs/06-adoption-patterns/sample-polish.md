---
description: "Slim ceremony for a bounded change. One module, one feature, a single checkpoint. Mentor-2 runs slim — no CP1/CP2/CP3 — and the change ships in hours, not days."
---

# Sample Polish Lane — invoice status filter

> *Slim ceremony for a bounded change. One module, one feature, a single checkpoint. Mentor-2 runs slim — no CP1/CP2/CP3 — and the change ships in hours, not days.*

**New here?** This page walks through one small, real feature — adding a dropdown filter to a table — from first request to shipped code. It shows you the *lightest* way work flows through CompassAlpha, so you can see that small changes don't need heavy process.

A quick orientation before the jargon arrives: a **lane** is just a size-of-job setting (small jobs get a short process, big jobs a longer one). **Polish** is the lane for small-but-real changes. **Mentor-1, Mentor-2, and Doer** are roles — a coordinator, a planner, and the hands that write the code. **Checkpoints (CP1/CP2/CP3)** are formal review pauses used on bigger work; the Polish lane skips them. With that in hand, the walkthrough below should read plainly.

This is the worked example for the **Polish Lane** (see [Work Granularity Lanes](../03-tunables/work-granularity-lanes.md)). Polish is for cosmetic or bounded behavioural changes inside a single module: a datatable column, a microcopy tweak, a modal layout fix, **a new dropdown filter**. It is the everyday lane for the founder's small wishes that are still more than a one-line edit.

## Setup

Northwind's Billing module has an invoices table. The founder wants a **status filter** — a dropdown to show only `paid`, `past_due`, or `void` invoices. It's bounded (one module, one table, no schema change), so it goes to Polish, not [Phase 3](sample-phase3.md).

- **Charter posture:** LOCKED (build axis active). Polish can *also* run during an UNLOCKED doctrine epoch, since it never touches the primitives a doctrine cycle is amending.
- **Tiers in play:** Mentor-1 · **slim** Mentor-2 · Doer. No CP structure.
- **Deliverable:** a working status filter on the invoices table.
- **Tag plan:** lightweight `polish-invoice-filter-v1.0`.

Northwind uses the default Polish stage taxonomy: `BRIEF → ASSIGNED → IMPLEMENTING → SMOKE → COMMIT → DONE` (see [Stage taxonomies](../03-tunables/stage-taxonomies.md)). Notice there are **no checkpoint sub-stages** — the whole lane is single-stage execution.

## Stage-by-stage walkthrough

### BRIEF — founder request triaged to Polish

The founder drops a one-liner into Mentor-1's inbox. Mentor-1 **triages the lane** (this is founder-eligible triage — small wishes are the most common Polish source) and confirms: single module, bounded behaviour, no primitive touched → Polish.

```
/path/to/reviewer-state/tier-1-mentor/inbox/polish/from-founder-request.md
  [[FROM-FOUNDER→TO-MENTOR1 · polish · request]]
  Add a status filter dropdown (paid / past_due / void) above the invoices table in Billing.
  [[/FROM-FOUNDER→TO-MENTOR1]]
```

### ASSIGNED — slim Mentor-2 stamps a Doer

Mentor-1 stamps a **slim** Mentor-2 — no full launch ceremony, no CP1 premise check. The brief routes nearly straight to a Doer:

```
/path/to/reviewer-state/tier-2-orchestrator/polish-invoice-filter/s1/inbox/from-mentor2-brief.md
  [[FROM-MENTOR2→TO-DOER · polish-invoice-filter · brief]]
  Add a status filter dropdown to the invoices table.
  Options: paid / past_due / void / all. Filters client-side on existing data — no new query.
  Files: /path/to/substrate/billing/views/invoices_table.tsx (the table + toolbar)
  [[/FROM-MENTOR2→TO-DOER]]
```

### IMPLEMENTING — Doer executes the bounded change

A single fresh Doer makes the change in a worktree. Because the brief said "client-side on existing data," there's no route or schema work — the Doer wires the dropdown to the existing list state.

### SMOKE — smoke test + UX review (no full audit)

Polish does **not** run the full Phase-3 gate package. It runs a **smoke test** plus a UX review pass:

```
Smoke: table renders · each filter option narrows rows correctly · "all" restores · no console errors
UX review: dropdown matches the design system; placement above-right of the table; keyboard-accessible
```

No multi-gate reconciliation, no EXIT_REPORT. The smoke + UX pass *is* the gate for this lane.

### COMMIT — commit-discipline + lightweight tag

The Doer commits via the same commit-discipline as every other lane (this never relaxes), and applies the lightweight Polish tag:

```bash
git -C /path/to/substrate add billing/views/invoices_table.tsx
git -C /path/to/substrate commit -m "billing: invoice status filter dropdown"
git -C /path/to/substrate push origin main:main
git -C /path/to/substrate tag -a polish-invoice-filter-v1.0 -m "Polish: invoice status filter"
git -C /path/to/substrate push origin polish-invoice-filter-v1.0
```

### DONE — loop closes

Mentor-2 confirms to Mentor-1; Mentor-1 pings the founder. Done.

## What's relaxed vs Phase 3

| Aspect | Phase 3 | Polish |
|---|---|---|
| Tiers | full Mentor-1 → Mentor-2 → Doer | Mentor-1 → **slim** Mentor-2 → Doer |
| Checkpoints | CP1 → CP2 → CP3 | single-stage |
| Gate package | 4 objective gates + EXIT_REPORT | smoke + UX review |
| Tag | versioned module tag (`reporting-v1.3`) | lightweight (`polish-<topic>-v1.0`) |
| Tier-1 status grid | mandatory | mandatory |
| Turnaround | days to weeks | hours to a day |

## What's still preserved (never relaxed)

Even at slim ceremony, the load-bearing rules hold:

- **Firewall** — the founder did *not* edit the table; the change went through a tier (see [Firewall](../01-axioms/firewall.md)).
- **Bus protocol** — the request and brief travelled as inbox files, not chat.
- **Persistence + commit discipline** — committed, pushed, read back.
- **Hard labour rule** — only the Doer touched substrate.

## What the status grid shows at close

```
STATUS GRID — 2026-06-09 · END · Mentor-1 · MODE: RELAY · cycle stage DONE
GATE        Charter v0.6 LOCKED · smoke+UX pass · 1/1 polish done
DISPATCH    none — last: polish-invoice-filter-v1.0
LEFTOVERS   0 open
NEXT        idle — awaiting next founder request
DISK        2 state artifacts · read-back ✓ · no unflushed state · GH-sync 0/0 @ c40f9aa
```

## Outcome

- The filter shipped in a single afternoon with a slim, single-stage flow.
- No checkpoint ceremony, no full audit — but firewall, bus, persistence, and commit discipline all held.
- A bounded change got a bounded process. That proportionality is the whole point of the lane system: **match the ceremony to the size of the change.**

The next example goes lighter still — small enough that even the slim Mentor-2 is skipped entirely.

## Remember this

- **Match the ceremony to the size of the change.** A bounded one-module tweak gets a bounded, single-stage process — no checkpoints, no full audit. That proportionality is the whole point of the lane system.
- **Lighter process, same guardrails.** Even on the slim path, the founder never edits code directly (the firewall holds), requests travel as files not chat, and every change is committed and pushed. Speed is bought by dropping *ceremony*, never by dropping *discipline*.
- **Polish is the everyday lane** for small wishes that are still more than a one-line edit — and it ships in hours, not days.
- If the roles and rules here feel unfamiliar, [the mental model](../00-foundation/mental-model.md) explains how the tiers fit together.

---

## Next: [Sample Surgical Strike →](sample-surgical.md)
