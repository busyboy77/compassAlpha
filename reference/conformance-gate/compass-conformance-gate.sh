#!/usr/bin/env bash
# CompassAlpha · Conformance Gate (reference enforcement primitive)
# -----------------------------------------------------------------------------
# A FAIL-CLOSED conformance check. It mechanizes the slice of codebase coherence
# and the provenance law that can be verified automatically, so that "the one
# canonical way" stops being a convention you hope holds and becomes a gate that
# BLOCKS a commit or a merge when it doesn't.
#
# It is deliberately generic: it carries no project knowledge of its own. You
# encode YOUR Charter's rules in a rules file; the gate enforces exactly those,
# fail-closed. What it does not encode, it does not claim to enforce.
#
# Two rule kinds (see conformance.rules.example):
#   forbid       <ERE regex>  :: <message>   a banned anti-pattern; any match fails
#   require-cite <path-glob>                 commits touching these paths must cite
#                                            substrate (a tag/sha) in their message
#
# Usage:
#   compass-conformance-gate.sh --staged            [rules-file]   # pre-commit: added lines only
#   compass-conformance-gate.sh --tree  <path>      [rules-file]   # CI: scan a path/worktree
#   compass-conformance-gate.sh --range <a>..<b>    [rules-file]   # CI: require-cite over commits
# Default rules-file: ./conformance.rules
#
# Exit codes:  0 = conforms   1 = violation (fail closed)   2 = misuse / setup error
# Dependencies: bash, git, grep, sed — nothing else.
set -uo pipefail

usage() { sed -n '2,30p' "$0" | sed 's/^# \{0,1\}//'; exit 2; }

MODE="${1:-}"; [ -n "$MODE" ] || usage
RULES=""
TARGET=""
case "$MODE" in
  --staged) RULES="${2:-./conformance.rules}" ;;
  --tree)   TARGET="${2:-}"; RULES="${3:-./conformance.rules}"; [ -n "$TARGET" ] || usage ;;
  --range)  TARGET="${2:-}"; RULES="${3:-./conformance.rules}"; [ -n "$TARGET" ] || usage ;;
  -h|--help) usage ;;
  *) usage ;;
esac

[ -f "$RULES" ] || { echo "conformance-gate: rules file '$RULES' not found." >&2; exit 2; }

fail=0
emit() { printf '%s\n' "$*" >&2; }
trim() { local s="$1"; s="${s#"${s%%[![:space:]]*}"}"; s="${s%"${s##*[![:space:]]}"}"; printf '%s' "$s"; }

# --- collect forbid + require-cite rules ------------------------------------
# Read once into parallel arrays (portable; no associative arrays needed).
forbid_re=(); forbid_msg=(); cite_glob=()
while IFS= read -r line; do
  case "$line" in
    ''|\#*) continue ;;
  esac
  kind=$(printf '%s' "$line" | awk '{print $1}')
  case "$kind" in
    forbid)
      # forbid <regex> :: <message>
      rest=$(trim "${line#forbid}")
      if printf '%s' "$rest" | grep -q ' :: '; then
        re=$(trim "${rest%% :: *}"); msg=$(trim "${rest#* :: }")
      else
        re=$(trim "$rest"); msg="(no message)"
      fi
      forbid_re+=("$re"); forbid_msg+=("$msg") ;;
    require-cite)
      glob=$(printf '%s' "$line" | awk '{print $2}')
      cite_glob+=("$glob") ;;
    *) emit "conformance-gate: unknown rule kind '$kind' (ignored)" ;;
  esac
done < "$RULES"

# --- forbid checks -----------------------------------------------------------
check_forbid_text() {  # $1 = label, $2 = text
  local label="$1" text="$2" i
  for i in "${!forbid_re[@]}"; do
    local hits
    hits=$(printf '%s' "$text" | grep -nE "${forbid_re[$i]}" || true)
    if [ -n "$hits" ]; then
      emit "✗ FORBIDDEN [$label]: ${forbid_msg[$i]}"
      emit "    pattern: ${forbid_re[$i]}"
      printf '%s\n' "$hits" | sed 's/^/    /' >&2
      fail=1
    fi
  done
}

if [ "$MODE" = "--staged" ] && [ "${#forbid_re[@]}" -gt 0 ]; then
  # scan ONLY added lines of staged changes, so pre-existing debt doesn't block
  while IFS= read -r f; do
    [ -n "$f" ] || continue
    added=$(git diff --cached -U0 -- "$f" | grep '^+' | grep -v '^+++' | sed 's/^+//' || true)
    [ -n "$added" ] && check_forbid_text "$f (staged)" "$added"
  done < <(git diff --cached --name-only --diff-filter=ACM)
elif [ "$MODE" = "--tree" ] && [ "${#forbid_re[@]}" -gt 0 ]; then
  for i in "${!forbid_re[@]}"; do
    hits=$(grep -rnE "${forbid_re[$i]}" "$TARGET" --exclude-dir=.git 2>/dev/null || true)
    if [ -n "$hits" ]; then
      emit "✗ FORBIDDEN: ${forbid_msg[$i]}"
      emit "    pattern: ${forbid_re[$i]}"
      printf '%s\n' "$hits" | head -50 | sed 's/^/    /' >&2
      fail=1
    fi
  done
fi

# --- require-cite checks (commit messages over a range) ----------------------
# A citation is valid only if it RESOLVES to a real object in this repo — a tag,
# branch, or sha that git rev-parse can verify. Matching the *shape* of a ref is
# not enough (a fabricated "Ref:" or a random hex string would pass); we resolve
# each candidate against the object store so an invalid citation fails closed.
resolves_citation() {   # $1 = commit message → 0 if a real substrate ref is cited
  local msg="$1" cand cands
  cands=$(printf '%s\n' "$msg" \
            | grep -oE '(@|Ref:)[[:space:]]*[A-Za-z0-9._/-]+' \
            | sed -E 's/^(@|Ref:)[[:space:]]*//')
  cands="$cands
$(printf '%s\n' "$msg" | grep -oE '[0-9a-f]{7,40}')"
  while IFS= read -r cand; do
    [ -n "$cand" ] || continue
    if git rev-parse --verify --quiet "${cand}^{commit}" >/dev/null 2>&1; then
      return 0
    fi
  done <<EOF
$cands
EOF
  return 1
}
if [ "$MODE" = "--range" ] && [ "${#cite_glob[@]}" -gt 0 ]; then
  while IFS= read -r sha; do
    [ -n "$sha" ] || continue
    touched=0
    files=$(git show --name-only --pretty=format: "$sha")
    for g in "${cite_glob[@]}"; do
      printf '%s\n' "$files" | grep -qE "$(printf '%s' "$g" | sed 's/\*/.*/g')" && touched=1
    done
    if [ "$touched" = "1" ]; then
      msg=$(git log -1 --pretty=%B "$sha")
      if ! resolves_citation "$msg"; then
        emit "✗ UNCITED: commit ${sha:0:9} touches a cite-required path but cites no RESOLVABLE substrate"
        emit "    (no tag/sha/Ref: in its message resolves to a real object in this repo)."
        fail=1
      fi
    fi
  done < <(git rev-list "$TARGET")
fi

if [ "$fail" -ne 0 ]; then
  emit ""
  emit "Conformance gate FAILED — the change is blocked. Fix the violations above,"
  emit "or open a doctrine cycle to change the rule deliberately (never silently)."
  exit 1
fi
echo "Conformance gate passed — change conforms to the declared Charter rules."
exit 0
