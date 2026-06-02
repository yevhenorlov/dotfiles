---
name: to-tickets
description: Quiz the user to fill in a ticket template field-by-field, then publish it to Linear. Use when the user wants to create a Linear issue, ticket, or task.
allowed-tools: mcp__claude_ai_Linear__list_teams, mcp__claude_ai_Linear__list_users, mcp__claude_ai_Linear__list_issue_labels, mcp__claude_ai_Linear__save_issue
---

# To-Tickets

Create a Linear ticket by quizzing the user field-by-field, then publishing.

## Phase 0: Fetch Linear data upfront

Before asking anything, fetch all three in parallel:
- `list_teams` — to offer team options and resolve team ID
- `list_users` — to offer assignee options and resolve user ID
- `list_issue_labels` — to offer label options and resolve label IDs

## Phase 1: Read template

Read `TEMPLATE.md` from the same directory as this skill file. It defines the ticket title and body format using `{{placeholder}}` syntax. The interview will collect values for each placeholder.

## Phase 2: Quiz field-by-field

Ask **one question at a time**. For each field, suggest a value derived from the current conversation context. Wait for the user's answer before moving on.

Field order (maps to TEMPLATE.md placeholders):

1. **title** — short, imperative (e.g. "Add export button to reports page"). Suggest based on conversation.

2. **Type** — one of: `bug`, `feature`, `chore`, `spike`. Suggest based on conversation context. *(not in template; passed as issue type to Linear)*

3. **role** — the user role affected (e.g. "admin", "end user"). Suggest from context.

4. **feature** — what they want (the "I want" part). Suggest from context.

5. **benefit** — the "so that" reason. Suggest from context.

6. **context** — things not covered by the user story: technical constraints, unknowns, accepted tradeoffs, historical record of the feature. Suggest from conversation context, or leave blank if none applies.

7. **acceptance_criteria** — markdown checklist. Suggest 2–4 items. Ask the user to confirm, add, or remove. Render as `- [ ] item` lines.

8. **Team** — present a numbered list of teams fetched from Linear. Ask the user to pick one. *(not in template; metadata)*

9. **Labels** *(optional)* — present available labels for the chosen team. Pick any or skip. *(metadata)*

10. **Assignee** *(optional)* — present a numbered list of users. Pick one or skip. *(metadata)*

## Phase 3: Preview and confirm

Render the final ticket by substituting all `{{placeholder}}` values into the template. Show it alongside metadata:

```
Type:     <type>
Team:     <team name>
Labels:   <labels or none>
Assignee: <name or unassigned>

<rendered TEMPLATE.md with placeholders filled in>
```

Ask: "Publish this to Linear?" — wait for explicit confirmation before proceeding.

## Phase 4: Publish

1. Resolve all names to IDs (team, labels, assignee) using the data fetched in Phase 0.
2. Call `save_issue` with: title and body from the rendered template, plus type/team/labels/assignee.
3. Output the resulting ticket URL to the user.
