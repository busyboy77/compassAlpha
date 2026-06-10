---
description: "The set-once decisions. Made at adoption, effectively permanent — changing one is a migration, not a flip."
---

# Project-Lifecycle Toggles

> *The set-once decisions. Made at adoption, effectively permanent — changing one is a migration, not a flip.*

`[TOGGLES — class: LIFECYCLE]`

## TL;DR

A **project-lifecycle toggle** is a setting baked so deeply into the federation that changing it isn't a flip at all — it's a **migration**. These are the decisions you make when you adopt CompassAlpha: the project name, the repo paths, the tier names, the choice of VCS, the canonical artifact set. They get encoded into file paths, bus inbox names, boot reads, and tier homes. Once the federation has run even one cycle, those encodings are everywhere on disk and at origin.

The honest framing: **treat these as permanent.** They *can* change, but only through a deliberate migration that rewrites state. Don't go looking for a runtime dial — there isn't one.

## The switches

| Setting | Default | Encoded into | Changing it means |
|---|---|---|---|
| Project name | — | paths, namespaces, branding | full rename migration |
| Reviewer-state repo path | `/path/to/reviewer-state` | every artifact's home | repo relocation + path rewrite |
| Substrate repo path | `/path/to/substrate` | Doer worktrees, axis declarations | repo relocation + path rewrite |
| Tier names (per axis) | Mentor-1 / Mentor-2 / Doer | bus inbox names, homes, logs | rename across all history references |
| VCS choice | git | the entire coordination layer | not changeable — `[INVARIANT — git is the bus]` |
| Remote service | a push-target | commit-discipline + sync checks | re-point remote (lighter) |
| Number of canonical state artifacts | 5 | every tier's boot read sequence | re-tool boot + handover |
| Mentor-1 lifecycle | per-cycle long-running | the continuity spine | rare cycle-boundary change |
| Single-live-writer enforcement | strict | the whole concurrency model | not relaxable — `[INVARIANT]` |
| Host power-down resilience model | volatile-local / durable-origin | flush cadence semantics | host migration |

## Why these are effectively permanent

### Paths and names are written everywhere

The [persistence law](../01-axioms/persistence-law.md) means *every load-bearing fact lives on disk and at origin*. The [bus protocol](../01-axioms/bus-protocol.md) routes messages through inbox files named for the sender and recipient tiers. The [firewall](../01-axioms/firewall.md) confines each tier to a folder named for it. So the moment the federation runs, the project name, the repo paths, and the tier names are stamped into:

- every committed artifact's location,
- every bus inbox filename,
- every handover-log and ledger reference,
- every tier home and worktree path,
- the boot-read sequence each fresh session executes at T0.

Changing one means rewriting all of that *and* the git history that references it. That's a migration project, not a setting flip.

### Some are genuine invariants

Two rows aren't really toggles at all — they're listed here so adopters stop looking for a dial:

- **VCS = git.** Git *is* the coordination, durability, and audit layer of CompassAlpha (this is the GitAI thesis). There is no "use something else" toggle. `[INVARIANT — git is the bus]`.
- **Single-live-writer enforcement = strict.** Only the current jurisdiction-holder writes the state-of-record while holding jurisdiction; any overlap writer fetches-before-push and never clobbers. This cannot be relaxed downward without breaking the [persistence law](../01-axioms/persistence-law.md). `[INVARIANT — keep strict]`.

### Some are foundational but technically migratable

- **Reviewer-state and substrate repo paths** can move — that's a repo relocation plus a path rewrite across the canonical artifacts. Real work, done deliberately, not a runtime flip.
- **Remote service** (the push-target) is the lightest of these: re-pointing the remote is a config change, since CompassAlpha only requires *a* push-target, not a specific provider.
- **Number of canonical state artifacts** (the reference is 5; smaller projects might collapse to 3) re-tools the boot-read sequence and the handover battery. Set it at adoption.
- **Mentor-1 lifecycle** (per-cycle long-running vs per-epoch) is the continuity spine of the federation. A mature project *may* revisit it at a cycle boundary, but it behaves more like a foundation than a dial — treat it as set-once unless you have a strong reason.
- **Host power-down resilience model** is determined by where tiers run. It sets the *semantics* of flush cadence (volatile-local hosts must push every flush trigger; durable-local hosts may batch). It changes only when you migrate hosts.

## Risks of trying to flip these mid-life

These don't "flip wrong" so much as **break if you treat them as flippable**:

- **Renaming a tier or moving a repo without a migration** orphans every existing bus inbox, breaks every path reference in the ledger and handover log, and triggers boot-integrity failures (disk references a name/path the session no longer expects). The [persistence-law](../01-axioms/persistence-law.md) read-back will flag drift and halt — which is the system protecting you.
- **Trying to relax single-live-writer** to "speed things up" re-opens the cross-session contamination and clobber-on-push failure modes the [git foundations](../01-axioms/git-foundations.md) exist to prevent.
- **Swapping VCS** isn't a CompassAlpha federation anymore — it's a different thing wearing the name.

When you genuinely need to change one of these, do it as a planned migration. See [Getting started](../05-getting-started/index.md) for the adoption and brownfield-migration flows.

## Defaults

The defaults above are the reference choices. The generic example federations in this portal use **Auth**, **Billing**, and **Reporting** as substrate scopes, `/path/to/substrate` and `/path/to/reviewer-state` as repo paths, and **Mentor-1 / Mentor-2 / Doer** as tier names — adopters substitute their own at adoption and then leave them alone.

## Connections

- These settings are the project-level and tech-stack entries on the [Tunables](../03-tunables/index.md) surface.
- They're permanent *because* of the [persistence law](../01-axioms/persistence-law.md), [bus protocol](../01-axioms/bus-protocol.md), and [firewall](../01-axioms/firewall.md) — the same invariants that make the federation durable also make these settings sticky.
- Contrast with [Runtime toggles](runtime-toggles.md) (flip anytime) and [Cycle toggles](cycle-toggles.md) (flip at a seam).
- Setting them is the first step of adoption; see [Getting started](../05-getting-started/index.md).

---

## Next: [Operating presets →](operating-presets.md)
