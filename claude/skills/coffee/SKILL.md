---
name: coffee
description: >
  Morning brief. Pulls what is blocking on you, what moved on work adjacent to yours, and which
  promises you made are still open — from Linear, Slack, GitHub and Google Calendar — and prints
  one page of ranked items with a suggested action each. Triggers on "coffee", "morning brief",
  "what needs me", "what did I miss", or /coffee. Read-only: it never replies, never marks read,
  never writes.
allowed-tools: mcp__claude_ai_Slack__slack_search_public_and_private, mcp__claude_ai_Slack__slack_read_thread, mcp__claude_ai_Slack__slack_read_channel, mcp__claude_ai_Linear__get_notifications, mcp__claude_ai_Linear__get_issue, mcp__claude_ai_Linear__list_issues, mcp__claude_ai_Linear__list_comments, mcp__claude_ai_Linear__get_project, mcp__claude_ai_Google_Calendar__list_events, Bash(gh pr list:*), Bash(gh pr view:*), Bash(git for-each-ref:*), Bash(git log:*), Bash(date:*)
---

One page, over one coffee. Ranked by who is waiting on you.

## Hard rules

**Read-only.** The write tools are not in `allowed-tools` and must not be requested. Never send a
Slack message, never `save_issue`, never `mark_notification`. Marking Linear notifications read is
what makes tomorrow's brief wrong — `get_notifications` does not mark, keep it that way. Where an
item needs a reply, print a draft the user can copy. Sending is theirs.

**Terminal only.** Print the brief and stop. No file, no artifact, no upload, no memory write.
It carries colleagues' DM content and personal data and is stale by lunch; there is nothing worth
persisting and everything worth not persisting. If asked to publish it, say why not first.

**Use only the fields a check needs.** Some payloads carry more than the brief may use. Calendar
events come back with descriptions; use title, start, organiser, attendees and created time only,
and never quote, summarise or reason from a description — that is where meeting content and
external attendees' details sit. Same spirit for DMs: quote the commitment, not the conversation
around it.

**Stateless.** Fixed lookbacks, no watermark file, no cache. Running it twice is harmless and
re-shows the same items — that is the intended trade, not a bug to fix.

## Lookbacks

- **News** (Linear updates, channel mentions): 72h. On a Monday, since 09:00 the previous Friday.
- **DMs, promises and calendar**: 7 days back — one working week, which still catches a promise
  made last Tuesday. Calendar also looks 14 days ahead, where scheduled follow-ups land.

The DM window is a measured trade, not a round number. On 2026-10-02, at 20 results per page,
`to:me` covered about 4 days in 5 pages and `from:` about 4.5 days in 4 — so 7 days is roughly
6–9 pages per search, and 14 days would be double that. Do not widen it without re-measuring.

Compute all cutoffs with `date` and pass them as `after:YYYY-MM-DD` / ISO timestamps.

## Identity — get this wrong and the brief is empty

Read `identity.local.md` next to this file before the first call. It is gitignored (`*.local.md`),
so personal and organisation values stay out of version control. Below, `SLACK_ID` and
`GITHUB_LOGIN` stand for its values.

