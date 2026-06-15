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

## How this connects

- [The minimal-sufficient bus](../02-guardrails/minimal-sufficient-bus.md) (guardrail) — specifies the pull-on-demand this surface mechanizes.
- [Retrieval discipline](../02-guardrails/retrieval-discipline.md) (guardrail) — the `[INVARIANT]` constraints (partition, `as-of` + re-verify, pointer-not-truth) bounding every dial here.
- [Context patterns](context-patterns.md) (tunable) — the sibling context surface; retrieval is how a fresh or loaded tier reloads only the relevant slice instead of full history.
- [Provenance law](../01-axioms/provenance-law.md) (axiom) — the hit is a pointer; the frozen blob is the truth; the cite is the substrate.
- [Git foundations](../01-axioms/git-foundations.md) (axiom) — keeps the index a rebuildable cache, not a specialized database.

---

## Next: [AI model choices →](ai-model-choices.md)
