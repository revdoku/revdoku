Connect this AI agent or MCP client to my Revdoku account.

User action: paste this whole message into the agent chat or connector setup. Do not share your Revdoku password or an API key.

Revdoku app: https://app.revdoku.com
Hosted MCP connector URL: https://app.revdoku.com/mcp
Claude setup guide: https://revdoku.com/claude
ChatGPT setup guide: https://revdoku.com/chatgpt

Agent instructions for Codex, Claude Code, Claude Desktop, Claude.ai, ChatGPT, or another AI agent:
1. First identify whether this is a cloud chat/custom connector, a local agent running on my computer, or an MCP client that already has Revdoku tools available. Do not say Revdoku is unavailable just because the connector has not been added yet.
2. If Revdoku MCP tools are already available in this chat, use them directly. If the tools require authorization, follow the MCP OAuth flow shown by the client.
3. If this is Claude.ai, ChatGPT, or another cloud product that supports custom remote MCP connectors, guide me through adding Revdoku as a custom MCP connector instead of trying to run shell commands. Use connector name "Revdoku" and connector URL https://app.revdoku.com/mcp. For product-specific setup steps, point me to https://revdoku.com/claude for Claude or https://revdoku.com/chatgpt for ChatGPT. Tell me to complete the Revdoku OAuth login and consent screen, then return to this chat and say that Revdoku is connected. Do not ask for my Revdoku password, API key, one-time grant, or emailed code in a cloud chat.
4. Cloud MCP works well for files generated in chat or already stored in Revdoku. A local agent such as Codex CLI, Claude Code, or Claude Desktop is better when the task needs files from my computer or a local project folder.
5. If this cloud chat or current account plan cannot add custom remote MCP connectors, say that this chat cannot connect to Revdoku directly from this surface yet. Direct me to open Revdoku here: https://app.revdoku.com/users/sign_up?utm_source=prompt&utm_medium=agent_chat&utm_campaign=unsupported_agent, then suggest using a local agent such as Codex CLI, Claude Code, Claude Desktop, or another local MCP-capable coding agent.
6. If this agent can run shell commands on my computer and the Revdoku client tooling is not installed, install it with:
   curl -fsSL https://revdoku.com/install.sh | bash
7. Start Revdoku agent authentication against https://app.revdoku.com.
8. If this prompt includes a one-time grant, exchange that grant first using the local Revdoku MCP tool or CLI command shown in the grant details.
9. If no one-time grant is available, request an email code from /api/v1/agent_auth/request_code, ask me for the emailed code, then verify it with /api/v1/agent_auth/verify_code.
10. Store the returned revdoku_ API key securely in the local Revdoku credentials store or the agent's secret storage.
11. Use that key to store, read, and update private workspace files in Revdoku. If you call the HTTP API directly, send agent identification headers such as X-Revdoku-Agent, X-Revdoku-Agent-Client, X-Revdoku-Agent-Version, and X-Revdoku-Agent-Task so Revdoku can show changes as agent activity instead of plain user activity. Publish a workspace only when I explicitly ask for a public link. When publishing a website, create or update index.html as the default root page unless I ask for a different entrypoint. New account connections get read/write access to normal workspaces and read access to the Library workspace by default.
12. When creating a workspace, choose a short descriptive title, add a concise description, and assign relevant existing labels. With MCP, call workspace_tag_list before choosing labels; otherwise call GET /api/v1/tags. Prefer simple labels such as website, draft, ai-agent, or slash groups such as projects/work.
13. If I ask to open the Revdoku dashboard, manage access, agents, API keys, or pricing, create a one-time browser login link. Use /workspaces for the dashboard, /account/access for access, and /pricing for plans. Tell me the link is single-use and expires quickly; if shown in a terminal, I can usually Cmd-click it on macOS or Ctrl-click it on Windows/Linux.

Do not print, paste, or log the API key.
