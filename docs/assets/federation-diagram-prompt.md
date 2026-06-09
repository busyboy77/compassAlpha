# Comprehensive Web-Claude Prompt — FEDERATION_PROTOCOL inheritance diagram (v2)

> Self-contained prompt for Claude.ai (or any image-generation-capable LLM).
> Paste this into a fresh chat to get a polished PNG / SVG render of the same diagram
> the local SVG (`FEDERATION_PROTOCOL_DIAGRAM.svg`) captures — with polish from a web tool.

---

## Prompt — paste this verbatim

I need a clean, technical, comprehensive diagram visualizing a **doctrine refactor + inheritance hierarchy** for a multi-agent federation. Please generate it as a high-quality SVG (preferred) or PNG, vector-style, suitable for technical documentation. Modern, clean, business-document aesthetic — no decorative flourish.

## Context (one paragraph for grounding)

A federation of AI-agent tiers governs two parallel "axes" of work. Each axis has 3 tiers: a top mentor, a middle orchestrator, and a doer at the bottom. The rules of the federation evolved organically with duplicate sections for each axis (same substantive rule restated with different role names). The proposed refactor creates **one master doctrine** that both axes inherit from — class-inheritance style. Each axis declares its tier names + deliverable type + a few axis-specific settings; everything else (the substantive rules, locality, persistence, bus protocol, firewall, hygiene, gates) inherits from the master. The federation is also designed to be **EXTENSIBLE** — future axes can plug in by declaring their bindings; no new parallel sections needed. Additionally, the two axes alternate temporally (Charter LOCKED → build axis active; Charter UNLOCKED → doctrine axis active), and the master encodes this alternation as a universal property.

## Diagram layout — 6 stacked panels in one image, vertical orientation, total ~1400×2100

### PANEL 1 (top) — Inheritance + Extensibility (THREE child boxes, not just two)

- **Master box** at top center: dark-navy (`#2d3a4a`), white text. Label: `FEDERATION_PROTOCOL.md`. Subtitle: "*master · parent · one source of truth*". Contains bulleted list of rules the master holds:
  - Tier grammar: Mentor-1 / Mentor-2 / Doer
  - Firewall + state-tracking scope
  - Bus protocol (inbox-in-destination)
  - Hard labour rule (mentors never labour)
  - Locality (host + GH + flush=push + NO-TMP)
  - Hygiene · Brief completeness · Gates · Flush triggers T0–T7
  - + status grids Tier 1/2/3 · 14 memories · dual validation

- **Three arrows** from the master pointing down to **three child boxes** side-by-side, labeled "inherits":

#### Child 1 (LEFT) — **BUILD AXIS** — blue themed (`#3b6ea5`)
- Axis-specific declarations:
  - Deliverable: **code**
  - Cycle: **Phase 3 · CP1 → CP2 → CP3**
  - Charter posture: **LOCKED**
  - Activator: a module Phase 3 dispatch
- Tier bindings (3 rows, light-blue tints):
  - MENTOR-1 (top mentor) · `/path/to/reviewer-state/CLAUDE.md`
  - MENTOR-2 (orchestrator) · `mentor2-<module>-v<x.y>/`
  - DOER (replaces a persistent single-writer anti-pattern: bus-spawned per CP, fresh-per-CP) · `/path/to/substrate (worktree)`

#### Child 2 (CENTER) — **DOCTRINE AXIS** — purple themed (`#7a5b9c`)
- Axis-specific declarations:
  - Deliverable: **compass + primitives**
  - Cycle: **entity S1→S2a→S2b→S3a→S3b→S4→S5**
  - Charter posture: **UNLOCKED** (cycle only)
  - Activator: founder walk + §9 depth
- Tier bindings (3 rows, light-purple tints):
  - MENTOR-1 (top mentor) · `mentor1-v<X+1>/CLAUDE.md`
  - MENTOR-2 (orchestrator) · `mentor2-<entity>-v<x.y>/`
  - DOER (AI agent @ xhigh, fresh-per-slice) · `/path/to/substrate (worktree)`

#### Child 3 (RIGHT) — **FUTURE AXIS** — GHOST box (dashed border, light grey fill, slight opacity reduction)
- Header: "FUTURE AXIS · plug-and-play"
- Axis-specific declarations (placeholder values to make the template obvious):
  - Deliverable: *`<your axis output>`*
  - Cycle granularity: *`<your stages>`*
  - Charter posture: *`<LOCKED | UNLOCKED | DECOUPLED>`*
  - Activator: *`<what fires the cycle>`*
