---
description: "The heaviest lane. Cross-module structural work runs the full doctrine axis: S1 → S5, freeze, gate-check, sub-bump, ratify. This walkthrough produces a 60K/30K/10K compass for Northwind's Billing module."
---

# Sample Doctrine Cycle — authoring the Billing compass

> *The heaviest lane. Cross-module structural work runs the full doctrine axis: S1 → S5, freeze, gate-check, sub-bump, ratify. This walkthrough produces a 60K/30K/10K compass for Northwind's Billing module.*

This is the worked example for the **Doctrine Cycle** lane (see [Work Granularity Lanes](../03-tunables/work-granularity-lanes.md)). It is the most ceremonious thing CompassAlpha does, and the example most worth reading slowly — every other lane is a *relaxation* of this one.

## Setup

Northwind has shipped its first few modules but never wrote down what Billing actually *is* — its invariants live in tribal knowledge and in code. The founder wants a **compass**: the canonical doctrine document for Billing, structured at three altitudes (see [Compass tier system, §19](../03-tunables/stage-taxonomies.md)).

- **Charter posture:** UNLOCKED for the duration (doctrine axis active; build axis dormant — see [Axis declarations](../03-tunables/axis-declarations.md)).
- **Tiers in play (doctrine axis):** Mentor-1 (long-lived for the cycle) · Mentor-2 (per-entity orchestrator) · Doer (fresh-per-slice).
- **Deliverable:** `/path/to/substrate/docs/compass/billing.md` — the Billing compass.
- **Tag plan:** per-entity sub-bump `billing-compass-v0.1` + cycle-end `charter-v0.6`.

### Cycle activation

Before any tier boots, the cycle is **activated**, not started ad-hoc:

- The **§9 queue** holds deferrals from earlier build cycles tagged to Billing (e.g. "the proration rule isn't written down anywhere").
- The founder does a **walk** — a pre-cycle review — and writes observations to `WALK_FEEDBACK.md` *before* the cycle boots (persistence law: nothing load-bearing in chat).

```
/path/to/reviewer-state/cycles/billing-compass/WALK_FEEDBACK.md
  - "proration on mid-cycle upgrade is undocumented and I'm not sure it's right"
  - "invoice numbering must be gapless for the tax authority — capture as an invariant?"
  - "dunning retry schedule lives only in a cron config"
```

The walk feedback + the §9 queue are the cycle's primary input.

## Stage-by-stage walkthrough

Northwind uses the default doctrine stage taxonomy: `WIP-S1 → WIP-S2a → WIP-S2b → WIP-S3a → WIP-S3b → WIP-S4 → WIP-S5` (see [Stage taxonomies](../03-tunables/stage-taxonomies.md)).

### S1 — Substrate recon + 60K Ideology

Mentor-1 stamps a launch brief into Mentor-2's inbox; the founder relays one trigger ping; Mentor-2 boots and dispatches a Doer to read the Billing code.

```
/path/to/reviewer-state/tier-2-orchestrator/billing/inbox/from-mentor1-launch.md
  [[FROM-MENTOR1→TO-MENTOR2 · billing-compass · launch]]
  Engage Billing compass. Begin S1: substrate recon + 60K ideology.
  Cite by substrate (§23). Surface any founder-calls.
  [[/FROM-MENTOR1→TO-MENTOR2]]
```

The Doer reads `/path/to/substrate/billing/**`, then returns a tagged digest. Mentor-2 triages it into the **60K view** of the compass — the ideology: *why billing exists, the named theses (e.g. "invoices are immutable once issued"), the principles*.

**Gate at this stage:** every claim cites a substrate file/line. A 60K assertion with no anchor is parked as an open question, not written as fact.

### S2a / S2b — 30K mechanics

S2a is the higher-altitude mechanics; S2b is the **compass-conjoined** pass — explicit cross-references to sibling compasses. Billing depends on Auth (who can be billed) and feeds Notifications (dunning emails), so S2b writes those edges down:

```markdown
## Federation Contract (30K)
Billing OFFERS:  invoice-issued events, subscription-state queries
Billing REQUIRES: account identity + entitlement from Auth
Cross-Compass refs: → Auth (billable-entity definition), → Notifications (dunning template trigger)
```

This is where the **invoice-numbering-must-be-gapless** observation from the walk becomes a candidate **LIFT-WATCH** item — it may be a cross-scope invariant, not just a Billing rule.

### S3a / S3b — 10K schema + routes + engine + events

The strictest substance gate. 60K can be aspirational; **10K must be executable**. S3a documents tables, types, and the subscription state machine; S3b documents route handlers, the proration engine, and the events emitted.

