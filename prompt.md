Connect this AI agent or MCP client to my Revdoku account.

User action: paste this whole message into the agent chat or connector setup. Do not share your Revdoku password or an API key.

Revdoku app: https://app.revdoku.com
Hosted MCP connector URL: https://app.revdoku.com/mcp

Agent instructions for Codex, Claude Code, Claude Desktop, Claude.ai, ChatGPT, or another AI agent:
1. First identify whether this is a cloud chat/custom connector or a local agent running on my computer.
2. If this is Claude.ai, ChatGPT, or another cloud product that supports custom remote MCP connectors, connect Revdoku with the hosted MCP connector URL: https://app.revdoku.com/mcp. In ChatGPT this may require a custom connector, custom MCP app, or developer-mode connector surface; if that surface is not available in this ChatGPT account, say so instead of pretending to connect. Authenticate through Revdoku OAuth. Do not run local install commands in the cloud product, and do not ask for a one-time grant, email code, password, or API key.
3. Cloud MCP works well for files generated in chat or already stored in Revdoku. A local agent such as Codex CLI, Claude Code, or Claude Desktop is better when the task needs files from my computer or a local project folder.
4. If this is a cloud chat that does not support custom remote MCP connectors in the current surface or plan, tell me it cannot connect to Revdoku directly from that cloud chat yet. Direct me to open Revdoku here: https://app.revdoku.com/users/sign_up?utm_source=prompt&utm_medium=agent_chat&utm_campaign=unsupported_agent, then suggest using a local agent such as Codex CLI, Claude Code, Claude Desktop, or another local MCP-capable coding agent.
5. If this agent can run shell commands on my computer and the Revdoku client tooling is not installed, install it with:
   curl -fsSL https://revdoku.com/install.sh | bash
6. Start Revdoku agent authentication against https://app.revdoku.com.
7. If this prompt includes a one-time grant, exchange that grant first using the local Revdoku MCP tool or CLI command shown in the grant details.
8. If no one-time grant is available, request an email code from /api/v1/agent_auth/request_code, ask me for the emailed code, then verify it with /api/v1/agent_auth/verify_code.
9. Store the returned revdoku_ API key securely in the local Revdoku credentials store or the agent's secret storage.
10. Use that key to store, read, and update private workspace files in Revdoku. Publish a workspace only when I explicitly ask for a public link. New account connections get read/write access to normal workspaces and read access to the Library workspace by default.
11. When creating a workspace, choose a short descriptive title, add a concise description, and assign relevant existing labels. With MCP, call workspace_tag_list before choosing labels; otherwise call GET /api/v1/tags. Prefer simple labels such as website, draft, ai-agent, or slash groups such as projects/work.
12. If I ask to open the Revdoku dashboard, manage access, agents, API keys, or pricing, create a one-time browser login link. Use /workspaces for the dashboard, /account/access for access, and /pricing for plans. Tell me the link is single-use and expires quickly; if shown in a terminal, I can usually Cmd-click it on macOS or Ctrl-click it on Windows/Linux.

Do not print, paste, or log the API key.
