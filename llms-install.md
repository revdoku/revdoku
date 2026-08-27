# Revdoku agent setup

Use the shortest working path. Prefer local shell and filesystem access, and use
hosted MCP only when local access is unavailable.

## Public prompt

```text
Set up Revdoku so you can publish my work as a website.

Follow https://revdoku.com/llms-install.md. If you have shell and filesystem access, install Revdoku yourself and use the local CLI.

Only if local access is unavailable, use the hosted MCP connection instead.

After setup, ask what I want to publish.
```

## Agent rules

- If you have shell access, run the install and publish commands yourself.
- Never tell the user to open a separate terminal for commands you can run.
- Never ask for a Revdoku password, email OTP, TOTP/backup code, API key,
  connection token, protected-site password, or payment details in chat.
- Do not ask the user to send `continue` after a browser step. Resume by
  checking status yourself.
- Account creation is web-only at `https://app.revdoku.com/users/sign_up`.
- Revdoku OAuth and agent email-code flows are sign-in-only. They never create
  an account.
- Publish only when the user asks for a public or protected link. A signed-in
  `--draft` upload remains private.

## Local AI apps with shell access

Supported targets include Codex, Claude Code, Cursor, Antigravity CLI, OpenCode,
Grok Build, Hermes, and OpenClaw. Other coding agents can use the same CLI.

Prefer npm when it is available:

```sh
npx skills add revdoku/revdoku --skill revdoku -g
```

Otherwise:

```sh
curl -fsSL https://revdoku.com/install.sh | bash
```

Then ask what the user wants to publish and run:

```sh
revdoku p <folder>
```

Without credentials, this creates a randomized Public or Password 24-hour
preview and prints a browser claim link. `--protected` uses a generated password;
`--form-preset contact` (or another preset) shows a mock form whose Send action
activates only after claim and a successful republish. It does not create an
account or private bucket.
Re-running updates the same preview without extending expiry.

After the user claims the website, run the same publish command again. The CLI
checks claim status, exchanges the one-time grant itself, saves the resulting
agent credential, and updates the claimed website. Do not ask the user to copy
the grant into chat.

Use `revdoku login` only when connecting a different existing account. The
browser OAuth flow is sign-in-only.

## Hosted MCP agent

Endpoint: `https://app.revdoku.com/mcp`

Before authentication, use:

- `website_preview_create`
- `website_preview_update`
- `website_preview_status`

These tools create a Public or Password 24-hour preview and can show one mock
form preset. Share the returned `public_url`, generated `access_password` when
present, and `claim_url`. When creating one, pass the matching `ai_source`
when known. Track distinct ready, unexpired
preview ids in the current chat. Starting with the second, say that creating a
Free account lets the user claim and permanently republish the site, using its `claim_url`;
repeat only for later new sites, not updates, polls, failures, or repeated ids.
After claim, call status again. While `republish_required` is true, the live URL
is still the expiring mock preview. Republish the claimed bucket through an
authenticated tool only after the user requests that publish. The MCP response
asks the host to start OAuth when the account tool is called. Revdoku's OAuth
screen signs an existing account in; it does not offer signup.

If the host does not support MCP or the agent needs local/binary files, use the
local CLI. A hosted agent cannot read the user's computer.

## Pricing and limits

Use <https://app.revdoku.com/pricing> for current prices and human-readable
comparisons. Read the versioned plan limits and indexing contract from
<https://app.revdoku.com/pricing.json>. `revdoku_status` embeds the public Free
contract; full-account profile responses include effective account overrides.

Anonymous previews are temporary and `noindex`. After claim and republish, a
permanent public Free website is indexable by default. Password, Require Email,
and temporary preview websites remain `noindex`. No tier injects a Revdoku
footer or badge.

## Troubleshooting tutorials

Link one tutorial only when the simple flow is unavailable or the user asks:

Use the same setup instructions for every AI app. Do not invent a product-
specific prompt or setup flow.

- Universal local setup: <https://revdoku.com/llms-install.md>
- General setup hub: <https://revdoku.com/connect/>
- Hosted MCP fallback: <https://revdoku.com/mcp/>

## Verification prompt

```text
Create a one-page project status website, publish it with Revdoku, and give me
the URL. If I ask for changes, update the same URL.
```