| key | used for |
|---|---|
| Slack user ID | `SLACK_ID` — mentions and the user's own messages |
| GitHub login | `GITHUB_LOGIN` — review completion |
| Git authors | every name and email the user commits as |
| Repos | `owner/repo`, each marked `reviews` (all open PRs) or `own` (the user's PRs only) |
| Local checkouts | where to read local branch names for seeding |
| Bot senders | Slack senders and channels to drop from results |

If the file is missing, ask for the values and print the file for the user to save — the skill
itself writes nothing. Never guess a value: a wrong ID returns an empty brief that looks like a
quiet morning.

The work email is often not the git identity: `git log --author=<work email>` returning zero is the
sign. Never seed from it.

## Pull plan — run in parallel

**GitHub**

1. Each `reviews` repo: `gh pr list --repo <owner/repo> --state open --limit 100 --json number,title,author,reviewRequests,reviews,updatedAt,isDraft`
2. Each `own` repo: `gh pr list --repo <owner/repo> --author "@me" --state open --json number,title,updatedAt`

From these payloads derive reviews pending on the user, the user's own open PRs, and review
completions (see traps).

**Slack** — `sort=timestamp`, `include_context=false`, `response_format=concise`. Paginate each
search until results cross the cutoff.

3. `to:me after:<7d>`, `channel_types=im,mpim` — what was said to them.
4. `from:<@SLACK_ID> after:<7d>`, all channel types — what they said. DMs feed the reply check;
   channels catch promises kept in public ("posted in #legal"). Their own volume is low.
5. `<@SLACK_ID> -from:<@SLACK_ID> after:<news>`,
   `channel_types=public_channel,private_channel` — mentions.

**Linear**

6. `get_notifications` — the inbox. Real read state, unlike Slack. Do not pass `unreadOnly` alone;
   read state and recency are different questions.
7. `list_issues` with `assignee: "me"`, `updatedAt` after the 7-day cutoff — their own tickets,
   with status and due date.
8. `list_issues` per seeded project (one call each, usually 1–3), `updatedAt` after the news
   cutoff — what moved next to them.

**Google Calendar**

9. `list_events` on the primary calendar with explicit `startTime` (7 days back) and `endTime`
   (14 days ahead) — the default is now + 7 days and misses every past promise — plus
   `eventType: ["DEFAULT"]`, `pageSize: 250`. There is no organiser filter; keep only events the
   user organised. Not authenticated → skip it and say so in the footer. Never start OAuth from
   inside the brief.

**Follow-ups**, only to settle a specific item already on the page: `gh pr view <n> --json
mergeStateStatus,statusCheckRollup` for the user's approved PRs (approved but behind main is a
different action from ready to merge), and `gh pr list --state merged` when a review ask may
already have landed.

## Seeding "your work"

Ticket IDs from, in order of trust:

1. Titles of the user's PRs, open and recently merged (`gh`). Authoritative.
2. Local branch names: `git for-each-ref --sort=-committerdate refs/heads/`. Carries IDs and dates —
   but reaches back months, so drop anything older than 30 days or you will pull dead work.

Hop 1 is those tickets where the **last update was not the user's**. Hop 2 is other tickets in the
same Linear projects. Do not widen to whole team cycles — two teams of cycle churn buries everything.

## Traps, all of them found by testing

**Slack search accepts a modifier-only query.** `to:me after:2026-09-04` works with no keyword. This
is the whole reason the Slack half is possible — semantic search is off for this account, keyword
search has no boolean operators, and there is no unread or mentions API.

**`from:me` returns nothing; use the user ID.** On 2026-10-02, `from:me after:…` over DMs returned
zero results, and `from:<@SLACK_ID>` over the same window returned 20 per page. Zero from call 4
looks like a quiet week and silently empties the reply and promise checks. The exclusion in call 5
uses the ID for the same reason — without it, the mention search matches the user's own messages.

**`to:me` is a DM filter only.** It returns nothing against channels. Channel mentions need the
literal `<@SLACK_ID>`.

**Bots dominate unfiltered results** — 3 of 10 in DMs, 4 of 10 in channels, despite
`include_bots=false`, because they post as users. Drop the senders and channels the
identity file lists as bot senders.

**Never sweep DM channels one by one.** There are 200+ group DMs and the list still paginates.
Search is the only viable path.

**`reviewRequests` shows only *pending* requests.** GitHub clears it the moment a review is
submitted, so an empty list means either "never asked" or "already done" — the two things you most
need to tell apart. For completion, read `reviews[] | select(.author.login == "GITHUB_LOGIN")` and
compare `submittedAt` against the ask.

