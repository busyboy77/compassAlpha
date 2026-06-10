---
description: "How to help shape CompassAlpha — and how your contributions are licensed."
---

# Contributing

> How to help shape CompassAlpha — and how your contributions are licensed.

Contributions are welcome. Because CompassAlpha is a framework — a constitution plus conventions plus worked examples — most contributions are about *doctrine and documentation* as much as code. This page explains the channels and the ground rules.

## Ways to contribute

- **Issues** — report a contradiction in the doctrine, a broken link, an unclear page, or a gap in the worked examples. A precise, reproducible report is worth more than a vague one.
- **Discussions** — raise an open question, propose a direction, or ask how the framework would handle a particular federation shape. Discussion is the right place for anything not yet concrete enough to be an issue.
- **Doctrine proposals** — propose a change to an axiom, guardrail, tunable, or toggle. These are the highest-impact and highest-scrutiny contributions; see below.
- **Documentation fixes** — typos, clarity passes, better examples, corrected cross-links. Always welcome and usually fast to merge.

## How doctrine proposals work

A doctrine proposal changes the framework's behavior or its invariants, so it travels through the framework's own **doctrine-cycle discipline** rather than landing as an ad-hoc edit:

1. Open a discussion that states the problem the change solves and the smallest change that solves it.
2. Cite the substrate — point to the exact page, axiom, or section affected, by path.
3. Capture the proposed delta and its rationale on disk (not only in chat), so the change is reviewable and durable.
4. A maintainer reviews against the existing axioms for consistency before anything is locked in.

Changes to **invariant axioms** carry the highest bar and may be deferred to a doctrine-cycle close.

## We dogfood our own doctrine

CompassAlpha runs by its own rules, so contributors should expect that discipline:

- **Persistence law** — every load-bearing artifact lives on disk before it is relied on. Decisions made only in a thread are not yet decisions.
- **Provenance law** — claims and derivations cite their substrate by path, so anyone can trace a page back to its source.
- **Status grids** — work batches open and close with an explicit statement of what is and is not done.

You do not need to master these before contributing, but PRs and proposals that follow them move faster.

## Licensing of contributions

This is the part to read carefully. By submitting a contribution to CompassAlpha, you agree that:

- Your contribution is provided under the project's **Business Source License 1.1**, the same license that covers the rest of the work.
- You grant **gradus** the right to **relicense** your contribution, including under **commercial terms** and under the future **Apache License 2.0** Change License — i.e., gradus retains the right to dual-license the combined work.
- You have the right to make the contribution (it is your own work, or you are authorized to submit it).

This is a lightweight inbound-license note, not a separate legal contract; submitting a contribution constitutes your agreement to it.

!!! note "Trademarks are not licensed"
    "CompassAlpha" and "gradus" are trademarks of gradus. Nothing here grants rights to those names or logos. You may, of course, refer to the framework by name to describe origin or interoperability.

## See also

- [Code of conduct](code-of-conduct.md) — expected behavior in all community spaces.
- [Governance](governance.md) — who accepts contributions and how decisions are made.
- [Roadmap](roadmap.md) — where help is most useful right now.
