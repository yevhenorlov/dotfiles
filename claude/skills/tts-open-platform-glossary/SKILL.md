---
name: tts-open-platform-glossary
description: Use this skill when the user asks about TikTok Shop Open Platform, TTSPC, seller, shop, logistics, sandbox, development shop, 3PL, 4PL, cross-border shop, local shop, bundle, combined_skus, or external-developer terminology. This skill returns concise external-facing glossary definitions and aliases.
---

# TTS Open Platform Glossary

Use this skill to explain common TikTok Shop Open Platform and TTSPC terms in external-developer language.

## Workflow

1. Read `references/glossary.md`.
2. Match the user's term or phrase to the closest glossary entry.
3. Return the definition, aliases, and a short usage note when ambiguity matters.
4. If the user asks for API schema or endpoint behavior, pair the glossary answer with exact OpenAPI docs or MCP tool evidence.

## Output Shape

```text
Term:
Meaning:
Aliases:
Notes:
```

## Reference

- `references/glossary.md` contains the term list.
