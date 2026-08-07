---
name: memory-audit
description: Audit the project's persistent memory store — measure context footprint, detect index/disk drift, find oversized or duplicated memories, and verify dated claims (PR numbers, ticket IDs, file paths) against the real world before proposing prunes. Use when the user asks to audit/check/clean memories, worries about context growth, asks "what do you remember", or invokes /memory-audit.
---

Audit the memory store for the current project. Report findings, then propose prunes — **do not delete anything until the user confirms**, except memories proven factually wrong (see step 5).

## 0. Locate the store

The project dir is the cwd with both `/` and `.` replaced by `-` (existing hyphens are kept). Translating only `/` is a common mistake — it silently misses any path containing a dot, e.g. a username like `y.orlov`.

```bash
M="$HOME/.claude/projects/$(pwd | tr './' '--')/memory"
[ -d "$M" ] || M=$(ls -d "$HOME/.claude/projects/"*"$(basename "$(pwd)")"/memory 2>/dev/null | head -1)
[ -d "$M" ] || { echo "no memory store for this project"; exit 0; }
echo "store: $M"
```

Always echo the resolved path and confirm it contains files before reporting "nothing to audit" — a bad path and an empty store look identical otherwise.

## 1. Footprint

Only `MEMORY.md` loads every session; the rest load on demand. Report both separately so the standing cost is not confused with the total.

```bash
wc -l -c "$M/MEMORY.md" | awk '{print "index: "$1" lines, "$2" B, ~"int($2/4)" tok/session"}'
cat $(find "$M" -name '*.md' ! -name 'MEMORY.md') | wc -c \
  | awk '{print "corpus: "$1" B, ~"int($1/4)" tok if all loaded"}'
```

Express the index cost as a share of a 200k window so it's interpretable.

## 2. Drift between index and disk

```bash
# index pointers with no file
grep -o '(\./[^)]*\.md)' "$M/MEMORY.md" | sed 's/^(\.\///; s/)$//' \
  | while read f; do [ -f "$M/$f" ] || echo "MISSING: $f"; done
# files with no index pointer
find "$M" -name '*.md' ! -name 'MEMORY.md' -exec basename {} \; \
  | while read f; do grep -q "($f)\|(\./$f)" "$M/MEMORY.md" || echo "ORPHAN: $f"; done
```

Do **not** normalise filenames with `tr -d '(./)'` — it strips the dot from `.md` and reports every file as missing. Use `sed` as above.

## 3. Structural smells

```bash
find "$M" -name '*.md' ! -name 'MEMORY.md' -exec wc -c {} + | sort -rn | head -10
```

Flag:
- **Any file > 2 KB** — a memory holds *one* fact. An oversized file is almost always an accreted work log that grew a paragraph per session. These are the highest-value deletions: they dominate the corpus and rot fastest.
- **Index > ~40 lines** — prune before adding more.
- **Near-duplicate `description:` lines** — two memories competing for the same recall slot means neither reliably wins.
- **Content the repo already records** — code structure, past fixes, git history, or anything restating a ticket that holds the same detail. The better record wins; the memory goes.

## 4. Verify dated claims — do not trust, check

Memories are point-in-time. Extract every falsifiable reference and test it:

```bash
grep -onE '#[0-9]{2,}|[A-Z]{2,}-[0-9]+|20[0-9]{2}-[0-9]{2}-[0-9]{2}' \
  $(find "$M" -name '*.md' ! -name 'MEMORY.md')
```

- **PR/MR numbers** → `gh api repos/{owner}/{repo}/pulls/{n} --jq '.state, .merged'`. Resolve the repo with `gh repo view --json nameWithOwner --jq .nameWithOwner`. Never use `gh pr view`.
- **Ticket IDs** → fetch via the issue tracker's MCP tools; check for a closed/done/completed status.
- **Claims about code** — a named file, symbol, or flag → confirm it still exists (`git grep`, `git ls-tree -r --name-only origin/main`). Check against the remote default branch, not just the working tree.
- **Status language** — "in progress", "ready for review", "pending", "blocked", "next step" older than ~2 weeks is presumptively stale.

## 5. Classify and act

| Verdict | Criterion | Action |
|---|---|---|
| **Dead** | every claim verified false or completed | delete; state the evidence |
| **Shrink** | mostly done, one live fact remains | rewrite to just that fact, or fold it into a related memory |
| **Superseded** | a better record exists (ticket, doc, code) | delete; point at the real record |
| **Keep** | still true and not recorded elsewhere | leave untouched |

Deleting a memory proven false is correct and needs no permission — a wrong memory is worse than no memory. Everything else (shrinking, merging, judgement calls about relevance) needs the user's say-so.

Before deleting, read the file and check for open follow-ups worth rescuing — a dead work log often contains one portable, still-true gotcha. Extract it into the appropriate memory first, then delete the rest.

After any change: update `MEMORY.md` pointers in the same pass, then re-run steps 1 and 2 and report before/after numbers.

## 6. Report

Lead with the numbers, then the verdict table, then what you actually changed. Be specific about evidence — "PR #1234 merged 3 weeks ago" beats "looked stale". If nothing needed changing, say that plainly; a clean audit is a real result.
