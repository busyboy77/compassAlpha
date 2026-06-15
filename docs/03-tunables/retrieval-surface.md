---
description: "How a tier pulls the slice it needs from substrate on demand — the retrieval mechanism behind the minimal-sufficient bus. Two grades (lexical / grep-grade default; embeddings-vector opt-in), plus what's indexed, chunk granularity, and refresh cadence. Provider-agnostic; the index is a rebuildable cache, never a source of truth."
---

# The Retrieval Surface

> *How a tier pulls the slice it needs from substrate, on demand — without dredging the whole file.*

`[TUNABLE — retrieval mechanism]`

## TL;DR

The [minimal-sufficient bus](../02-guardrails/minimal-sufficient-bus.md) relays a pointer and keeps the detail in substrate, **pulled on demand**. This page is the dial for *how* that pull happens. Two grades sit on the surface: **lexical / grep-grade** (the default — `git grep` / ripgrep, path- and tag-scoped, no infrastructure, rebuildable for free) and **embeddings / vector** (opt-in — semantic retrieval for where lexical misses). Around the grade sit four more dials: what's indexed, chunk granularity, refresh cadence, and per-tier scope. The whole surface is **provider-agnostic**, and the index is always a **rebuildable cache derived from git, never a source of truth**. The `[INVARIANT]` constraints that keep retrieval from becoming a back-door — tier-partitioned scope, `as-of` + re-verify, pointer-not-truth — live in [Retrieval discipline](../02-guardrails/retrieval-discipline.md) and are in force behind every dial here.

## Why this dial exists

"Pull on demand" is only as light as the pull. If a receiver answers a detail question by reading the whole LEDGER, the whole tagged return, or the whole commit history, the bus stayed light but the *pull* flooded the receiver's context — the relay vector of pollution simply reopened one step downstream. Retrieval closes it: the receiver pulls the **minimal-sufficient slice** instead of the whole file. This dial sets the mechanism that makes the pull surgical; the [discipline guardrail](../02-guardrails/retrieval-discipline.md) keeps that mechanism honest.

## The dials

### 1. Retrieval grade

How the slice is located.

| Grade | Mechanism | Infra | Cost | Best for |
|---|---|---|---|---|
| **Lexical / grep-grade** (default) | `git grep`, ripgrep; path- and tag-scoped lexical search | none — runs anywhere git runs | near-zero; rebuildable for free | the common case — finding a known term, tag, ledger entry, or section |
| **Embeddings / vector** (opt-in) | embeddings over chunks + a vector store; semantic similarity | a vector store + an embeddings provider, server-side on the host | index-build + query cost; provider dependency | semantic retrieval where the right slice doesn't share the query's words |

Lexical is the default deliberately: it honours the framework's [no-specialized-databases](../01-axioms/git-foundations.md) stance, it needs no provider, and for most "where did we record X" pulls it is *sufficient*. Reach for the vector grade only when lexical demonstrably misses — when the slice you need is phrased differently from how you'd ask for it. Even then, the vector store is a **cache** (see dial 5), never a new durability layer.

### 2. Index corpus — what's indexed

What the retrieval layer covers, **per tier**:

- The tier's **own folder** — LEDGER, HANDOVER_LOG, LEFTOVERS, CLAUDE.md.
- The **inboxes it receives** — the tagged returns and briefs that legitimately reach it.
- Its **own memories**.
- The **substrate it owns or reviews**, at the relevant tags.

It does **not** cover other tiers' working folders. This is not a preference — the per-tier partition is the `[INVARIANT]` floor set by [Retrieval discipline §1](../02-guardrails/retrieval-discipline.md#1-tier-partitioned-scope-the-index-is-not-a-back-door-past-the-firewall). The tunable part is only *which* of the entitled corpus a project bothers to index (e.g. memories on or off), never whether the partition holds.

### 3. Chunk granularity

How finely the corpus is split into retrievable units.

- **Per-section** (default for docs/specs) — a heading and its body. Aligns with how briefs cite (`§10K`), so a hit maps cleanly to a substrate citation.
- **Per-return / per-entry** (default for ledgers and inboxes) — one tagged return or ledger line per chunk. Keeps a hit minimal-sufficient.
- **Per-commit-body** (for history) — the commit message body as the unit, with the diff reachable by pointer.

