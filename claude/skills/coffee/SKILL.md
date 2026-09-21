---
name: coffee
description: >
  Morning brief. Pulls what is blocking on you, what moved on work adjacent to yours, and which
  promises you made are still open — from Linear, Slack and GitHub — and prints one page of ranked
  items with a suggested action each. Triggers on "coffee", "morning brief", "what needs me",
  "what did I miss", or /coffee. Read-only: it never replies, never marks read, never writes.
allowed-tools: mcp__claude_ai_Slack__slack_search_public_and_private, mcp__claude_ai_Slack__slack_read_thread, mcp__claude_ai_Slack__slack_read_channel, mcp__claude_ai_Linear__get_notifications, mcp__claude_ai_Linear__get_issue, mcp__claude_ai_Linear__list_issues, mcp__claude_ai_Linear__list_comments, mcp__claude_ai_Linear__get_project, Bash(gh pr list:*), Bash(gh pr view:*), Bash(git for-each-ref:*), Bash(git log:*), Bash(date:*)
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

**Stateless.** Fixed lookbacks, no watermark file, no cache. Running it twice is harmless and
re-shows the same items — that is the intended trade, not a bug to fix.

## Lookbacks

- **News** (Linear updates, channel mentions): 72h. On a Monday, since 09:00 the previous Friday.
- **Unanswered and promises**: 14 days. These self-clear when the user acts, so a wide window
  costs nothing and catches a promise made last Tuesday.

Compute both with `date` and pass them as `after:YYYY-MM-DD` / ISO timestamps.

## Identity — get this wrong and the brief is empty

| what | value |
|---|---|
| Slack user | `U04GZTAA1CJ` |
| GitHub login | `yevhenorlov` |
| Git authors | `Yev Orlov`, `Yevhen Orlov`, `yevhenorlov@*` |
| Repos | `weerdm/trengo-frontend`, `weerdm/trengo` (backend) |
| Linear teams | `FE`, `TEA3`, `LEN` |

`git log --author="y.orlov"` returns **zero** — the work email is not the git identity. Never seed
from it.

## Pull plan — 7 calls, run them in parallel

**GitHub** (2 calls, `--json` in one shot; files/reviews for ~30 open PRs takes ~2s)

1. `gh pr list --state open --limit 100 --json number,title,author,reviewRequests,reviews,updatedAt,isDraft`
   in `~/code/trengo/trengo-frontend`, plus `gh pr list --repo weerdm/trengo --author "@me" --state open --json number,title,updatedAt`.
2. Derive from that one payload: reviews pending on the user, the user's own open PRs, and review
   completions (see traps).

**Slack** (3 searches, `sort=timestamp`, `include_context=false`, `response_format=concise`)

3. `to:me after:<14d>` with `channel_types=im,mpim` — what was said to them.
4. `from:me after:<14d>` with `channel_types=im,mpim` — what they said. One call, and it is what
   makes the reply check and the promise check possible.
5. `<@U04GZTAA1CJ> after:<news>` with `channel_types=public_channel,private_channel` — mentions.

**Linear** (2 calls)

6. `get_notifications` — the inbox. Real read state, unlike Slack. Do not pass `unreadOnly` alone;
   read state and recency are different questions.
7. Seed tickets → `list_issues` for their projects, `updatedAt` after the news cutoff.

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

**`to:me` is a DM filter only.** It returns nothing against channels. Channel mentions need the
literal `<@U04GZTAA1CJ>`.

**Bots dominate unfiltered results** — 3 of 10 in DMs, 4 of 10 in channels, despite
`include_bots=false`, because they post as users. Drop `#notification-github`, and drop senders
`GitHub`, `Grafana`, `Google Calendar`, `Dross`. Add `-from:me` to the mention query; it matches the
user's own messages otherwise.

**20 results per search, max.** Paginate on a busy window rather than narrowing the query.

**Never sweep DM channels one by one.** There are 200+ group DMs and the list still paginates.
Search is the only viable path.

**`reviewRequests` shows only *pending* requests.** GitHub clears it the moment a review is
submitted, so an empty list means either "never asked" or "already done" — the two things you most
need to tell apart. For completion, read `reviews[] | select(.author.login == "yevhenorlov")` and
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
pulls endpoint, is deterministic, and covers both repos in two calls.

**Same ticket ID open in both repos means a coordinated landing**, and usually that the user is
blocking themselves — backend i18n keys must merge before the frontend that reads them. Always call
this out with the merge order.

## The four checks that make the sections true

**Unanswered** — their last message in a conversation postdates the user's last message in that same
conversation. Cross-reference calls 3 and 4 by conversation label; no extra calls.

**Replied is not resolved.** "Sure thing, I'll check" closes the reply check and opens a promise.
A last-message-wins rule alone will mark a real obligation as handled.

**Promise completion.** For every commitment in call 4 — "I'll check", "I'll get back to you",
"I'll reach out", "happy to show on Thursday" — look for a completing action after its timestamp: a
review in call 1, a later message from the user in that thread, or an acknowledgement in call 3
("thanks for the approvals"). Suppress it if found. An unverified promise tracker nags about
finished work, twice, and then gets ignored.

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
```

**Rank by who is waiting, then by age.** A named person blocked on the user outranks an FYI, and
staleness breaks ties. The 11-day review request and the self-block go on top; "FYI, might be
relevant" goes to the bottom or the overflow count.

**Cap 3–4 per section and state the overflow count.** A brief and a broken pull look identical
without the counts. Same reason the header carries totals.

**Keep the cleared line.** One italic line naming what the completion check suppressed. Drop it and
the promises section becomes untrustworthy, because the user cannot tell a working check from a
check that found nothing.

**One action per item, concrete.** "→ merge #7495 first" is an action. "Follow up with the team"
is not. If there is no action, it belongs in Around you or the overflow.

Say plainly when a section is empty. A quiet morning is a three-line brief, and that is a correct
result — never pad it by loosening a check.

## Scope limit

No state files, no caches, no config, no helper scripts, no saved output. Do not add file-collision
detection between the user's branches and others' PRs: it was tested, and shared registry files
(`featureFlag.ts` collided with four open PRs) bury the real hits.

Seven read calls and a page of markdown is the entire mechanism. If this starts needing
infrastructure, the skill is wrong — delete it rather than extend it.
