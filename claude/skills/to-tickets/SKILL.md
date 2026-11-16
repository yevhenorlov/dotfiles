---
name: to-tickets
description: Quiz the user in rounds to fill in a ticket template, then publish it to Linear. Use when the user wants to create a Linear issue, ticket, or task.
allowed-tools: mcp__claude_ai_Linear__list_teams, mcp__claude_ai_Linear__list_users, mcp__claude_ai_Linear__list_issue_labels, mcp__claude_ai_Linear__list_templates, mcp__claude_ai_Linear__get_template, mcp__claude_ai_Linear__save_issue, mcp__claude_ai_Linear__get_issue, mcp__linear-server__list_teams, mcp__linear-server__list_users, mcp__linear-server__list_issue_labels, mcp__linear-server__list_templates, mcp__linear-server__get_template, mcp__linear-server__save_issue, mcp__linear-server__get_issue
---

# To-Tickets

Create a Linear ticket by quizzing the user in rounds, then publishing. One ticket per run.

The body comes from the **team's Linear template** whenever one fits, so Linear stays the only
copy of the templates. `TEMPLATE.md` in this directory is the fallback for when no team template
fits or Linear can't be reached.

## Phase 0: Find the Linear tools and fetch data upfront

Linear's tool names depend on the user's connector, so resolve them at runtime. Call `ToolSearch`
with `select:` for the names you need, or with keywords such as `linear save_issue`, and use the
Linear server it returns. Do not hardcode a connector ID. If no Linear tools are found, stop and
say the Linear connector is not connected.

Before asking anything, fetch both in parallel:
- `list_teams` — to offer team options and resolve team ID
- `list_users` — to offer assignee options and resolve user ID

Labels and templates are fetched after the team is chosen.

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
- **Nothing to suggest is still a question.** When the conversation gives nothing for a section,
  ask it anyway with "➡️ leave out", so a dropped section is visible.
- **Follow-up round.** If an answer changes something a later suggestion was derived from (new
  `Options` in a Decision make the suggested `Proposal` stale), ask a short follow-up round with
  only the questions whose suggestion changed, before the preview. No such change, no follow-up
  round.

## Round A: title, team, assignee

1. **Title** — short and plain. Keep a prefix if the work is one of these kinds:
   `Decision:` / `Definition:` (an open question), `Research:` / `Verify:` (gathering facts,
   never deciding), `Data:` (one data-team change). Anything else has no prefix.
2. **Team** — numbered list from Phase 0.
3. **Assignee** *(optional)* — numbered list of users; suggest one from the conversation, or
   "➡️ unassigned".

## Pick the template

Once Round A is answered, pick the template **without asking**, from the title:

| Title starts with | Template name |
|---|---|
| `Decision:` or `Definition:` | Decision |
| `Research:` or `Verify:` | Research |
| `Data:` | Data change |
| anything else | Build |

Call `list_templates` with the chosen team and `type: "issue"`. If a template with that exact
name exists, call `get_template` and use its description as the body skeleton, and note its
`labelIds` (they are applied on publish).

**Fallback:** if the team has no template with that name, or either call fails, read
`TEMPLATE.md` from this skill's directory and use it instead. With the fallback, the sections are
its `{{placeholders}}`: role, feature, benefit (the user story), context, acceptance_criteria.

## Round B: the template's sections, plus labels and relations

Open the round with one line naming the template ("Using the team's **Decision** template", or
that the fallback is in use), so the user can override it. Fetch labels for the chosen team first
(paginate with `cursor` until `hasNextPage` is false). Then ask, in one round:

1. **One question per section**, in the template's order.
   - Each `## Heading` in the template is one section. Template text in the section is a hint
     for what goes there; never copy it into the ticket.
   - A bold line above the first heading (for example `**Result:** open · **Signed off by:** —`
     in Decision) is not a question; it is kept as it is unless the user gives a value.
   - A section the user leaves out is left out of the ticket. Don't invent content and don't
     leave it empty or write "TBD". `## Done when` is the exception: always asked, never "leave
     out".
   - `## Done when` is a `- [ ]` checklist. Suggest 2–4 items; the user confirms, adds or removes.
   - Don't write "PR #NN" as plain text (Linear auto-links it to the wrong repo); use the PR URL.
2. **Labels** *(optional)* — name the labels the template already applies, then suggest only
   extra labels the conversation supports, and say the team's other labels are available on
   request. Don't list them all.
3. **Relations** — "blocked by" and "blocks" issue IDs, suggested from the conversation, or
   "➡️ none". **Dependencies are not text:** they go in the relations on publish, not in the body.
   A sentence of nuance ("only the first part waits for X") may stay in the body.

## Round C: preview and confirm

Show the rendered ticket with its metadata:

```
Title:     <title>
Team:      <team name>
Template:  <template name, or "fallback TEMPLATE.md">
Labels:    <template labels + chosen labels, or none>
Assignee:  <name or unassigned>
Relations: <blocked by …, blocks …, or none>

<rendered body>
```

Ask: "Publish this to Linear?" — wait for explicit confirmation. This is never a question that
silence accepts.

If the user asks for edits:
- An edit that changes the title's prefix to one that maps to a **different template** goes back
  to Round B for the new template; the sections no longer match.
- Any other edit is applied in place, and the preview is shown again.

## Publish and verify

1. Resolve names to IDs (team, labels, assignee).
2. Call `save_issue` with `title`, `team`, `description` set to the rendered body, labels,
   assignee, and `blockedBy` / `blocks` for the relations. When a Linear template was used, also
   pass `template` (its ID) so Linear records which template the issue came from; the
   `description` replaces the template body, and the template's labels merge in.
   Never add the title as a heading at the top of the description.
3. **Verify**: call `get_issue` on the result and check the description and relations are
   there. Don't trust `save_issue`'s own response, and don't trust a read made right after it
   either: Linear reads can show the previous content for a while after a save that did go
   through. If the check fails, wait a moment and read again before concluding anything. Never
   call `save_issue` again to "retry" a create, because that makes a duplicate ticket. If it
   still looks wrong, say so plainly with the issue URL and let the user check it in Linear.
4. Output the ticket URL.
