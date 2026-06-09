# Cutover from a Pre-AI Project

> *A concrete, revertible, step-by-step walkthrough for a team moving an existing project under CompassAlpha. Worked end-to-end with Auth / Billing / Reporting as the example modules. No big bang — every step can be undone.*

This is the hands-on companion to [brownfield onboarding](brownfield-onboarding.md). Where that page describes the five-phase *journey*, this page is the *worked walkthrough*: the exact moves a team makes, in order, with the safety property that **nothing here destroys or freezes your existing workflow until you choose to retire it**.

The example is a small SaaS with three modules — **Auth**, **Billing**, **Reporting** — running on a conventional pull-request workflow with CI. No AI agents, no doctrine layer. We move it under CompassAlpha module by module.

!!! note "Why revertible matters"
    A team cannot afford a one-way migration on a production system. Every step below is additive or parallel — you can stop, observe, and roll back at any phase boundary without losing your existing process. CompassAlpha runs *alongside* your workflow until you're confident enough to retire it.

!!! note "Commercial use"
    Cutting a production project over is production use. Confirm your [commercial license](https://github.com/busyboy77/compassAlpha/blob/main/COMMERCIAL.md) before you start.

---

## Cutover at a glance

| Step | Action | Revert by… |
|---|---|---|
| 1 | Stand up reviewer-state alongside the existing substrate | Deleting the reviewer-state repo; substrate untouched |
| 2 | Inventory modules; pick Auth as pilot | No code change yet — nothing to revert |
| 3 | Run Discovery Doctrine Cycle on Auth → frozen compass | Discard the compass; Auth code unchanged |
| 4 | Author + LOCK Charter v0.1 | Unlock / discard; no module forced to comply yet |
| 5 | Route Auth changes through CompassAlpha; Billing/Reporting stay legacy | Route Auth back through the old PR workflow |
| 6 | Graduate Billing, then Reporting | Each graduation is independent and reversible |
| 7 | Retire the legacy workflow | The only one-way step — taken last, deliberately |

---

## Step 1 — Stand up reviewer-state alongside the existing substrate

Your existing project repo *becomes* the substrate. You don't move or restructure it. You add a **sibling** reviewer-state repo next to it.

```bash
# your existing project is already at /path/to/substrate (with its own remote)
git init /path/to/reviewer-state
git -C /path/to/reviewer-state remote add origin <reviewer-state-remote-url>
```

Drop in the master, author the canonical state artifacts, lay out the bus tree, stamp the tiers — exactly [greenfield setup](greenfield-setup.md) steps 2–6. Your substrate's existing branches, CI, and PR process keep working untouched.

**Revert:** delete `/path/to/reviewer-state`. The substrate never changed.

---

## Step 2 — Inventory and pick the pilot

List the modules and their relationships:

| Module | Depended on by | Depends on | Change rate | Pick as pilot? |
|---|---|---|---|---|
| **Auth** | Billing, Reporting | (none) | medium | **Yes** — well-bounded, widely depended-on, clear invariants |
| **Billing** | Reporting | Auth | high | Later |
| **Reporting** | (none) | Auth, Billing | low | Last |

Auth is the right first pilot: self-contained, depended on by everyone (so its doctrine is high-value), and not currently on fire.

**Revert:** nothing changed; this is analysis only.

---

## Step 3 — Run the Discovery Doctrine Cycle on Auth

Extract Auth's doctrine *from its existing code*. The cycle stages (see [brownfield onboarding](brownfield-onboarding.md#the-discovery-doctrine-cycle-stages)):

```
SURVEY → DRAFT → CROSS-REFERENCE → REVIEW → FREEZE-AS-v0.1
```

Run it through the tiers:

1. **Mentor-1** opens the Discovery cycle, dispatches Auth to Mentor-2.
2. **Mentor-2** slices: SURVEY slice, DRAFT slice, CROSS-REFERENCE slice.
3. **Doer (SURVEY)** reads Auth's code, README, commit history; interviews the team; returns an inventory of what Auth *actually does* — e.g. "sessions expire after 24h", "passwords hashed with algorithm X", "every login emits an event Reporting consumes".
4. **Doer (DRAFT)** writes the Auth compass at three altitudes.
5. **Doer (CROSS-REFERENCE)** checks every doctrine claim against the code. Discrepancy found: the README says 24h sessions but the code says 12h. That's a **founder-call** — Mentor-1 surfaces it; the founder rules which is doctrine; the compass records the truth.
6. **Mentor-1** ratifies; the Auth compass is **frozen as v0.1** and tagged.

You now have the first written doctrine the project has ever had — and you discovered a real discrepancy in the process.

**Revert:** discard the compass and the doctrine cycle's reviewer-state. Auth's code was only *read*, never modified.

---

## Step 4 — Author and LOCK Charter v0.1

From the Auth compass (plus anything obviously cross-cutting), write a minimal Charter v0.1. Keep it to rules that genuinely span modules:

```
CHARTER v0.1 (minimal)
1. All modules authenticate through Auth. No module rolls its own session logic.
2. Money values are integer minor-units; never floating point. (binds Billing)
3. Every state-changing action emits an event for Reporting.
4. No module reads another module's database tables directly; cross-module
   access goes through the owning module's interface.
```

Review, ratify, and **LOCK** it. A LOCKED Charter is the precondition for the build axis to run. Crucially: locking the Charter does **not** force Billing or Reporting to comply yet — they're still legacy. The Charter governs CompassAlpha-managed modules; legacy modules graduate into it.

**Revert:** unlock and discard. No module was forced to change.

---

## Step 5 — Route Auth through CompassAlpha; keep Billing/Reporting legacy

This is the parallel-track. From now on:

- **Auth changes** go through CompassAlpha: Mentor-1 brief → Mentor-2 slice → Doer commits via worktree + commit-tree + refspec push → gate → tag. Exactly the [first dispatch](first-dispatch.md) rhythm.
- **Billing and Reporting changes** keep using your existing PR workflow and CI. Untouched.
- **Cross-boundary calls** are recorded. When an Auth Doer must touch the Billing interface, the brief notes the legacy boundary so the integration is deliberate.

Worked example — a real Auth change under CompassAlpha:

1. Founder: "Auth needs rate-limiting on login."
2. Mentor-1 composes a dispatch brief (Charter rule 3 reminds: emit an event for Reporting).
3. Mentor-2 slices: `s1` rate-limit middleware, `s2` the Reporting event.
4. Doers implement each slice in isolated worktrees, commit to substrate, return digests.
5. Mentor-2 gates each slice; Mentor-1 ratifies and tags `auth-ratelimit-v0.1`.

Meanwhile a Billing change ships through the old PR flow the same afternoon. Both coexist.

**Revert:** route Auth back through the old PR workflow. The CompassAlpha tags remain as history; nothing is lost.

---

## Step 6 — Graduate Billing, then Reporting

Repeat the loop per module. **Billing** is higher-risk (money, high change rate, depends on Auth), so its Discovery Doctrine Cycle pays special attention to Charter rule 2 (integer minor-units). Induct any pre-existing Billing debt into `LEFTOVERS.md` as `PRE-EXISTING`:

| ID | Description | Type | Origin | Target | Status |
|---|---|---|---|---|---|
| BILL-001 | float rounding in legacy invoice path | PRE-EXISTING | pre-CompassAlpha | Billing graduation | ACTIVE |
| BILL-002 | no event emitted on refund | PRE-EXISTING | pre-CompassAlpha | next Billing dispatch | ACTIVE |

When Billing's compass freezes and it complies with the Charter, Billing **graduates** — its changes now flow through CompassAlpha. Then **Reporting** last (it depends on both, so it's the safest to onboard once Auth and Billing are stable).

