# REVDOKU

Publish websites from Claude, ChatGPT, Codex, Gemini, and other AI agents using Revdoku.
A few seconds from idea to a live website you can share — `revdoku p` and you
have a URL. Nothing goes live until you publish (use `--draft` to store privately).

Create a free account: <https://revdoku.com>

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
| [ChatGPT web](#chatgpt-web) | Custom app/connector with Revdoku OAuth |
| [Codex web](#codex-web) | Hosted MCP server in Codex settings |
| [Codex Desktop](#codex-desktop) | Copy Instructions for AI |
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
```

Step-by-step tutorial: <https://revdoku.com/claude-desktop-terminal/>.

<a id="claude-cli-claude-code"></a>

### Claude CLI / Claude Code

Install the Claude Code plugin:

```sh
/plugin marketplace add revdoku/revdoku
/plugin install revdoku@revdoku
/mcp
```

You can also use **Copy Instructions for AI** from the Revdoku app and paste the
prompt into a terminal Claude session. Step-by-step tutorial:
<https://revdoku.com/claude-desktop-terminal/>.

<a id="chatgpt-web"></a>

### ChatGPT Web

Create a custom app/connector named `Revdoku` with server URL:

```text
https://app.revdoku.com/mcp
```

Use OAuth, sign in with Revdoku, then pick Revdoku in a new chat or ask
ChatGPT to `publish with Revdoku`. Step-by-step tutorial:
<https://revdoku.com/chatgpt/>.

<a id="codex-web"></a>

### Codex Web

Add a Revdoku MCP server in Codex settings:

```text
Name: Revdoku
Transport: Streamable HTTP
URL: https://app.revdoku.com/mcp
```

Authenticate with Revdoku when prompted. Step-by-step tutorial:
<https://revdoku.com/codex/>.

<a id="codex-desktop"></a>

### Codex Desktop

Sign in to Revdoku at <https://app.revdoku.com>, click **New** (or **+** on
mobile), choose **Copy Instructions for AI**, and paste the copied prompt into
Codex Desktop. Step-by-step tutorial: <https://revdoku.com/codex/>.

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
```

If your Hermes runtime supports remote Streamable HTTP MCP with OAuth, add:

```text
Name: Revdoku
URL: https://app.revdoku.com/mcp
Transport: streamable-http
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
```

Machine-oriented setup notes: [`llms-install.md`](./llms-install.md).

<a id="openclaw"></a>

### OpenClaw

```sh
openclaw mcp set revdoku '{"url":"https://app.revdoku.com/mcp","transport":"streamable-http"}'
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
```

Then paste **Copy Instructions for AI** from the Revdoku app, or publish
directly (below).

## Publish a website

```sh
revdoku p                 # publish the current folder -> live URL
revdoku p ./dist          # publish a specific folder
revdoku p --protected --generate-password   # password-protected site
```

Re-running `revdoku p` updates the **same** site (the bucket is remembered in a
local `.revdoku` file). `revdoku open` opens it in a browser; `revdoku ls` lists
your sites; `revdoku --help` shows every command. Start a new project with
`revdoku init`.

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
