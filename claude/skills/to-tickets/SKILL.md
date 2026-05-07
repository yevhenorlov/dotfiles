---
name: to-tickets
description: Quiz the user to fill in a ticket template field-by-field, then publish it to Linear. Use when the user wants to create a Linear issue, ticket, or task.
tools: mcp__linear-server__list_teams, mcp__linear-server__list_users, mcp__linear-server__list_issue_labels, mcp__linear-server__save_issue
---

# To-Tickets

Create a Linear ticket by quizzing the user field-by-field, then publishing.

## Phase 0: Fetch Linear data upfront

Before asking anything, fetch all three in parallel:
- `list_teams` — to offer team options and resolve team ID
- `list_users` — to offer assignee options and resolve user ID
- `list_issue_labels` — to offer label options and resolve label IDs

## Phase 1: Quiz field-by-field

Ask **one question at a time**. For each field, suggest a value derived from the current conversation context. Wait for the user's answer before moving on.

Field order:

1. **Title** — short, imperative (e.g. "Add export button to reports page"). Suggest a title based on what was discussed.

2. **Type** — one of: `bug`, `feature`, `chore`, `spike`. Suggest based on conversation context.

3. **Description** — user story format:
   > "As a [role], I want [feature], so that [benefit]."
   Draft a user story from the conversation. Ask the user to confirm or edit.

4. **Acceptance criteria** — markdown checklist. Suggest 2–4 criteria based on the description. Ask the user to confirm, add, or remove items.

5. **Team** — present a numbered list of teams fetched from Linear. Ask the user to pick one.

6. **Labels** *(optional)* — present available labels for the chosen team. Ask the user to pick any that apply, or skip.

7. **Assignee** *(optional)* — present a numbered list of users. Ask the user to pick one, or skip.

## Phase 2: Preview and confirm

Show the complete ticket as it will appear:

```
Title:    <title>
Type:     <type>
Team:     <team name>
Labels:   <labels or none>
Assignee: <name or unassigned>

Description:
As a <role>, I want <feature>, so that <benefit>.

Acceptance criteria:
- [ ] ...
- [ ] ...
```

Ask: "Publish this to Linear?" — wait for explicit confirmation before proceeding.

## Phase 3: Publish

1. Resolve all names to IDs (team, labels, assignee) using the data fetched in Phase 0.
2. Call `save_issue` with the resolved fields.
3. Output the resulting ticket URL to the user.