- Tier bindings (3 rows, light-grey tints, dashed inner borders):
  - MENTOR-1 (top) → *`<your Mentor-1 role>`*
  - MENTOR-2 (orchestrator) → *`<your Mentor-2 role>`*
  - DOER (only labour tier; fresh-per-unit) → *`<your Doer role>`*

- **Extensibility footer banner** below all three child boxes (warm-grey/cream `#f0ede4` background):
  - Headline (bold): "▸ Federation is OPEN to new axes. Declare 4 settings + 3 tier roles. Inherit everything else, for free."
  - Subtext (italic): "Example future axes: review/compliance axis · ops/deploy axis · AI-training axis · research axis · pen-test/security axis · whatever the federation grows next."

### PANEL 2 — Cross-axis Temporal Posture (NEW)

- Slate-blue themed (`#5a8aa8`)
- Header: "Cross-axis Temporal Posture — axes alternate; Charter state is the switch"
- Subtitle (italic): "Axes do NOT run concurrently. Charter LOCKED ↔ UNLOCKED gates which axis is active. The federation's life is alternating epochs."
- **Horizontal timeline** with 4 epoch boxes connected by labeled transitions:

  1. **Charter v0.3 LOCKED** (blue tint, faded): BUILD AXIS active · doctrine dormant · "Phase 3 dispatches: several modules" · "→ gate ① fired"
  2. *(arrow labeled "founder walk → unlock")*
  3. **Charter v0.4 UNLOCKED ← NOW** (purple tint, bold border): DOCTRINE AXIS active · build axis dormant · "Amendment cycle (mentor1-v0.5/)" · "12+ entities so far; ~22–28 total" · "producing charter-v0.5"
  4. *(arrow labeled "cycle close → re-lock")*
  5. **Charter v0.5 LOCKED ← NEXT** (blue tint, bold border): BUILD AXIS active · doctrine dormant · "Phase 3 dispatches resume" · "new Mentor-1 boots on host" · "protocol-born, not single-writer-tamed"
  6. *(arrow labeled "future walk")*
  7. **Charter v0.5 UNLOCKED** (grey, ghost, dashed border): "DOCTRINE next cycle · v0.5 → v0.6 amendment cycle · (eventually)"

- Footer text: "The cycle repeats indefinitely: build → walk → doctrine cycle → re-lock → build → walk → …" / "The master encodes this alternation as a universal property; both axes know to step aside when the other is engaged."

### PANEL 3 (left, half-width) — Bus Protocol

- Amber themed (`#b89425`)
- Header: "Bus Protocol — universal mechanism"
- Horizontal flow: 4 boxes connected by arrows: **Sender** → **Nasir** → **Recipient** → **git/GH**
  - Sender: "1. write to recipient's inbox/ · 2. git commit + push · 3. ping Nasir"
  - Nasir: "(trigger bus only) · one-liner ping: *'pull + read your inbox'* · zero content carried"
  - Recipient: "1. git pull --ff-only · 2. read own inbox/ · 3. act on tagged content"
  - git/GH: "durable · resume-anywhere · audit trail"
- Footer (italic): "The build axis (Mentor-1↔Mentor-2↔Doer) uses the SAME mechanism as the doctrine axis (Mentor-1↔Mentor-2↔Doer)." / "Nasir's clipboard carries ZERO substantive content." / "Single-live-writer + fetch-before-push prevents clobber across axes."

### PANEL 4 (right, half-width) — Migration phases timeline

- Green themed (`#3a7a3a`)
- Header: "Migration in 3 phases — running cycle undisturbed"
- 3 boxes on timeline (colors progressively lighter green: `#3a7a3a` → `#5a9a5a` → `#7aba7a`):
  1. **PHASE 1 · NOW** (confined · low-risk): "Author **FEDERATION_PROTOCOL.md** as NEW file in root. Banner: POST-CYCLE · doctrine-axis may skip"
  2. **PHASE 2 · cycle-close** (~5–7 weeks out): "Refactor **HANDOVER_PROTOCOL.md** · §7 + §7h consolidated; pointer to master. Old §s → HISTORICAL. in v0.5 ratification batch"
  3. **PHASE 3 · post-cycle** (doctrine axis dormant): "Templates thin out: MENTOR2_BOOTSTRAP · DOCTRINE_DOER_TEMPLATE · CLAUDE.md (boot files) · RELOCATION_PROTOCOL → reference master by §"
- Timeline labels: "today" — "cycle-close (charter-v0.5)" — "build axis re-engages"

### PANEL 5 — Load-bearing rules (NEW)

