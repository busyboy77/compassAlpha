---
description: "An honest enforcement inventory: which of CompassAlpha's rules are mechanically enforced (a gate fails closed), which are structurally enforced (git makes a violation visible), and which are convention (the agent is instructed, with no automated stop). The line between a control and a hope, drawn explicitly."
---

# What is actually enforced

> *A convention you hope holds is not a control. This page draws the line explicitly — rule by rule — between what a machine blocks, what git makes impossible to hide, and what still rests on the operator. An enforced subset you can trust beats an "enforced" label you can't.*

CompassAlpha is a constitution, and a fair question from anyone betting work on it is: **of all these rules, which ones would actually stop me from breaking them, and which ones just ask me nicely?** This page answers that without softening it. The honest summary up front: a small, high-value subset is *mechanically* enforced today; a larger set is *structurally* enforced (git makes a violation visible and auditable, even if nothing blocks it); and the rest is *convention* — instructed, not gated.

## The three enforcement classes

- **Mechanical** — a script or CI step **fails closed** on violation: the commit or the merge is blocked, and the only way past is to conform or to change the rule deliberately. You can run it yourself. This is the only class that removes the honor system.
- **Structural** — the framework's git layout makes a violation **visible and auditable** by construction (separate repos, committed inbox files, recorded dispositions). Nothing *blocks* the violation, but it cannot hide — a cold reader reconstructs it from git alone.
- **Convention** — the agent is **instructed** to follow the rule; there is no automated stop. The discipline lives in the operator. This is exactly the variable the framework exists to reduce — so naming which rules are still here is the honest thing to do.

## The inventory

| Rule | Class today | What catches a violation | What it does **not** catch |
|---|---|---|---|
| **Coherence anti-patterns** (your declared canonical-ways) | **Mechanical** | [Conformance gate](conformance-gate.md) `forbid` rules — fail closed in CI / pre-commit | semantic rules ("module X must not import Y") — pattern-matching is the floor, not the ceiling |
| **Provenance law** — cite by substrate | **Mechanical** (partial) | conformance gate `require-cite` — a commit touching a cite-required path whose message cites no *resolvable* substrate fails closed | a hallucinated *read* an agent acts on without needing to cite it |
| **No public meta-leak** | **Mechanical** | `scripts/content-safety.sh` — fails the deploy if forbidden content reaches the built site | leakage in artifacts that never hit the public site |
| **Git foundations** — two-plane, `GIT_INDEX_FILE`, worktree | **Structural** | the substrate and control planes are *separate repos*; a cross-plane commit is detectable in git | nothing *blocks* a confused cross-plane `git add` today → candidate gate #2 |
| **Bus protocol** — inbox-in-destination-folder | **Structural** | every message is a committed file with sender, recipient, timestamp — fully auditable | misrouting isn't blocked; tag-gated ingestion is convention |
| **Amendment protocol** — persisted dispositions | **Structural** | accept / defer / reject are recorded in git, so decisions are queryable and don't re-litigate | nothing enforces that a disposition *was* recorded |
| **Persistence law** — flush before disclose | **Convention** | — (the tier is instructed to flush + push before discussing) | nothing stops a turn from disclosing before state is on disk + at origin → **candidate gate #1** |
| **Hard-labour rule** — mentors never touch substrate | **Convention** (partly structural) | only the Doer is handed a worktree, so role is *visible* in git | nothing blocks a mentor session that does commit to substrate → **candidate gate #2** |
| **Tier grammar** — roles per axis | **Convention** | — | a machine can't prove an agent reasoned at the wrong tier |
| **Firewall** — mentor doesn't retain sub-tier detail | **Convention** (partly structural) | the folder layout bounds what's handed upward | a machine can't prove a mentor didn't *internally* retain detail |

**The one artifact a skeptic can run themselves** is the [conformance gate](conformance-gate.md) — a dependency-free `bash` script CompassAlpha dogfoods against its own source in CI before every deploy. Read it, then run it. Everything in the Mechanical rows above is that gate (plus the content-safety gate).

## The honest gap

Most of the *coordination* invariants — the ones about how tiers behave toward each other — are **structural or convention today, not mechanical.** Git makes them auditable, but a pipeline does not yet block them. That is the real distance between "a well-argued methodology" and "a framework that holds itself under pressure," and pretending otherwise would betray the [provenance law](../01-axioms/provenance-law.md) this whole project is built on. The roadmap below is how that gap closes.

## Raising the floor — the next two gates

These are **specified, not yet built.** They are named here as roadmap, not as existing controls — see the [roadmap](../08-community/roadmap.md). Each is the same shape as the conformance gate: a small, dependency-free, fail-closed reference primitive you opt into.

### Candidate gate #1 — the disclosure guard (persistence law → mechanical)

- **Checks:** at turn-close, over each of the tier's repos — fail closed if the working tree is **dirty** or if `HEAD` is **not present at `origin`** (unpushed).
- **Proves:** the *observable precondition* of flush-before-disclose — state is on disk **and** at origin before it is discussed, bounding crash-loss to one turn.
- **Does not prove:** that an agent won't speak before running it. Like the conformance gate, it is a step you wire into the turn-close / pre-push path; it converts the law's precondition from "instructed" to "blocked."

### Candidate gate #2 — the plane-separation check (git foundations + hard-labour → mechanical)

- **Checks:** fail closed if a single commit or staging mixes **substrate-plane** and **control-plane** paths, or if a mentor-tier session stages a substrate deliverable.
- **Proves:** the "two planes, never cross-commit" discipline mechanically, and the *observable* half of the hard-labour rule (who commits to substrate).
- **Does not prove:** a mentor reasoning about substrate without committing. Trickier than gate #1 — it needs the repo-pair convention configured — which is why it is specified for review before it becomes a script.

Neither gate can mechanize the genuinely honor-system rows (tier-grammar role discipline, firewall non-retention): you cannot gate what an agent *thinks*. Those stay convention by nature, and this page will keep saying so.

## Remember this

- **Three classes, named honestly.** Mechanical (a gate blocks it), Structural (git makes it visible), Convention (the operator is trusted). Today the coordination invariants are mostly the latter two.
- **Run the gate yourself.** The [conformance gate](conformance-gate.md) is the one control a skeptic can execute — it's dogfooded in CI, fail-closed, dependency-free.
- **The gap is named, not hidden.** Two more gates (disclosure guard, plane-separation) are specified to move persistence and the two-plane rule from convention to mechanical. They are roadmap, not yet built.
- **Some rules can never be gated.** You cannot mechanically prove what an agent reasoned about — those rows stay convention, and the framework says so plainly rather than claiming otherwise.
