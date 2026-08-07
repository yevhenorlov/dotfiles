# TikTok Shop Developer Onboarding Guide

Use this reference for external-facing onboarding guidance.

## Choose the Right Path

| Path | Best for | Core requirement | App availability | Review expectation |
| --- | --- | --- | --- | --- |
| ISV | Independent software vendors building apps for multiple TikTok Shop sellers. | Developer account plus company/entity qualification in Partner Center. | Can be authorized by multiple sellers after approval. | App review is required before production launch. |
| Seller Developer | A merchant building a custom tool for their own shop, such as ERP or WMS integration. | A valid operating TikTok Shop seller account. | Bound to the seller's own shop; not installable by other sellers. | No marketplace-style app review for serving other sellers, but the app still must follow API and security rules. |

## ISV Onboarding Checklist

1. Register a developer account in TikTok Shop Partner Center.
2. Submit company or entity qualification materials required by Partner Center.
3. Create an app and choose the appropriate app type/category.
4. Configure sandbox testing, API scopes, OAuth redirect URL, signing, and webhooks.
5. Build and test the app in sandbox before production use.
6. Submit the app for review when it will serve external sellers.
7. Launch after approval and guide sellers through OAuth authorization.

## Seller Developer Checklist

1. Use an active TikTok Shop seller account.
2. Enable developer/custom app capability from the seller/developer entry point available to that account.
3. Create a custom app for the seller's own shop.
4. Configure app key/secret, scopes, OAuth redirect URL, signing, and webhook handling.
5. Test in sandbox where available.
6. Use the app internally for that shop only.

## Technical Areas to Prepare

- OAuth authorization and redirect URL handling.
- Minimal required API scopes.
- Request signing and secret handling.
- Access token refresh and reauthorization handling.
- Webhook event setup and retry handling.
- Sandbox testing and production separation.

## Common Review Risks for ISV Apps

- Incomplete or buggy app flows.
- Requesting unnecessary scopes.
- Poor seller authorization or onboarding experience.
- App secret exposed in frontend code.
- Weak redirect URL validation or callback handling.

## Support and Verification

Use Partner Center as the source of truth for current qualification requirements, app review requirements, API documentation, testing tools, and support tickets: https://partner.tiktokshop.com/doc/home
