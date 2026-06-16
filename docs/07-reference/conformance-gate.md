---
description: "The conformance gate — a fail-closed reference enforcement primitive for CompassAlpha. It mechanizes the machine-checkable subset of codebase coherence and the provenance law: you encode your Charter's rules, wire the gate into a pre-commit hook or CI, and a violation blocks the commit or merge. Turns 'the one canonical way' from a convention you hope holds into an enforced gate for the rules you declare."
---

# The Conformance Gate

> *A convention you hope holds is not a control. This is the reference primitive that makes at least part of your doctrine **mechanically enforced**, fail-closed — so a violation blocks the commit or the merge, instead of being caught later, or never.*

CompassAlpha enforces coherence two ways. The first is **by construction**: the federation builds every layer against one doctrine and the [provenance law](../01-axioms/provenance-law.md) forbids acting on memory instead of substrate — so an agent can't quietly invent a second way. That is real, but it is *process* enforcement: it depends on the federation following its own rules.

The **conformance gate** adds the second way — *mechanical* enforcement. It is a small, dependency-free script you wire into a pre-commit hook and/or CI. You encode the machine-checkable subset of your Charter as rules; the gate checks every change against them and **exits non-zero — blocking the commit or merge — on any violation.** Where you wire it, "the one canonical way" stops being a convention and becomes a gate.

!!! note "What it does and doesn't claim"
    The gate enforces **exactly the rules you declare, fail-closed — nothing more.** It does not magically enforce all of coherence; it makes the *automatable* slice (banned anti-patterns, required substrate citations) genuinely enforced, and leaves the rest to the federation's by-construction discipline. That honesty is the point: an enforced subset you can trust beats an "enforced" label you can't.

## What it mechanizes

| Rule kind | Maps to | Effect |
|---|---|---|
| `forbid <regex> :: <message>` | [Codebase coherence](../00-foundation/codebase-coherence.md) — a non-canonical anti-pattern | Any match in the change fails closed, citing the Charter message |
| `require-cite <path-glob>` | [Provenance law](../01-axioms/provenance-law.md) — cite by substrate | A commit touching a matched path whose message cites no substrate (tag/sha/`Ref:`) fails closed |

## The rules file — the machine-checkable subset of your Charter

The gate carries no project knowledge of its own. You write the rules, derived from your invariants and canonical-ways:

```text
# forbid       <ERE regex>  :: <message shown when it matches>
# require-cite <path-glob>          # commits touching these must cite substrate

# The gate matches text, so one rules file carries rules for every language.
forbid  parseFloat\(.*(price|amount|total|money)       :: [JS]  Money is integer minor units, never a float.
forbid  (mysqli_query|->query)\(.*\$_(GET|POST|REQUEST) :: [PHP] No SQL built from a raw superglobal; use prepared statements.
forbid  FIXME                                          :: Resolve FIXMEs (or convert to a tracked ticket) before merge.

require-cite  docs/spec/*
require-cite  *.schema.*
```

Keep it short. A rules file you trust beats a long one you don't — encode the handful of rules whose violation actually hurts. The gate is **language-agnostic**: it pattern-matches text, so it works the same for JavaScript, PHP, Python, Go, or anything else — you just write the rule.

## Worked example — watch it block

A PHP file builds a query straight from a request superglobal — a classic injection, and against the `[PHP]` rule above:

```php
<?php
function findUser($db) {
    $id = $_GET['id'];
    return mysqli_query($db, "SELECT * FROM users WHERE id = $_GET[id]");
}
```

Run the gate over it (CI mode):

```console
$ bash compass-conformance-gate.sh --tree app ./conformance.rules
✗ FORBIDDEN: [PHP] No SQL built from a raw superglobal; use prepared statements.
    pattern: (mysqli_query|->query)\(.*\$_(GET|POST|REQUEST)
    app/UserRepository.php:4:    return mysqli_query($db, "SELECT * FROM users WHERE id = $_GET[id]");

Conformance gate FAILED — the change is blocked. Fix the violations above,
or open a doctrine cycle to change the rule deliberately (never silently).
$ echo $?
1
```

