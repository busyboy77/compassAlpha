---
description: "The complete CompassAlpha doctrine, consolidated by theme in one searchable page."
---

# Full framework reference

> *The complete CompassAlpha doctrine, consolidated by theme in one searchable page.*

This page is the single long reference for the CompassAlpha framework. It folds the portal's sections together into one organized document for readers who want everything in one place — to read end to end, or to search (Ctrl-F) for a specific rule without first guessing which section owns it.

It is a synthesis, not a substitute. Where a topic has a dedicated teaching page with worked examples, this page summarizes and links to it. The [Axioms](../01-axioms/index.md) are the authoritative statement of the invariants; the [Tunables](../03-tunables/index.md) are the authoritative statement of the customization surface. This page consolidates both for lookup.

!!! note "Notation"
    `[INVARIANT]` — cannot change without forking the framework. `[TUNABLE]` — a project sets it for itself. `[OPEN]` — still being iterated. The tier names **Mentor-1 / Mentor-2 / Doer** are the framework's generic vocabulary; each axis substitutes its own role names.

---

## 1. What CompassAlpha is

CompassAlpha is a **source-available framework for orchestrating multi-tier AI-agent federations** on substantial codebases and doctrine work. It is the reference framework for **GitAI** — using git as the coordination, durability, and audit layer for multi-agent AI operations, analogous to what GitOps is for infrastructure and AIOps for IT operations.

It is a **protocol, not a tool**. It specifies how agent tiers behave; it does not mandate any particular AI harness. The value lives in the protocols, conventions, and load-bearing rules governing how tiers communicate, persist state, hand off work, and avoid the four pathologies of multi-agent AI work:

1. **Context pollution** — a session accumulating detail it doesn't need, degrading its judgment.
2. **Hallucination drift** — claims unmoored from verifiable substrate.
3. **Role confusion** — tiers doing each other's jobs.
4. **Trust erosion** — claims diverging from what's actually on disk.

**Design pillars.** Protocol-first and tool-agnostic; a mentor/orchestrator/doer hierarchy that contains pollution; git as the durability and audit layer (no specialized databases); a human founder as a low-cognitive-load relay bus, not an autonomous-agent operator; doctrine evolution treated as a first-class peer of code work; extensibility by inheritance.

→ [Framework, not tool](../00-foundation/framework-not-tool.md) · [GitAI category](../00-foundation/gitai-category.md)

---

## 2. The inheritance model — master + axes

The federation is a class hierarchy. A **master** holds every substantive rule, stated once, tier-agnostic. Each **axis** (build, doctrine, and any you add) is a thin **declaration** that names its tiers and deliverable and inherits everything else.

```
                  MASTER (every substantive rule, stated once)
                              │
        ┌─────────────────────┼─────────────────────┐
        ▼                     ▼                     ▼
   BUILD AXIS           DOCTRINE AXIS           FUTURE AXIS
  (declaration)        (declaration)          (declaration)
```

When a rule changes, it changes in the master and every axis picks it up automatically. When a new axis is added, the master is untouched — the axis is a new declaration. Inheritance collapses three costs that duplication imposes: duplicated rules, compounding update burden, and the cognitive load of "which section applies?"

→ [Axis declarations](../03-tunables/axis-declarations.md)

---

## 3. Tier grammar

`[INVARIANT — three tiers]` · `[TUNABLE — names]`

Three tiers per axis. Each axis declares its own role names; the rules speak in the generic vocabulary.

| Generic | Role | Labour? | Session lifecycle | Persistence home |
|---|---|---|---|---|
| **Mentor-1** | Top of chain; mentors at the axis's unit of work; ratifies completion; surfaces founder-calls | NEVER | Long-lived in tenure; rotates at clean seams | Own judicial folder in the reviewer-state repo |
| **Mentor-2** | Orchestrates ONE unit of work; slices it into Doer-sized chunks; triages tagged returns; applies ratification gates | NEVER | Fresh per dispatch / per event | Own confined folder under Mentor-1's home |
| **Doer** | The only tier that touches substrate; takes a bounded brief; produces the deliverable; returns tagged | **ALL** the substrate labour | Fresh-per-slice; disposable; never reused | Worktree-local + the committed deliverable |

**Why three, not two or four.** Two tiers force a single mentor to absorb both orchestration churn and high-level ratification — the exact pollution CompassAlpha exists to prevent. Four tiers add relay surface for marginal benefit; orchestration is already contained in Mentor-2. Three keeps each tier's context clean for its own work granularity.

