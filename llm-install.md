# Revdoku LLM Install

This singular filename is kept as an alias for tools that look for
`llm-install.md`. The canonical guide is [`llms-install.md`](./llms-install.md).

Essential setup:

- Revdoku app: <https://app.revdoku.com>
- Direct signup fallback: <https://app.revdoku.com/users/sign_up?utm_source=github.com&utm_medium=public-docs&utm_campaign=connect_ai_first>
- Remote MCP server: `https://app.revdoku.com/mcp`
- Public setup hub: <https://revdoku.com/connect/>
- For local files, install the CLI:

```sh
curl -fsSL https://revdoku.com/install.sh | bash
~/.revdoku/bin/revdoku login
```

For a hosted MCP client, add the remote MCP server and start OAuth immediately;
the Revdoku browser flow lets the user sign in or create an account. For Cline
and other tools without hosted MCP, ask the user to open Revdoku, sign in or
create an account, click **New** (or **+** on mobile), choose **Copy Instructions
for AI**, and paste the copied prompt into the tool.
