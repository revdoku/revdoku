# Revdoku agent setup

Revdoku provides email inboxes for people and AI agents, with private file storage.
Connect to create and manage inboxes, read messages and attachments, and store files.
Verify access, then complete the requested task.

Prefer local shell and filesystem access; use
hosted MCP only when local access is unavailable.

## Public prompt

```text
Connect Revdoku so you can create and manage email inboxes for my AI agents, read emails and attachments, and store files. Follow https://revdoku.com/llms-install.md to set up access. If I need an account, check https://revdoku.com/api.md#direct-api-signup. Use API signup when you can handle my authorization and email verification privately; otherwise guide me through browser signup. Keep verification codes and credentials out of chat. Verify access, then continue my task or ask what I want to do.
```

## Account setup

1. If you already have an authorized connection, verify it and continue the task.
2. If you need an account and your private API client can handle human authorization
   and email verification, follow [API signup](https://revdoku.com/api.md#direct-api-signup).
   Check `https://api.revdoku.com/v1/agent_auth/capabilities` for `data.signup.available`.
   No existing API key is needed. Use the human owner's supplied email, with their
   authorization for `accept_terms_and_policy: true` (Terms/AUP acceptance and
   privacy acknowledgment). Collect
   verification privately; never ask for a code in AI chat.
3. MCP clients with a private verification flow may use `revdoku_signup`,
   `revdoku_signup_verify` and `revdoku_signup_resend` with the same acceptance
   field; see [MCP signup](mcp.md#direct-mcp-signup).
4. For CLI setup, or when private API/MCP signup is unavailable, use
   [browser signup](https://app.revdoku.com/users/sign_up), then browser sign-in.
   Existing account owners use normal sign-in.

Signup creates the first inbox. With API signup, save the returned API key privately
and use the returned bucket; with CLI or MCP, list the accessible buckets after
connecting. Reuse that inbox for the task, or create another only when needed.
Check `email.receiving_enabled` before using an address, and share its email address
and dashboard link with the user. If receiving is unavailable, explain `blocked_reason`.

## Agent rules

- If you have shell access, run the requested setup and file commands yourself.
- Never tell the user to open a separate terminal for commands you can run.
- Never ask for a Revdoku password, email OTP, TOTP/backup code, API key,
  connection token, protected-site password, or payment details in chat.
- Do not ask the user to send `continue` after a browser step. Resume by
  checking status yourself.
- Follow the account setup flow above. Hosted MCP offers signup tools; account access uses browser OAuth.
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

Endpoint: `https://mcp.revdoku.com`

Authenticate with OAuth before calling account tools. Then call `revdoku_status`, create
or choose a private bucket, and read or write the requested files. Bucket creation
returns its incoming email address and receiving state. For an existing bucket, use `bucket_get(include_email: true)` with write access.
Check `receiving_enabled`, then use `bucket_email_list` with a saved `pagination.next_cursor`
to poll. Read `eml_` IDs with `bucket_email_get`; download attachments or the original
with `bucket_email_download`.
If not ready, explain `blocked_reason`; do not assume a paused or unknown inbox
can receive. Read quotas with `account_limits`. Personal
notification frequency is managed in Account Settings → Notifications.
See the [email contract](https://revdoku.com/api.md#incoming-email-into-a-bucket).
If the user has no account, follow Account setup above.

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
