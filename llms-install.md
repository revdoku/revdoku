# Revdoku agent setup

Revdoku publishes docs as a site from GitHub or uploaded files. AI agents read the site through its MCP server,
visitors ask questions, and support requests arrive as tickets. A bucket holds the files, the site and the support mailbox.
Connect to create buckets, edit and publish docs, read site analytics and answer tickets.
Verify the account and granted access with a read, then complete the requested task.

| Task | Connection |
| --- | --- |
| Application backend | [REST API](https://docs.revdoku.com/api) with a normal API key |
| Local coding assistant | Skill with bundled CLI |
| Desktop or cloud assistant | [Hosted MCP setup](https://revdoku.com/connect/) |
| Chat app that cannot add connectors | [No connector available](#no-connector-available) |

Use an existing connection when its account and scope fit. Installation prompts
are instructions for one of these methods; they do not require another credential.

## Public prompt

```text
Connect Revdoku so you can create buckets, edit and publish my docs, read site analytics and answer support tickets. Follow https://revdoku.com/llms-install.md to set up access. If I need an account, guide me to https://app.revdoku.com/users/sign_up?utm_source=revdoku&utm_medium=prompt&utm_campaign=connect to complete signup in my browser. Keep verification codes and credentials out of chat. Verify access, then continue my task or ask what I want to do. If I have no task yet, ask whether to publish docs from a GitHub repository or start from a template, then publish and show the site address.
```

## Account setup

1. If you already have an authorized connection, verify it and continue the task.
2. If you need an account, complete [browser signup](https://app.revdoku.com/users/sign_up?utm_source=revdoku&utm_medium=prompt&utm_campaign=connect).
3. Sign in through the browser to authorize the connection.

List the accessible buckets after connecting. Create one when there is none.
With write access, check `email.receiving_enabled` before sharing an address.
Read-only connections cannot see the address. They verify access by listing authorized
buckets and reading an existing message; ask the operator for the address when needed. Show the account
ID and granted scope. Browser account switching does not change a tool credential's
default: use an explicit `account_id` or CLI `--account-id` for the intended account.

## First task

If the user has a task, continue it after connection. Otherwise, ask whether to publish docs from a GitHub repository
or to start from a docs template. See [Publish your first docs site](https://docs.revdoku.com/docs-sites#publish-your-first-docs-site).
Publish the site and show its address. Then offer the next step: edit a page, read the site analytics or answer a support ticket.

## Agent rules

- If you have shell access, run the requested setup and file commands yourself.
- Never tell the user to open a separate terminal for commands you can run.
- Never ask for a Revdoku password, email OTP, TOTP/backup code, API key,
  connection token, protected-site password, or payment details in chat.
- Do not ask the user to send `continue` after a browser step. Resume by
  checking status yourself.
- Follow the account setup flow above. Hosted MCP requires browser OAuth before connecting.
- If you are an AI agent that uses the Revdoku dashboard in a browser, choose what the
  mailbox is for and create it in the setup steps after signup, then choose **Are you an AI agent?**.
- Use `revdoku upload` for files and folders. Share the dashboard link with authorized
  people; the link itself does not grant access.

## Choose access

On the Revdoku permission screen, select the bucket for the task, then choose:

| Option | Choose it when |
| --- | --- |
| **Read only** | The agent only reads saved email and files. It cannot see the mailbox address. |
| **Read & write** | The agent must show the mailbox address, reply to senders, or save files. |
| **Full access** | The agent must create or manage buckets, or delete email. |

## No connector available

Some desktop and web chat apps cannot add custom connectors, for example free
ChatGPT accounts. If you have no shell access and cannot connect Revdoku in this
chat, do not send the user to a terminal. Give them these steps instead:

1. Sign up through [browser signup](https://app.revdoku.com/users/sign_up?utm_source=revdoku&utm_medium=prompt&utm_campaign=connect), or sign in.
2. Open the [dashboard](https://app.revdoku.com/buckets) and copy the bucket's email address.
3. Forward an email to that address, or send one from their usual email app.
4. Open the message in the dashboard, then paste its text or attach its files in this chat.

Then work with the pasted email or files.

Custom connectors depend on the user's plan: see [ChatGPT developer mode](https://help.openai.com/en/articles/12584461-developer-mode-and-mcp-apps-in-chatgpt) and [Claude custom connectors](https://support.claude.com/en/articles/11175166).

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
updates the same bucket. Use `revdoku files`, `revdoku read PATH`, and
`revdoku versions PATH` to inspect its files and their history.

## Hosted MCP agent

Endpoint: `https://mcp.revdoku.com`

Authenticate with OAuth before calling account tools. Select only the buckets
the task needs, and [choose access](#choose-access) for the task: **Read only** to
read saved email, **Read & write** when you must show the mailbox address.
Call `account_list`, choose an account, pass its `account_id` on later calls, and
list its authorized buckets. Read an existing message before making requested changes. Bucket creation
returns its incoming email address and receiving state. For an existing bucket, `bucket_get` returns `email.address` with write access.
Check `email.receiving_enabled`, then use `bucket_ticket_list` with `updated_after`
to poll. Read `tkt_` IDs and their messages with `bucket_ticket_get`; download attachments or the original
with `bucket_ticket_download`.
If not ready, explain `receiving_blocked_reason`; do not assume a paused or unknown bucket
can receive. Read quotas with `account_limits`. Each person manages
notification emails in Account Settings → Notifications.
See the [email contract](https://docs.revdoku.com/api#tickets).
If the user has no account, follow Account setup above.

If the host does not support MCP or the agent needs local/binary files, use the
local CLI when you have shell access. A hosted agent cannot read the user's computer.
Without MCP or shell access, follow [No connector available](#no-connector-available).

Private storage and collaboration follow the [Terms of Use](https://revdoku.com/terms/).
## Plans

New accounts start on the Free plan. For regular use, choose a paid plan on the [pricing page](https://app.revdoku.com/pricing).

## Troubleshooting tutorials

Link one tutorial only when the simple flow is unavailable or the user asks:

Use the client-specific instructions linked from the setup hub; desktop settings and terminal commands differ.

- Universal local setup: <https://revdoku.com/llms-install.md>
- General setup hub: <https://revdoku.com/connect/>
- Hosted MCP fallback: <https://revdoku.com/mcp/>

## Verification prompt

```text
Confirm my Revdoku account ID and granted access. List the buckets you can access,
ask which to use, and read its latest message if one exists. Do not change anything.
```

Incoming email keeps arriving while a bucket-wide edit lock is held. Prefer
individual file locks or revision checks. Human administrators inspect receiving
holds and logs in the dashboard.
