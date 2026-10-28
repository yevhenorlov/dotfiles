# Skills — Credits & Attribution

Some skills in this directory are copied or adapted from third-party sources.
This file records their provenance and preserves the required license notices.

## Sources

### mattpocock/skills

- Repository: https://github.com/mattpocock/skills
- License: MIT © 2026 Matt Pocock (full text below)

Skills in this directory that originate from that repo:

| Skill      | Relation        | Upstream path                        |
| ---------- | --------------- | ------------------------------------ |
| `teach`    | verbatim copy   | `skills/productivity/teach`          |
| `grill-me` | adapted         | `skills/productivity/grill-me`       |
| `improve-codebase-architecture` | adapted | `skills/engineering/improve-codebase-architecture` + `skills/engineering/codebase-design` |

Adaptations to `improve-codebase-architecture` (upstream at
`d80fa0f4ebe0c5714af0adf8670336065233ecc6`): the `codebase-design` vocabulary, principles and
dependency categories are inlined, so it depends on no other skill; the CDN-based HTML report
is replaced by a terminal report with ASCII sketches, with `show-me` or a self-contained local
HTML file as the fallback; `GLOSSARY.md`/`docs/adr/` are replaced by discovering the project's
own decision records, plans and rules at runtime; `grilling` is replaced by `grill-me` with an
inline fallback; framework-collision, read-only, local-only and structure-not-data rules added.

> `to-tickets` shares a name with an upstream skill but is an independent,
> original skill — not derived from that repo.

### humanlayer/skills

- Repository: https://github.com/humanlayer/skills
- License: MIT © 2026 HumanLayer (same MIT text as below, with this copyright line)
- Pinned at: `ca7c8088db69e315a8b2deea43820270457f8f3c`

| Skill     | Relation | Upstream path                                        |
| --------- | -------- | ---------------------------------------------------- |
| `show-me` | adapted  | `plugins/visual-pr/skills/visual-pr/references/show-me.md` |

Adaptations: promoted from a `visual-pr` reference file to a standalone skill; `task-artifact`
output replaced with one self-contained local HTML file (no CDN/remote assets) opened with
`open`; local-only, ground-in-real-code and placeholder-data rules added.

---

## MIT License (mattpocock/skills)

```
MIT License

Copyright (c) 2026 Matt Pocock

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
