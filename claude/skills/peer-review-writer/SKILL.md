---
name: peer-review-writer
description: Write a structured peer performance review for a colleague by asking the user targeted questions and filling out the review template. Use when the user wants to write a peer review, performance feedback, or 360 review for someone on their team.
allowed-tools: AskUserQuestion, Bash
---

# Peer Review Writer

Help the user write a thoughtful, honest, and specific peer performance review by gathering context through targeted questions, then producing a polished review in the standard template format.

**This skill is interactive.** It asks the user questions, then writes the review.

## Workflow

### Phase 0: Load Config

Run: `cat "{base_dir}/.env" 2>/dev/null`

Parse `COMPANY_CORE_VALUES` from the output (format: `COMPANY_CORE_VALUES="Value1, Value2, Value3"`). If the file doesn't exist or the variable is absent, set `COMPANY_CORE_VALUES` to `null` — you'll ask the user for values inline during Phase 1.

### Phase 1: Gather Context

Ask the following questions **one at a time**, waiting for the answer before asking the next. Skip questions the user has already answered in their initial message.

Start with:

> "Who are you reviewing? Tell me their name and role — and what's the main thing you work together on."

Then collect the following, asking naturally (not as a numbered list):

1. **Their standout strength** — What's the most impressive thing this person does? Can you give a concrete example from the past few months?
2. **Impact of that strength** — How has it benefited the team or the product?
3. **Growth area** — What's one thing they could do more of, or do differently, to be even more effective? Be specific — avoid generic advice.
4. **Why that matters** — Why would changing this thing make a difference for them or the team?
5. **Core value alignment** — Which of the company core values fits them best? _(If the user doesn't know them, skip this and note it as a placeholder.)_  
   If `COMPANY_CORE_VALUES` was loaded in Phase 0, present those values as options. Otherwise ask the user to name their company's core values first.

6. **Why that value** — What specific behavior or moment made you think of that value for them?

**Tips for asking:**

- If an answer is vague ("they're great at communication"), probe for a specific example: "Can you think of a specific time that stood out?"
- If an answer is overly harsh or judgmental, gently reframe: "How would you phrase that as something they could _do more of_ rather than something they did wrong?"
- Keep it conversational — you're helping the user think, not interrogating them.

### Phase 2: Draft the Review

Once you have enough to fill all three sections, write the review using the template below. Aim for:

- **Question 1 (Strength)**: 2–4 sentences. Specific, warm, grounded in a real example. Name the behavior and its impact.
- **Question 2 (Growth area)**: 2–4 sentences. Framed as an opportunity, not a criticism. Concrete and actionable.
- **Question 3 (Core value)**: 1–3 sentences. Names the value and explains why this person embodies it with a brief example.

**Output format — fill in and present to user:**

---

Thank you for taking the time to provide feedback! Please be honest, constructive, and actionable. Your insights help your peers grow and develop. We aspire to maintain a safe, growth-oriented feedback culture, so we focus on observations and suggestions rather than judgments.

We also encourage scheduling a 15-minute conversation with each peer you review. This is a great opportunity to walk them through your feedback, answer questions, and create a space for meaningful discussion.

1. What is something this person does exceptionally well that you admire or value?

[Drafted answer here]

2. What is one thing this person could do more of or differently to be even more effective in their role?

[Drafted answer here]

3. This is the core value that resonates the most with this person, and this is why:

[Drafted answer here]

---

### Phase 3: Refine

After presenting the draft, ask:

> "How does this feel? Anything you'd like to change, strengthen, or soften?"

Iterate until the user is happy with the review. Then present the final version cleanly, ready to copy-paste.

## Tone Guidelines

- **Specific over generic**: "She caught a critical edge case in the checkout flow before launch" beats "She has great attention to detail"
- **Behavior over personality**: Describe what the person _does_, not who they _are_
- **Growth framing**: "Could do more of X" or "Would benefit from Y" — not "doesn't do X" or "struggles with Y"
- **Genuine**: Don't over-inflate. A real, grounded review is more valuable than hollow praise
