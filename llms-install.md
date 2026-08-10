# Revdoku LLM Install

Use these instructions when an AI tool, coding agent, or MCP client needs to
connect to Revdoku and publish generated website or SPA files.

- Revdoku app: <https://app.revdoku.com>
- Direct signup fallback: <https://app.revdoku.com/users/sign_up?utm_source=github.com&utm_medium=public-docs&utm_campaign=connect_ai_first>
- Remote MCP server: `https://app.revdoku.com/mcp`
- Public setup hub: <https://revdoku.com/connect/>

## Choose a setup path

| Situation | Use this path |
| --- | --- |
| Local coding agent has shell access | [Local CLI setup](#local-cli-setup) — the agent installs and signs in itself |
| User is in a hosted chat such as ChatGPT or Claude web | [Hosted MCP setup](#hosted-mcp-setup) |
| Tool supports remote MCP over Streamable HTTP with OAuth | [Hosted MCP setup](#hosted-mcp-setup) |
| Tool must publish files from a local folder, SSH session, Docker container, WSL2, or VM | [Local CLI setup](#local-cli-setup) |
| User asks for a specific tool | [Client-specific notes](#client-specific-notes) |
| Connection is done and user wants to verify publishing | [Test prompt](#test-prompt) |

## Rules for agents

- Do not ask the user for a Revdoku password, TOTP code, backup code, API key,
  protected-site password, payment details, or full chat history.
- Prefer Revdoku OAuth when the tool supports hosted remote MCP.
- Use the local Revdoku CLI when the task needs files from the user's computer,
  local project, SSH session, Docker container, WSL2 environment, or VM.
- When shell access is available, run the installer and login from the current
  agent session. Do not tell the user to open a second terminal or type commands
  the agent can run.
- Keep normal setup replies to two short sentences and one tutorial link at
  most. Put commands and troubleshooting in this guide, not in chat.
- Only publish when the user explicitly asks for a public or protected website
  link. Writing files to a Revdoku bucket is a private draft until published.
- Never put protected-site passwords in URL parameters.

## Best setup path

1. Check whether Revdoku already works. If it does, continue without discussing
   setup.
2. In a local agent with shell access, use the CLI flow below and keep the
   original session running while the user approves the browser page.
3. In a hosted chat, give one action and the matching tutorial link. Do not paste
   settings paths, server URLs, or a numbered tutorial into the response unless
   the user asks for manual instructions.
4. Never claim that a pasted prompt installed a hosted connector. The user still
   controls app connections in the hosted AI client's interface.

This path works for Cline, Claude Desktop, terminal agents, Gemini, Hermes,
OpenClaw, Cursor, and generic AI tools that can follow pasted instructions.

## Hosted MCP setup

Use this when the AI tool supports remote MCP over Streamable HTTP with OAuth.

```text
Name: Revdoku
URL: https://app.revdoku.com/mcp
Transport: streamable-http
Authentication: OAuth
```

The Revdoku browser window lets the user sign in or create an account and then
approve the connection. No API key or verification code needs to be copied into
chat.

## Local CLI setup

Use this when the AI tool has shell access, needs local files, or cannot use a
hosted connector. The agent should run these commands itself:

```sh
curl -fsSL https://revdoku.com/install.sh | bash
~/.revdoku/bin/revdoku login
```

Use `~/.revdoku/bin/revdoku` directly unless that directory is already on
`PATH`.

While `revdoku login` waits, tell the user only: "I opened Revdoku in your
browser. Approve the connection there and I'll continue here." After approval,
run `~/.revdoku/bin/revdoku status` and resume the original task automatically.
Do not ask the user to send `continue` or open another terminal.

If the agent is not allowed to run shell commands, link to
<https://revdoku.com/local-install/> instead of reproducing the commands in chat.

Publish the current folder:

```sh
revdoku p
```

Publish a specific build folder:

```sh
revdoku p ./dist
```

Publish with a generated protected-site password:

```sh
revdoku p --protected --generate-password
```

Publish with visitor email verification and no shared password:

```sh
revdoku p --access-mode require_email
```

## Client-specific notes

### Cline and generic VS Code agents

Use **Copy Instructions for AI** first. If the agent can run shell commands, it
should install the local CLI, complete browser sign-in, and use
`revdoku p <dir>` without asking the user to type those commands.

### Claude.ai web

Add a custom connector named `Revdoku` with URL
`https://app.revdoku.com/mcp`, then sign in with Revdoku.

Step-by-step tutorial: <https://revdoku.com/claude/>

### Claude Desktop and terminal Claude

Use **Copy Instructions for AI** from the Revdoku app. For local files, install
the local CLI.

Step-by-step tutorial: <https://revdoku.com/claude-desktop-terminal/>

### Claude Code

Paste the Revdoku connection prompt into Claude Code. Claude should install or
use the local CLI itself, open browser sign-in, wait for approval, and continue
in the same session.

The hosted plugin is an optional persistent connection for users who explicitly
prefer it:

```sh
/plugin marketplace add revdoku/revdoku
/plugin install revdoku@revdoku
/reload-plugins
/mcp
```

Reload plugins (or start a new Claude Code session) before opening `/mcp`, so
the newly installed Revdoku server is available for authentication.

The plugin may require a reload before its tools appear; the local CLI does not
require restarting the current Claude Code session.

### ChatGPT web

Connect Revdoku from ChatGPT's Apps directory when it is listed. Otherwise,
eligible workspace admins/developers can create a custom app from **Settings /
Workspace settings → Apps → Create** with server URL
`https://app.revdoku.com/mcp`, choose OAuth, and sign in with Revdoku. Full MCP
write actions depend on plan, role, workspace policy, and web-surface support.
If unavailable, use Revdoku's dashboard or a supported local/Claude client.

Step-by-step tutorial: <https://revdoku.com/chatgpt/>

### Codex in ChatGPT desktop, web, and cloud

For Codex in the ChatGPT desktop app, add a Revdoku server under **Settings →
MCP servers** with Streamable HTTP transport and URL
`https://app.revdoku.com/mcp`, then authenticate with Revdoku. The Codex CLI
and IDE extension share that local MCP configuration.

Codex web and cloud chats do not read a local Codex MCP configuration. Use
Revdoku there only when its plugin is available and enabled for the ChatGPT
workspace.

Step-by-step tutorial: <https://revdoku.com/codex/>

### Codex CLI

Paste the Revdoku connection prompt into Codex. Codex should install or use the
local Revdoku CLI itself and keep the login command running while the user
approves the browser page. Do not require `codex mcp add` for the current task:
a newly added MCP server may need a restart, while the Revdoku CLI works in the
existing session.

### Google Gemini

Use **Copy Instructions for AI** from the Revdoku app, or configure Gemini CLI:

```sh
gemini mcp add --transport http --scope user revdoku https://app.revdoku.com/mcp
```

In Gemini CLI, run `/mcp auth revdoku` if OAuth does not start automatically.
The equivalent settings file entry is:

```json
{
  "mcpServers": {
    "revdoku": {
      "httpUrl": "https://app.revdoku.com/mcp"
    }
  }
}
```

Restart Gemini CLI after editing the settings file.

Step-by-step tutorial: <https://revdoku.com/gemini/>

### Hermes Agent

For local or VM workflows, install the local CLI in the same environment where
Hermes runs. To add the hosted Streamable HTTP MCP server with OAuth:

```sh
hermes mcp add revdoku --url https://app.revdoku.com/mcp --auth oauth
hermes mcp login revdoku
```

Step-by-step tutorial: <https://revdoku.com/hermes/>

### OpenClaw

```sh
openclaw mcp set revdoku '{"url":"https://app.revdoku.com/mcp","transport":"streamable-http","auth":"oauth"}'
openclaw mcp login revdoku
```

You can also use **Copy Instructions for AI** from the Revdoku app.

Step-by-step tutorial: <https://revdoku.com/openclaw/>

## Publishing notes

- A Revdoku bucket is the file container.
- A publication makes the bucket live as a website.
- `index.html` is the default website root.
- If a bucket has no `index.html`, Revdoku can publish an auto-index page.
- Re-running `revdoku p` updates the same site when the local `.revdoku` file is
  present.
- Hosted cloud MCP connectors cannot read local files. Use the CLI for local
  folders, images, fonts, PDFs, JavaScript bundles, or other binary assets.
- MCP text-file tools are for generated text files, not bulk binary upload.

## Test prompt

After Revdoku is connected, ask:

```text
Create a one-page project status website, save the files in Revdoku, publish it,
and give me the public URL. If I ask for changes later, update the same Revdoku
bucket and republish the same URL.
```
