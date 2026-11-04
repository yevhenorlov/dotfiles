---
name: grill-me
description: Interview the user relentlessly about a plan or design until reaching shared understanding, resolving each branch of the decision tree. Use when user wants to stress-test a plan, get grilled on their design, or mentions "grill me".
---

Interview me relentlessly until we reach a shared understanding. Map the plan as a **design
tree**: every decision branches into the decisions that hang off it.

Work the tree in **rounds**. The **frontier** is every decision whose prerequisites are already
settled: the questions you can ask now without guessing at answers you haven't heard yet. Ask
the whole frontier in one round, number each question, and give your recommended answer. Then
wait for my answers.

```
❓ **Q1** - **<title>**: <question; options if there are any>

➡️ <your recommended answer>

---

❓ **Q2** - ...
```

- Word each question so "yes" accepts your recommendation.
- A question that depends on another one still open in this round goes in a later round.
- After each answer, recompute the frontier and ask the next round.
- **Facts are your job, decisions are mine.** If a question can be answered by exploring the
  codebase, docs, or tools, look it up instead of asking. For a wide search, use a sub-agent if
  the harness has one. Only questions downstream of a pending lookup wait for it.

Done when the frontier is empty: every branch visited, nothing silently assumed. Summarise what
we settled and don't act on it until I confirm it's our shared understanding.
