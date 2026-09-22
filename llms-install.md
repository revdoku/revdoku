# Revdoku agent setup

Revdoku is cloud storage with an email address for every bucket. Connect to store
and share files with authorized people and agents, and receive email and attachments.
Verify access, then complete the requested file or incoming-email task.

Prefer local shell and filesystem access; use
hosted MCP only when local access is unavailable.

## Public prompt

```text
Connect Revdoku so you can store and share my files, and read incoming email and attachments in private buckets.

Follow https://revdoku.com/llms-install.md. If you have shell and filesystem access, install and use the local CLI. Otherwise, connect through hosted MCP.

Complete sign-in in the browser, check the connection, and ask what I want to do with my files or incoming emails. Check account capabilities before offering website publishing; new accounts have it disabled.
```

## Agent rules

- If you have shell access, run the requested setup and file commands yourself.
- Never tell the user to open a separate terminal for commands you can run.
- Never ask for a Revdoku password, email OTP, TOTP/backup code, API key,
  connection token, protected-site password, or payment details in chat.
- Do not ask the user to send `continue` after a browser step. Resume by
  checking status yourself.
- Create new accounts in the browser at `https://app.revdoku.com/users/sign_up` before connecting.
- Keep `--draft` on CLI storage uploads. Share the dashboard link with authorized
  people; the link itself does not grant access.
- Website publishing is disabled for new accounts on every plan. Check
  `features.website_publishing` before offering website features; upgrades do not
  enable it. For enabled accounts, publish only on an explicit request.

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

To save the requested files in a private bucket, run:

```sh
revdoku p <folder> --draft
```

Keep `--draft` for storage-only updates. Omit it only when the user asks to publish.

With `npx skills`, run the bundled `scripts/revdoku.sh` from the installed
skill directory in place of `revdoku`; this install does not add a CLI to `PATH`.

Without credentials, the CLI opens browser sign-in. Re-running with `--draft`
updates the same bucket. Use `revdoku files`, `revdoku read PATH`, and
`revdoku versions` to inspect its files and history.

## Hosted MCP agent

Endpoint: `https://app.revdoku.com/mcp`

Authenticate with OAuth before calling tools. Then call `revdoku_status`, create
or choose a private bucket, and read or write the requested files. Bucket creation
returns its incoming email address and receiving state. For an existing bucket, use `bucket_get(include_inbound_email: true)` with write access.
Check `ready`, compare `received_count` for new mail, and read
`last_received_path + "message.json"` with `bucket_file_read`; `message.md` provides readable Markdown.
If not ready, explain `blocked_reason`; do not assume a paused or unknown inbox
can receive. Read effective size/count/data limits from the service. Personal
notification frequency is managed in Account Settings → Notifications.
See the [email contract](https://revdoku.com/api.md#incoming-email-into-a-bucket).
If the user has no account, direct them to `https://app.revdoku.com/users/sign_up` first.

If the host does not support MCP or the agent needs local/binary files, use the
local CLI. A hosted agent cannot read the user's computer.

Private storage and collaboration follow the [Terms of Use](https://revdoku.com/terms/).
For a requested website on an enabled account, follow the
[publishing guide](https://revdoku.com/docs.md#publishing) and
[Website Publishing Policy](https://revdoku.com/acceptable-use/).

## Pricing and limits

Use <https://app.revdoku.com/pricing> for current prices and human-readable
comparisons. Read the versioned plan limits and indexing contract from
<https://app.revdoku.com/pricing.json>. `revdoku_status` embeds the public Free
contract; full-account profile responses include effective account overrides.

## Troubleshooting tutorials

Link one tutorial only when the simple flow is unavailable or the user asks:

Use the same setup instructions for every AI app. Do not invent a product-
specific prompt or setup flow.

- Universal local setup: <https://revdoku.com/llms-install.md>
- General setup hub: <https://revdoku.com/connect/>
- Hosted MCP fallback: <https://revdoku.com/mcp/>

## Verification prompt

```text
Create a private bucket for my project notes, save a README.md, and give me its
dashboard link and incoming email address. Check whether the bucket is ready to
receive email. If I ask for changes, update the same bucket.
```
