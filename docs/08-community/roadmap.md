# Roadmap

> The path from v0.1 DRAFT to a stable v1.0.

CompassAlpha is young. This page describes where it is, what stands between here and a stable release, and how we will know we have arrived. It is deliberately milestone-based rather than date-based — the framework matures when the work is done, not when a calendar says so.

## Where we are now

**v0.1 DRAFT.** The framework has been extracted into a clean, abstract, adopter-independent form and published by gradus under the Business Source License 1.1.

The documentation portal is built through its first two layers:

- **Foundation** — orientation: framework-not-tool framing, the constitution overview, the GitAI category, and the glossary.
- **Axioms** — the invariant constitution.

That is 13 pages. The remaining sections are pending.

## The path to v1.0

The work ahead falls into phases. Each builds on the one before it.

### Phase 1 — Complete the doctrine surface

Finish authoring the portal so the framework is fully specified end to end:

- **Guardrails** — what the framework prevents.
- **Tunables** — the customization surface.
- **Toggles** — the live switches.
- **Getting started** — onboarding, including brownfield adoption.
- **Adoption patterns** — worked examples and Day-2 operation.
- **Reference** — the manifesto and technical reference.
- **Community** — the section you are reading.

### Phase 2 — Harden through use

Doctrine only proves itself in contact with reality. This phase is about running the framework, finding the rough edges, and feeding what we learn back into the doctrine through the normal doctrine-cycle discipline.

### Phase 3 — Re-lock for stability

Close a full doctrine cycle, fold in community review, and lock the axioms and conventions into a form stable enough to promise compatibility against.

## v1.0 stability criteria

We will tag **v1.0** when all three of the following hold:

1. **A full doctrine cycle closes and re-locks** — at least one complete cycle of proposal, review, and lock has run end to end, leaving the doctrine internally consistent and settled.
2. **A community review pass** — contributors outside the original authorship have reviewed the doctrine and their feedback has been resolved.
3. **Real adoption** — at least **one greenfield** project (built on CompassAlpha from the start) and **one brownfield** project (an existing system adopting it) are running on the framework.

Until those are met, expect breaking changes between v0.x releases.

## A licensing note in context

Each released version of CompassAlpha carries a Change Date — for v0.1 that date is **2030-06-09**, after which that version converts to Apache 2.0. This is a property of the license, not a roadmap milestone; the roadmap above is about reaching a stable, well-adopted v1.0 well before then.

---

*Want to help move this forward? See [Contributing](contributing.md). Track shipped work in the [Changelog](changelog.md).*
