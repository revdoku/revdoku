Connect this AI agent or MCP client to my Revdoku account so it can create, update, and publish websites with Revdoku.

User action: paste this whole message into the agent chat or connector setup. Do not share your Revdoku password or an API key.

Revdoku app: https://app.revdoku.com
Hosted MCP connector URL: https://app.revdoku.com/mcp
Claude setup guide: https://revdoku.com/claude
ChatGPT setup guide: https://revdoku.com/chatgpt
Unsupported client fallback: https://app.revdoku.com/users/sign_up?utm_source=prompt&utm_medium=agent_chat&utm_campaign=unsupported_agent

Agent instructions:
1. If Revdoku MCP tools are already available, use them directly. If authorization is required, follow the MCP OAuth flow shown by the client.
2. For Claude.ai, ChatGPT, or another cloud product with custom remote MCP connectors, add connector name "Revdoku" with URL https://app.revdoku.com/mcp, complete Revdoku OAuth, then return here. Do not ask for my Revdoku password, API key, one-time grant, or emailed code in a cloud chat.
3. If a cloud connector is unavailable, or this task needs files from my computer, local project, SSH, Docker, WSL2, or a VM, use a local agent and install the Revdoku client if needed:
   curl -fsSL https://revdoku.com/install.sh | bash
4. Authenticate against https://app.revdoku.com. If this prompt includes a one-time grant, exchange it first. Otherwise request an email code from /api/v1/agent_auth/request_code, ask me for the emailed code, then verify it with /api/v1/agent_auth/verify_code.
5. Store the returned revdoku_ API key securely in the local Revdoku credentials store or the agent's secret storage. Do not print, paste, or log the API key.
6. Use Revdoku buckets as durable private website/project storage. Preserve useful relative paths and use index.html as the default website root unless I ask for another entrypoint.
7. Publish only when I explicitly ask for a website link. Public and password-protected publishing are different paths: use bucket_publish for public websites, bucket_publish_password_protected when I ask for a protected/password/private website, and never put the password in the URL.
8. If I ask to open Revdoku, manage access, or view pricing, create a one-time browser login link. Use /buckets for the dashboard, /account/access for access, and /pricing for plans. If Revdoku says browser login links are disabled because two-factor authentication is enabled or required, tell me to open Revdoku through the normal browser sign-in flow instead.
