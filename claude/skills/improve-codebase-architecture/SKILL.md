---
name: improve-codebase-architecture
description: Scan a codebase for deepening opportunities — clusters of shallow modules that would be better as one deep module behind a small interface — report them in the terminal with before/after sketches, then grill through whichever one the user picks. Use when the user asks to find architectural friction, make code more testable or easier to navigate, or invokes /improve-codebase-architecture.
disable-model-invocation: true
---

# Improve codebase architecture

Surface architectural friction and propose **deepening opportunities**: refactors that turn
shallow modules into deep ones. The aim is testability and navigability, for humans and agents.

Adapted from mattpocock/skills `engineering/improve-codebase-architecture` and
`engineering/codebase-design` (MIT) — see `~/.claude/skills/CREDITS.md`.

## Hard rules

- **Read-only until a decision.** No edits, branches, PRs or tickets while exploring, reporting
  or grilling. Implementation starts only when the user asks for it.
- **Local only.** The report goes to the terminal, or to one local file. Never post, comment or
  publish it anywhere. Sharing is a separate, explicit request.
- **Structure, not data.** The report names files, modules and call relationships. Never copy
  values out of fixtures, seeds, logs, env files or query results; if an example needs data,
  invent placeholders.
- **The project's conventions win.** Where a project doc and this skill disagree, follow the
  project and say so.

## Vocabulary

Use these terms exactly, in every candidate. Consistent language is the point.

- **Module** — anything with an interface and an implementation, at any scale: a function, a
  class, a file, a package, a slice across tiers.
- **Interface** — everything a caller must know to use the module correctly: types, but also
  invariants, ordering constraints, error modes, required configuration, performance.
- **Implementation** — the code inside a module.
- **Depth** — behaviour a caller (or test) can exercise per unit of interface they must learn.
  **Deep**: much behaviour behind a small interface. **Shallow**: the interface is nearly as
  complex as the implementation.
- **Seam** — the place where behaviour can be altered without editing in that place; where a
  module's interface lives.
- **Adapter** — a concrete thing that satisfies an interface at a seam. Describes a role, not
  what is inside.
- **Leverage** — what callers get from depth: one implementation pays back across N call sites
  and M tests.
- **Locality** — what maintainers get from depth: change, bugs and verification concentrate in
  one place.

Don't drift into "service", "API", "boundary", "layer" or "wrapper" for these ideas.

**Framework collisions.** If the project's framework already uses one of these words, or a
banned one, for a concrete thing — a UI component, an injectable service, a framework module —
keep the word for that thing and use **module** for the architectural idea. Never rename the
framework's concepts.

## Principles

- **The deletion test.** Imagine deleting the module. If complexity vanishes, it was a
  pass-through. If it reappears across N callers, it was earning its keep. "Deleting it would
  concentrate complexity" is the signal you want.
- **The interface is the test surface.** Callers and tests cross the same seam. A test that has
  to reach past the interface says the module is the wrong shape.
- **One adapter is a hypothetical seam; two adapters is a real one.** Don't introduce a seam
  unless something actually varies across it (typically production + test).
- **Depth belongs to the interface, not the implementation.** A deep module can be built from
  small internal parts with their own internal seams; they just aren't part of its interface.
- **Accept dependencies, return results.** Modules that create their own dependencies or act
  only through side effects are hard to test at their interface.

## Dependency categories

Classify each candidate's dependencies. The category decides how the deepened module is tested.

1. **In-process** — pure computation, in-memory state, no I/O. Merge the modules and test
   through the new interface directly. No adapter.
2. **Local-substitutable** — has a local stand-in that runs in the test suite (in-memory
   database, test store, fake filesystem). The seam stays internal; no port at the interface.
3. **Ports & adapters** — owned code across a network or process boundary. Define a port at the
   seam; production gets a transport adapter, tests get an in-memory one.
4. **Mock** — third-party systems you don't control. Inject them as a port; tests supply a mock
   adapter.

Testing after a deepening: **replace, don't layer.** Write tests at the deepened module's
interface, then delete the tests on the shallow modules it absorbed. Tests that must change when
the implementation changes are testing past the interface.

## Process

### 1. Read the project's conventions

Start from the agent and contributor docs (`CLAUDE.md`, `AGENTS.md`, `CONTRIBUTING.md`,
`README.md`) and follow what they link to. Collect, with paths:

