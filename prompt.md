Connect this coding agent to my Revdoku account.

User action: paste this whole message into the agent chat. Do not share your Revdoku password or an API key.

Revdoku app: https://app.revdoku.com

Agent instructions for Codex, Claude Code, Claude Desktop, ChatGPT, or another coding agent:
1. If this is a cloud chat, use Revdoku only when the Revdoku MCP connector is available to this chat. If the connector is not available, ask me to run the local install command on my computer instead of trying to use files from the cloud environment.
2. If this agent can run shell commands on my computer and the Revdoku client tooling is not installed, install it with:
   curl -fsSL https://revdoku.com/install.sh | bash
3. Start Revdoku agent authentication against https://app.revdoku.com.
4. Request an email code from /api/v1/agent_auth/request_code.
5. Ask me for the emailed code, then verify it with /api/v1/agent_auth/verify_code.
6. Store the returned revdoku_ API key securely in the local Revdoku credentials store or the agent's secret storage.
7. Use that key to store, read, and update private workspace files in Revdoku. Publish a workspace only when I explicitly ask for a public link. New account connections get read/write access to normal workspaces and read access to the Library workspace by default.
8. When creating a workspace, choose a short descriptive title, add a concise description, and assign relevant existing labels. With MCP, call workspace_tag_list before choosing labels; otherwise call GET /api/v1/tags. Prefer simple labels such as website, draft, ai-agent, or slash groups such as projects/work.
9. If I ask to open the Revdoku dashboard, manage access, agents, API keys, or pricing, create a one-time browser login link. Use /workspaces for the dashboard, /account/access for access, and /pricing for plans. Tell me the link is single-use and expires quickly; if shown in a terminal, I can usually Cmd-click it on macOS or Ctrl-click it on Windows/Linux.

Unsupported online chat fallback:
- If this is ChatGPT, Claude.ai, Gemini, or another web-only chat that cannot use a Revdoku MCP connector and cannot run shell commands on the user's computer, do not attempt to connect Revdoku from the cloud chat.
- Tell the user this chat cannot connect to Revdoku yet, then direct them to sign up or open Revdoku here: https://app.revdoku.com/users/sign_up?utm_source=prompt&utm_medium=agent_chat&utm_campaign=unsupported_agent
- After that, suggest using Revdoku from a supported local agent such as Codex, Claude Code, Claude Desktop, or another coding agent that can install the Revdoku client or use the Revdoku MCP connector.

Do not print, paste, or log the API key.
