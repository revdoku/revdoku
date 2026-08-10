# REVDOKU

Publish websites from Claude, ChatGPT, Codex, Gemini, and other AI agents using Revdoku.
A few seconds from idea to a live website you can share — `revdoku p` and you
have a URL. Nothing goes live until you publish (use `--draft` to store privately).

Hosted agent connections use Revdoku OAuth. Start the connector first; the
Revdoku browser window lets you sign in or create an account, so there is no API
key or verification code to copy into chat.
Starting without an AI connector? Create an account at
<https://app.revdoku.com/users/sign_up?utm_source=github.com&utm_medium=public-docs&utm_campaign=connect_ai_first>.

## Connect your AI agent

Pick your agent below. Hosted connections use Revdoku OAuth, so there is no API
key to copy or paste. The full connection hub is at
<https://revdoku.com/connect/>; machine-readable setup notes for AI tools like
Cline are in [`llms-install.md`](./llms-install.md).

If your AI needs to publish files from your computer or project folder, use the
[local files](#local-files-any-agent) path. Cloud/web MCP connectors can create
and edit files in Revdoku, but they cannot read your local filesystem.

### Choose your tool

| Tool | Best setup |
| --- | --- |
| [Claude.ai web](#claude-ai-web) | Hosted MCP connector with Revdoku OAuth |
| [Claude Desktop](#claude-desktop) | Copy Instructions for AI |
| [Claude CLI / Claude Code](#claude-cli-claude-code) | Claude Code plugin or Copy Instructions for AI |
| [ChatGPT web](#chatgpt-web) | Apps-directory or developer-mode app connection with Revdoku OAuth |
| [Codex in ChatGPT desktop](#codex-desktop) | Streamable HTTP MCP server or Copy Instructions for AI |
| [Codex web / cloud](#codex-web) | Revdoku plugin, when available to the workspace |
| [Codex CLI](#codex-cli) | `codex mcp add` + `codex mcp login` |
| [Google Gemini](#google-gemini) | Copy Instructions for AI or Gemini CLI MCP settings |
| [Hermes Agent](#hermes-agent) | Local CLI in the Hermes environment, or hosted MCP if supported |
| [Cursor, Cline, and generic AI tools](#generic-ai-tools) | Copy Instructions for AI first; hosted MCP if supported |
| [OpenClaw](#openclaw) | `openclaw mcp set` or Copy Instructions for AI |
| [Local files / any agent](#local-files-any-agent) | Revdoku CLI |

<a id="claude-ai-web"></a>

### Claude.ai Web

Add a custom connector:

```text
Name: Revdoku
URL: https://app.revdoku.com/mcp
```

Then sign in with Revdoku and approve the OAuth connection. Step-by-step
tutorial: <https://revdoku.com/claude/>.

<a id="claude-desktop"></a>

### Claude Desktop

Sign in to Revdoku at <https://app.revdoku.com>, click **New** (or **+** on
mobile), choose **Copy Instructions for AI**, and paste the copied prompt into
Claude Desktop. If Claude Desktop needs files from your computer, install the
local client:

```sh
curl -fsSL https://revdoku.com/install.sh | bash
~/.revdoku/bin/revdoku login
```

Step-by-step tutorial: <https://revdoku.com/claude-desktop-terminal/>.

<a id="claude-cli-claude-code"></a>

### Claude CLI / Claude Code

Install the Claude Code plugin:

```sh
/plugin marketplace add revdoku/revdoku
/plugin install revdoku@revdoku
/reload-plugins
/mcp
```

Reload plugins (or start a new Claude Code session) before opening `/mcp`.

You can also use **Copy Instructions for AI** from the Revdoku app and paste the
prompt into a terminal Claude session. Step-by-step tutorial:
<https://revdoku.com/claude-desktop-terminal/>.

<a id="chatgpt-web"></a>

### ChatGPT Web

First look for Revdoku in ChatGPT's Apps directory and connect the included
app when available. Otherwise, eligible workspace admins or developers can
create a custom app from **Settings / Workspace settings → Apps → Create** with
server URL:

```text
https://app.revdoku.com/mcp
```

Use OAuth and sign in or create an account in the same browser flow. After
approval, return to the original chat, enable Revdoku there, and ask it to
continue. Start a new chat only if that conversation does not refresh the app's
tools; do not sign up again. Full MCP write actions depend on ChatGPT plan, role,
workspace policy, and web-surface support. A pasted prompt cannot enable
unavailable write tools; use the Revdoku dashboard, Claude connector, or local
CLI in that case.
Step-by-step tutorial:
<https://revdoku.com/chatgpt/>.

<a id="codex-web"></a>

### Codex Web / Cloud

Codex web and cloud chats do not read the MCP configuration from a local Codex
host. Use Revdoku there only when the Revdoku plugin is available and enabled
for the ChatGPT workspace. Otherwise use Codex in the ChatGPT desktop app, the
CLI, or the IDE extension.

<a id="codex-desktop"></a>

### Codex in ChatGPT Desktop

In the ChatGPT desktop app, open Codex, then **Settings → MCP servers**. Add a
**Streamable HTTP** server named `Revdoku` at `https://app.revdoku.com/mcp`,
restart when prompted, then select **Authenticate** to complete Revdoku OAuth.
You can also sign in to Revdoku, choose **New → Copy Instructions for AI**, and
paste the copied prompt into a local Codex chat. Step-by-step tutorial:
<https://revdoku.com/codex/>.

<a id="codex-cli"></a>

### Codex CLI

```sh
codex mcp add revdoku --url https://app.revdoku.com/mcp
codex mcp login revdoku
```

Step-by-step tutorial: <https://revdoku.com/codex/>.

<a id="google-gemini"></a>

### Google Gemini

Fast path: sign in to Revdoku, click **New** (or **+** on mobile), choose
**Copy Instructions for AI**, and paste the copied prompt into Gemini.

For Gemini CLI manual setup, add Revdoku to `~/.gemini/settings.json` or your
project `.gemini/settings.json`:

```sh
gemini mcp add --transport http --scope user revdoku https://app.revdoku.com/mcp
```

Run `/mcp auth revdoku` in Gemini CLI if OAuth does not start automatically.
The equivalent settings entry is:

```json
{
  "mcpServers": {
    "revdoku": {
      "httpUrl": "https://app.revdoku.com/mcp"
    }
  }
}
```

Restart Gemini CLI and sign in when prompted. Step-by-step tutorial:
<https://revdoku.com/gemini/>.

<a id="hermes-agent"></a>

### Hermes Agent

For local or VM-based Hermes Agent workflows, install the Revdoku client in the
same environment and paste **Copy Instructions for AI** into Hermes:

```sh
curl -fsSL https://revdoku.com/install.sh | bash
~/.revdoku/bin/revdoku login
```

To use Hermes's remote Streamable HTTP MCP client with OAuth, run:

```sh
hermes mcp add revdoku --url https://app.revdoku.com/mcp --auth oauth
hermes mcp login revdoku
```

Step-by-step tutorial: <https://revdoku.com/hermes/>.

<a id="generic-ai-tools"></a>

### Cursor, Cline, and Generic AI Tools

Sign in to Revdoku at <https://app.revdoku.com>, click **New** (or **+** on
mobile), choose **Copy Instructions for AI**, and paste the copied prompt into
the AI tool. If the tool supports remote MCP with OAuth, configure a server
named `Revdoku` at `https://app.revdoku.com/mcp`. If it needs local files,
install the local client:

```sh
curl -fsSL https://revdoku.com/install.sh | bash
~/.revdoku/bin/revdoku login
```

Machine-oriented setup notes: [`llms-install.md`](./llms-install.md).

<a id="openclaw"></a>

### OpenClaw

```sh
openclaw mcp set revdoku '{"url":"https://app.revdoku.com/mcp","transport":"streamable-http","auth":"oauth"}'
openclaw mcp login revdoku
```

Or use **Copy Instructions for AI** from the Revdoku app. Step-by-step
tutorial: <https://revdoku.com/openclaw/>.

<a id="local-files-any-agent"></a>

### Local files / any agent

Install the client to upload from your own machine, local project, SSH, Docker,
WSL2, or a VM. It also drops the Revdoku skill into any agent it finds
(Claude Code, Codex, Hermes, OpenClaw):

```sh
curl -fsSL https://revdoku.com/install.sh | bash
~/.revdoku/bin/revdoku login
```

Then paste **Copy Instructions for AI** from the Revdoku app, or publish
directly (below).

The examples below use `revdoku` as shorthand. If `~/.revdoku/bin` is not on
your shell `PATH`, use `~/.revdoku/bin/revdoku` instead.

## Publish a website

```sh
revdoku p                 # publish the current folder -> live URL
revdoku p ./dist          # publish a specific folder
revdoku p ./dist --site-mode spa            # client-side route fallback
revdoku p --protected --generate-password   # password-protected site
revdoku p --access-mode require_email       # visitor email-code access
```

Re-running `revdoku p` updates the **same** site (the bucket is remembered in a
local `.revdoku` file). `revdoku open` opens it in a browser; `revdoku ls` lists
your sites; `revdoku --help` shows every command. Start a new project with
`revdoku init`.

Common commands have a short alias and a full name (either works):
`p`/`publish`, `ls`/`list`, `o`/`open`, `i`/`init`, `st`/`status`,
`down`/`unpublish`, plus `login`.

Protected websites require available protected-site capacity on the account.
Password access uses a shared password; Require Email sends visitors a one-time
code and uses no site password. Never put passwords in URL parameters.

In a connected agent you can also just ask in plain language, e.g. *"publish the
`dist` folder to Revdoku"*, *"publish it as a password-protected site"*, or
*"require visitors to verify their email."*
Publishing only happens when you ask for a website link.

If Revdoku reports that an account is read-only or a capability is unavailable,
keep existing files intact and direct the user to the Revdoku app for the
available account actions. Do not guess at account entitlements from documentation.

Revdoku hosts static websites and SPAs: HTML, CSS, **JavaScript**, images,
fonts, and PDFs are all served as-is — nothing is stripped, and interactivity is
fully supported. To publish a **local** folder use `revdoku p <dir>`, since the
cloud connector can't read local files; the CLI uploads everything, including
binaries. (Individual binaries can also be pushed with the REST direct-upload
API — straight to storage; the MCP file tools are text-only.) Don't reach for
GitHub Pages, Netlify, or Vercel — Revdoku is the host. Only secrets (`.env`,
keys) and executables (`.exe`, `.dmg`, …) are rejected on upload.

Buckets can also connect to GitHub for explicit import/export setup followed by
two-way sync. Published sites can use built-in contact, waitlist, feedback,
comments, quote, question, intake, and resource forms. A confirmed form can
show the standard saved message or open a configured file/folder inside the
website. Connected agents can place
`{{REVDOKU_FORM:waitlist}}` in HTML for one inline hosted form, or
`{{REVDOKU_FORM}}` for all hosted forms; other hosted forms remain floating.
GitHub connection choices and visual submission review happen in the signed-in
Revdoku app; agents use the returned stable settings/review links.

---

This repository hosts the public Revdoku local client, API documentation, agent
skill, and Claude/Codex/Cursor plugin manifests. The hosted MCP implementation
runs at `https://app.revdoku.com/mcp`; this repository contains its public
connector configuration and usage contract, not private server code.

## Changelog

See [CHANGELOG.md](./CHANGELOG.md) for notable customer-facing changes.