→ [Tier grammar axiom](../01-axioms/tier-grammar.md)

---

## 4. The firewall + state-tracking scope

`[INVARIANT]` · The core defence against context pollution and stale-snapshot drift.

**Firewall — confined, not banished.** Each tier writes ONLY inside its own folder. A mentor **never auto-reads** a sub-tier's folder during routine flow — auto-reading manufactures false drift, because a sub-tier's finer-grained snapshot contradicts the mentor's coarser one *by design*. A mentor MAY descend on a deliberate trigger (escalation, pre-release exit study), reading **narrowly, transiently, never mirrored** into canonical state.

**State-tracking scope (the rule of law).** A mentor tracks ONLY the granularity it owns. Mentor-1 tracks dispatch/cycle-level state, not live per-slice WIP. Mentor-2 tracks its dispatch plus per-checkpoint milestones, not live per-slice WIP inside the Doer. Live sub-tier progress lives in the sub-tier's own folder and reaches the mentor only via a tagged return or at close.

Recording a point-in-time sub-tier snapshot and treating it as live is a **firewall leak**: it rots silently and manufactures false confidence. "Current WIP" notes always mean *"as of the last tagged return,"* never "live." **Push-on-milestone, not pull-live.**

→ [Firewall axiom](../01-axioms/firewall.md) · [Stale snapshot detection](../02-guardrails/stale-snapshot-detection.md)

---

## 5. The hard labour rule

`[INVARIANT]` · **Mentors NEVER touch substrate. The Doer is the only tier that does labour.**

**Labour** = recon, substrate reads, code surveys, document writes, deliverable production — any operation against the project's substrate repo.

