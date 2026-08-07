---
name: tts-openapi-guide
description: Use this skill when the user asks about TikTok Shop OpenAPI endpoint structure, request parameters, request body schema, response schema, headers, path/method selection, or how to confirm exact API fields. Always inspect the bundled OAS reference first, then fall back to official Partner Center docv2 when OAS does not answer the question.
---

# TTS OpenAPI Guide

Use this skill to answer exact TikTok Shop OpenAPI structure questions from the bundled OAS reference before using any other source.

## Workflow

1. Read `references/oas-guide.md`.
2. Inspect `references/oas/index.json` to find the first-level API path file, then inspect the matching `references/oas/paths/<first_level_path>.json` file for the API path, method, headers, query/path parameters, request body schema, and response schema.
3. Do not infer fields, enum values, required flags, or response shapes that are not present in the OAS.
4. When online docs are useful, build the official doc URL as `https://partner.tiktokshop.com/docv2/page/{api}-{version}`, where `{api}` is the API slug and `{version}` is the six-digit version from the endpoint.
5. If the OAS cannot locate the API or does not resolve the question, use the official Partner Center docs at `https://partner.tiktokshop.com/docv2`.
6. If OAS and docv2 differ, state the difference clearly and cite which source was used for the final answer.

## Output Shape

```text
API:
Source checked:
Method and path:
Required headers:
Query/path parameters:
Request body:
Response:
Unresolved gaps:
Fallback docs:
Online doc URL:
```

## References

- `references/oas-guide.md` explains how to search and read the split OAS references.
- `references/oas/index.json` maps first-level API paths to split OAS files.
- `references/oas/paths/*.json` contains the OAS path subsets split by first-level API path.
