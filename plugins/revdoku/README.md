# Revdoku skill and MCP plugin

Cloud file storage and incoming email for people and AI agents. Each bucket has
an email address and holds messages, attachments and other files. Authorized
members and agents can read and manage shared bucket data, including versions.
Email is receive-only.

This package contains the portable Revdoku skill, its bundled local CLI, and the
hosted OAuth MCP configuration at `https://mcp.revdoku.com`. The repository's
Codex catalog selects this package. The separate Claude package is at
`plugins/revdoku-claude` and uses hosted MCP without a local CLI.

## Connect and use

Connect the hosted MCP server through the agent's connector controls and sign in
with Revdoku in the browser. For local uploads, the skill runs
`skills/revdoku/scripts/revdoku.sh`, which uses the bundled CLI. The wrapper can
download pinned, checksum-verified jq when it is missing. Browser login stores
Revdoku credentials locally under the host's tool policy.

Ask to summarize recent mail, inspect attachments, store selected local files,
write text or restore a file version. Access must cover the intended account and
bucket. Connecting does not authorize unrelated writes, account creation or
permanent deletion. Dashboard links do not grant access by themselves.

- [Documentation](https://revdoku.com/api.md)
- [Privacy](https://revdoku.com/privacy/)
- [Terms](https://revdoku.com/terms/)
- Support: support@revdoku.com

The plugin is MIT licensed; the skill and its CLI payload are MIT-0 licensed.