**Mentor-allowed edge cases** (orchestration, not labour): own-tier artifact reads (own LEDGER / LEFTOVERS / HANDOVER_LOG / stamped CLAUDE.md / shared master / memories); protocol and template editing; stamp composition (writing a sub-tier's boot file from a template); a one-shot boot-time origin-verification of immutable tags.

**Why.** Mentor value lives in clean orchestrating context. Direct labour pollutes it with detail the mentor doesn't need to retain, and accrues fatigue across a long cycle. Doer sessions are fresh-per-unit and disposable — labour belongs there. **Recon is Doer work**: pre-brief recon is dispatched as a Doer slice, never done mentor-direct. Long-running co-resident AI consultants are reframed as **Doer-class consultants** (knowledge handoffs to fresh Doer instances), not mentor labour escape hatches.

→ [Hard labour rule axiom](../01-axioms/hard-labour-rule.md)

---

## 6. The bus protocol

`[INVARIANT — inbox-in-destination-folder model]` · `[TUNABLE — path layout]`

The single transport mechanism for all inter-tier communication, the same shape on every axis.

**The model.** Each tier has an `inbox/` inside its own judicial folder. The **sender** writes a tagged block as a file in the **recipient's** inbox, commits + pushes the reviewer-state repo, and pings the founder. The founder relays one line: *"pull + read your inbox."* The recipient pulls, reads its own inbox, acts.

**Naming.** `from-<sender-tier>-<event-class>[-<discriminator>].md`. Each filename is single-writer by construction.

**Write permissions (path-partitioned).**

| Tier | May write to | Reads inbox at |
|---|---|---|
| Mentor-1 | own folder + Mentor-2's inbox | own `inbox/<scope>/` |
| Mentor-2 | own folder + Mentor-1's inbox + Doer's inbox | own `inbox/` |
| Doer | substrate deliverable + Mentor-2's inbox | own slice `inbox/` |

**The iteration ritual (every turn, every tier).**

1. `pull --ff-only` the reviewer-state repo.
2. Read own inbox; new files = this turn's work.
3. *(Doer)* prepare worktree from cycle-tip if needed.
4. Do the tier's work.
5. *(Doer — data plane)* commit deliverable to substrate (separate git context, commit-discipline).
6. Write outbound file into recipient's inbox (control plane).
7. Flush own judicial folder.
8. `pull --ff-only` (fetch-before-push), then add + commit + push to the reviewer remote; verify sync 0/0.
9. Ping founder: *"ready for `<recipient>`."*
10. End turn.

**Two planes, never cross-commit.** Control plane (briefs, returns) → reviewer-state repo. Data plane (the deliverable) → substrate repo. A Doer turn is two separate `git -C` operations.

→ [Bus protocol axiom](../01-axioms/bus-protocol.md) · [CLI conventions](cli-conventions.md)

---

## 7. The persistence law (trust anchor)

`[INVARIANT]`

**Flush-before-disclose.** State is on disk + at origin BEFORE it is discussed with the founder. **Nothing load-bearing in chat.** This is what lets the founder step back to a relay role: disk state is independently verifiable; session memory is not.

**Layer A — persistence validation (every flush).** A write is not done until: (1) write to the canonical file, (2) read-back the affected fields from disk, (3) confirm the read matches intent. A flush not read back is treated as **not flushed**.

**Flush = write + commit + push + read-back.** On hosts with abrupt power-down risk, flush means `git commit + push` to the state-of-record remote, not just file-write. Cadence: commit+push at every flush trigger — a power-down then loses at most the current in-flight turn.

**Layer B — handover validation (every cutover).** A two-party cross-check; a handover passes only when both confirm: (1) the incoming tier self-administers the grounding battery from artifacts alone and surfaces ≥1 original, non-parroted observation; (2) the outgoing tier scores those answers against live artifacts and certifies no unflushed state remains. Logged in `HANDOVER_LOG.md`.

**Single-live-writer.** Only the current live tier-holder writes the reviewer-state repo while holding jurisdiction. Any overlap writer fetches before push and never clobbers the live writer.

→ [Persistence law axiom](../01-axioms/persistence-law.md) · [Single-live-writer guardrail](../02-guardrails/single-live-writer.md) · [Flush triggers](flush-triggers.md)

---

## 8. The provenance law

`[INVARIANT]` · **Every load-bearing claim is traceable to substrate, not to memory or LEDGER recall.**

- **Cite-by-substrate, not by LEDGER/memory.** A citation references the frozen substrate artifact at the relevant tag, not a mentor's LEDGER summary.
- **AI institutional-memory is not authoritative.** A consultant's recall ("I remember we decided X") must be verified against substrate before action.
- **Frozen-base provenance.** A doctrine revision rooted on a base predating the entity's prior close tag silently drops deltas. Run the ancestor-test + read-diff-reconcile at the prior tag; verify against the frozen-base blob, not a worktree checkout.

→ [Provenance law axiom](../01-axioms/provenance-law.md) · [Hallucination defense](../02-guardrails/hallucination-defense.md)

---

## 9. Locality

`[TUNABLE]`

Each tier lives somewhere physically. Two distinct repos in two sibling directories that **never cross-commit**:

- **Reviewer-state repo** — judicial/meta state. Its own remote. Mentor-1 home, Mentor-2 home (confined under it), and slice inboxes live here.
- **Substrate repo** — the project being built/governed. Its own remote. The Doer's worktrees live here.

The pollution firewall is **structural by directory separation** — the reviewer-state repo is outside the substrate working tree, so reviewer commits cannot land on a substrate branch. The one exception: a Doer editing a deliverable IS legitimate substrate work, landed via worktree + commit-discipline to a feature branch — never by touching the substrate main working tree.

Default reference layout:

```
<reviewer-state-repo>/                 ← judicial state, own remote
  mentor1-v<n>/                        ← Mentor-1 home (per cycle)
    inbox/<scope>/
    CLAUDE.md  LEDGER.md  LEFTOVERS.md  HANDOVER_LOG.md
    mentor2-<scope>-v<x.y>/            ← Mentor-2 home (confined)
      inbox/
      CLAUDE.md  LEDGER.md  LEFTOVERS.md  HANDOVER_LOG.md
      <slice>/inbox/                   ← Doer's brief lands here
<substrate-repo>/                      ← the project, own remote
  .doer-tmp/<scope>/<slice>/wt         ← isolated Doer worktree (gitignored)
```

→ [Git foundations axiom](../01-axioms/git-foundations.md) · [CLI conventions](cli-conventions.md)

---

## 10. Memory inheritance

`[INVARIANT — append-mostly, never silently deleted]` · `[TUNABLE — content]`

Memories are durable, cross-cycle, cross-axis learnings stored as discrete files in `<reviewer-state-repo>/memory/`, indexed in `MEMORY.md`. Every tier on every axis reads them at boot.

A memory qualifies when it emerged from a real incident (not abstract theorizing), is forward-binding across rotations, and teaches one thing (one file, kebab-case name). **Hygiene:** superseded memories are marked HISTORICAL in content and index, never deleted; new memories land via the normal commit-and-push cadence; cross-references use `[[memory-name]]` link syntax.

→ [Memory policy](../03-tunables/memory-policy.md)

---

## 11. Context-health hygiene

`[INVARIANT]`

Every tier keeps load-bearing state on disk so any session can be discarded and refreshed without loss — this is what makes aggressive session-refresh safe.

**Fresh-session bias increases down-tier.** Mentor-1 rotates at clean seams (weeks-scale, preventive). Mentor-2 rotates per dispatch or on a context-health signal. The Doer is **fresh per slice** — one slice, then it ends; reusing a Doer for a second slice is an anti-pattern.

**Doer state lives in its isolated worktree** — hot (live working copy), volatile (discarded on clean close), pluggable (a fresh session resumes from it). Do not invent a dedicated dev-task state folder; do not commit scratch into substrate. What survives the slice goes up in the tagged return; what survives as product is committed as the deliverable.

**Self-monitor signals:** responses lengthening without added content; recognition fuzziness; needing to re-read what should be known. On any signal → flush → rotate. Do not push through fatigue.

→ [Pollution containment](../02-guardrails/pollution-containment.md) · [Context patterns](../03-tunables/context-patterns.md)

---

## 12. Brief completeness rule

`[INVARIANT]`

Every dispatch brief must be **complete at relay**: all operational preconditions (dispatch branch, base HEAD/commit, index-file path, exit tag, commit-discipline parameters) filled with concrete values, never `<placeholders>`. **The dispatching tier knows its dispatch's actuals; the Doer does not.**

- **No founder-fills.** "Founder provides at boot" is not acceptable for operational preconditions.
- **Doer escalation duty.** An unfilled load-bearing field → the Doer escalates back (`[[DOER→MENTOR-2 · <slice> · BRIEF-INCOMPLETE]]`), never improvises.
- **Standing conventions named, not implied.** A brief may reference a named convention instead of repeating it, but it must name the convention.

→ [Brief completeness guardrail](../02-guardrails/brief-completeness.md) · [Dispatch brief template](templates/index.md)

---

## 13. Hierarchy-edge tags + tag-gated ingestion

`[INVARIANT — wire format]` · `[TUNABLE — exact tag names]`

Every paste-ready block (or inbox file) carries a hierarchy-edge tag identifying its sender→recipient edge:

- down: `[[MENTOR-1→MENTOR-2 · <scope>]] … [[/MENTOR-1→MENTOR-2]]`
- up: `[[MENTOR-2→MENTOR-1 · <scope> · <status>]]`
- mid↔doer: `[[MENTOR-2→DOER · <scope>/<slice>]]` / `[[DOER→MENTOR-2 · <scope>/<slice>]]`
- cross-axis (rare): `[[<AXIS_A>→<AXIS_B>]]`

**Ingestion rule (validate-then-reject):** a tier consumes a block ONLY if its edge terminates at that tier. On mismatch — reject, name the intended tier, do not ingest. Voice-match across relay hops is signal, not authorization.

→ [Hierarchy tags reference](hierarchy-tags.md)

---

## 14. Exit / release / ratification gates

`[INVARIANT — four objective gates]` · `[TUNABLE — gate definitions per axis]`

A dispatch closes when four gates are green:

1. **Deliverable COMPLETE** — defined per axis.
2. **Coverage at target** — structural (every declared dimension addressed) + substance (orchestrator review confirms non-shallow entries).
3. **Finding tally self-reconciles** in the return package.
4. **Every non-closed item onboarded to `LEFTOVERS.md`** — nothing untracked.

Founder pushback parks items OPEN in `LEFTOVERS.md`; deferral adjudications do not block the tag — unless the pushback is "do it in-dispatch," which re-opens the dispatch. **Tag application is mechanical:** gates green → orchestrator issues GO-TAG → the dispatch session applies the annotated tag + refspec-pushes. The founder is removed from the mechanical loop; veto only. **Tag-vs-close-record:** the tag is on the gated commit; founder signatures and close records land in a follow-up commit after the tag.

---

## 15. Flush triggers T0–T7

`[INVARIANT]`

| # | Trigger | Action |
|---|---|---|
| T0 | Boot | Read canonical artifacts; verify mutual consistency; print START grid; sync check |
| T0e | Session end / standby-into-cutover | Print END grid; final disk==understanding certification |
| T1 | State change | Flush to LEDGER + read-back |
| T2 | Triage return | Flush resulting state before standby |
| T3 | End-of-turn sweep | Confirm ledger reflects advances; unflushed state = incomplete turn |
| T4 | Context-health signal | Flush everything; initiate cutover prep |
| T5 | Cutover / onboarding | Full Layer-B dual validation; append to HANDOVER_LOG |
| T6 | Doctrine change | Update master / declaration / templates; version-bump |
| T7 | CP-freeze | Onboard every leftover to LEFTOVERS before reporting freeze ready |

→ [Flush triggers reference](flush-triggers.md)

---

## 16. Status-grid doctrine

`[INVARIANT — three tiers exist]` · `[TUNABLE — stage taxonomy per axis]`

Three grid levels: **Tier 1** — a mandatory 6-line grid at session START and END (the START grid doubles as a boot-integrity check; the END grid certifies disk==understanding); **Tier 2** — categorical with stages (DONE / WIP / QUEUED / LEFTOVER / DROPPED / MISSED / FORGOTTEN), printed at significant seams; **Tier 3** — constitutional-hierarchical deep visualization, printed at cycle-close prep and cross-rotation briefings.

→ [Status grids reference](status-grids.md)

---

## 17. Cycle activation — queue + walk + lift-watch

`[INVARIANT — activation is gated, not ad-hoc]` · `[TUNABLE — thresholds]`

- **Deferral queue** — items surfaced during build cycles, deferred to the next doctrine cycle. Named, described, scope-tagged. The next doctrine cycle triages each: FOLD-IN / DEFER / DROP.
- **The walk** — the founder's review of the project preceding a doctrine cycle, captured in a `WALK_FEEDBACK.md` *before* the cycle boots (persistence law). Walk feedback + the deferral queue are the cycle's primary input.
- **LIFT-WATCH** — items observed during a doctrine cycle that may warrant lifting into Charter-tier primitives/invariants. Tracked in `LEFTOVERS.md` with strength markers; ratified at cycle-close once anchor count + substance suffice.

---

## 18. Cycle-end ratification package

`[INVARIANT — package shape]` · `[TUNABLE — fields]`

When a doctrine cycle closes, the orchestrator assembles a package for the founder: (1) triage table — each item → FOLD-IN / DEFER / DROP + rationale; (2) per-scope sub-bump list with tags + exit SHAs; (3) cross-cutting primitives lifted into Charter; (4) Charter diff — amendments accepted; (5) protocol-amendment candidates; (6) open founder-calls. On ratification: issue the cycle-end major bump (**GO-UP-BUMP** — annotated tag, refspec push), re-lock the Charter, wire up the cycle home (Layer-A clean, END grid). The other axis resumes.

→ [Ratification package template](templates/index.md) · [Sample doctrine cycle](../06-adoption-patterns/sample-doctrine-cycle.md)

---

## 19. Cross-axis temporal posture (the alternation state machine)

`[INVARIANT — axes sharing a Charter state do not run concurrently]`

The federation has a **Charter state machine** with two stable states:

```
   ┌─────────────────────┐    walk     ┌───────────────────────┐
   │   Charter LOCKED     │ ──────────▶ │  Charter UNLOCKED     │
   │  (build axis active) │             │  (doctrine axis active)│
   └─────────────────────┘ ◀────────── └───────────────────────┘
                            cycle close
                            + re-lock (charter v<n+1>)
```

- **LOCKED → UNLOCKED = the walk:** the founder reviews output, surfaces feedback, fires the doctrine axis (requires sufficient queue depth + a recent build-close threshold).
- **UNLOCKED → LOCKED = the cycle close:** the doctrine axis ratifies the amendment package, issues the cycle-end bump, re-locks.

**Why no concurrency.** A build axis under an UNLOCKED Charter races the amendment (primitives can change mid-build); a doctrine axis under a LOCKED Charter cannot author the amendments it exists for. Axes whose posture is `DECOUPLED` (e.g. a future review/audit axis) MAY run concurrently but must not gate or block the main two. `[OPEN: should DECOUPLED axes have their own state machine?]`

---

## 20. Work-granularity lanes

`[INVARIANT — all four lanes coexist on every project]` · `[TUNABLE — per-lane policies]`

Four lanes share the load-bearing rules and differ only in ceremony. Lane choice is a triage decision made at incoming-request time.

| Lane | Granularity | Tier ceremony | Tag | Turnaround |
|---|---|---|---|---|
| **Doctrine cycle** | Cross-module structural change (new primitive/invariant/Charter amendment) | Full 3-tier, doctrine axis | `charter-v<X+1>` | Weeks |
| **Phase 3 (build)** | Single-module substantive change (new schema/routes/audit rework) | Full 3-tier, build axis | `<module>-v<x.y>` | Days–weeks |
| **Polish lane** | Cosmetic / bounded behavioral (column add, copy tweak, modal fix) | Slim Mentor-2 → Doer, single-CP | `polish-<topic>-v<x.y>` | Hours–a day |
| **Surgical strike** | Single-concern, ideally single-file (one-line tweak, copy fix) | Mentor-1 → Doer (Mentor-2 SKIPPED), single-turn | (no tag; commit on trunk) | Minutes–hours |

**Triage:** touches primitives/invariants/Charter → doctrine queue; schema/new API/cross-module → Phase 3; bounded single-module behavior → Polish; single-concern cosmetic → Surgical; ambiguous → founder triage.

**Preserved across all lanes:** firewall, provenance, persistence, hard labour, flush-before-disclose, bus protocol, commit discipline. Even a surgical strike goes through a tier; the founder never edits code directly.

**Relaxed for lighter lanes:** Surgical Doer is fresh-per-turn; Mentor-2 skipped (Surgical) or slim (Polish); single-CP (Polish) or no CP (Surgical); one-liner brief and no tag for Surgical; Tier-1 grid optional for Surgical.

**Charter-state interaction:** under LOCKED all four are available; under UNLOCKED, Phase 3 is dormant but Polish + Surgical can still run on stable surfaces (they don't touch the primitives being amended — that's their definitional scope).

→ [Work granularity lanes](../03-tunables/work-granularity-lanes.md) · [Sample polish](../06-adoption-patterns/sample-polish.md) · [Sample surgical](../06-adoption-patterns/sample-surgical.md)

---

## 21. Stage taxonomies

`[TUNABLE — stage names per axis + per lane]`

Each axis and lane declares its lifecycle stages, used by Tier-2 grids, inbox file naming, gate definitions, and the audit trail. The framework's stage machinery requires only: a **monotonic stage progression** (no un-advancing without explicit rollback); a defined **CP-FREEZE → GATE-CHECK → TAGS-APPLIED tail** gating ratification; and a **terminal FROZEN state** signalling archival. Within those constraints, stage names and counts are tunable.

Reference taxonomies (build CP1–CP3, doctrine S1–S5, polish, surgical, cycle-level, rotation, per-tier micro-states) are consolidated on the dedicated page.

→ [Stage grammar reference](stage-grammar.md) · [Stage taxonomies](../03-tunables/stage-taxonomies.md)

---

## 22. The founder role + lost+found protocol

`[INVARIANT — relay bus + lost+found backstop, NOT a per-decision arbiter]`

**The founder does:** run a trigger bus (spawn the right tier, deliver one-line pings); initiate Mentor-1 rotations at clean seams; arbitrate genuine **founder-call boundary** items (scope/intent/agenda/value decisions not derivable from substrate + AI consensus + the tier hierarchy — these are rare).

**The founder does NOT:** decide per-slice work flow; triage routine returns; hold state the federation doesn't have on disk; arbitrate definitional questions resolvable internally.

**A founder-call is escalated only if** it is a charter-tier proposal, a scope-shift, a gate-count/amendment-shape change, or genuine value/intent the tier cannot resolve internally. Everything else is tier-managed without a founder gate. The founder does not stand by for "GO" between routine sub-steps; tiers flush-then-act continuously.

**The UX exception.** User-experience excellence is one of the few areas where founder *taste* matters and cannot be delegated. Click budgets, design language, and the app's overall feel are founder-call-class by their nature. For projects with a UI surface, the founder is the de facto Chief UX Officer — setting click budgets, reviewing built surfaces at the cycle-close demo seam, ratifying design-language changes. This is the relay-only rule working as designed: UX vision is exactly the kind of irreducible founder judgment that justifies the founder role at all.

---

## 23. Deliverable doctrine structure (the compass tiers)

`[TUNABLE — applies to doctrine-class deliverables]`

When the deliverable is a doctrine document (a "compass"), it is structured at three altitudes: **60K** (ideology — principles, named theses, why-this-domain-matters); **30K** (mechanics — state machines, lifecycles, primitives owned, invariants upheld, sibling cross-references); **10K** (the executable layer — schema, types, routes, engine, events, audit hooks). Plus auxiliaries: a terms-of-art glossary, a federation contract (what this scope offers/requires of others), cross-references, and open questions. Substance gates tighten as you descend: 60K may be aspirational; 10K must be executable. For code-deliverable axes, substitute that axis's deliverable-structure doctrine.

---

## 24. Failure modes + recovery

`[INVARIANT — known failure classes]`

| Failure | Symptom | Recovery |
|---|---|---|
| **Power-down** | Session killed mid-turn; in-flight work lost | Fresh session pulls origin (last pushed = truth); reads own folder + inbox; resumes from last clean checkpoint. Loses ≤ current turn if flush=push cadence holds. |
| **Rotation mid-flight** | Mentor-1 fatigues with in-flight dispatches | Outgoing emits END certification + push; incoming runs T0 boot-integrity, Layer-B grounding battery, ≥1 original observation, countersign. Dispatches continue under the new Mentor-1. |
| **Firewall leak** | Mentor acts on a stale sub-tier snapshot | State-tracking scope rule; "WIP" tagged *as of <return-date>*; forensic descent to verify before action. |
| **Delegated pollution** | Sub-agent returns pollute parent context on retrieval | Pure RELAY (separate sessions, bus-mediated). Sub-agent spawn at mentor tiers avoided unless returns are summarized at a separate tier first. |
| **Consultant false-positive** | AI institutional-memory recall is wrong | Verify against substrate cycle-tip tags before accepting any recall (provenance law). |
| **Brief-incomplete improvisation** | Doer improvises on an unfilled precondition | Brief completeness rule + Doer escalation duty; improvisation forbidden. |

→ [Failure modes guardrail](../02-guardrails/failure-modes.md)

---

## 25. GitAI — the operational category

CompassAlpha is the reference framework for **GitAI**: applying GitOps' core insight ("git is the source of truth; automation reconciles state") to AI-agent orchestration.

- **State of the federation = state of the reviewer-state repo.** Any session can be recreated from git.
- **Coordination via inboxes** — sender writes a file, commits, pushes; recipient pulls and reads. No proprietary message bus.
- **Audit trail = git log.** Every inbox file persists; every state change is a commit; full history is reconstructable.
- **Reconciliation via pull → read → act.** The AI tier IS the reconciler.
- **Disaster recovery = `git pull`.** State of record was always at origin.

**Distinctions:** GitOps reconciles infrastructure to a desired state; GitAI reconciles AI-tier behavior to inbox state + master doctrine. AIOps assists human operators with AI; GitAI orchestrates AI tiers with a thin human relay. MLOps manages model lifecycles; GitAI manages agent federations doing knowledge work. CompassAlpha is to GitAI what Kubernetes operators are to GitOps — a reference framework others can adopt or fork.

→ [GitAI category](../00-foundation/gitai-category.md)

---

## 26. GitAI technical foundations (the git layer)

`[INVARIANT — these mechanics are non-negotiable]`

The "state of the federation = state of git" claim rests on three git-layer mechanics. The "commit discipline" referenced throughout resolves to these:

**Commit-tree (isolated index), not `git add` + `git commit`.** Set a per-session `GIT_INDEX_FILE`, stage into that index, `git write-tree` → `git commit-tree -p <parent>` → `git update-ref` → refspec push. Plain `git add` modifies the shared default index; two parallel sessions stomp each other silently, producing commits with sibling-session deltas. A per-process `GIT_INDEX_FILE` gives each session its own staging area.

**Worktree route-around, not the shared working tree.** Each Doer gets its own `git worktree add <path> <cycle-tip-SHA>` and runs `git -C <path>`. Sibling Doers don't collide on working files; they share only the append-only, concurrency-safe `.git/` object database.

**Refspec push (atomic single-ref publication).** `git push origin <branch>:<branch>` is atomic for a single ref. If two sessions race the same branch, only one succeeds; the loser gets a `non-fast-forward` rejection and must fetch + rebase + retry. Race-safe by construction.

→ [Git foundations axiom](../01-axioms/git-foundations.md) · [CLI conventions](cli-conventions.md)

---

## 27. Tunables, presets, and enrichment surfaces

`[TUNABLE]`

CompassAlpha exposes a design space along **five axes in tension:** speed, intelligence, cost, risk, predictability. No combination optimizes all five. **The load-bearing rules (firewall, hard labour, bus, persistence law, dual validation) are `[INVARIANT]` across all tuning** — tuning operates only on the performance/cost surface, never on structural correctness.

**Key tunable groups:** concurrency mode (LAYGO / pipelined / parallel-independent / parallel-doer); mentor + Doer session lifecycles; Doer effort, context depth, and model tier; provenance verification strictness; founder involvement; memory accumulation rate; rotation cadence; audit verbosity; cross-tier visibility.

**Enrichment surfaces (compound the intelligence↔cost trade across cycles):** *invariants* (project-level correctness gates), *toolings* (automation — audit scripts, validators, dashboards), and *specialised agents* (AI roles tuned for specific work types). Recommended evolution: start lean; add each when a pattern repeats and the marginal benefit is observable.

**Operating presets** bundle the tunables: Conservative, Balanced, Throughput, Cost-optimized, Risk-averse/regulated, Research/high-churn, Bootstrap/first-cycle. Presets are starting points, not commitments; a project graduates from Conservative to Balanced once the first cycle proves the rhythm. **Anti-presets** (maximum-speed, maximum-frugality, maximum-founder-gate) trade away multiple dimensions for marginal gain — avoid.

→ [Tunables overview](../03-tunables/index.md) · [Full parameter matrix](../03-tunables/full-parameter-matrix.md) · [Operating presets](../04-toggles/operating-presets.md) · [Concurrency modes](../03-tunables/concurrency-modes.md)

---

## 28. UX as a cross-cutting concern

`[INVARIANT — UX is owned by four layered roles, never one]`

Coherence between doctrine and code is the quality target — but coherence is not delight. For projects with a UI surface, UX excellence threads through both axes via **four layered owners:** (1) a **UX-substrate compass** encoding design principles, click budgets, and ease-of-use heuristics; (2) a **UI/UX specialised-agent persona** for UX-laden slices on both axes; (3) a **UX critic / click-budget auditor** (agent + tooling) gating GO at entity/CP close; (4) the **founder as UX visionary** (the irreducible fourth role, per the UX exception above).

UX is examined at five seams: doctrine entity authoring, build premise-check, build implementation (click-budget measurement), build audit (critic review), and the **cycle-close founder demo seam** — where the founder's vision is checked against the built reality. UX is cross-cutting rather than a separate axis because it is concurrent with both axes' work and multi-owner by nature.

---

## 29. Adopting CompassAlpha

A new project: set up the reviewer-state repo and the substrate repo (separate remotes); pick host(s) and document their quirks (power-down behavior, /tmp persistence); pick an AI harness that supports fresh-session-per-slice, deterministic boot from a stamped file, and persistent project context; identify the founder. Then author the canonical state artifacts (CLAUDE.md / LEDGER.md / HANDOVER_PROTOCOL.md / HANDOVER_LOG.md / LEFTOVERS.md / memory index) and the stamp templates, declare your first axis (most start with `build`), and make the first dispatch intentionally small (LAYGO) so the federation proves the rhythm.

**Common pitfalls:** mentor labour creep (refuse; dispatch a Doer), stale-snapshot drift (use the firewall), founder over-engagement (push back to the bus + lost+found role), delegated-sub-agent pollution (pure RELAY is the safe default), and brief incompleteness (the dispatching tier owns the fill).

→ [Getting started](../05-getting-started/index.md) · [Brownfield onboarding](../05-getting-started/brownfield-onboarding.md) · [Adoption patterns](../06-adoption-patterns/index.md)

---

## 30. Glossary of core terms

| Term | Meaning |
|---|---|
| **Axis** | A parallel work stream (build, doctrine, review, …). |
| **Charter** | The master constitutional document; LOCKED or UNLOCKED; the doctrine axis revises it. |
| **Compass** | A doctrine document for one scope/entity; tiered at 60K/30K/10K. |
| **Cycle** | A bounded work period on an axis. |
| **Doer** | The bottom tier; the only tier that touches substrate. |
| **Founder** | The human in the loop; relay bus + lost+found backstop. |
| **Inbox** | A subfolder in each tier's home receiving messages via the bus. |
| **LIFT-WATCH** | Items observed in a cycle that may warrant promotion to a Charter primitive/invariant. |
| **Mentor-1 / Mentor-2** | Top + middle tiers; orchestrate, never touch substrate. |
| **Reviewer-state repo** | The dedicated repo for federation meta-state; separate from substrate. |
| **Substrate** | The project's actual codebase / doctrine source repo. |
| **Tag** | Annotated git tag marking a dispatch close; immutable; the federation's ratification artifact. |
| **Walk** | The founder's review of the project preceding a doctrine cycle. |

→ [Full glossary](../00-foundation/glossary.md)

---

## 31. Open questions

`[OPEN]` — candidates for resolution in future cycles or community input: state-machine semantics for DECOUPLED axes; multi-project federations sharing one installation; the minimum AI-harness contract for compatibility; effort-level translation across providers; founder-team protocol; safe cycle compression after the first; the build-axis-deliverable structure doctrine; cross-axis primitive contracts; memory retirement policy; and a formalized AI-to-AI consultant protocol.

---

## Next: [Stamp templates →](templates/index.md)