- Coral/red themed (`#c44a4a`) — color signals "load-bearing, never violate"
- Header: "Load-bearing rules — inherited from master, apply to ALL axes"
- 3 columns:

  - **Mentors NEVER labour** — "Mentor-1 + Mentor-2 = orchestrate only. Doer = ONLY tier touching substrate." Then "Mentor-allowed (edge cases): own-tier artifact reads · protocol/template editing · stamp composition · T0-boot origin-verification"
  - **Firewall + state-tracking scope** — "Confined, not banished. Each tier writes ONLY its own folder + recipient inboxes." Then "State-tracking scope (rule of law): mentor tracks ONLY its granularity · 'current WIP' = as of last tagged return · never mirror live sub-tier WIP · rotting snapshots = firewall leak"
  - **Flush-before-disclose trust anchor** — "State on disk + at origin BEFORE discussed with Nasir. Nothing in chat." Then "Why it's load-bearing: Nasir trusts disk, not memory · lets him step back to relay+lost+found · power-down survival (volatile local disk) · never regress"

### PANEL 6 — Resolutions + bonus properties

- Subtle dashed-border box, "How this resolves the four concerns — plus extensibility bonus + single-writer replacement"
- Top row: 5 colored columns matching panel themes:
  - Blue: "✓ Duplication — One doctrine, two axis bindings. Future cross-axis refinements update ONE place."
  - Purple: "✓ Update burden — New memory or rule lands once. Both axes pick it up by inheritance, automatically."
  - Amber: "✓ Hard to memorise §s — Fewer §s. '§7b or §7h-b?' → 'master §X firewall; my binding is Mentor-1/Mentor-2/etc.'"
  - Green: "✓ Context pollution + billing — Smaller boot read. Lower per-rotation cost, compounded over federation life."
  - Grey: "✓ Extensibility (NEW) — Adding a third axis later = one new row in the bindings table. No new parallel §."
- Bottom row: 2 wider call-out boxes (slate-blue tinted `#eef4f8`):
  - "▸ Single-writer-replacement framing (build axis)": "A persistent single-writer anti-pattern is a long-lived in-repo co-resident — substrate-knowledge holder, ad-hoc consults, a long-running session accumulating context. The bus protocol institutionalizes that role into discrete bus-mediated Doer spawns per CP, with substrate-knowledge distributed into the inbox-as-state-of-record. The new dev cycle is protocol-born, never single-writer-tamed."
  - "▸ Future-proof by construction": "When the federation grows a third or fourth axis (review · ops · AI-training · pen-test · whatever), each one is a child class: declare 4 settings + 3 tier roles, inherit everything else. The shared mechanics — bus protocol, firewall, hygiene, locality, flush-before-disclose — apply automatically. The master grows; the axes stay thin. The federation scales sideways."

## Style notes

- Vector-clean, modern. Sans-serif throughout (system fonts).
- Color palette (use these exactly):
  - Master: `#2d3a4a` (dark navy, white text)
  - Build axis: `#3b6ea5` (blue)
  - Doctrine axis: `#7a5b9c` (purple)
  - Future axis (ghost): `#8a8a8a` (medium grey, dashed border)
  - Bus protocol: `#b89425` (amber)
  - Migration phases: `#3a7a3a` → `#5a9a5a` → `#7aba7a` (progressive lightening)
  - Cross-axis posture: `#5a8aa8` (slate blue)
  - Load-bearing rules: `#c44a4a` (coral/red — signals "load-bearing")
  - Background: very light cream `#fafaf8`
- Rounded corners on all boxes (radius 8–10 px)
- Monospace font (Menlo / Consolas / ui-monospace) for code paths
- Dashed borders for ghost/future/dormant elements; solid for concrete/current
- Generous whitespace; no crowding
- Footer at bottom: small grey "FEDERATION_PROTOCOL.md inheritance diagram (v2)"

## Output

Please generate the final SVG. Single comprehensive file at ~1400×2100 viewBox. If you must split for clarity, output two SVGs (Panels 1-2-3 and Panels 4-5-6) — but a single file is preferred.

---

## Why this prompt is self-contained

- All content text is in the prompt verbatim (no external lookup needed)
- Layout is explicit (6 panels, position relative to each other, 3 child boxes in Panel 1)
- Color palette named with hex codes (deterministic)
- Style specified (vector, sans-serif, generous whitespace, dashed for ghost elements)
- Output format requested (SVG preferred, PNG acceptable)
- No reference to any specific project or domain-specific terms requiring external knowledge beyond what's quoted; all tier names are the framework's universal Mentor-1 / Mentor-2 / Doer vocabulary

A web-Claude session with no prior context can render this diagram from this prompt alone.
