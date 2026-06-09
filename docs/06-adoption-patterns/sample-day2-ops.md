# Sample Day-2 Ops axis — deploying and watching the release

> *A DECOUPLED Day-2 axis with two cadences: per-release (continuous) and per-incident. This walkthrough deploys the QA-approved scheduled-exports release and stands up the monitoring that will catch the next problem.*

This is the worked example for the **Ops axis** — the Day-2 axis that takes a verified release and gets it *running in production*, then keeps watching it. Like [QA](sample-day2-qa.md), Ops runs **DECOUPLED**: parallel to Build and Doctrine, sharing the [bus protocol](../01-axioms/bus-protocol.md) and [persistence law](../01-axioms/persistence-law.md), competing for no Charter state.

## The Ops axis tiers + cadences

| Generic tier | Northwind Ops role | Does |
|---|---|---|
| **Mentor-1** | SRE Lead | owns deploy policy; ratifies go-live; surfaces founder-calls |
| **Mentor-2** | Platform Engineer | orchestrates one deploy or one capacity review; triages telemetry |
| **Doer** | Deploy / Config Editor | applies the deploy; edits config; wires monitors |

Ops runs on **three** cadences:

- **Per-release (continuous)** — every QA-passed release gets deployed and watched. *(This example.)*
- **Per-incident** — when something breaks, the [Incident Response lane](sample-incident-response.md) fires.
- **Periodic capacity** — scheduled capacity/cost reviews.

## Setup

The [QA axis](sample-day2-qa.md) just tagged `qa-reporting-v1.3-pass` (conditional pass on scheduled exports). The Ops axis now deploys it.

- **Deliverable:** the release running in production + monitoring + a deploy record.
- **Cadence:** per-release.
- **Tag plan:** `ops-reporting-v1.3-deployed` on the deploy record.

Ops declares its own stage taxonomy — Northwind uses `INTAKE → STAGE → SMOKE-PROD → CUTOVER → OBSERVE → CLOSE`.

## Stage-by-stage walkthrough

### INTAKE — QA handoff

QA's status grid `NEXT` line said *"hand to Ops."* That handoff arrives as a bus message into the SRE Lead's inbox:

```
/path/to/reviewer-state/ops/tier-1-lead/inbox/from-qa-handoff.md
  [[FROM-QA-MENTOR1→TO-OPS-MENTOR1 · reporting-v1.3 · deploy-handoff]]
  qa-reporting-v1.3-pass (conditional). Approved to ship CRUD + runner.
  Watch-item: the runner's new background job — first time we run a scheduled worker in prod.
  [[/FROM-QA-MENTOR1→TO-OPS-MENTOR1]]
```

### STAGE → SMOKE-PROD — Platform Engineer prepares

The SRE Lead stamps a Platform Engineer (Mentor-2) for this deploy. A fresh Doer (Deploy Editor) deploys to staging-prod and runs a production smoke check — including the *new* surface (the scheduled-export worker):

```
/path/to/reviewer-state/ops/tier-2-platform/reporting-v1.3/s1/inbox/from-platform-brief.md
  [[FROM-OPS-MENTOR2→TO-DOER · reporting-v1.3/s1 · brief]]
  Deploy reporting-v1.3 to staging-prod. Run migration. Smoke: app boots, export worker starts,
  one test schedule fires and delivers. Wire a monitor on the export-worker job-lag metric BEFORE cutover.
  [[/FROM-OPS-MENTOR2→TO-DOER]]
```

The monitoring is wired **before** cutover — the SRE Lead's deploy policy requires a watch in place before traffic flips.

### CUTOVER — go-live ratified

The Platform Engineer reports the staging smoke is green and surfaces the go-live decision. The SRE Lead ratifies **CUTOVER** and the Deploy Editor flips production:

```bash
# Deploy record committed to substrate (data plane)
git -C /path/to/substrate add ops/deploys/reporting-v1.3.md
git -C /path/to/substrate commit -m "ops: reporting-v1.3 prod cutover record"
git -C /path/to/substrate push origin main:main
git -C /path/to/substrate tag -a ops-reporting-v1.3-deployed -m "Ops: reporting-v1.3 live in prod"
git -C /path/to/substrate push origin ops-reporting-v1.3-deployed
```

### OBSERVE — the continuous part

This is what makes Ops *continuous* rather than a one-shot. The Platform Engineer watches the new monitors for the agreed soak window. The export-worker job-lag metric stays nominal; one transient spike self-recovers and is logged but not escalated.

```
OBSERVE log (soak window):
  export-worker job-lag: nominal (peak 4s, threshold 60s)
  delivery success rate: 99.8%
  one transient lag spike @ 03:14 — self-recovered, no action
```

### CLOSE — deploy record finalized

The Platform Engineer finalizes the deploy record and the SRE Lead closes the per-release cycle. Any watch-items that need ongoing attention are onboarded to `LEFTOVERS.md` (T7 discipline).

## What the Ops status grid shows at close

```
STATUS GRID — 2026-06-09 · END · Ops-Mentor-1 · MODE: RELAY · axis OPS (DECOUPLED) · stage CLOSE
GATE        no Charter state (DECOUPLED) · deploy LIVE · monitors GREEN
DISPATCH    none — last: ops-reporting-v1.3-deployed
LEFTOVERS   1 open  (top: tune job-lag threshold after first full week)
NEXT        soak complete; per-release cycle closed; standby for next release/incident
DISK        2 state artifacts · read-back ✓ · no unflushed state · GH-sync 0/0 @ f51d0a3
```

## How the cadences interlock

The per-release cycle just closed cleanly. But the Ops axis doesn't stop — it stands by on its other two cadences:

- **Periodic capacity** will revisit the job-lag threshold leftover after a week of real traffic.
- **Per-incident** is armed: if that export worker *had* fallen over, the [Incident Response lane](sample-incident-response.md) would have fired with reduced ceremony.

This is the deploy that went *right*. The next example is the one that goes *wrong* at 02:00 — and shows how Ops handles a real incident.

## Outcome

- `reporting-v1.3` is live, deployed through a gated CUTOVER, with monitoring wired before traffic flipped.
- The deploy is auditable: handoff, brief, deploy record, and tag are all on disk.
- A tuning leftover was tracked for the periodic-capacity cadence instead of being forgotten.
- Ops ran DECOUPLED — no Charter contention, coordinated entirely through bus handoffs from QA.

---

## Next: [Sample Incident Response →](sample-incident-response.md)
