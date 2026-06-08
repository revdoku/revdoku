Connect this AI agent or MCP client to Revdoku — signing in to my existing account or creating a new one — so it can create, update, and publish websites with Revdoku.

User action: paste this whole message into the agent chat or connector setup. Do not share your Revdoku password or an API key.

Revdoku app: https://app.revdoku.com
Hosted MCP connector URL: https://app.revdoku.com/mcp
Claude setup guide: https://revdoku.com/claude
ChatGPT setup guide: https://revdoku.com/chatgpt
Create a Revdoku account: https://app.revdoku.com/users/sign_up?utm_source=prompt&utm_medium=agent_chat&utm_campaign=agent_connect
Sign in to Revdoku: https://app.revdoku.com/users/sign_in?utm_source=prompt&utm_medium=agent_chat&utm_campaign=agent_connect
Unsupported client fallback: https://app.revdoku.com/users/sign_in?utm_source=prompt&utm_medium=agent_chat&utm_campaign=unsupported_agent

Agent instructions:
1. If Revdoku MCP tools are already available, use them directly. If authorization is required, follow the MCP OAuth flow shown by the client.
2. For Claude.ai, ChatGPT, or another cloud product with custom remote MCP connectors, add connector name "Revdoku" with URL https://app.revdoku.com/mcp, complete Revdoku OAuth, then return here. Do not ask for my Revdoku password, API key, one-time grant, or emailed code in a cloud chat.
3. If a cloud connector is unavailable, or this task needs files from my computer, local project, SSH, Docker, WSL2, or a VM, use a local agent and install the Revdoku client if needed:
   curl -fsSL https://revdoku.com/install.sh | bash
4. Authenticate against https://app.revdoku.com. If this prompt includes a one-time grant, exchange it first. Otherwise ask for my account email, request an email code from /api/v1/agent_auth/request_code (this signs me in, or creates a new Revdoku account if I do not have one yet), ask me for the emailed code, then verify it with /api/v1/agent_auth/verify_code. If no code arrives or verification fails, ask me to sign in at https://app.revdoku.com/users/sign_in?utm_source=prompt&utm_medium=agent_chat&utm_campaign=agent_connect and copy a one-time connection prompt/grant. Do not ask for my Revdoku password, TOTP, backup codes, payment details, API key, or full chat history.
5. Store the returned revdoku_ API key securely in the local Revdoku credentials store or the agent's secret storage. Do not print, paste, or log the API key.
6. Use Revdoku buckets as durable private website/project storage. Preserve useful relative paths and use index.html as the default website root unless I ask for another entrypoint.
7. Publish only when I explicitly ask for a website link. Public and password-protected publishing are different paths: use bucket_publish for public websites and bucket_publish_password_protected when I ask for a protected/password/private website. If I ask for a bucket description while publishing, pass description on the publish tool or update the bucket first; password and password+email gates show the bucket description under the title. Use access_mode password_ask_info when I ask visitors to enter email before the password. After protected publish, give me the website URL and password/share text returned by Revdoku. Never ask me to type a protected-site password in chat, and never put the password in the URL.
8. If I ask to open Revdoku or manage access, create a one-time browser login link. Use /buckets for the dashboard and /account/access for access. If Revdoku says browser login links are disabled because two-factor authentication is enabled or required, tell me to open Revdoku through the normal browser sign-in flow instead.