- **Decision records** — `docs/adr/`, `ADR-*.md`, a decisions log, architecture docs. Don't
  re-propose what they rule out unless the friction is real enough to reopen the decision.
- **Active refactoring plans** — roadmaps, initiative docs, migration trackers. Candidates they
  already cover are marked "already planned", not proposed fresh.
- **Testing policy and review rules** — what may or may not be tested, extraction rules, layer
  rules. Candidates must fit them; cite them rather than restate them.
- **Domain glossary**, if one exists — use its nouns to name modules.

If no decision records turn up, say so in the report header and continue.

### 2. Scope before you scan

Deepening pays off by making future change easier, so weight what changes.

- If the user named a direction (a module, a subsystem, a pain point), take it and skip the rest
  of this step.
- Otherwise find hot spots in recent history:
  `git log --since='6 months ago' --name-only --format= | sort | uniq -c | sort -rn | head -40`.
  Let the clusters pull your attention first. If changes are scattered, widen the net.

### 3. Explore

Spawn an Explore sub-agent on the scoped area. Give it the vocabulary, the conventions found in
step 1, and these questions, and ask it to report friction rather than apply heuristics:

- Where does understanding one concept require bouncing between many small modules?
- Where are modules shallow, with an interface nearly as complex as the implementation?
- Where were pure functions extracted just for testability, while the real bugs hide in how
  they're called (no locality)?
- Where do tightly coupled modules leak across their seams?
- What is untested, or hard to test through its current interface?

Read the files behind every candidate yourself before reporting it. A sub-agent's mistakes come
back as confidently as its findings. Apply the deletion test to each.

### 4. Report

Print the report in the terminal. Header: scope, the convention docs found (paths), and a legend
for the sketches. Then one block per candidate, 3–6 candidates at most:

- **Title** naming the deepening, e.g. "Collapse the order intake pipeline".
- **Strength** — `Strong`, `Worth exploring` or `Speculative` — and the dependency category.
- **Files** involved.
- **Before / after sketch** — the centrepiece. ASCII, grounded in real file and module names.
- **Problem** — one sentence.
- **Solution** — one sentence, in plain English. No interface design yet.
- **Wins** — short bullets in vocabulary terms ("locality: bugs land in one module",
  "leverage: one interface, 5 call sites"), never "cleaner" or "easier to maintain".
- **Conflict callout**, if it contradicts a decision record or overlaps an active plan: name
  the doc and why it's still worth raising.

```text
before                                 after
┌ intake.ts ┐   ┌ validate.ts ┐        ┏━━━━━━━━ OrderIntake ━━━━━━━━┓
│ parse()   │──▶│ check()     │        ┃ submit(draft) → Result      ┃
└───────────┘   └──────┬──────┘        ┃ · parse · check · price     ┃
                       ┆ leaks         ┃   (internal)                ┃
                ┌ pricing.ts ┐         ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
                │ quote()    │         one interface, one test surface
                └────────────┘
legend: ┌┐ module  ━ deep module  ──▶ call  ┆ leak across a seam
```

End with a **Top recommendation**: which candidate to tackle first and why, in one sentence.
Then ask: "Which of these would you like to explore?"

When a candidate is too dense for ASCII, hand that one to the `show-me` skill if it is
available. Otherwise write one self-contained HTML file to `${TMPDIR:-/tmp}`, with inline styles
and SVG and no remote scripts or stylesheets, open it, and give its absolute path.

### 5. Grill the chosen candidate

Use the `grill-me` skill if it is available. Otherwise ask one question at a time, give your
recommended answer with each, and look facts up in the code instead of asking for them.

Walk the decision tree: constraints, dependencies and their category, the shape of the deepened
module's interface, what sits behind the seam, and which tests survive (replace, don't layer).
If the user wants to compare interfaces, sketch two or three radically different ones and
compare them on depth, locality and seam placement.

As decisions crystallise:

- **Rejected for a load-bearing reason?** Offer to draft a decision record in the project's
  existing format and location — only if the choice is hard to reverse, surprising without
  context, and the result of a real trade-off. Show the draft; write it only on a yes.
- **New domain term, and the project keeps a glossary?** Offer the entry; same rule.

Done when every branch is resolved. Summarise the agreed shape of the deepened module and stop;
implementation is a separate request.
