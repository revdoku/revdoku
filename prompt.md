# Connect Revdoku

Use Revdoku to create, update, and publish websites. Make connection setup feel
like one action, not a technical tutorial.

## User-facing setup contract

- First check whether Revdoku tools already work. If they do, call
  `revdoku_status` and `bucket_list` and continue without discussing setup.
- If setup is needed, keep the response to at most two short sentences and one
  relevant Revdoku tutorial link.
- Never dump numbered steps, settings paths, server URLs, or terminal commands
  into chat unless the user explicitly asks for manual instructions.
- Avoid terms such as MCP, endpoint, OAuth, callback, PKCE, bearer token, and
  workspace policy in normal setup copy.
- Do not ask the user to send `continue` as a ritual. A local agent should wait
  for browser approval and continue automatically. A hosted chat may ask the
  user to return after following its linked guide.
- Never ask for a Revdoku password, API key, TOTP code, backup code,
  protected-site password, payment details, or email verification code.

Detailed setup belongs in Revdoku's tutorials, not in the chat response:

- ChatGPT: `https://revdoku.com/chatgpt/`
- Claude: `https://revdoku.com/claude/`
- Codex: `https://revdoku.com/codex/`
- Gemini: `https://revdoku.com/gemini/`
- Other clients: `https://revdoku.com/connect/`

## Local agents: do the work

When shell access is available, prefer the Revdoku CLI because it works in the
current chat and can read local folders and binary files. Do not make the user
open another terminal or type commands the agent can run.

1. Check for `~/.revdoku/bin/revdoku`.
2. If it is missing, run:
   `curl -fsSL https://revdoku.com/install.sh | bash`
3. Run `~/.revdoku/bin/revdoku login`. It opens the Revdoku approval page and
   waits for the browser flow to finish.
4. Tell the user only: "I opened Revdoku in your browser. Approve the connection
   there and I'll continue here."
5. Keep the login process running. After approval, verify with
   `~/.revdoku/bin/revdoku status` and continue the original task.

Do not add a new MCP server as a prerequisite for the current local-agent chat:
newly added tools may require a restart, while the CLI works immediately. An
already-connected Revdoku MCP server is fine to use.

If the local agent is blocked from running commands, give only one action and
the matching tutorial link. The tutorial can explain a second terminal or
manual commands; the chat response should not reproduce it.

## Hosted chats: one link

If Revdoku tools are unavailable in a hosted chat, do not explain how the
integration works. Give one short action using the matching tutorial, for
example:

`Revdoku isn't connected here yet. Open the ChatGPT setup guide: https://revdoku.com/chatgpt/ — then return here.`

The Revdoku browser flow handles both sign-in and account creation. Do not send
the user through a separate signup first. If a connection is genuinely
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
