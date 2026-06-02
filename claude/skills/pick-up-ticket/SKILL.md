---
name: pick-up-ticket
description: "Pick up a Linear ticket to work on — fetches ticket details, creates a git branch, updates status to In Progress, then grills the developer on requirements and produces a task plan. Usage: /pick-up-ticket [TICKET-ID]. If no ID given, lists tickets assigned to you."
tools: mcp__claude_ai_Linear__get_issue, mcp__claude_ai_Linear__list_issues, mcp__claude_ai_Linear__list_users, mcp__claude_ai_Linear__list_issue_statuses, mcp__claude_ai_Linear__list_teams, mcp__claude_ai_Linear__save_issue
---

# Pick Up Ticket

Help a developer pick up a Linear ticket: branch, status update, requirements grill, task plan.

## Phase 0 — Preflight

Run `git status --porcelain`. If output is non-empty, abort:
> "Working tree is dirty. Stash or commit your changes first."

## Phase 1 — Ticket selection

Always call `list_users` to find the current user's Linear ID by matching against the user's email (available in session context as `# userEmail`). Store this as `current_user_id` for use in Phase 3.

**If a ticket ID was provided as an argument** (e.g. `FE-123`):
- Call `get_issue` with that identifier (in parallel with `list_users`).
- If not found, tell the user and abort.

**If no ticket ID was provided**:
- In parallel, fetch:
  - `list_users` — to find the current user's Linear ID (as above)
  - `list_teams` — for reference
- Call `list_issues` filtered by: assignee = current user, status in [Todo, Backlog], sorted by priority descending.
- Display a numbered list: `#. [TICKET-ID] Title (Priority: X)`
- Ask the user to pick one by number.
- Call `get_issue` on the selected ticket.

## Phase 2 — Branch creation

Derive the branch name:
1. **Type prefix** — map the ticket's type/label to a git prefix:
   - `bug` / `fix` → `fix`
   - `feature` / `improvement` → `feat`
   - `chore` / `maintenance` → `chore`
   - `spike` / `research` → `spike`
   - fallback → `feat`
2. **Slug** — take the ticket title, lowercase, replace spaces and special chars with `-`, trim to 50 chars, strip trailing `-`.
3. **Branch name**: `{prefix}/{TICKET-ID}-{slug}` e.g. `feat/FE-123-add-export-button`

Run these git commands in sequence:
```
git fetch origin main
git checkout -b {branch-name} origin/main
```

If branch already exists, abort with: "Branch `{branch-name}` already exists. Are you resuming this ticket?"

## Phase 3 — Status update + summary

- Call `list_issue_statuses` for the ticket's team to find the "In Progress" status ID.
- Call `save_issue` to update the ticket's status to In Progress **and** set `assigneeId` to `current_user_id` (resolved in Phase 1).
- Print summary:
  ```
  Ticket:  {TICKET-ID} — {title}
  Branch:  {branch-name}
  URL:     {Linear ticket URL}
  ```

## Phase 4 — Requirements grill

Read the full ticket: title, description, acceptance criteria, labels, priority, any linked issues or comments.

Then invoke the `grill-me` skill, passing the ticket details as context. The goal is twofold:
1. Surface ambiguities or gaps in the requirements.
2. Drive toward a concrete implementation approach.

Instruction to pass to grill-me:
> "I'm about to implement Linear ticket {TICKET-ID}: {title}. Here are the details: {description + acceptance criteria}. Grill me on requirements ambiguities AND implementation approach."

## Phase 5 — Implementation plan

After grill-me concludes, create a structured implementation plan using TaskCreate:
- One parent task: "Implement {TICKET-ID}: {title}"
- Child tasks: concrete implementation steps derived from the grill-me session
- Mark the parent task as `in_progress`

Tell the user the plan is ready and they can start coding.
