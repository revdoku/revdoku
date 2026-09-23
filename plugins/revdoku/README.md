# Revdoku — Claude Code plugin

Cloud storage with an email address for every bucket. Store and share files with authorized people and AI agents; receive email and attachments.
Each bucket holds uploaded files, original messages, decoded email, and attachments.

The plugin bundles:

- the **Revdoku skill**, which tells Claude how to store, receive email, share, version, lock,
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
bucket, or read incoming email and attachments.

## Usage

Just ask in natural language, for example:

- "Store this folder in Revdoku."
- "Give me the incoming email address for my project bucket."
- "Read the latest email and summarize its attachments in the same bucket."
- "Update the files shared with my other agent."

Share bucket dashboard links with authorized people. A link does not grant access;
manage membership and agent permissions in Revdoku.

## Local files

The hosted MCP server covers bucket files and incoming email from any agent. To store
files directly from your **local machine** (local project, SSH, Docker, WSL2, or a
VM), run the bundled CLI from the plugin's `skills/revdoku` directory:

```text
scripts/revdoku.sh p <folder>
```

Uploads save files in private bucket storage.

The wrapper uses the bundled CLI and installs a pinned, checksum-verified `jq`
only if needed. No separate CLI installation is required.

## Links

- Website: https://revdoku.com
- App: https://app.revdoku.com
- Claude setup guide: https://revdoku.com/claude

MIT licensed.
