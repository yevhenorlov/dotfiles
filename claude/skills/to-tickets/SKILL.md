---
name: to-tickets
description: Quiz the user in rounds to fill in a ticket template, then publish it to Linear. Use when the user wants to create a Linear issue, ticket, or task.
allowed-tools: mcp__claude_ai_Linear__list_teams, mcp__claude_ai_Linear__list_users, mcp__claude_ai_Linear__list_issue_labels, mcp__claude_ai_Linear__save_issue
---

# To-Tickets

Create a Linear ticket by quizzing the user in rounds, then publishing. One ticket per run.

## Phase 0: Find the Linear tools and fetch data upfront

Linear's tool names depend on the user's connector, so resolve them at runtime. Call `ToolSearch`
with `select:` for the names you need, or with keywords such as `linear save_issue`, and use the
Linear server it returns. Do not hardcode a connector ID. If no Linear tools are found, stop and
say the Linear connector is not connected.

Before asking anything, fetch both in parallel:
- `list_teams` — to offer team options and resolve team ID
- `list_users` — to offer assignee options and resolve user ID

Labels are fetched after the team is chosen (Round B).

Read `TEMPLATE.md` from the same directory as this skill file. It defines the ticket body format
using `{{placeholder}}` syntax; Round B collects a value for each placeholder. The title is not
part of the template — Linear renders it above the description, so repeating it in the body
duplicates it.

## How a round works

Ask every question of a round in one message, numbered across the whole run, each with your
suggested answer derived from the conversation. Word each question so "yes" accepts the
suggestion:

```
❓ **Q1** - **<title>**: <question; options if there are any>

➡️ <your suggested answer>

---

❓ **Q2** - ...
```

- **Silence accepts.** A question the user's reply doesn't mention takes its suggestion. The user
  can answer some by number ("Q3: …, Q5: drop it") or all at once ("yes to all").
- **Nothing to suggest is still a question.** When the conversation gives nothing for an optional
  field, ask it anyway with "➡️ leave out", so a dropped field is visible.
- **Follow-up round.** If an answer changes something a later suggestion was derived from, ask a
  short follow-up round with only the questions whose suggestion changed, before the preview. No
  such change, no follow-up round.

## Round A: title, team, assignee

1. **Title** — short, imperative (e.g. "Add export button to reports page").
2. **Team** — numbered list of teams from Phase 0.
3. **Assignee** *(optional)* — numbered list of users; suggest one from the conversation, or
   "➡️ unassigned".

## Round B: the template's fields, plus labels

Fetch labels for the chosen team first (paginate with `cursor` until `hasNextPage` is false).

1. **role** — the user role affected (e.g. "admin", "end user").
2. **feature** — what they want (the "I want" part).
3. **benefit** — the "so that" reason.
4. **context** — things not covered by the user story: technical constraints, unknowns, accepted
   tradeoffs, historical record of the feature. "➡️ leave out" if none applies.
5. **acceptance_criteria** — always asked. Suggest 2–4 items, rendered as `- [ ] item` lines; the
   user confirms, adds or removes.
6. **Labels** *(optional)* — suggest only labels the conversation supports, and say the team's
   other labels are available on request. Don't list them all.

## Round C: preview and confirm

Render the final ticket by substituting all `{{placeholder}}` values into the template. Show it
alongside metadata:

```
Title:    <title>
Team:     <team name>
Labels:   <labels or none>
Assignee: <name or unassigned>

<rendered TEMPLATE.md with placeholders filled in>
```

Ask: "Publish this to Linear?" — wait for explicit confirmation. This is never a question that
silence accepts. If the user asks for edits, apply them and show the preview again.

## Publish

1. Resolve all names to IDs (team, labels, assignee) using the data fetched in Phase 0 and Round B.
2. Call `save_issue` with `title` set to the title and `description` set to the rendered template, plus team/labels/assignee. Never add the title as a heading at the top of the description.
3. Output the resulting ticket URL to the user.
