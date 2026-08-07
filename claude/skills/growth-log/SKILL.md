---
name: growth-log
description: >
  Append work evidence to a personal log and prepare a periodic report from it. Use when the user
  has just finished a piece of work, paired with someone, reviewed a PR, sent a decision note, got
  pulled onto other priorities, or is preparing for a check-in. Triggers on "log this", "growth
  log", "did I make progress", "1:1 prep", or /growth-log. Keeps counters correct by recounting
  entries, never by incrementing.
---

Capture evidence at the moment it exists, and turn it into a report at the check-in.

## This skill holds procedure only

All content — commitments, targets, entry templates, framing rules, where reports get published — lives in a local notes repo, not here:

- Plan: `~/code/notes/growth/growth2026.json`
- Log: `~/code/notes/growth/log.md`
- Harvest script: `~/code/notes/growth/harvest.sh`
- Reasoning record: `~/code/notes/growth/DECISIONS.private.md`

**Read the plan and the log before doing anything.** They are the single source of truth. Never copy their content into this file — if this skill and those files disagree, the files win.

Invoked from whatever repo the work happened in, so always use the paths above rather than anything relative.

## Two modes

Decide from the request; if ambiguous, ask rather than guess.

- **Capture** — something happened, write it down. Default when the user describes work.
- **Report** — check-in prep. Triggers on "1:1", "report", "prep", "what have I done".

---

## Capture

1. **Read `log.md`** for the current rules and entry templates, and **the plan** for the live commitments and their targets.
2. **Classify the event** against the plan's actions whose due date is the current window. If it maps to an action deferred to a later window, log it anyway and say so — it's evidence for next cycle, not this one. Don't silently drop it.
3. **Check it isn't already logged.** Search for the task name, PR number, or person's name. If an entry exists, append to it rather than creating a second. Double-counting makes the numbers worthless.
4. **Append** using the matching template, newest first, above the marker comment.
5. **Never edit or reword past entries.** The log is append-only, and its git history is what makes its dates trustworthy. Corrections are new entries, not rewrites.

### Rules that matter more than completeness

- **Capture transferable output, not experience.** For a collaborative session: what you absorbed, what the other person left with, what decision changed as a result. "Good session, learned a lot" is not evidence. Three specifics are.
- **Anything required to precede the work doesn't count if written afterwards.** Say so plainly and log it as a retrospective note. Backdating hollows out the commitment it's meant to serve.
- **Log non-events neutrally** — a declined session, a period pulled onto other priorities. Factual, never as grievance. These records carry as much weight as the wins, because they're what justifies re-planning later.
- **Keep the log strictly work-framed.** Anything personal stays in the reasoning record and never moves out of it — not into the log, not into the plan, not into anything published.

---

## Counters

**Recount from entries. Never increment.**

After any capture, count the actual entries per commitment and write that number to both places that track it: the `progress` field on the matching action in the plan, and the corresponding column in the log's targets table. Both must agree — they're read by different audiences.

Deriving rather than incrementing makes repeat invocation harmless and means the two cannot silently diverge.

If a recount lowers a number, say so out loud. Never quietly adjust it.

---

## Report

1. **Run the harvest script** with the date of the last report, to collect whatever is already recorded in an external system. Nothing already captured by a system should depend on memory.
2. **Read log entries** since that date.
3. **Recount the counters**, so the plan is current before it's discussed.
4. **Produce two lists:**
   - **For the check-in** — everything, including empty stretches. Raw and honest.
   - **Publication candidates** — reframed for a senior audience: **outcome + scope of effect + beneficiary + link.** Effort and intent don't carry; scope of effect does. Non-events get reframed as neutral fact, not omitted.
5. **State progress as `n / target`**, and name anything at risk of missing given the time remaining.

### Never inflate

If little happened, report that little happened. A quiet period is logged as a quiet period, not as a generous reading of something adjacent. Inflated counters are worse than no counters — the numbers only do their job if they survive scrutiny by someone who wasn't there.

The decision about what gets published belongs to the user and whoever reviews it, jointly. Produce candidates; don't declare outcomes.

---

## Scope limit

Do not create new files, state files, schemas, indexes, or helper scripts. Do not restructure the log. Do not improve any viewer. Appending to a markdown file and correcting two numbers is the entire mechanism, and it stays that way.

Building a better measurement system instead of running the rough one is the most likely way this quietly dies. If this skill starts needing infrastructure to work, the skill is wrong — delete it rather than extending it.
