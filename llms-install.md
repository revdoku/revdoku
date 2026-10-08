# Revdoku agent setup

Revdoku provides email mailboxes for people and AI agents, with private file storage.
Connect to create and manage mailboxes, read messages and attachments, and store files.
Verify the account and granted access with a read, then complete the requested task.

| Task | Connection |
| --- | --- |
| Application backend | [REST API](https://revdoku.com/api/) with a normal API key |
| Local coding assistant | Skill with bundled CLI |
| Desktop or cloud assistant | [Hosted MCP setup](https://revdoku.com/connect/) |

Use an existing connection when its account and scope fit. Installation prompts
are instructions for one of these methods; they do not require another credential.

## Public prompt

```text
Connect Revdoku so you can create and manage email mailboxes for my AI agents, read emails and attachments, and store files. Follow https://revdoku.com/llms-install.md to set up access. If I need an account, guide me to https://app.revdoku.com/users/sign_up to complete signup in my browser. Keep verification codes and credentials out of chat. Verify access. Continue my task. If I have no task yet, help me choose a first email workflow using https://revdoku.com/docs.md#first-email-workflow. Reuse my mailbox. Show its actual address as a mailto link only when receiving is ready and access permits it. Ask me to send an email there, use the address for relevant notifications, or set up Gmail forwarding. After a relevant message arrives, help me get the result I chose. Offer recurring automation afterward without implying that this connection runs it.
```

## Account setup

1. If you already have an authorized connection, verify it and continue the task.
2. If you need an account, complete [browser signup](https://app.revdoku.com/users/sign_up).
3. Sign in through the browser to authorize the connection.

Signup creates the first mailbox. List the accessible mailboxes after connecting. Reuse that mailbox for the task, or create another only when needed.
With write access, check `email.receiving_enabled` before sharing an address.
Read-only connections verify access by listing authorized mailboxes and reading an
existing message; ask the operator for the address when needed. Show the account
ID and granted scope. Browser account switching does not change a tool credential's
default: use an explicit `account_id` or CLI `--account-id` for the intended account.

## First email workflow

If the user has a task, continue it after connection. Otherwise, help them [choose and complete a first email workflow](https://revdoku.com/docs.md#first-email-workflow).
Show the authorized, ready address as a `mailto:` link. Ask the user to send an email there.
Offer direct use of the address or [Gmail forwarding](https://revdoku.com/blog/how-to-set-up-auto-forwarding-from-gmail-to-revdoku-s-email/) for future messages.
Read a relevant message and produce the chosen result before offering recurring automation.

## Agent rules

- If you have shell access, run the requested setup and file commands yourself.
- Never tell the user to open a separate terminal for commands you can run.
- Never ask for a Revdoku password, email OTP, TOTP/backup code, API key,
  connection token, protected-site password, or payment details in chat.
- Do not ask the user to send `continue` after a browser step. Resume by
  checking status yourself.
- Follow the account setup flow above. Hosted MCP requires browser OAuth before connecting.
- Use `revdoku upload` for files and folders. Share the dashboard link with authorized
  people; the link itself does not grant access.

## Local AI apps with shell access

Prefer local shell and filesystem access for local coding assistants.
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

To save the requested files in a private mailbox, run:

```sh
revdoku upload <folder>
```

With `npx skills`, run the bundled `scripts/revdoku.sh` from the installed
skill directory in place of `revdoku`; this install does not add a CLI to `PATH`.

Without credentials, the CLI opens browser sign-in. Re-running the upload
updates the same mailbox. Use `revdoku files`, `revdoku read PATH`, and
`revdoku versions` to inspect its files and history.

## Hosted MCP agent

Endpoint: `https://mcp.revdoku.com`

Authenticate with OAuth before calling account tools. Choose selected mailboxes and
read access for reading tasks; choose broader access only for the requested task.
Call `account_list`, then `account_get` with the chosen ID, and list its authorized
mailboxes. Read an existing message before making requested changes. Mailbox creation
returns its incoming email address and receiving state. For an existing mailbox, use `mailbox_get(include_email: true)` with write access.
Check `receiving_enabled`, then use `mailbox_email_list` with a saved `pagination.next_cursor`
to poll. Read `eml_` IDs with `mailbox_email_get`; download attachments or the original
with `mailbox_email_download`.
If not ready, explain `blocked_reason`; do not assume a paused or unknown mailbox
can receive. Read quotas with `account_limits`. Personal
notification frequency is managed in Account Settings → Notifications.
See the [email contract](https://revdoku.com/api.md#incoming-email-into-a-mailbox).
If the user has no account, follow Account setup above.

If the host does not support MCP or the agent needs local/binary files, use the
local CLI. A hosted agent cannot read the user's computer.

Private storage and collaboration follow the [Terms of Use](https://revdoku.com/terms/).
## Start free

You can start free. See [pricing](https://app.revdoku.com/pricing) for current plans.

## Troubleshooting tutorials

Link one tutorial only when the simple flow is unavailable or the user asks:

Use the client-specific instructions linked from the setup hub; desktop settings and terminal commands differ.

- Universal local setup: <https://revdoku.com/llms-install.md>
- General setup hub: <https://revdoku.com/connect/>
- Hosted MCP fallback: <https://revdoku.com/mcp/>

## Verification prompt

```text
Confirm my Revdoku account ID and granted access. List the mailboxes you can access,
ask which to use, and read its latest message if one exists. Do not change anything.
```

A mailbox-wide edit lock blocks incoming email. Prefer individual file locks or
revision checks while an mailbox is receiving. Human administrators inspect receiving
holds and logs in the dashboard.
