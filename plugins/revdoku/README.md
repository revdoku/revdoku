# Revdoku — Claude Code plugin

Publish and update static websites and files. Manage bucket files, versions, access settings, forms, and analytics.
Private workspaces need no preview or website. Website republishing keeps the same URL.

The plugin bundles:

- the **Revdoku skill**, which tells Claude how to store, publish, version, lock,
  and clean up Revdoku **buckets**, with its bundled local CLI, and
- the hosted **Revdoku MCP server** (`https://app.revdoku.com/mcp`), which exposes
  the `bucket_*` and `revdoku_*` tools. Claude Code handles sign-in through the
  standard MCP OAuth flow — no API key is stored in the plugin.

## Install

```text
/plugin marketplace add revdoku/revdoku
/plugin install revdoku@revdoku
/reload-plugins
/mcp                 # authenticate with Revdoku (OAuth, in browser)
```

Reload plugins (or start a new Claude Code session), then run `/mcp` and start
Revdoku OAuth. A new user can create a Free account in the browser before
authorizing Claude. Revdoku's bucket tools are then available, and the skill
helps when you ask to store or manage files in Revdoku, collaborate on an existing
bucket, or publish a website.

## Usage

Just ask in natural language, for example:

- "Store this folder in Revdoku."
- "Publish the `dist/` folder to Revdoku as a website."
- "Publish it as a password-protected site."
- "Which of my Revdoku buckets are public?"

Publishing only happens when you explicitly ask for a website link. Public and
protected sites are separate paths. Password access uses a shared password;
Require Email sends visitors a one-time code and uses no site password.

## Local files

The hosted MCP server covers bucket and website operations from any agent. To store
files directly from your **local machine** (local project, SSH, Docker, WSL2, or a
VM), run the bundled CLI from the plugin's `skills/revdoku` directory:

```text
scripts/revdoku.sh p <folder> --draft
```

Keep `--draft` for private storage. Omit it only when the user asks to publish.

The wrapper uses the bundled CLI and installs a pinned, checksum-verified `jq`
only if needed. No separate CLI installation is required.

## Links

- Website: https://revdoku.com
- App: https://app.revdoku.com
- Claude setup guide: https://revdoku.com/claude

MIT licensed.
