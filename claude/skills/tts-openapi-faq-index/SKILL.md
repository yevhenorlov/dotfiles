---
name: tts-openapi-faq-index
description: Use this skill when the user asks a TikTok Shop OpenAPI FAQ, common integration question, API troubleshooting question, authorization issue, token refresh issue, signature issue, order/product/logistics/reverse-order API question, webhook setup issue, sandbox testing issue, or needs a categorized FAQ routing index for external developers. This skill maps the question to a topic area and recommends the next documentation or diagnostic path without embedding internal document sources.
---

# TTS OpenAPI FAQ Index

Use this skill to route common TikTok Shop OpenAPI developer questions to the right topic area and diagnostic checklist.

## Workflow

1. Read `references/faq-index.md`.
2. Match the user's question to the closest FAQ category and question title.
3. Return the category, matched FAQ title, and a concise next-step checklist.
4. If the user needs exact endpoint fields, request/response schemas, rate limits, or policy-current behavior, verify with official Partner Center docs or the TTS OpenAPI MCP tools before giving final details.
5. If the issue still cannot be resolved, direct the developer to TTSPC / TikTok Shop Partner Center `Contact Us` to submit a support ticket. Tell them to include App Key, API name, full request and response payloads, error codes, timestamps, shop or region context, and screenshots when available.

## Output Shape

```text
Question:
Matched FAQ category:
Closest FAQ title(s):
Suggested next step:
Docs/tooling to verify:
Escalation:
```

## Reference

- `references/faq-index.md` contains the categorized FAQ index.
