#!/usr/bin/env bash
# Content safety gate.
#
# Fails if the BUILT site contains forbidden / internal / leaked content.
# Runs in CI before the Pages deploy, so nothing on this list can ever reach
# the public site. Scans the built site/ only (HTML + SVG) — repo-root legal
# files (LICENSE / NOTICE) may legitimately name the copyright holder and are
# out of scope here.
#
# Usage: bash scripts/content-safety.sh [site-dir]   (default: site)
set -uo pipefail

DIR="${1:-site}"

# High-signal patterns only — things that must NEVER appear on the public site.
# Kept deliberately specific so legitimate framework content does not false-trip.
PATTERN='pmf|paymyfee|pay[ -]my[ -]fee|grandfather|cartographer|\bdarch\b|\bcarch\b|compass-architect|doctrine-architect|/home/nmr|/users/nasirmahmood|brand credit|never a host|paste this verbatim|open[- ]source|nasir'

if [ ! -d "$DIR" ]; then
  echo "content-safety: directory '$DIR' not found (build the site first)." >&2
  exit 2
fi

hits=$(grep -rniE "$PATTERN" "$DIR" --include='*.html' --include='*.svg' 2>/dev/null || true)

if [ -n "$hits" ]; then
  echo "::error::Content safety gate FAILED — forbidden/internal content in the built site:"
  echo "$hits" | head -50
  echo ""
  echo "Nothing was published. Remove the offending content and rebuild."
  exit 1
fi

echo "Content safety gate passed — no forbidden/internal content in '$DIR'."
