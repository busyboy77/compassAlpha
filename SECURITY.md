# Security Policy

CompassAlpha is a source-available framework published by **[gradus](https://gradus.pk)**. It is primarily documentation, conventions, and reference templates, plus the CI that builds this portal. We take security reports seriously across all of it.

## Reporting a vulnerability

**Please do not open a public issue for security problems.**

Report privately via either:

- **GitHub** — use **Security → Report a vulnerability** (private vulnerability reporting) on the repository, or
- **Email** — **security@gradus.pk**

Include, where you can:

- A description of the issue and its impact
- Steps to reproduce (or a proof of concept)
- Affected file(s), workflow(s), or page(s)
- Any suggested remediation

## What to expect

- **Acknowledgement** within a few business days.
- An assessment and, where applicable, a fix or mitigation.
- Credit for the report if you would like it (let us know).

Please allow a reasonable period for remediation before any public disclosure (coordinated disclosure).

## Scope

In scope:

- The documentation site build/deploy pipeline (`.github/workflows/`, `mkdocs.yml`)
- Reference templates, snippets, or scripts shipped in this repository
- Content that could mislead an adopter into an insecure configuration

Out of scope:

- Vulnerabilities in third-party tools you choose to run a federation on (your AI agent, your git host, your CI) — report those to their respective vendors
- The general security posture of any adopter's own deployment

## A note on the framework itself

CompassAlpha's axioms (the persistence law, the firewall, single-live-writer, provenance law) exist partly to make multi-agent operations *auditable and recoverable*. If you find a way the documented protocol itself could lead an adopter into an unsafe state, that is a valid and welcome report.
