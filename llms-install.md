# Revdoku LLM Install

Use these instructions when an AI tool, coding agent, or MCP client needs to
connect to Revdoku and publish generated websites or app files.

- Revdoku app: <https://app.revdoku.com>
- Remote MCP server: `https://app.revdoku.com/mcp`
- Public setup hub: <https://revdoku.com/connect/>

## Choose a setup path

| Situation | Use this path |
| --- | --- |
| User is in Cline, Cursor, Claude Desktop, Gemini, Hermes, OpenClaw, or another generic AI tool | [Best setup path](#best-setup-path): Copy Instructions for AI |
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
- Only publish when the user explicitly asks for a public or protected website
  link. Writing files to a Revdoku bucket is a private draft until published.
- Never put protected-site passwords in URL parameters.

## Best setup path

1. Ask the user to sign in at <https://app.revdoku.com>.
2. In Revdoku, the user clicks **New** (or **+** on mobile).
3. The user chooses **Copy Instructions for AI**.
4. The user pastes the copied prompt into the AI tool.
5. Follow the copied prompt exactly and complete Revdoku OAuth or browser device
   sign-in before using Revdoku actions.

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

The user signs in with Revdoku and approves the connection. No API key needs to
be copied into chat.

## Local CLI setup

Use this when the AI tool needs local files or when hosted remote MCP is not
available.

```sh
curl -fsSL https://revdoku.com/install.sh | bash
revdoku --login
```

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

## Client-specific notes

### Cline and generic VS Code agents

Use **Copy Instructions for AI** first. If Cline is allowed to run shell
commands, install the local CLI and use `revdoku p <dir>` for local project
files. If the Cline environment supports remote MCP with OAuth, configure the
hosted MCP server at `https://app.revdoku.com/mcp`.

### Claude.ai web

Add a custom connector named `Revdoku` with URL
`https://app.revdoku.com/mcp`, then sign in with Revdoku.

Step-by-step tutorial: <https://revdoku.com/claude/>

### Claude Desktop and terminal Claude

Use **Copy Instructions for AI** from the Revdoku app. For local files, install
the local CLI.

Step-by-step tutorial: <https://revdoku.com/claude-desktop-terminal/>

### Claude Code

Use the plugin path:

```sh
/plugin marketplace add revdoku/revdoku
/plugin install revdoku@revdoku
/mcp
```

The copied Revdoku prompt also works in a Claude Code session.

### ChatGPT web

Create a custom app/connector named `Revdoku` with server URL
`https://app.revdoku.com/mcp`, choose OAuth, then sign in with Revdoku.

Step-by-step tutorial: <https://revdoku.com/chatgpt/>

### Codex web and Codex Desktop

For Codex web, add a Revdoku MCP server with Streamable HTTP transport and URL
`https://app.revdoku.com/mcp`.

For Codex Desktop, use **Copy Instructions for AI** from the Revdoku app.

Step-by-step tutorial: <https://revdoku.com/codex/>

### Codex CLI

```sh
codex mcp add revdoku --url https://app.revdoku.com/mcp
codex mcp login revdoku
```

### Google Gemini

Use **Copy Instructions for AI** from the Revdoku app, or configure Gemini CLI:

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
Hermes runs. If Hermes supports remote Streamable HTTP MCP with OAuth, add the
hosted MCP server.

Step-by-step tutorial: <https://revdoku.com/hermes/>

### OpenClaw

```sh
openclaw mcp set revdoku '{"url":"https://app.revdoku.com/mcp","transport":"streamable-http"}'
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
