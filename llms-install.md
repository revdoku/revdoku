# Revdoku agent setup

Revdoku is cloud storage for AI, designed for humans and AI apps working together.
Keep files and folders private or share selected files as a website. Version
history, access control, and logs support collaboration; published websites add
visitor analytics.

Use the shortest working path. Prefer local shell and filesystem access, and use
hosted MCP only when local access is unavailable.

## Public prompt

```text
Set up Revdoku cloud storage so I can work with my AI apps and agents on the same files and folders. Keep them private, and share selected files as a website when I ask.

Follow https://revdoku.com/llms-install.md. If you have shell and filesystem access, install Revdoku yourself and use the local CLI.

Only if local access is unavailable, use the hosted MCP connection instead.

After setup, ask what I want to store, collaborate on, or publish.
```

## Agent rules

- If you have shell access, run the requested setup, storage, or publishing commands yourself.
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

Add `--agent codex` (or the current agent's name) to select one target and
avoid unsupported global targets such as PromptScript.

Otherwise:

```sh
curl -fsSL https://revdoku.com/install.sh | bash
```

Then follow the user's storage or publishing goal. To keep files private, run:

```sh
revdoku p <folder> --draft
```

Keep `--draft` for storage-only updates. Omit it only when the user asks to publish.

With `npx skills`, run the bundled `scripts/revdoku.sh` from the installed
skill directory in place of `revdoku`; this install does not add a CLI to `PATH`.

Without credentials, the CLI opens browser sign-in. Use `revdoku preview` to
create a temporary review URL and `revdoku p` only after the user explicitly
asks to publish the main site. Re-running updates the same bucket and URL.

## Hosted MCP agent

Endpoint: `https://app.revdoku.com/mcp`

Authenticate with OAuth before calling tools. Then call `revdoku_status`, create
or choose a private bucket, and read or write the requested files. Finish there
for private storage. For a requested website, use `bucket_publish_preview`
for review when appropriate, then publish the main website only when authorized. If the user has no
account, direct them to `https://app.revdoku.com/users/sign_up` first.

If the host does not support MCP or the agent needs local/binary files, use the
local CLI. A hosted agent cannot read the user's computer.

Private bucket storage and collaboration follow the
[Terms of Use](https://revdoku.com/terms/), including its rules against illegal
and abusive use. The [Website Publishing Policy (Acceptable Use Policy)](https://revdoku.com/acceptable-use/)
applies when content is served to visitors: public websites, published files,
share links, previews, password- or email-protected sites, and public comments.
It does not apply solely to private bucket files or authenticated account downloads.
Publishing-only restrictions, including the political-content restriction, apply
on every plan and in previews. Publication stays unavailable until review succeeds.

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
