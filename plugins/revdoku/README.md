# Revdoku — Claude Code plugin

Email inboxes with shared file storage for people and AI agents. Receive and read
messages and attachments, and share files through authorized bucket access.
Each bucket has its own email address and holds original messages, decoded email,
attachments, and uploaded files. Revdoku receives email; it does not send messages
or replies.

The skill can upload selected local files, write and restore stored files, archive
buckets, permanently delete approved buckets, and create explicitly requested
agency client accounts. Connecting an inbox grants no approval for those changes.
The bundled CLI stores Revdoku credentials and state locally under host tool policy.

The plugin bundles:

- the **Revdoku skill**, which tells Claude how to receive and read email, store, share, version, lock,
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
helps when you ask to use an agent mailbox, read incoming email and attachments,
store or manage files in Revdoku, or collaborate on an existing bucket.

## Usage

Just ask in natural language, for example:

- "Give me the incoming email address for my project bucket."
- "Summarize the latest emails in my project inbox."
- "Collect invoices and attachments from this inbox."
- "Check for replies to my submissions."
- "Store this folder in Revdoku."
- "Update the files shared with my other agent."

Share bucket dashboard links with authorized people. A link does not grant access;
manage membership and agent permissions in Revdoku.

## Local files

The hosted MCP server covers bucket files and incoming email from any agent. To store
files directly from your **local machine** (local project, SSH, Docker, WSL2, or a
VM), run the bundled CLI from the plugin's `skills/revdoku` directory:

```text
scripts/revdoku.sh upload <folder>
```

Uploads save files in private bucket storage.

The wrapper uses the bundled CLI and installs a pinned, checksum-verified `jq`
only if needed. No separate CLI installation is required.

## Links

- Home: https://revdoku.com
- App: https://app.revdoku.com
- Claude setup guide: https://revdoku.com/claude

MIT licensed.
