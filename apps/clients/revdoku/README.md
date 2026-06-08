# REVDOKU

Publish websites from Claude, ChatGPT, Codex, and other AI agents using Revdoku.
A few seconds from idea to a live website you can share.

Create a free account: <https://revdoku.com>

## Connect your AI agent

Pick your agent below — most setups are a single line. Hosted connections use
Revdoku OAuth, so there is no API key to copy or paste.

**Cloud chat (Claude.ai, ChatGPT, and other remote‑MCP clients)**

Add a custom MCP connector named `Revdoku` and sign in when prompted:

```text
https://app.revdoku.com/mcp
```

**Claude Code**

```sh
/plugin marketplace add revdoku/revdoku
/plugin install revdoku@revdoku
/mcp
```

**Codex CLI**

```sh
codex mcp add revdoku --url https://app.revdoku.com/mcp
codex mcp login revdoku
```

**Cursor** — add an MCP server with URL `https://app.revdoku.com/mcp`, then sign in.

**OpenClaw**

```sh
openclaw mcp set revdoku '{"url":"https://app.revdoku.com/mcp","transport":"streamable-http"}'
```

**Local files / any agent** — install the client to upload from your own machine
(local project, SSH, Docker, WSL2, or a VM). It also drops the Revdoku skill into
any agent it finds (Claude Code, Codex, Hermes, OpenClaw):

```sh
curl -fsSL https://revdoku.com/install.sh | bash
```

Then paste the connect prompt from the Revdoku app, or publish directly (below).

## Publish a website

```sh
revdoku --publish ./dist
revdoku --publish --protected --generate-password ./dist
```

Protected websites are available on Pro plans. Open the returned URL and enter the
password — never put passwords in URL parameters.

In a connected agent you can also just ask in plain language, e.g. *"publish the
`dist` folder to Revdoku"* or *"publish it as a password‑protected site."*
Publishing only happens when you ask for a website link.

---

This repository hosts the public Revdoku local client, the Claude Code plugin
(`plugins/revdoku/` + the `revdoku` marketplace in `.claude-plugin/`), and the
agent skill used by Revdoku setup prompts.