If onboarding Reporting surfaces a new cross-cutting rule (say, "all reports are reproducible from the event log"), that's a **standard doctrine cycle**: UNLOCK the Charter → amend → re-LOCK at v0.2. The Charter evolves as the project's understanding deepens.

**Revert:** each module's graduation is independent. Roll any single module back to legacy without affecting the others.

---

## Step 7 — Retire the legacy workflow

Once Auth, Billing, and Reporting are all CompassAlpha-managed and stable, retire the old PR workflow. This is the **one deliberately one-way step** — and you take it only after every module has proven itself under CompassAlpha. By now:

- All three modules have frozen compasses.
- The Charter governs the whole system.
- Every change for weeks has flowed through the bus with a durable audit trail.
- Pre-existing debt is visible in `LEFTOVERS.md` and being worked down.

Even here, "retire" means *stop using*, not *delete* — your old CI config and PR history remain as record. The cutover is complete.

---

## What the team gained

- **A written doctrine layer** where there was only tribal knowledge — and which now doubles as onboarding material for new hires.
- **A durable audit trail**: every change reconstructable from git log, not lost in chat or ticket comments.
- **A real discrepancy caught** (the 24h-vs-12h session bug) during extraction — brownfield onboarding routinely surfaces these.
- **No production disruption**: the whole cutover ran alongside the existing workflow, one revertible step at a time.

---

## Cutover checklist

```
[ ] reviewer-state stood up beside the existing substrate (substrate untouched)
[ ] modules inventoried; Auth chosen as pilot
[ ] Auth Discovery Doctrine Cycle run → compass frozen; discrepancies surfaced as founder-calls
[ ] Charter v0.1 authored from extracted doctrine → LOCKED
[ ] Auth changes routed through CompassAlpha; Billing/Reporting still legacy
[ ] cross-boundary calls to legacy interfaces recorded in briefs
[ ] pre-existing debt inducted into LEFTOVERS as PRE-EXISTING
[ ] Billing graduated, then Reporting; Charter amended via standard doctrine cycle as needed
[ ] legacy workflow retired LAST, deliberately, after all modules proven
```

---

## ← Back to [Getting Started index](index.md) · Next section: [06 Adoption Patterns →](../06-adoption-patterns/index.md)