Finer chunks return less noise per hit (better pollution containment) at the cost of more hits to assemble; coarser chunks risk dragging in detail the receiver never needed. Bias finer for high-stakes lanes.

### 4. Refresh cadence

How current the index is kept relative to the substrate it covers.

- **Per-commit** (default) — the index updates when the substrate it covers advances, so the `as-of` watermark tracks the tip closely.
- **Scheduled** — periodic rebuild; cheaper, but a wider staleness window.
- **On-demand** — rebuilt before a retrieval-heavy session; lowest standing cost, highest first-query latency.

Whatever the cadence, every hit carries its `as of <commit>` watermark and load-bearing use re-reads the frozen blob — the [staleness constraint](../02-guardrails/retrieval-discipline.md#2-as-of-stamping-re-verify-against-the-frozen-blob-the-index-is-a-snapshot) holds regardless of how fresh the index happens to be.

### 5. Index locus — the cache, never the record

Where the index lives and what authority it has.

- **Rebuildable cache** (the only sane setting) — the index is derived from git and can be dropped and regenerated. It holds pointers (`file @ tag § chunk`) and, for the vector grade, embeddings. The authoritative content stays in the commit history.
- **Source-of-record** (anti-pattern — off the table) — load-bearing content living only in the index. This breaks [git foundations](../01-axioms/git-foundations.md) and [provenance law](../01-axioms/provenance-law.md); documented only so adopters recognize and avoid it.

## Defaults

| Dial | Default | Range |
|---|---|---|
| Retrieval grade | lexical / grep-grade | lexical / embeddings-vector |
| Index corpus | own folder + received inboxes + owned substrate (+ memories) | same — partition is `[INVARIANT]`; memory inclusion is the only toggle |
| Chunk granularity | per-section (docs) · per-return (ledgers/inboxes) | per-section / per-return / per-commit-body |
| Refresh cadence | per-commit | per-commit / scheduled / on-demand |
| Index locus | rebuildable cache | rebuildable cache / source-of-record (anti-pattern) |
| Embeddings provider | — (n/a at lexical default) | any, server-side — provider-agnostic |

## How to choose

- **Start lexical.** Most "where did we record X" pulls are lexical. Adopt the vector grade only after you observe lexical misses on slices phrased differently from the query.
- **Keep chunks fine for high-stakes lanes** — finer chunks return less noise per hit, which is the whole point of retrieval as a pollution defense.
- **Match refresh cadence to substrate velocity** — per-commit where the substrate moves fast and decisions are time-sensitive; scheduled or on-demand for slow, low-stakes corpora.
- **Never let the index become the record.** If dropping the index would lose information, the information was in the wrong place — move it to substrate.
- **Run index-build server-side**, off the tiers' context budget, so the mechanism that fights pollution doesn't become a pollution source itself.

## Runbook: provisioning and switching grades

### Readiness at a glance

| Grade | Provisioning required | Ready out of the box? | Reverse cost |
|---|---|---|---|
| **Lexical / grep-grade** | none — git + ripgrep | **yes, immediately** | n/a — it is the floor |
| **Embeddings / vector** | embeddings provider + vector store + server-side index-build, partitioned per tier | **no — the adopter provisions it; opt-in** | **free** — drop the cache, fall back to lexical |

The framework ships **no infrastructure** — it is a framework, not a tool; you bring your own host. Lexical is "ready" precisely because it needs nothing. Vector is "ready" only once an adopter has provisioned it to the [acceptance bar](#acceptance-bar-what-fully-provisioned-means) below — that checklist *is* the definition of "fully provisioned."

### Decision gate — do you actually need vector?

Stay on lexical unless **all** of these hold:

1. You have **observed lexical misses** — slices you needed were phrased differently from any query that would find them (semantic, not keyword, gaps).
2. The corpus is large enough that the miss rate actually costs cycles.
3. You accept an **embeddings-provider dependency** and the cost + staleness window a built index introduces.

If any fails, lexical is the correct, cheaper, git-native answer. Most federations never need to flip.

### Runbook A — lexical (default · zero provisioning)

1. **Nothing to stand up.** Git is the index.
2. **Pull pattern** (provider-agnostic): scope the search to the tier's *entitled* paths at a tag — own folder + received inboxes + owned substrate — e.g. `git grep -n <query> <tag> -- <entitled-paths>`, or ripgrep over a `git archive` of the tag. Scoping to entitled paths *is* the partition.
3. **Return pointers** (`file @ tag § section`), not pasted text; re-read the frozen blob before citing.
4. **Refresh:** none — rebuilding is free because there is nothing built.

All three [discipline constraints](../02-guardrails/retrieval-discipline.md) hold for free: you scope to entitled paths (partition), you pin the tag (`as-of`), git is the source (pointer-not-truth).

### Runbook B — vector (opt-in · provisioned)

- **Phase 0 — Prerequisites (provider-agnostic).** An embeddings provider (configurable), a vector store (configurable), and a host to run index-build **server-side**, off every tier's context budget.
- **Phase 1 — Partition the namespaces.** Create **one index namespace per tier**, each scoped strictly to that tier's entitled corpus. Do **not** create a single shared collection — that is the [back-door](../02-guardrails/retrieval-discipline.md#1-tier-partitioned-scope-the-index-is-not-a-back-door-past-the-firewall). The partition is `[INVARIANT]`.
- **Phase 2 — Chunk + embed.** Split per the [granularity dial](#3-chunk-granularity); embed each chunk; store metadata = file path + tag/commit + section anchor → the pointer `file @ tag § section`.
- **Phase 3 — Stamp freshness.** Record the watermark (the commit each namespace was built from) so every hit can carry `as of <commit>`.
- **Phase 4 — Wire refresh.** Trigger rebuild on substrate advance per the [cadence dial](#4-refresh-cadence); server-side; never on a tier's budget.
- **Phase 5 — Query path.** The tier queries **only its own namespace** → top-k candidate pointers → re-reads the **frozen blob** at the tag → cites the substrate. The chunk is never pasted as the answer.

### The switch (the toggle)

The grade switch is a **cycle-boundary flip** with a **lifecycle provisioning prerequisite** on the vector side — you don't turn vector on mid-cycle; you provision it (Phases 0–4) out of band, then cut over at a clean seam.

- **Lexical → vector cutover:** ① provision to the acceptance bar; ② run **shadow for one cycle** — both grades answer the same pulls, lexical stays authoritative, compare recall; ③ cut over at the seam, keeping lexical as fallback.
- **Vector → lexical rollback:** free and instant — **drop the namespaces** (a rebuildable cache) and fall back to `git grep`. Zero loss, because nothing load-bearing lived only in the index (pointer-not-truth).

### Acceptance bar — what "fully provisioned" means

Vector is provisioned **only when every box passes** — this checklist is the answer to *"is it ready?"*:

- [ ] **Per-tier namespaces** — no shared/global collection (partition holds; firewall intact).
- [ ] **`as of <commit>` on every hit**, and load-bearing use re-reads the frozen blob.
- [ ] **Drop-and-rebuild proven** — delete the index, regenerate from git, identical pointers.
- [ ] **Index-build runs server-side**, off every tier's context budget.
- [ ] **Providers are configuration** — embeddings + store swappable (provider-agnostic).
- [ ] **Chunk size tuned** so a hit is minimal-sufficient (no oversized chunks).

Until every box is checked, **stay on lexical** — an unfinished vector setup is the [back-door](../02-guardrails/retrieval-discipline.md), not an upgrade.

## How this connects

- [The minimal-sufficient bus](../02-guardrails/minimal-sufficient-bus.md) (guardrail) — specifies the pull-on-demand this surface mechanizes.
- [Retrieval discipline](../02-guardrails/retrieval-discipline.md) (guardrail) — the `[INVARIANT]` constraints (partition, `as-of` + re-verify, pointer-not-truth) bounding every dial here.
- [Context patterns](context-patterns.md) (tunable) — the sibling context surface; retrieval is how a fresh or loaded tier reloads only the relevant slice instead of full history.
- [Provenance law](../01-axioms/provenance-law.md) (axiom) — the hit is a pointer; the frozen blob is the truth; the cite is the substrate.
- [Git foundations](../01-axioms/git-foundations.md) (axiom) — keeps the index a rebuildable cache, not a specialized database.
- [Cycle toggles](../04-toggles/cycle-toggles.md) / [Project-lifecycle toggles](../04-toggles/project-lifecycle-toggles.md) — the grade switch is a cycle-boundary flip with a lifecycle provisioning prerequisite on the vector side (see the [runbook](#runbook-provisioning-and-switching-grades)).

---

## Next: [AI model choices →](ai-model-choices.md)