Exit 1 — the commit or merge is **blocked**, with the file, line, and the Charter rule it broke. Fix the code (use a prepared statement) and the gate exits 0. That is the whole point: the rule stops being something a reviewer might catch and becomes something the pipeline *won't let through*.

For the provenance side, `require-cite` is checked the same way over a commit range — and a citation only counts if it **resolves to a real object**: a commit that touches `docs/spec/*` but whose message cites a tag/sha that doesn't exist in the repo fails closed, so a citation can't be faked by writing a plausible-looking `Ref:`.

## The gate

A portable `bash` + `git` + `grep` script — no other dependencies. (The runnable copy lives in the repository at `reference/conformance-gate/`.)

```bash
#!/usr/bin/env bash
# CompassAlpha · Conformance Gate (reference enforcement primitive)
# Fail-closed: blocks a commit/merge when a change violates a declared Charter rule.
#   --staged            scan added lines of staged changes (pre-commit)
#   --tree  <path>      scan a path / worktree (CI)
#   --range <a>..<b>    require-cite over a commit range (CI)
# Exit: 0 conforms · 1 violation (fail closed) · 2 misuse.
set -uo pipefail
# ...full script in reference/conformance-gate/compass-conformance-gate.sh...
```

The full script is intentionally short enough to read in one sitting before you trust it with a `block` decision — read it, don't just run it.

## Wiring it in

**As a pre-commit hook** (blocks the commit locally):

```bash
# .git/hooks/pre-commit  (chmod +x)
#!/usr/bin/env bash
exec path/to/compass-conformance-gate.sh --staged ./conformance.rules
```

**In CI** (blocks the merge — this is the one that an auditor or a separation-of-duties policy can rely on, because it doesn't depend on every contributor's local setup):

```yaml
# e.g. a CI step
- name: CompassAlpha conformance gate
  run: |
    bash reference/conformance-gate/compass-conformance-gate.sh --tree . ./conformance.rules
    bash reference/conformance-gate/compass-conformance-gate.sh --range origin/main..HEAD ./conformance.rules
```

A failed gate fails the job; nothing merges. That is the difference between *documented* and *enforced*.

## Why fail-closed matters

A gate that warns and lets the change through is a suggestion. A gate that **fails closed** — defaults to *block* on any violation, and on its own errors — is a control: the only way past it is to conform, or to change the rule **deliberately** (open a [doctrine cycle](../06-adoption-patterns/sample-doctrine-cycle.md), amend the rule, re-lock) rather than silently.

**CompassAlpha dogfoods this gate.** Its own CI runs this exact script against its source before every docs deploy — enforcing the project's naming and no-leak Charter rules fail-closed — so the framework is held to a rule it can't water down silently. The script you adapt is the script the framework runs on itself.

## Honest limits (so you wire it with eyes open)

- It enforces **textual, pattern-checkable** rules. Semantic rules ("this module must not depend on that one") need a richer check; the gate is the floor, not the ceiling.
- It is **not** tamper-evidence or access control. It blocks non-conforming *content*; it does not by itself prove *who* changed what or stop a privileged actor from removing the gate. Signed commits, protected branches, and separation-of-duties are complementary controls your git host provides.
- Its strength is exactly its declared rules. An empty rules file enforces nothing — the gate is only as real as the Charter you encode into it.

## Remember this

- **Enforced means fail-closed.** The gate blocks a commit or merge on violation — that's the line between a convention and a control.
- **You declare the rules; the gate enforces exactly those.** It mechanizes the automatable subset of your Charter (forbidden anti-patterns) and the provenance law (required citations).
- **Run it in CI, not just locally** — a merge-blocking gate doesn't depend on anyone's machine, which is what makes it defensible to an auditor.
- **It's a floor, not the whole story** — pair it with the federation's by-construction coherence and your git host's access controls.
