---
name: review-prs
description: >
  Review the pull requests waiting on you. Finds the PRs that name you personally as a reviewer,
  fans one sub-agent out per PR to run /code-review plus the repo's own review rules, verifies the
  findings before repeating them, then reports in plain language and drafts a postable review for
  each — without being asked twice. Triggers on "what needs my review", "review my PRs", "check PRs
  assigned to me", "draft a review for #N", or /review-prs. The go-ahead is needed only to publish.
---

Turn a review queue into posted reviews, without hand-reading every diff.

Run straight through to a drafted review for every PR. There is exactly one stop: publishing.
Do not pause to ask whether to draft — the draft costs the user nothing and waiting costs them a
round-trip.

## Phase 0 — Find the queue

Resolve the login first: `gh api user --jq .login`.

Two different questions, and the difference matters:

```sh
# named personally as a reviewer — this is "explicitly assigned to me"
gh api -X GET search/issues -f q='is:open is:pr user-review-requested:@me' -f per_page=50 \
  --jq '.total_count, (.items[] | "\(.number)\t\(.repository_url|split("/")|.[-2:]|join("/"))\t\(.title)")'

# the above PLUS ones routed via a team or CODEOWNERS
gh api -X GET search/issues -f q='is:open is:pr review-requested:<login>' -f per_page=50 --jq '...'
```

Default to the personal set. **Name the team-routed remainder in one line and offer it** — do not
silently review them, and do not silently drop them either.

Never use `gh search prs`: it returns partial results under secondary rate limits without saying so.

Then for each PR: `gh api repos/{owner}/{repo}/pulls/{n}` for author, draft status, base, head,
changed files, additions/deletions. Bare `gh pr view` fails on some orgs (Projects-classic
deprecation); `--json` or the REST path avoids it.

## Phase 1 — Fan out, one agent per PR

One `Agent` call per PR, all in a single message so they run concurrently, each with
`isolation: "worktree"` so they cannot trip over each other's checkouts.

Each agent's prompt carries:

1. The exact fetch/checkout commands and the diff range (`git diff origin/main...HEAD`).
2. Invoke the `code-review` skill at `high`. **Never `--comment` or `--fix`** — read-only, this is
   someone else's PR.
3. Read the PR description via `gh api repos/{owner}/{repo}/pulls/{n} --jq .body`.
4. Apply the repo's own review rules if `.claude/rules/` exists — read `index.md`, load the rules
   whose trigger glob matches the changed files. Rules the repo marks as required (e.g.
   `severity: must`) outrank everything else the agent finds.
5. **Never report what `npm run lint` already catches.** A finding a linter could have produced
   costs trust in the ones that matter.
6. What the diff is *about*, so the agent knows where to press. Analytics → classify every property
   of every event. An edit/update flow → form initialisation, partial vs full payload, validation
   differences from create, failed-save behaviour. A UI-library migration → what the new component
   does that the old one didn't.
7. Output shape: file:line, what's wrong, and what breaks with what input. Most severe first. Say
   plainly if there is nothing — no filler.

## Phase 2 — Verify before you repeat it

A sub-agent's report is a lead, not a finding. Before any of it reaches the user or a PR:

- **Re-check every line number.** They drift, and a wrong one in a posted review is embarrassing in
  a way the prose isn't. Grep for the symbol, don't trust the number.
- **Confirm the single highest-stakes claim yourself.** Anything about personal data leaving the
  browser, data loss, or a security boundary — read the actual code. In practice this is one grep.
- **Check the branch hasn't moved**: `git fetch` the head ref and compare to the worktree HEAD.
  Reviewing a stale commit wastes the author's time.
- If two passes disagree — the skill's agent and the sub-agent's own read often do — **say so and
  give the union.** Neither alone tends to be complete.

Correct the report where it's wrong. Don't narrate the correction at length; just carry the right
version forward.

## Phase 3 — Report and draft, in one pass

Every PR gets both: the plain-language read *and* a finished draft. Don't offer the draft, produce it.

For the plain-language part, follow the `bro` skill's bar: one human talking to another, no jargon.
That means:

- Lead with what the reader would *notice*, not the mechanism. "The '+ Translate' menu gets sliced
  off" before "AccordionContent carries `ui:overflow-hidden`".
- Concrete reproduction over category names. "Select 60 tickets, pick an assignee" beats "missing
  guard".
- Say what is genuinely fine. A review that only lists problems reads as a hostile skim.
- Rank by consequence, not by how interesting the bug is.

With a queue of more than three, lead with the plain-language read for all of them so the user can
triage, then the drafts in the same order.

End with the call the user actually has to make — which is only ever whether to post.

## Phase 4 — Draft format

Write each draft to the scratchpad directory and show it inline.

Structure that works:

```
<One short paragraph crediting what holds up — name the specific calls that could have gone
 wrong and didn't. This is not padding; it tells the author you read it.>

### Blocking            ← only if something genuinely cannot ship
### Should fix
### Non-blocking
### Checked and clear   ← the risk areas you cleared, so the author knows the scope of the read
```

Per finding: `file.ext:line`, what's wrong, then **the concrete failure** — inputs and result. Add
the fix when it's short, and the reason the obvious fix is wrong when it is (e.g. "can't just be
`overflow: visible`, the animation needs the clip"). Flag where the PR's own description or docs
now contradict the code — that lands harder than the bug.

Keep the tone collegial. These are colleagues, and the author usually already knows about half of it.

## Phase 5 — Post only on an explicit go-ahead

Posting a review is outward-facing and lands in a colleague's notifications. Never post without the
user saying so for that specific PR.

When drafting, **recommend an event type and say why**, one line:

- `REQUEST_CHANGES` — something ships that can't be undone (data at a processor, data loss) or the
  PR would merge broken.
- `APPROVE` — real findings, but none needs another round from you.
- `COMMENT` — flag-gated or otherwise unreachable, and you don't want to gate on it.

Post with the body as a file, so quoting can't mangle it:

```sh
jq -n --rawfile b "$SP/pr<N>-review.md" '{body:$b, event:"<EVENT>"}' > "$SP/pr<N>-review.json"
gh api -X POST repos/{owner}/{repo}/pulls/<N>/reviews --input "$SP/pr<N>-review.json" \
  --jq '"posted: \(.html_url)\nstate: \(.state)"'
```

**If approving a body that contains a "Should fix" heading, add one reconciling line at the top** —
otherwise the review contradicts itself. Something like: "Approving — none of this needs another
round from me. #1 is real though, please take it before merging." Tell the user you added it and
what it says.

## After posting

Surface anything the PR thread can't fix. A leak that already shipped behind a flag is not resolved
by the patch that stops it — say so, once, and leave it with the user.
