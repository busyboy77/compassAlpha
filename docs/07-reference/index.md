---
description: "CompassAlpha technical reference: the framework spec, stamp templates, status grids, hierarchy tags, flush triggers, stage grammar, and CLI conventions."
---

# 07 · Reference

> *The lookup layer. When you know what you need and want the exact spec, definition, or template — start here.*

In plain terms: this is the "look it up fast" section — exact definitions, copy-paste templates, and rule formats, with no story or background. It's for people who already know roughly what they're after and just want the precise version. New here? Start with [the mental model](../00-foundation/mental-model.md) and come back once the ideas feel familiar.

The Foundation and Axioms sections teach the framework. The Tunables and Toggles sections explain its customization surface. This **Reference** section is different: it is the consolidated, terse, accurate lookup layer. It does not re-teach — it indexes, defines, and provides copy-pasteable artifacts.

Use it the way you'd use a man page or a language reference: jump to the exact thing, read the spec, leave.

## What's in this section

| Page | What it gives you | Use when |
|---|---|---|
| [Full framework reference](manifesto-full.md) | The entire framework doctrine, consolidated and organized by theme in one long page | You want to read or search the whole doctrine in one place, or you're not sure which section owns a rule |
| [Stamp templates](templates/index.md) | Copy-pasteable boilerplate: boot stamps, dispatch briefs, status grids, handover certificates, ratification packages | You're standing up a federation, composing a stamp, or assembling a cycle-end package |
| [Status grids](status-grids.md) | The three-tier status-grid doctrine, columns, when each is printed, with worked examples | You need the exact grid format to print at a session seam |
| [Hierarchy tags](hierarchy-tags.md) | The hierarchy-edge tag wire format and the tag-gated ingestion rule | You're authoring an inbox file or implementing ingestion validation |
| [Flush triggers T0–T7](flush-triggers.md) | Each of the eight flush triggers, defined, with its required action | You need to know exactly when state must go to disk |
| [Stage grammar](stage-grammar.md) | The consolidated stage vocabulary across every axis and lane | You're declaring a stage taxonomy or naming inbox files / grid columns |
| [CLI conventions](cli-conventions.md) | The git / shell conventions for operating a federation — two-plane discipline, isolated index, worktrees, refspec push | You're scripting tier operations or debugging a contaminated commit |

## How the reference relates to the rest of the portal

The reference **consolidates** material that the teaching sections spread across many pages:

- The [Axioms](../01-axioms/index.md) explain *why* each invariant exists and what it defends against.
- The [Tunables](../03-tunables/index.md) and [Toggles](../04-toggles/index.md) explain the *customization surface*.
- This reference gives you the *exact wire formats, definitions, and templates* — the load-bearing detail, stripped of narrative.

Where a reference page would otherwise duplicate a teaching page, it links back instead. The reference is for lookup; the teaching sections are for understanding.

## The single-page option

If you'd rather have everything in one scrollable, searchable document, the [Full framework reference](manifesto-full.md) is a complete, organized synthesis of the framework's doctrine by theme. It folds together what the rest of the portal teaches across its sections, for readers who want one canonical lookup target.

## Conventions used throughout this section

| Notation | Meaning |
|---|---|
| `[INVARIANT]` | A rule that cannot change without forking the framework. See [Axioms](../01-axioms/index.md). |
| `[TUNABLE]` | A value a project sets for itself. See [Tunables](../03-tunables/index.md). |
| `[OPEN]` | A question still being iterated; candidate for community input. |
| `<placeholder>` | A value you substitute for your project. |
| Mentor-1 / Mentor-2 / Doer | The framework's generic tier names. Each axis substitutes its own role names; the rules speak in the generic vocabulary. |

---

## Next: [Full framework reference →](manifesto-full.md)
