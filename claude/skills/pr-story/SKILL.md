---
name: pr-story
description: >
  Tell the story of a pull request in plain language — what was asked for, the context around it,
  and what the author found out along the way. Reads the PR diff, description, commits and comment
  threads, plus its Linear ticket. Usage: /pr-story [PR number | PR URL]. With no argument it uses
  the PR for the current branch. Triggers on "tell me the story of PR X", "explain PR X",
  "what happened in PR X", or /pr-story. Read-only, terminal only.
allowed-tools: Bash(gh api:*), Bash(gh repo view:*), Bash(git branch:*), Bash(git rev-parse:*), Bash(git log:*), mcp__claude_ai_Linear__get_issue, mcp__claude_ai_Linear__list_comments
---

# PR story

Someone wants to understand a pull request without reading it. Not a summary of the code — a story:
what was the request, what surrounded it, and what the author learned that nobody knew when the
ticket was written.

## Hard rules

**Read-only.** Never comment on the PR, never touch the ticket, never push. No write tools are in
`allowed-tools` and none should be requested. This skill reads and narrates, nothing else.

**Terminal only.** Print the story and stop. No file, no artifact, no Slack, no memory write. PR
diffs and ticket threads routinely contain customer names, email addresses and message content —
that content stays in the terminal. Do not copy personal data into the story: name the customer
as "a customer", the reporter as "support", the author by first name only.

**No invented discoveries.** A story format invites filling gaps with plausible narrative. Every
claim in the story must trace to something you actually read. If the sources are thin, the story is
short and says so — see [§ When there is no story](#when-there-is-no-story). Never infer intent
from code shape alone and present it as what the author was thinking.

## Phase 1 — Resolve the PR

Resolve the repo once: `gh repo view --json nameWithOwner --jq .nameWithOwner`. Everything below
uses that as `$R`. Note the repo is often not the one the remote URL suggests, so don't hardcode it.

The argument may be `123`, `#123`, or a full GitHub URL — strip to the number. If no argument was
given, find the PR for the current branch:

```
git rev-parse --abbrev-ref HEAD
gh api "repos/$R/pulls?head=$OWNER:$BRANCH&state=all" --jq '.[0].number'
```

If that returns nothing, ask which PR they mean and stop. Don't guess from recent PRs.

**Do not use bare `gh pr view` or `gh pr edit`** — they fail on this org with a GraphQL
Projects-classic deprecation error. `gh api` REST is the working path throughout.

## Phase 2 — Gather

Fetch these together in one Bash call — they're independent:

```sh
R=<owner/repo>; N=<pr number>
gh api repos/$R/pulls/$N --jq '{number,title,state,merged,draft,user:.user.login,head:.head.ref,base:.base.ref,created_at,merged_at,additions,deletions,changed_files,commits,body}'
gh api --paginate repos/$R/pulls/$N/files --jq '.[]|"\(.status) +\(.additions)-\(.deletions) \(.filename)"'
gh api --paginate repos/$R/pulls/$N/commits --jq '.[].commit.message | split("\n")[0]'
gh api --paginate repos/$R/issues/$N/comments --jq '.[]|{user:.user.login,created_at,body}'
gh api --paginate repos/$R/pulls/$N/comments --jq '.[]|{user:.user.login,path,line,in_reply_to_id,body}'
```

Then the diff. Check `additions + deletions` from the metadata first:

- **under ~2000 lines** — read the whole thing:
  `gh api repos/$R/pulls/$N -H "Accept: application/vnd.github.v3.diff"`
- **over that** — don't dump it. Use the file list to pick the files that carry the intent (new
  source files, the composable or store, the API layer) and fetch their patches only:
  `gh api --paginate repos/$R/pulls/$N/files --jq '.[]|select(.filename|test("<pattern>"))|.patch'`
  Skip lockfiles, snapshots, generated output, and pure-formatting churn. Say in the story that you
  read part of the diff, not all of it.

Empty comment arrays are normal and not an error. A `body` of `null` means no description — that is
itself a finding for Phase 5.

## Phase 3 — Resolve the ticket

Find the ticket ID by looking, in this order, for `[A-Z]{2,5}-[0-9]+` in:

1. the branch name (`feat/ABC-26-csv-export` → `ABC-26`) — most reliable
2. the PR title (often bracketed: `feat(x): [ABC-26] …`)
3. the PR body, including a Linear autolink URL

Then `get_issue` on it, and `list_comments` for that issue in the same turn.

Read from the issue: title, description, status, assignee, `createdBy`, project, `stateHistory`,
`attachments`, `parentId`.

Two things people miss, and both are usually where the story is:

