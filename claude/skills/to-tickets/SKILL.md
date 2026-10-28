---
name: to-tickets
description: Quiz the user to fill in a ticket template field-by-field, then publish it to Linear. Use when the user wants to create a Linear issue, ticket, or task.
allowed-tools: mcp__claude_ai_Linear__list_teams, mcp__claude_ai_Linear__list_users, mcp__claude_ai_Linear__list_issue_labels, mcp__claude_ai_Linear__save_issue
---

# To-Tickets

Create a Linear ticket by quizzing the user field-by-field, then publishing.

## Phase 0: Fetch Linear data upfront

Before asking anything, fetch both in parallel:
- `list_teams` — to offer team options and resolve team ID
- `list_users` — to offer assignee options and resolve user ID

Do NOT fetch labels yet — labels are fetched after the team is chosen (see step 8).

## Phase 1: Read template

Read `TEMPLATE.md` from the same directory as this skill file. It defines the ticket body format using `{{placeholder}}` syntax. The interview will collect values for each placeholder. The title is not part of the template — Linear renders it above the description, so repeating it in the body duplicates it.

## Phase 2: Quiz field-by-field

Ask **one question at a time**. For each field, suggest a value derived from the current conversation context. Wait for the user's answer before moving on.

Field order (maps to TEMPLATE.md placeholders):

1. **title** — short, imperative (e.g. "Add export button to reports page"). Suggest based on conversation. *(not in template; passed as the `title` field)*

2. **role** — the user role affected (e.g. "admin", "end user"). Suggest from context.

3. **feature** — what they want (the "I want" part). Suggest from context.

4. **benefit** — the "so that" reason. Suggest from context.

5. **context** — things not covered by the user story: technical constraints, unknowns, accepted tradeoffs, historical record of the feature. Suggest from conversation context, or leave blank if none applies.

6. **acceptance_criteria** — markdown checklist. Suggest 2–4 items. Ask the user to confirm, add, or remove. Render as `- [ ] item` lines.

7. **Team** — present a numbered list of teams fetched from Linear. Ask the user to pick one. *(not in template; metadata)*

8. **Labels** *(optional)* — after the team is chosen, fetch labels filtered by that team. Paginate (`cursor`) until `hasNextPage` is false to get the full list. Present all labels and let the user pick any or skip. *(metadata)*

9. **Assignee** *(optional)* — present a numbered list of users. Pick one or skip. *(metadata)*

## Phase 3: Preview and confirm

Render the final ticket by substituting all `{{placeholder}}` values into the template. Show it alongside metadata:

```
Title:    <title>
Team:     <team name>
Labels:   <labels or none>
Assignee: <name or unassigned>

<rendered TEMPLATE.md with placeholders filled in>
```

Ask: "Publish this to Linear?" — wait for explicit confirmation before proceeding.

## Phase 4: Publish

1. Resolve all names to IDs (team, labels, assignee) using the data fetched in Phase 0 and step 8.
2. Call `save_issue` with `title` set to the title and `description` set to the rendered template, plus team/labels/assignee. Never add the title as a heading at the top of the description.
3. Output the resulting ticket URL to the user.