```markdown
## 10K — State machine (S3a)
subscription: trialing → active → past_due → canceled
  (past_due entered by failed charge; exits to active on retry success or canceled on dunning exhaustion)

## 10K — Engine (S3b)
proration: charge = remaining_days/period_days × (new_plan − old_plan), floored at 0
  anchored: /path/to/substrate/billing/proration.ts:L40–L72
```

The walk's proration concern is resolved here: the rule is now *written down and anchored*, and the Doer flags one discrepancy (the floor-at-0 wasn't applied on downgrades) as a build-axis leftover.

### S4 — Grass-root walks + LIFT-anchor evidence

The Doer walks the actual code paths to gather evidence anchoring the LIFT-WATCH candidate. By S4 close, the gapless-numbering invariant has **two** independent anchors (a DB constraint + a service check), enough to mark it `LIFT-WATCH: high`.

### S5 — Close package + reconciliation

Mentor-2 assembles the close package directly: the finished compass, the finding tally, and the leftover roster.

```
/path/to/reviewer-state/tier-1-mentor/inbox/billing-compass/from-mentor2-close-package.md
  [[FROM-MENTOR2→TO-MENTOR1 · billing-compass · close-package]]
  Compass COMPLETE across 60K/30K/10K. Coverage: all declared scope dims addressed.
  Finding tally self-reconciles (12 anchored, 0 dangling).
  LEFTOVERS onboarded: proration-downgrade-floor (build), LIFT-WATCH:gapless-numbering (high).
  [[/FROM-MENTOR2→TO-MENTOR1]]
```

## Freeze → gate-check → sub-bump

At **CP-FREEZE**, trigger **T7** fires: every non-closed item must be onboarded to `LEFTOVERS.md` *before* the freeze is reported as ratification-ready (see [Persistence Law, flush triggers](../01-axioms/persistence-law.md)).

Mentor-1 then runs the four objective **gates** (see §13 in [Stage taxonomies](../03-tunables/stage-taxonomies.md) and the [Guardrails](../02-guardrails/index.md)):

| Gate | Check | Result |
|---|---|---|
| 1 · Deliverable COMPLETE | compass across all three altitudes | GREEN |
| 2 · Coverage at target | every scope dimension + substance review | GREEN |
| 3 · Finding tally self-reconciles | 12 anchored, 0 dangling | GREEN |
| 4 · Every non-closed item onboarded | 2 leftovers in `LEFTOVERS.md` | GREEN |

Gates GREEN → Mentor-1 issues **GO-SUB-BUMP**. Mentor-2 applies the per-entity tag and pushes:

```bash
git -C /path/to/substrate tag -a billing-compass-v0.1 -m "Billing compass S1-S5 frozen"
git -C /path/to/substrate push origin billing-compass-v0.1
git -C /path/to/substrate ls-remote --tags origin | grep billing-compass-v0.1   # verify
```

The founder is **out of the mechanical tag loop** — veto only.

## Cycle-end ratification

This is a doctrine cycle, so it produces a **ratification package** for the founder (see §21 in [Stage taxonomies](../03-tunables/stage-taxonomies.md)):

1. **Triage table** — each walk/§9 item → FOLD-IN / DEFER / DROP.
2. **Per-scope sub-bump list** — `billing-compass-v0.1` @ exit SHA.
3. **Cross-cutting primitives lifted** — the gapless-numbering invariant, promoted to the Charter.
4. **Charter diff** — one new invariant added.
5. **Protocol-amendment candidates** — none this cycle.
6. **Open founder-calls** — the proration-downgrade bug: fix now (Polish) or defer?

The founder ratifies. On ratification:

```bash
git -C /path/to/substrate tag -a charter-v0.6 -m "Cycle close: Billing compass + gapless-numbering invariant"
```

Charter **RE-LOCKS**. Build axis resumes; doctrine axis goes dormant until the next walk.

## What the status grid shows at close

```
STATUS GRID — 2026-06-09 · END · Mentor-1 · MODE: RELAY · cycle stage CLOSED
GATE        Charter v0.5 UNLOCKED → v0.6 LOCKED · gates closed · 1/1 entity done
DISPATCH    none — last: billing-compass-v0.1
LEFTOVERS   1 open  (top: proration-downgrade-floor → routed to Polish)
NEXT        re-lock confirmed; build axis resume
DISK        4 state artifacts · read-back ✓ · no unflushed state · GH-sync 0/0 @ 9f3a1c2
```

## Outcome

- Billing now has a canonical compass at three altitudes, every claim anchored to code.
- One latent bug (proration on downgrade) was surfaced and routed to a lighter lane.
- One cross-cutting invariant (gapless invoice numbering) was lifted into the Charter, so *every* module now inherits it.
- The whole cycle is reconstructable from git: the walk, the inbox messages, the compass, the tags.

This is the heaviest lane. Notice that the **next** example does *less* of all of this — and the one after that, less still.

---

## Next: [Sample Phase 3 dispatch →](sample-phase3.md)
