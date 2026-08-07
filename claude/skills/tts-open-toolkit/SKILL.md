---
name: tts-open-toolkit
description: Use this skill when the user asks how to install, upgrade, configure, diagnose, or use @tts-open-toolkit/cli or tts_open_toolkit; manage coding-agent skills; log in to TTSPC with OAuth and switch accounts; call supported account, app, service, document, authorization, or sandbox DevAPIs; bootstrap Codex, Claude Code, or Trae; or inspect toolkit history and updates.
---

# TTS Open Toolkit

Use this skill to help external TikTok Shop developers install, upgrade, and use the TTS Open Toolkit CLI.

## What It Does

`@tts-open-toolkit/cli` provides the `tts_open_toolkit` command. It installs and updates TTS coding-agent skills, manages Partner Center OAuth profiles, calls fixed OAuth DevAPI methods, exposes sandbox operations, configures Codex / Claude Code hooks, records skill usage history, and checks for toolkit updates.

Treat it as the long-lived entry point for TTS developer tooling. Current releases cover skill maintenance, TTSPC OAuth profiles, supported Developer Center and Partner Center API calls, and sandbox workflows. Future releases may add more TTS integration helpers. Do not claim a helper is available unless the installed CLI or release notes show it exists.

## Capability Map

| User intent | Start with | Guidance |
|---|---|---|
| Install or diagnose the CLI | `doctor`, `version` | Confirm the executable, Node/platform, config layers, cache, and protected credential-store support. |
| Install or update TTS skills | `skill add`, `skill list`, `skill state` | Choose project, user, agent, or explicit target. Use `--update` for managed installs. |
| Log in to Partner Center | `auth login`, `auth status` | OAuth uses `client_id=open_toolkit_cli` and stores tokens only in macOS Keychain or Windows CurrentUser DPAPI. |
| Add or switch TTSPC accounts | `auth login --add --profile`, `auth list`, `auth switch` | Profiles contain non-secret metadata; the active profile selects the protected token used by API calls. |
| Call a supported TTSPC DevAPI | `devapi list --json`, `devapi call <method-name>` | Prefer the 13 fixed methods. They lock method/path/input fields and remove secret-bearing response fields. |
| Inspect apps or sandbox state | `app list`, `sandbox list`, `sandbox endpoints` | These are compatibility shortcuts. Sandbox account deletion is intentionally unavailable. |
| Configure host hooks or inspect usage | `setup`, `history` | Use dry-run before writing host settings; history remains local. |
| Check or install an update | `update --check`, `update --yes` | Check is read-only; `--yes` is required before package installation. |

## Workflow

1. If the toolkit is not installed, give the npm install command.
2. If it is installed, check health and version with `tts_open_toolkit doctor`.
3. Install or update bundled skills for the user's project or coding agent.
4. Inspect layered configuration and cache paths with `doctor`; use explicit `--config` only when discovery must be bypassed.
5. For ongoing maintenance, use `tts_open_toolkit update --check` and `tts_open_toolkit update --yes`.
6. For OAuth-backed account, app, sandbox, service, document, and authorization operations, inspect `tts_open_toolkit devapi list --json` and use `devapi call <method-name>` instead of a caller-provided route.
7. Use `auth request` only for explicit diagnostics against a known existing TTSPC route that is not represented by a fixed method; never use it to bypass an API allowlist.
8. For broader developer-shop, app, or API questions, pair this skill with `tts-openapi-guide` or `tts-developer-onboarding-guide`.

## Commands

```bash
npm install -g @tts-open-toolkit/cli
tts_open_toolkit doctor

tts_open_toolkit skill add --agent codex
tts_open_toolkit skill add --agent cc
tts_open_toolkit skill add --agent trae
tts_open_toolkit skill add --agent trae-cn
tts_open_toolkit skill add --agent codex --update
tts_open_toolkit skill list --agent codex
tts_open_toolkit skill state --agent codex

tts_open_toolkit auth login
tts_open_toolkit auth login --add --profile second-account
tts_open_toolkit auth list --json
tts_open_toolkit auth switch second-account
tts_open_toolkit devapi list --json
tts_open_toolkit devapi call partner-profile --json
tts_open_toolkit app list --json
tts_open_toolkit sandbox endpoints --json
tts_open_toolkit sandbox call account-basic-list --query region_code=840 --json

tts_open_toolkit setup codex --dry-run
tts_open_toolkit history skills --json

tts_open_toolkit update --check
tts_open_toolkit update --yes
```

Read [references/cli-usage.md](references/cli-usage.md) when the request depends on exact target selection, OAuth profile management, fixed DevAPI method names and inputs, compatibility commands, sandbox operations, configuration precedence, OS config/cache paths, environment overrides, hooks, history, JSON output, or troubleshooting.

If the user's npm registry is stale or uses a mirror, prefer npmjs explicitly:

```bash
tts_open_toolkit update --yes --registry https://registry.npmjs.org
```

## Safety Boundaries

- Never print, persist, or ask the user to paste OAuth access tokens, refresh tokens, App Secrets, authorization codes, PKCE verifiers, or Partner Center cookies.
- Prefer `devapi call` over raw `auth request`. The fixed methods preserve the backend allowlist and omit secret-bearing response fields from normal output, safe raw output, and business-error payloads.
- Keep `app_key`, shop context, and pagination identifiers when the workflow needs them; they are identifiers, not App Secrets.
- Do not invent or expose sandbox delete behavior. `/api/v2/sandbox/account/delete` is excluded from the CLI catalog.
- Use `--force` only for an intentional overwrite and `--yes` only for an intentional package update.
- Use PPE headers only for an explicit internal PPE workflow. Normal production CLI use must not add them.

## Official Links

- Partner Center: `https://partner.tiktokshop.com/`
- Developer overview: `https://partner.tiktokshop.com/docv2/page/developer`
- Developer shops: `https://partner.tiktokshop.com/docv2/page/seller-center-development-shops`
- API documentation: `https://partner.tiktokshop.com/docv2`
- API scopes and app management path: `https://partner.tiktokshop.com/docv2/page/access-scope`

## Output Shape

```text
Install / upgrade:
Recommended toolkit command:
Active OAuth profile or API method:
Skill maintenance command:
Relevant official link:
Safety notes:
```
