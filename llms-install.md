# Revdoku agent setup

Revdoku provides private cloud storage and managed email inboxes for AI agents
and developers. Store files, create inboxes, and read received emails and attachments.
Multiple authorized agents can use the same private bucket; there are no public
file-sharing links.
Verify access, then complete the requested file or incoming-email task.

Prefer local shell and filesystem access; use
hosted MCP only when local access is unavailable.

## Public prompt

```text
Connect Revdoku so you can store my files, create email inboxes on Revdoku, and read received emails and attachments. Follow https://revdoku.com/llms-install.md, help me sign in through the browser, and verify the connection. Then continue my task, or ask what I want to do.
```

## Agent rules

- If you have shell access, run the requested setup and file commands yourself.
- Never tell the user to open a separate terminal for commands you can run.
- Never ask for a Revdoku password, email OTP, TOTP/backup code, API key,
  connection token, protected-site password, or payment details in chat.
- Do not ask the user to send `continue` after a browser step. Resume by
  checking status yourself.
- Create new accounts in the browser at `https://app.revdoku.com/users/sign_up` before connecting.
- Use `revdoku upload` for files and folders. Share the dashboard link with authorized
  people; the link itself does not grant access.

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
revdoku upload <folder>
```


With `npx skills`, run the bundled `scripts/revdoku.sh` from the installed
skill directory in place of `revdoku`; this install does not add a CLI to `PATH`.

Without credentials, the CLI opens browser sign-in. Re-running the upload
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
## Start free

You can start free. See [pricing](https://app.revdoku.com/pricing) for current plans.

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
