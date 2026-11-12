# Revdoku skill and MCP plugin

Revdoku publishes your docs as a site from GitHub or uploaded files. AI agents read the site
through its MCP server, visitors ask questions, and support requests arrive as tickets.
Connect your AI app to create buckets, edit and publish docs, read site analytics and answer tickets.

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

Ask to publish your docs, read the site analytics, answer support tickets, store selected
local files or restore a file version. Access must cover the intended account and
bucket. Connecting does not authorize unrelated writes, account creation or
permanent deletion. Dashboard links do not grant access by themselves.

- [Documentation](https://docs.revdoku.com/api)
- [Privacy](https://revdoku.com/privacy/)
- [Terms](https://revdoku.com/terms/)
- Support: support@revdoku.com

The plugin is MIT licensed; the skill and its CLI payload are MIT-0 licensed.
