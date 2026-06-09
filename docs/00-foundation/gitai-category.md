# GitAI category

> *State of the federation = state of git.*

CompassAlpha is the reference framework for a new operational category: **GitAI** — using git as the coordination, durability, and audit layer for multi-agent AI operations.

## Lineage

| Category | Era | Core insight | Reconciler |
|---|---|---|---|
| **GitOps** | ~2017+ | State of infrastructure = state of git. PRs + automated reconcilers. | k8s operators, Flux, ArgoCD, etc. |
| **AIOps** | ~2017+ | AI augments IT operations (monitoring, alerting, anomaly detection). | AI models + IT ops platforms. |
| **GitAI** | 2026+ | State of AI agent federation = state of git. Tiers + inbox bus + reconcilers. | The AI tiers themselves, via `pull → read → act`. |

## The GitAI insight

GitOps' core insight — *"git is the source of truth, automation reconciles state"* — applies just as cleanly to AI agent orchestration:

- **State of the federation = state of the reviewer-state repo.** Every tier's judicial state is committed + pushed; any session can be recreated from git.
- **Coordination via inboxes** ([→ bus protocol](../01-axioms/bus-protocol.md)) — sender writes file, commits, pushes; recipient pulls and reads. No proprietary message bus.
- **Audit trail = git log.** Every inbox file is persistent; every state change is a commit; the federation's full history is reconstructable from git.
- **Reconciliation via pull + read + act** — recipient turn = `pull` → read own inbox → act → commit + push. **The AI tier IS the reconciler.**
- **Disaster recovery = `git pull`.** Power-down? Pull origin. State of record was always at origin.

## Why GitAI now

Three converging trends made GitAI inevitable around 2026:

1. **AI agents got capable enough to do substantive work** — Claude, GPT-4+, others can author code, doctrine, audits at production quality.
2. **Multi-agent coordination became necessary** — single agents hit context limits on substantial projects; collaboration patterns were ad-hoc and failure-prone.
3. **Git remained the universal substrate** — every project already has git. No new infrastructure needed.

The pattern was sitting there waiting for someone to formalize it. CompassAlpha is the formalization.

## What GitAI is NOT

| GitAI is NOT | But GitAI is |
|---|---|
| AIOps | AIOps assists human operators with AI. GitAI orchestrates AI tiers using a thin human relay. |
| MLOps | MLOps manages ML model lifecycles. GitAI manages AI agent federations doing knowledge work. |
| RAG | RAG is a retrieval pattern for one agent. GitAI is a coordination pattern for many agents. |
| ChatOps | ChatOps automates operations via chat. GitAI uses git as the coordination, not chat. |
| Agent frameworks (LangChain, AutoGen, etc.) | Those are libraries to build agents. GitAI is a protocol for agents to collaborate via git. |

GitAI is **complementary** to all of the above — it doesn't replace them. An agent built with LangChain can participate in a GitAI federation. RAG can be used within a GitAI Doer's context. AIOps tools can monitor a GitAI federation's health.

## CompassAlpha's role in GitAI

CompassAlpha is to GitAI what Kubernetes operators are to GitOps — a **reference framework** that other projects can adopt or fork.

CompassAlpha provides:

- The **tier grammar** (Mentor-1 / Mentor-2 / Doer) + the protocols
- **Reference implementations** of state artifacts, stamp templates, memory systems
- **A battle-tested production federation example** (~12 months of cycles, multiple build-axis closes, doctrine cycles spanning many entities)

Other GitAI frameworks may emerge in 2026+. CompassAlpha's source-available release is intended to seed the ecosystem with a battle-tested reference. Convergence on shared protocols (bus inbox conventions, marker tag grammar) would benefit the whole category.

## What a GitAI federation looks like (in 30 seconds)

```
Reviewer-state repo (state of record):
  ├── tier-1-mentor/
  │   ├── CLAUDE.md           ← top-tier mentor's identity
  │   ├── LEDGER.md           ← live cycle state
  │   ├── inbox/              ← messages from sub-tiers
  │   └── tier-2-orchestrator/ (per-dispatch)
  │       ├── CLAUDE.md
  │       ├── LEDGER.md
  │       ├── inbox/
  │       └── slice-N/
  │           └── inbox/      ← doer's brief lands here
  ├── HANDOVER_PROTOCOL.md    ← shared doctrine
  ├── memory/                 ← cross-cycle learnings
  └── ...

Substrate repo (the project being built/governed):
  └── (your project's actual codebase)

Founder (human):
  - Spawns tier sessions on a host
  - Delivers one-line trigger pings: "pull + read your inbox"
  - Does NOT carry message content
```

Sessions read their inbox, do their work, write to recipient inboxes, commit + push, ping founder. The founder routes pings. Git is the substrate. Everything else is convention.

## Why "framework" and not "platform"

A **platform** would own the infrastructure (compute, storage, identity). CompassAlpha owns none of those. You bring your own git host, your own AI agent, your own compute. CompassAlpha is the **protocol** the federation runs on, not the infrastructure it runs on.

This is the same shape as:
- HTTP (protocol; you bring your servers, your clients)
- TCP/IP (protocol; you bring your network)
- IMAP (protocol; you bring your mail server, your client)

Calling CompassAlpha a platform would be a category error. It's deliberately stack-portable.

## The category position post-v1.0

CompassAlpha's v1.0 release is intended to establish GitAI as a recognized category. Once GitAI is recognized:

- Other implementations will emerge (CompassBeta, CompassGamma, alternative GitAI frameworks)
- Tooling will emerge to support GitAI federations (dashboards, validators, etc.)
- Best practices will accumulate
- AI agent providers may add GitAI-native features

This is the same trajectory GitOps took: ArgoCD and Flux competed; the category matured; the pattern became standard.

CompassAlpha's bet: a category exists here, and a clean reference implementation will accelerate its emergence.

## Reading recommendations

If you want to understand the surrounding categories:

- **GitOps**: [opengitops.dev](https://opengitops.dev/) — the canonical GitOps definition (4 principles)
- **AIOps**: Gartner's category definition (search "Gartner AIOps")
- **MLOps**: [ml-ops.org](https://ml-ops.org/) — community-maintained MLOps reference

If you want to understand CompassAlpha's specific GitAI implementation:

- [Axioms](../01-axioms/) — the inviolable rules
- [Bus protocol](../01-axioms/bus-protocol.md) — the core coordination mechanism

---

## Next: [Glossary →](glossary.md)
