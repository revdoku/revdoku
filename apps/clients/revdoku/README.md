# REVDOKU

Publish websites from Claude, ChatGPT, Codex, Gemini, and other AI agents using Revdoku.
A few seconds from idea to a live website you can share — `revdoku p` and you
have a URL. Nothing goes live until you publish (use `--draft` to store privately).

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
revdoku p                 # publish the current folder -> live URL
revdoku p ./dist          # publish a specific folder
revdoku p --protected --generate-password   # password-protected site
```

Re-running `revdoku p` updates the **same** site (the bucket is remembered in a
local `.revdoku` file). `revdoku open` opens it in a browser; `revdoku ls` lists
your sites; `revdoku --help` shows every command. Start a new project with
`revdoku init` (add `--template <id>` for a database-backed app starter).

Common commands have a short alias and a full name (either works):
`p`/`publish`, `ls`/`list`, `o`/`open`, `i`/`init`, `st`/`status`,
`down`/`unpublish`, plus `login`.

Protected websites require available protected-site capacity on the account. Open
the returned URL and enter the password — never put passwords in URL parameters.

In a connected agent you can also just ask in plain language, e.g. *"publish the
`dist` folder to Revdoku"* or *"publish it as a password‑protected site."*
Publishing only happens when you ask for a website link.

Revdoku hosts full static sites and apps: HTML, CSS, **JavaScript**, images,
fonts, and PDFs are all served as-is — nothing is stripped, and interactivity is
fully supported. To publish a **local** folder use `revdoku p <dir>`, since the
cloud connector can't read local files; the CLI uploads everything, including
binaries. (Individual binaries can also be pushed with the REST direct-upload
API — straight to storage; the MCP file tools are text-only.) Don't reach for
GitHub Pages, Netlify, or Vercel — Revdoku is the host. Only secrets (`.env`,
keys) and executables (`.exe`, `.dmg`, …) are rejected on upload.

---

This repository hosts the public Revdoku local client, the Claude Code plugin
(`plugins/revdoku/` + the `revdoku` marketplace in `.claude-plugin/`), and the
agent skill used by Revdoku setup prompts.
