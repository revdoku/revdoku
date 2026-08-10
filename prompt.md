# Connect Revdoku

Use Revdoku to create, update, and publish websites. Never ask the user to paste
a Revdoku password, API key, TOTP code, backup code, protected-site password,
payment details, or email verification code into chat.

## Start with capability detection

First check whether Revdoku tools are already available in this conversation.
If they are, call `revdoku_status` and `bucket_list` immediately. Do not ask the
user to sign in again merely because the account has no buckets.

If the tools are absent, do not claim that a chat message installed or connected
Revdoku. Connection is a user-controlled setting in the AI client. Give the
shortest applicable setup instructions below, wait for the user to finish them,
then check for the tools again.

## Cloud AI clients

Use the hosted MCP endpoint `https://app.revdoku.com/mcp`.

- **ChatGPT:** First look for Revdoku in the Apps directory and connect the app
  if it is available. Otherwise, eligible workspace admins/developers can create
  a custom MCP app from Settings or Workspace settings → Apps → Create. Full MCP
  write actions depend on plan, role, workspace policy, and web-surface support.
  If custom write-capable apps are unavailable, say so plainly and use Revdoku's
  dashboard or another supported client; a pasted prompt cannot bypass that limit.
- **Claude:** Open Customize → Connectors, add a custom connector named Revdoku
  with the hosted MCP endpoint, complete OAuth, then enable Revdoku for this
  conversation from the + / Connectors menu. Team and Enterprise workspaces may
  require an owner to add the connector first.
- **Gemini:** Add the hosted endpoint as a custom Connected App only when the
  current Gemini surface and account expose that MCP feature. Otherwise use the
  dashboard or a supported local client.
- **Other cloud clients:** Use their remote HTTP MCP setup only when they support
  OAuth and write-capable tools.

Revdoku OAuth is the signup and sign-in flow: an existing user signs in, while a
new user verifies the email and gets an account before approving the connection.
Only a Revdoku account owner or administrator can approve a whole-account AI
connection.
Do not send the user through a separate signup first. The authorization request
already carries the AI client's callback, state, and PKCE challenge. After the
user signs in or verifies a new account and approves access, Revdoku returns a
one-time authorization code to that callback; the AI client exchanges it and
stores the connection. Never put a bearer token, API key, or verification code
in a signup URL.

Ask the user to return to the original chat after approval and send "continue".
The OAuth callback may not replay the original message automatically. If Revdoku
tools are not visible in that conversation, ask the user to enable or select
Revdoku there, or start a new chat. Do not send the user through signup again;
reconnect only if the client explicitly reports that authorization expired or
is invalid.

If the current AI cannot connect Revdoku, offer this dashboard fallback with an
allowed `onboarding_source` (`chatgpt`, `claude`, `codex`, `gemini`, or `other`):

`https://app.revdoku.com/users/sign_up?onboarding_source=other&utm_medium=ai-chat&utm_campaign=connect_ai_first`

When a starter choice is known, also add `onboarding_project` with one of
`app_idea`, `portfolio`, `event_page`, `product_service`, or `own_idea`. Explain
that this fallback creates a Revdoku account and lets the user build the first
site in the dashboard; it does not connect the AI client.

## Local agents and the CLI

Prefer the local client's MCP integration when available:

- **Claude Code:** ask the user to run `/plugin marketplace add revdoku/revdoku`,
  `/plugin install revdoku@revdoku`, `/reload-plugins`, then `/mcp` and
  authenticate Revdoku. Starting a new Claude Code session can replace
  `/reload-plugins`.
- **Codex CLI/Desktop/IDE:** use
  `codex mcp add revdoku --url https://app.revdoku.com/mcp`, then
  `codex mcp login revdoku`. These local Codex surfaces share MCP configuration.

For a task that needs local folders or binary files, or as a local MCP fallback,
use the official CLI setup guide at `https://revdoku.com/local-install/`:

```sh
curl -fsSL https://revdoku.com/install.sh | bash
~/.revdoku/bin/revdoku login
```

Ask the user to complete browser device sign-in and approve the account shown on
the Revdoku consent screen. The client stores its credential securely in
`~/.revdoku/credentials`; never print or repeat it. Verify with
`~/.revdoku/bin/revdoku status`. Use the privacy-preserving email-code endpoint
only as a fallback for an existing account; it does not create accounts.

## First project

Once connected, call `revdoku_status` and `bucket_list`. If
`onboarding.state` is `empty_account`, offer this short menu instead of ending
with a broad question:

1. App idea landing page with a waitlist
2. Portfolio or personal profile
3. Event or invitation page
4. Product or service page
5. My own idea

These are starter project briefs. The dashboard shows previewable sample sites
for the first four choices; "My own idea" starts without a fixed template. In an
AI chat, personalize the selected brief instead of presenting a generic sample
as the finished site.

Honor a starter project already included in the prompt. Ask only for the facts
needed to make it. For an app idea, ask for the working name, problem, intended
users, up to three benefits or features, call to action, and visual direction.
Never invent testimonials, usage numbers, customers, investors, prices, launch
dates, or other validation.

Create the selected website as a private draft. File writes do not make it live.
Generate a temporary preview only after the user chooses the project, ask for
feedback, and publish only after the user explicitly approves a live website.
If buckets already exist, ask whether to continue one or start a new site.

## Revdoku working rules

- Use buckets as durable private website/project storage and preserve useful
  relative paths. Use `index.html` as the default website root.
- Cloud MCP text tools are for generated text files. Use the CLI for local folders
  and binary assets.
- Publish with Public, Password, or Require Email access only as requested. Never
  put a protected-site password in a URL or ask the user to type it into chat.
- After any asynchronous publish or unpublish, poll publication status before
  saying the site is live or removed.
