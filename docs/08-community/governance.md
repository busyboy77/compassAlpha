---
description: "Who decides what in CompassAlpha, and how those decisions are made."
---

# Governance

> Who decides what in CompassAlpha, and how those decisions are made.

**New here?** This page explains who gets to make decisions about the framework — what goes in, what changes, who has the final word — so you know how the project is run before you contribute or rely on it.

CompassAlpha is young, and its governance reflects that. *Governance* simply means the rules for who decides what. During the v0.x line — the framework's early, pre-1.0 releases — decision-making is intentionally simple and centralized so the *doctrine* (the framework's core rules and principles) can converge quickly. This page describes the current model and how it is expected to evolve.

## Steward

**[gradus](https://gradus.pk)** is the project's **steward**, **maintainer**, and **licensor**: it publishes the framework, holds its licensing, and is responsible for its continuity.

## Final authority during v0.x

The **founder** of CompassAlpha holds **final say** over its direction during the v0.x line. This is a *BDFL-style arrangement* — "Benevolent Dictator For Life", a common open-source pattern where one trusted person makes the final call when the group can't agree. Where a decision cannot be resolved by consensus, the founder decides. This keeps the early framework coherent while its core doctrine is still settling.

## How doctrine changes flow

Changes to the framework's doctrine — axioms, guardrails, tunables, toggles — do not land ad hoc (that is, no rushed, one-off edits). They travel through the framework's own **doctrine-cycle discipline**: a change is proposed, captured on disk with its rationale and *substrate citation* (a pointer to where the supporting evidence actually lives, rather than just "I remember it"), reviewed against the existing axioms for consistency, and only then locked in. Invariant axioms — the rules that never change — carry the highest bar. See [Contributing](contributing.md) for the contributor-facing view of this process.

## Contribution acceptance

Whether a contribution is accepted is at **maintainer discretion**. Maintainers weigh consistency with the existing doctrine, clarity, and fit with the roadmap. A well-argued proposal that follows the doctrine-cycle discipline is far more likely to be accepted than an isolated edit.

## License stewardship

gradus controls the framework's **licensing**, including:

- the **Business Source License 1.1** parameters (such as the Additional Use Grant and the Change Date),
- **commercial licensing** terms and arrangements (contact **licensing@gradus.pk**), and
- the **"CompassAlpha" and "gradus" trademarks**, which the license does not grant rights to.

These are reserved to the steward and are not subject to community vote.

## Evolution after v1.0

This model is appropriate for a framework still finding its shape. As CompassAlpha reaches v1.0 and a community forms around it, **governance is expected to broaden** — for example, toward shared review responsibilities and a more formal process for accepting doctrine changes. Any such change will be documented here and in the [Changelog](changelog.md).

## Remember this

- While CompassAlpha is young (the v0.x line), one person — the founder — has the final say, so the framework stays coherent while its rules are still settling.
- gradus is the steward: it publishes the framework, holds the license and trademarks, and is responsible for keeping it going.
- Changes to the core rules follow a disciplined path — proposed, written down with their reasoning, checked against existing rules, then locked in — the same care-with-decisions idea you'll see throughout [the mental model](../00-foundation/mental-model.md).

---

*See also: [Contributing](contributing.md) · [Code of conduct](code-of-conduct.md) · [Roadmap](roadmap.md).*
