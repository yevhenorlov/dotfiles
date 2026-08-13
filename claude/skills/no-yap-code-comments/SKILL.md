---
name: no-yap-code-comments
description: eliminate all comments that make the human reviewer's eyes glaze over - only essential info, delivered plainly.
disable-model-invocation: true
---

Delete every comment on a changed line. The list below is the only exception. Unsure → it goes.

Scope is the whole PR, committed or not — this runs after an agent has prepared the branch, so most of the work is already in commits:

```bash
BASE=$(git merge-base main HEAD)   # or the branch this PR targets
git diff "$BASE" HEAD              # everything in the PR
git diff HEAD                      # anything not committed yet
```

Changed lines only — what the reviewer sees, not the rest of the file. If both diffs are empty, say so and stop; don't widen the scope to compensate. Comments only: no renames, no refactors, no behaviour changes.

Apply the deletions to the working tree and leave them uncommitted. Don't amend, don't rewrite commits, don't add a commit — the cleanup is part of the pass being made before pushing, and it belongs to whoever is making that pass. Don't ask permission first either; it's all in git, and asking before deleting twelve comments is its own kind of yapping.

## The only comments that survive

- **Why.** Rationale, a tradeoff, an alternative that was tried and rejected.
- **Contract.** What a caller must know without reading the body — units, error conditions, nullability, invariants. A docstring that only echoes the signature (`@param userId The user ID`) is not a contract; it dies like anything else, exported or not.
- **Non-local constraint.** Ordering requirements, invariants another site depends on, "must run before X".
- **Referenced workaround.** Upstream bug, CVE, browser quirk — with the link. No link means it's folklore, and folklore goes.
- **Machine-read lines.** Pragmas, linter directives, codegen markers, license headers.
- **Load-bearing bandage.** The code is genuinely unreadable and the comment is the only thing making it legible. Keep it — deleting makes the next reader worse off — and flag it.

Everything else is noise: restatement of the code, edit narration (`// added this to fix the bug`, `// NEW`), section banners, commented-out code, ownerless TODOs, hedging.

The test: delete it and ask what the next reader loses. Nothing → gone.

## Report

Count and files. Then only what needs a decision from the reader:

```
11 comments, 4 files.

Kept:
  auth.ts:88   upstream bug ref (nodejs/node#41521)
  boot.ts:14   ordering constraint

Kept pending a refactor:
  parse.ts:44  nested ternary
  sync.ts:9    `d`, `d2`, `dd`
```

No preamble, no recap, no offer to do it again.
