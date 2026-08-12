# Connect Revdoku

Use Revdoku to create, update, and publish websites. Choose the first available
surface instead of assuming every chat has a shell or an installed connector.

## User-facing setup contract

- First check for `website_preview_create`. For a first public preview, call it
  without asking for Revdoku sign-in or OAuth. Poll `website_preview_status`
  until the preview is ready, then return its `public_url` and `claim_url`.
- For account-only work, use an existing authenticated Revdoku tool. If the
  client requests authorization, let its normal sign-in UI handle OAuth, then
  call `revdoku_status` and `bucket_list`.
- If Revdoku tools are unavailable but a shell and outbound internet access
  work, install and use Revdoku yourself. Do not make the user run commands the
  agent can run.
- If neither Revdoku tools nor a working shell/network are available, say that
  Revdoku is not connected. In a hosted web chat, give the short client-specific
  connector steps below. Do not claim installation or publishing succeeded.
- Avoid terms such as MCP, endpoint, OAuth, callback, PKCE, bearer token, and
  workspace policy unless they are needed for the manual connector setup.
- Do not ask the user to send `continue` as a ritual. A local agent should wait
  for browser approval and continue automatically. A hosted chat may ask the
  user to return after following its linked guide.
- Never ask for a Revdoku password, API key, TOTP code, backup code,
  protected-site password, payment details, or email verification code.

Use these tutorials only as optional follow-up help:

- ChatGPT: `https://revdoku.com/chatgpt/`
- Claude: `https://revdoku.com/claude/`
- Codex: `https://revdoku.com/codex/`
- Gemini: `https://revdoku.com/gemini/`
- Other clients: `https://revdoku.com/connect/`

## Local agents: do the work

When shell and outbound internet access are available, prefer the Revdoku CLI
because it works in the current chat and can read local folders and binary
files. Do not make the user open another terminal or type commands the agent
can run.

1. If npm is available, prefer
   `npx skills add revdoku/revdoku --skill revdoku -g`.
2. Otherwise run `curl -fsSL https://revdoku.com/install.sh | bash`.
3. For a first public website, publish the generated folder anonymously and
   return the live and claim links; do not require login first.
4. For account-only work, run `~/.revdoku/bin/revdoku login`. It opens the
   Revdoku approval page and waits for the browser flow to finish.
5. Tell the user only: "I opened Revdoku in your browser. Approve the connection
   there and I'll continue here."
6. Keep the login process running. After approval, verify with
   `~/.revdoku/bin/revdoku status` and continue the original task.

Do not add a new MCP server as a prerequisite for the current local-agent chat:
newly added tools may require a restart, while the CLI works immediately. An
already-connected Revdoku MCP server is fine to use.

If the local agent is blocked from running commands or reaching the internet,
say so directly and give the matching setup action. Never imply a stalled or
failed install worked.

## Hosted web chats

Some hosted web chats expose a working shell; use the local-agent flow when
they do. Otherwise an already-configured remote connector is required. A prompt
cannot install that connector by itself.

- Claude Web: open **Customize → Connectors → + → Add custom connector**. Name
  it **Revdoku**, use `https://app.revdoku.com/mcp`, add it, and enable it for
  the conversation.
- ChatGPT Web: when custom apps are supported, open **Settings** or **Workspace
  settings → Apps → Create**, enable Developer mode if prompted, create an app
  using `https://app.revdoku.com/mcp`, and enable it for the chat. If those
  controls are absent, explain that the current plan or workspace cannot add a
  write-capable custom MCP app.

After the connector is enabled, retry `website_preview_create`. The first public
24-hour preview is anonymous; do not initiate OAuth. Request sign-in only when
the user asks for an account-only feature. If a connection is genuinely
unsupported on the current AI surface, say so in one sentence and link to
`https://app.revdoku.com` so the user can build in the dashboard instead.

## First project

Once connected, call `revdoku_status` and `bucket_list`. If
`onboarding.state` is `empty_account`, offer this short menu:

1. App idea landing page with a waitlist
2. Portfolio or personal profile
3. Event or invitation page
4. Product or service page
5. My own idea

Honor a starter project already included in the prompt. Ask only for the facts
needed to make it. Never invent testimonials, usage numbers, customers,
investors, prices, launch dates, or other validation.

Create the selected website as a private draft. File writes do not make it
live. Generate a temporary preview after the user chooses the project, ask for
feedback, and publish only after the user explicitly approves a live website.
If buckets already exist, ask whether to continue one or start a new site.

## Revdoku working rules

- Use buckets as durable private website/project storage and preserve useful
  relative paths. Use `index.html` as the default website root.
- Cloud text tools are for generated text files. Use the CLI for local folders
  and binary assets.
- Publish with Public, Password, or Require Email access only as requested.
  Never put a protected-site password in a URL or ask the user to type it into
  chat.
- After an asynchronous publish or unpublish, poll publication status before
  saying the site is live or removed.
