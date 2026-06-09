# First Boot

> *Booting your first tier session: the T0 boot-integrity ritual, the reading order, and the START status grid that doubles as a drift check. Every session, every tier, every time — this is how a CompassAlpha session begins.*

You've set up your repos and stamped your tiers ([greenfield](greenfield-setup.md) or [brownfield](brownfield-onboarding.md)). Now you boot a session for the first time. This page is the boot ritual — it applies to *every* tier session you will ever run, so it's worth getting into your bones now.

A session that skips boot is a session operating on assumptions instead of disk. The boot ritual is what makes *"state of the federation = state of git"* trustworthy at the start of every turn.

---

## What "boot" means

When the founder spawns a fresh AI session in a tier's home folder and the session reads its stamped `CLAUDE.md`, that session **boots**. Boot is the **T0 flush trigger** — the first of the [flush triggers T0–T7](first-dispatch.md#the-gates-that-protect-a-dispatch). At T0 the session does not start working. First it proves it is grounded in reality.

The T0 contract, in order:

1. **Read all canonical state artifacts** in the prescribed reading order.
2. **Verify mutual consistency** — do the artifacts agree with each other and with what the boot file claims?
3. **Print the START status grid** (the Tier 1 six-line grid).
4. **Run the GH-sync check** — is local exactly equal to origin?

Only after all four does the session take work.

---

## The reading order

A booting tier reads, in this order:

1. **The master** — `COMPASS_ALPHA_FRAMEWORK_v0.1.md`. The substantive rules.
2. **This tier's stamp** — its own `CLAUDE.md`. Who am I, what may I touch, my commit discipline.
3. **The relevant axis declaration** — e.g. `AXIS_BUILD.md`. The bindings for this axis.
4. **`LEDGER.md`** — the live federation state. What's in flight, what's done, what's next.
5. **`memory/MEMORY.md`** — cross-cycle learnings, so the session inherits hard-won lessons without re-learning them.
6. **Its own `inbox/`** — new files here are this turn's work.

For a brand-new federation, the LEDGER and memory are near-empty and the inbox has nothing yet — that's expected. The reading order still runs; you're proving the *habit*, not just consuming content.

!!! note "The mentor does not read down"
    A Mentor never auto-reads a sub-tier's folder during routine boot. Auto-reading manufactures false drift, because a sub-tier's fine-grained snapshot contradicts the mentor's higher-altitude snapshot *by design*. A mentor descends only on a deliberate trigger (escalation, exit-study) — narrowly, transiently, never mirrored into its own state. See the [firewall](../01-axioms/firewall.md).

---

## The START status grid

After reading, the session prints the **Tier 1 six-line grid**. This is mandatory at session START and END. The shape:

```
STATUS GRID — <UTC date> · START · <tier-instance> · MODE: RELAY · cycle stage <CYCLE-STAGE>
GATE        Charter v<x> <LOCKED|UNLOCKED> → v<y> · gates closed · N/M units done
DISPATCH    <unit @ stage @ commit  |  "none — last: <tag>">
LEFTOVERS   <N open>  (top: <ids>)
NEXT        <single immediate next action — one T# event>
DISK        <K state artifacts · read-back ✓ · no unflushed state · GH-sync 0/0 @ <SHA>>
```

A first-boot grid on a brand-new build-axis federation looks like:

```
STATUS GRID — 2026-06-09 · START · Mentor-1 (build, tenure-1) · MODE: RELAY · cycle stage ENGAGED
GATE        Charter v0.1 LOCKED · gates closed · 0/0 units done
DISPATCH    none — last: (none, first cycle)
LEFTOVERS   0 open
NEXT        T1 — compose first dispatch brief for Mentor-2
DISK        6 state artifacts · read-back ✓ · no unflushed state · GH-sync 0/0 @ <SHA>
```

### The grid IS the boot-integrity check

The START grid is not decoration — it is the **drift detector**. Each line asserts something about disk. If any line cannot be truthfully filled from what's actually on disk and at origin, you have drift, and the rule is **halt and reconcile** before doing any work:

| Grid line | What it asserts | Drift if… |
|---|---|---|
| `GATE` | The Charter version and lock state | …the LEDGER says a different version than the Charter file |
| `DISPATCH` | The in-flight unit and its commit | …the named commit doesn't exist at origin |
| `LEFTOVERS` | Open deferred items | …the count disagrees with `LEFTOVERS.md` |
| `DISK` | Disk == understanding, GH-sync 0/0 | …`git status` is dirty or local ≠ origin |

The most important line is `DISK`. **`GH-sync 0/0`** means local has zero commits ahead and zero behind origin — local exactly equals the state of record. If it's not `0/0`, you are not booted on the true state.

---

## The GH-sync check in practice

```bash
# from the tier's home repo
git -C /path/to/reviewer-state fetch origin
git -C /path/to/reviewer-state status -sb
# expect: "## main...origin/main"  with nothing ahead/behind and a clean tree
```

If you're ahead: a prior session flushed but didn't push — push it (`pull --ff-only` then refspec push) before proceeding. If you're behind: pull (`--ff-only`) to pick up sibling writers. If the tree is dirty: there's unflushed state — flush and commit it before you trust the grid.

!!! warning "Never start work on a non-0/0 boot"
    A `GH-sync` that isn't `0/0` means the session's understanding and the state of record disagree. Working from there compounds the drift. Reconcile first — always.

---

## First-boot walkthrough

For your very first session (Mentor-1, build axis):

1. **Founder** spawns a fresh session in `/path/to/reviewer-state/tier-1-mentor/`.
2. **Founder** pings: *"boot — you are Mentor-1, build axis, tenure 1."*
3. **Session** reads the master → its stamp → `AXIS_BUILD.md` → `LEDGER.md` → `memory/MEMORY.md` → its `inbox/`.
4. **Session** verifies the artifacts agree (on a fresh setup: empty but consistent).
5. **Session** runs the GH-sync check; confirms `0/0`.
6. **Session** prints the START grid (like the example above).
7. **Session** is now booted and may take its first action — composing the first dispatch brief, which begins [first dispatch](first-dispatch.md).

---

## First-boot checklist

```
[ ] session spawned in the correct tier home folder
[ ] master + stamp + axis declaration + LEDGER + memory + inbox read, in order
[ ] artifacts mutually consistent (no contradictions)
[ ] GH-sync confirmed 0/0 (local == origin, tree clean)
[ ] START status grid printed; every line truthfully fillable from disk
[ ] no drift — or drift reconciled before any work
```

Once a session boots clean, it's ready to move work. That's the next page.

## Next: [First dispatch →](first-dispatch.md)
