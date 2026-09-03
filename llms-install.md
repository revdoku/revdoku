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
- Revdoku account creation is completed in the browser before agent access.
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

Without credentials, the CLI opens browser sign-in. Use `revdoku preview` to
create a temporary review URL and `revdoku p` only after the user explicitly
asks to publish the main site. Re-running updates the same bucket and URL.

## Hosted MCP agent

Endpoint: `https://app.revdoku.com/mcp`

Authenticate with OAuth before calling tools. Then call `revdoku_status`, create
or choose a private bucket, write the files, and use `bucket_publish_preview`
for review. Publish the main website only when the user asks. If the user has no
account, direct them to `https://app.revdoku.com/users/sign_up` first.

If the host does not support MCP or the agent needs local/binary files, use the
local CLI. A hosted agent cannot read the user's computer.

## Pricing and limits

Use <https://app.revdoku.com/pricing> for current prices and human-readable
comparisons. Read the versioned plan limits and indexing contract from
<https://app.revdoku.com/pricing.json>. `revdoku_status` embeds the public Free
contract; full-account profile responses include effective account overrides.

Permanent public Free websites are indexable by default. Password, Require
Email, and temporary preview websites remain `noindex`.

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
