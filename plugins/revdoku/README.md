# Revdoku — Claude Code plugin

Publish websites from AI agents with Revdoku. Store files privately, then publish
a folder as a public or password-protected website when you ask — Claude keeps the
same URL on every republish.

The plugin bundles:

- the **Revdoku skill**, which tells Claude how to store, publish, version, lock,
  and clean up Revdoku **buckets**, and
- the hosted **Revdoku MCP server** (`https://app.revdoku.com/mcp`), which exposes
  the `bucket_*` and `revdoku_*` tools. Claude Code handles sign-in through the
  standard MCP OAuth flow — no API key is stored in the plugin.

## Install

```text
/plugin marketplace add revdoku/revdoku
/plugin install revdoku@revdoku
/mcp                 # authenticate with Revdoku (OAuth, in browser)
```

Run `/mcp` after installing and complete the Revdoku OAuth prompt. Once connected,
Revdoku's bucket tools are available to Claude, and the skill activates whenever you
ask to store, publish, host, deploy, or share something on the web.

## Usage

Just ask in natural language, for example:

- "Store this folder in Revdoku."
- "Publish the `dist/` folder to Revdoku as a website."
- "Publish it as a password-protected site."
- "Which of my Revdoku buckets are public?"

Publishing only happens when you explicitly ask for a website link. Public and
password-protected sites are separate paths; Revdoku generates a password for
protected sites and never puts it in the URL.

## Local files (optional CLI)

The hosted MCP server covers bucket and website operations from any agent. To store
files directly from your **local machine** (local project, SSH, Docker, WSL2, or a
VM) without a cloud connector, install the Revdoku CLI:

```text
curl -fsSL https://revdoku.com/install.sh | bash
```

The skill automatically uses the CLI (`~/.revdoku/bin/revdoku`) for local-file work
when the MCP server is not the right fit.

## Links

- Website: https://revdoku.com
- App: https://app.revdoku.com
- Claude setup guide: https://revdoku.com/claude

MIT licensed.
