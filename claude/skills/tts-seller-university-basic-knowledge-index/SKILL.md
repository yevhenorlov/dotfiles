---
name: tts-seller-university-basic-knowledge-index
description: Use this skill when the user asks for TikTok Shop Seller University merchant basic knowledge, 商家大学 docs, seller education categories, campaign or promotion documentation links, shop design guidance links, GMV Max or ads education links, fulfillment or customer-service policy links, or when they need a categorized URL index rather than full document text. This skill returns categories and corresponding Seller University URLs for external developers or ISV support.
---

# 商家基础知识索引

Use this skill to map merchant-support topics to Seller University categories and public Seller University URLs. Keep the response lightweight; this is an index, not a document-body knowledge base.

## Workflow

1. Read `references/seller-university-index.md`.
2. Match the user topic to the closest category or document title. Use keyword matches across title, category, and the category cue column.
3. Return the category and corresponding Seller University URL.
4. If multiple documents match, return a short ranked list grouped by category.
5. If the user asks for endpoint fields, auth, webhook, or code behavior, state that this index only covers Seller University links and pair it with OpenAPI docs or MCP tools.

## Output Shape

```text
Topic:
Matched category:
Recommended URL(s):
Notes:
```

## Reference

- `references/seller-university-index.md` contains the full category and URL index.
