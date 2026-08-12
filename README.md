# Revdoku

Publish websites from Claude, ChatGPT, Codex, Cursor, Gemini, and other AI
agents. A first public preview needs no account.

## Prompt for an AI agent

```text
I'd like you to set up Revdoku: the web hosting service for AI agents.

Install as a skill if I have npm: npx skills add revdoku/revdoku --skill revdoku -g

If not, do this instead: curl -fsSL https://revdoku.com/install.sh | bash

After installing, review the docs at https://revdoku.com/docs and ask me what I'd like to publish
```

The agent should run setup commands itself when it has shell access. It must not
send the user to a separate terminal.

## How the first publish works

1. The agent creates a public preview at a randomized Revdoku URL. No signup or
   login is needed.
2. The preview lasts 24 hours. The agent can update the same URL without
   extending that deadline.
3. Revdoku returns one browser claim link. Account creation happens only at
   `https://app.revdoku.com/users/sign_up`.
4. After email verification, the website appears in the new Free account. The
   original agent reconnects automatically on its next command.

Anonymous previews never create private buckets and do not include forms,
analytics, custom domains, or custom URLs. They are noindex and use a
`no-referrer` policy.

## Local agents

Install the public skill and CLI:

```sh
npx skills add revdoku/revdoku --skill revdoku -g
```

If npm is unavailable:

```sh
curl -fsSL https://revdoku.com/install.sh | bash
```

Publish or update the current folder:

```sh
revdoku p
```

The first unsigned run prints the preview and claim URLs. Re-running updates the
same preview. After claim, re-running exchanges Revdoku's one-time connection
grant automatically and updates the claimed website.

For a different existing account, run `revdoku login`. This is sign-in only;
new accounts are created on the web signup page.

Useful commands:

- `revdoku p [PATH]` — publish or update a website.
- `revdoku preview [PATH]` — create a review URL.
- `revdoku p [PATH] --draft` — save a private draft after sign-in.
- `revdoku p --protected` — publish with Password access on an eligible plan.
- `revdoku p --access-mode require_email` — require visitor email OTP.
- `revdoku open`, `revdoku status`, `revdoku ls`, `revdoku --help` — inspect
  the current connection and sites.

## Hosted and web agents

The hosted MCP endpoint is `https://app.revdoku.com/mcp`. Its anonymous website
preview tools require no authentication. Durable buckets and account features
use OAuth, and that OAuth screen is sign-in only. If the user has no Revdoku
account, the agent should create an anonymous preview and share its returned web
signup/claim link instead of trying to sign the user up through OAuth.

Hosted agents cannot read files from the user's computer. Use the local CLI for
local folders, JavaScript bundles, images, fonts, PDFs, and other binary assets.
MCP can directly write generated text files.

## Tutorials

- Setup hub: <https://revdoku.com/connect/>
- ChatGPT: <https://revdoku.com/chatgpt/>
- Codex: <https://revdoku.com/codex/>
- Claude: <https://revdoku.com/claude/>
- Claude Desktop and terminal agents:
  <https://revdoku.com/claude-desktop-terminal/>
- Gemini: <https://revdoku.com/gemini/>
- Hermes: <https://revdoku.com/hermes/>

Use those tutorials only when manual setup or troubleshooting is actually
needed. Normal onboarding should stay to one preview URL and one claim link.

## Public package

This repository contains the Revdoku CLI, skill, API documentation, and
Claude/Codex/Cursor plugin manifests. The hosted MCP implementation runs at
`https://app.revdoku.com/mcp`. MCP manifests use `"auth":"oauth"` for account
tools; the tool descriptors separately advertise the anonymous preview tools as
`noauth`.

See [CHANGELOG.md](./CHANGELOG.md) and [api.md](./api.md).