- **`stateHistory`** is a timeline. A long `Blocked` stretch, a bounce back from `In Review` to
  `In Progress`, a months-old `startedAt` — each is a real event in the story and the reason a
  small PR took a long time.
- **`attachments`** lists every PR linked to the ticket. More than one means an earlier attempt
  exists. Fetch that PR's metadata and state too (`merged`, `state`) — an abandoned or superseded
  first attempt is often the most interesting thing that happened.

If the ticket description is empty or just an image (common — designs get pasted as screenshots),
say so plainly and lean on the parent ticket (`get_issue` on `parentId`) and the project name for
what was being built. Do not describe an image you cannot see.

If no ticket ID exists anywhere, skip this phase and note that the PR isn't linked to a ticket.

## Phase 4 — Find the discoveries

This is the part that earns the skill. A discovery is something the author learned that was not
known when the work started. Ranked by how reliably they signal one:

1. **`fix:` / `revert:` commits that land after the first feature commit.** The author shipped
   something, found it wrong, and corrected it. `stop togglePolicy mutating the policy prop` is a
   discovery: the reactive object was shared, and they found out the hard way. Read these as a
   sequence, not a list — three commits circling the same file is a fight with something.
2. **Prose in the PR description that isn't the template.** Anything under Notes, Findings,
   Gotchas, "worth knowing", or a paragraph explaining why an approach was rejected.
3. **Review threads where the author replies with a reason.** The reviewer asked "why like this"
   and the answer is the discovery. Match replies via `in_reply_to_id`.
4. **Ticket comments from the author.** Reporting back mid-work: a blocker, a backend dependency,
   a wrong assumption in the ticket.
5. **Code comments added in the diff.** A comment explaining a workaround marks a constraint the
   author hit. So does a `TODO` with a condition attached.
6. **Test names asserting something odd.** `it('does not render WhatsApp twice')` means it did.
7. **Ticket state anomalies** from Phase 3, and superseded PRs.

Discard: dependency bumps, lint and formatting fixes, coverage-threshold changes, rebases, typo
fixes, review nits that changed a name. These are noise, and a story padded with them reads as
though nothing happened — which is worse than saying nothing happened.

For each discovery keep the *consequence*, not the change. "Renaming the flag key" is a change;
"the flag never switched on because the key case didn't match what the backend sends" is a
discovery. If you can't state the consequence, you haven't found a discovery — drop it.

## Phase 5 — Tell it

Plain language means a specific discipline, not a friendly tone.

**Translate every term to what it does for a person.** Not "added a composable with a computed for
missing-SLA channels" but "worked out which channels have no response-time rule set, so the page can
warn about them". Component, composable, store, prop, reactive, hook, flag, endpoint, mock, mount,
teleport — none of these belong in the story. Filenames are fine when the user might go look; a
filename is a pointer, not jargon.

**Nothing stands in for an explanation.** No "leverages", "surfaces", "wires up", "under the hood",
"non-trivial", "robust", "seamless". If a sentence survives with the noun removed, it said nothing.

**Say who wanted what.** "Support kept getting asked X" is a story. "It was requested" is not.

Then print exactly this shape — prose, in full sentences, no bullet-point lists of code:

```
PR #123 — feat(reports): add a CSV export behind a flag
Sam · merged 9 Sep · 25 files · linked to ABC-26

WHAT WAS ASKED
  Two or three sentences. The request as the person asking would say it.

THE CONTEXT
  Why it came up now, what already existed, what it depends on. Include the timeline
  when it is odd — long blocks, earlier attempts, a wait on another team.

WHAT THE AUTHOR FOUND OUT
  The discoveries, in the order they happened, one short paragraph each. Each one says
  what they expected, what was actually true, and what it meant for the work.

WHERE IT LANDED
  What now exists and who can see it — behind a flag, for which customers, and anything
  deliberately left for later.
```

Aim for something readable in a minute: roughly 250–400 words. Two paragraphs of real discovery
beat six paragraphs of restated diff.

After the story, offer one line: `Want the code-level walkthrough of any part of this?` — and only
go deeper if asked.

## When there is no story

Plenty of PRs are a dependency bump, a rename, or a one-line fix with an empty description. Say
that in two sentences and stop:

> PR #118 removes a counter nobody read. No ticket, no description, no discoveries recorded —
> the commit message is the whole story.

Do not manufacture a narrative arc for a chore. Padding a trivial PR is the failure mode that makes
the skill untrustworthy on the PRs that do have a story. And where the sources genuinely conflict —
the ticket asks for one thing and the diff does another — report the conflict as the story rather
than smoothing it over. That gap is usually the most useful thing you can tell them.