**A draft PR is not a review request, even with the user in `reviewRequests`.** Requests survive
a PR being converted back to draft, and someone adding reviewers early to a draft is a heads-up,
not an ask. Filter `isDraft == false` before counting anything as blocking; a stale draft that
names the user belongs at most in the overflow line. Found when a 12-day-old draft topped the
list as an overdue review. The user's *own* drafts are a different check (the self-block), and
stay in.

**Never use `gh search`.** The search API has its own far stricter secondary rate limit and it
degrades *silently*: four consecutive identical `gh search prs --author "@me"` calls returned 1, 4,
5 results and then HTTP 403, and `gh api rate_limit` does not report the secondary limit at all. A
brief built on it under-reports and looks healthy. `gh pr list --repo <owner>/<repo>` hits the REST
pulls endpoint and is deterministic.

**Same ticket ID open in both repos means a coordinated landing**, and usually that the user is
blocking themselves — backend i18n keys must merge before the frontend that reads them. Always call
this out with the merge order.

## The four checks that make the sections true

**Unanswered** — their last message in a conversation postdates the user's last message in that same
conversation. Cross-reference calls 3 and 4 by conversation label; no extra calls.

**Replied is not resolved.** "Sure thing, I'll check" closes the reply check and opens a promise.
A last-message-wins rule alone will mark a real obligation as handled.

**Promise completion.** For every commitment in call 4 — "I'll check", "I'll get back to you",
"I'll reach out", "happy to show on Thursday" — look for a completing action after its timestamp:
a review in calls 1–2, a later message from the user in that thread or in a channel, or an
acknowledgement in call 3 ("thanks for the approvals"). A scheduling promise ("I'll schedule
something", "let's find a slot") is completed by an event in call 9 that the user organised,
created after the promise, with the people from that conversation among its attendees. Suppress
it if found. An unverified promise tracker nags about finished work, twice, and then gets ignored.

**Waiting on them, not you.** "Will look into it" in reply to the user's own ask is not an action
item. It belongs in the overflow line, not the list.

## Output

One page. Never longer.

```
☕ <Weekday D Mon> — N need you, M moved, P promises open

**Blocking on you** (3 shown, +N)
- **<the ask, 6-10 words>.** <who, what, how long>. → <action>

**Around you** (3 shown, +N)
- **<what changed>.** <who, and why it touches their work>.

**Promises you made** (N open, M auto-cleared)
- **"<quote>"** — <date>, <context>. <what completing it looks like>.
- *Cleared: <quote> → <completing action>.*

*<coverage: only when a source was skipped or a search stopped short of its cutoff>*
```

**Rank by who is waiting, then by age.** A named person blocked on the user outranks an FYI, and
staleness breaks ties. The oldest review request and the self-block go on top; "FYI, might be
relevant" goes to the bottom or the overflow count.

**Cap 3–4 per section and state the overflow count.** A brief and a broken pull look identical
without the counts. Same reason the header carries totals.

**Keep the cleared line.** One italic line naming what the completion check suppressed. Drop it and
the promises section becomes untrustworthy, because the user cannot tell a working check from a
check that found nothing.

**Keep the coverage line when it applies.** A skipped calendar or a DM search that stopped at
Tuesday changes what "0 promises open" means. Say which source and how far back it reached.

**One action per item, concrete.** "→ merge #123 first" is an action. "Follow up with the team"
is not. If there is no action, it belongs in Around you or the overflow.

Say plainly when a section is empty. A quiet morning is a three-line brief, and that is a correct
result — never pad it by loosening a check.

## Scope limit

No state files, no caches, no config beyond the identity file, no helper scripts, no saved output. Do not add file-collision
detection between the user's branches and others' PRs: it was tested, and shared registry files
(a shared feature-flag file collided with four open PRs) bury the real hits.

Nine read calls, their Slack pagination, and a page of markdown is the entire mechanism. If this
starts needing infrastructure, the skill is wrong — delete it rather than extend it.
