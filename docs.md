# Revdoku Docs

**Email inboxes for people and AI agents, with private file storage.** Create
an inbox, receive messages and attachments, and read them through the API, MCP,
CLI, or dashboard. Store and share additional files in the same bucket.
Email sending: **Coming soon**.

Start with [email](#receive-email-and-third-party-verification-messages),
[additional file storage](#keep-files-in-a-private-cloud-bucket), or
[file sharing](#share-files-with-people-and-agents).
Private storage and collaboration follow the [Terms of Use](https://revdoku.com/terms/).

## Quick Start

If npm is available, install the Revdoku skill:

```sh
npx skills add revdoku/revdoku --skill revdoku -g
```

Add `--agent codex` (or your agent's name) to select one target and avoid
unsupported global targets such as PromptScript.

Otherwise install the local client and skill:

```sh
curl -fsSL https://revdoku.com/install.sh | bash
```

The shell installer adds the `revdoku` command and installs the Revdoku skill
for Codex plus any detected local agents. Set `REVDOKU_AGENT` to `codex`,
`claude-code`, `cursor`, `antigravity`, `opencode`, `grok-build`, `hermes`,
`openclaw`, or `all` to choose explicitly.

The examples below use `revdoku` as shorthand. With `npx skills`, run
`scripts/revdoku.sh` from the installed skill directory. With the shell
installer, use `~/.revdoku/bin/revdoku` if it is not on your shell `PATH`.

### Receive email and third-party verification messages

Bucket creation returns `email` with its random address and receiving state.
For an existing bucket use MCP `bucket_get(include_email: true)` with write
access, or **Bucket settings → Email**. Check `email.ready` and use the
returned address verbatim. Receive invoices, documents, and project updates in the
same bucket as uploaded files. Anyone knowing the address can send, including
a service sending a user-authorized signup/login email. Reading requires bucket
access. Keep the address for later recovery mail; rotation immediately retires it.

CLI for an existing bucket:

```sh
revdoku inbox --bucket-id bkt_...
revdoku emails --bucket-id bkt_...
revdoku email eml_... --bucket-id bkt_...
```

Replace the bucket and email IDs with returned values. The `inbox`
command retrieves the address and readiness with write access. To create an
empty mailbox, use the dashboard, MCP `bucket_create`, or `POST /api/v1/buckets`.
The CLI can also create a bucket when you upload files to it.

New messages save under `_email/inbox/`, grouped by sender and normalized subject,
with one folder per delivery containing the exact `message.eml`,
decoded `message.json`, readable `message.md`, and allowed copies in `attachments/`. All saved bytes/files count toward storage limits.
Historical `_email/in/` messages remain readable; search `_email/` to cover both roots.
Use `email.ready`, `blocked_reason`, and `usage` to check whether receiving
is available. If receiving is paused, inspect the reason in the dashboard before
asking someone to send more mail. Paused delivery is not an overflow mailbox;
previously saved messages remain readable.

Use `bucket_email_list` to list messages and save `pagination.next_cursor` for
incremental polling, including empty pages. Read an `eml_` ID with
`bucket_email_get`; use `purpose: "background"` to preserve shared read status.
`bucket_email_update` marks a message read/unread. `bucket_email_download` returns
a download descriptor for an attachment ID, or the original EML when omitted.
Only send bearer credentials when `authentication` is `bearer` and the URL is on
`https://app.revdoku.com`. Storage URLs use `authentication: "none"`.
Email sending: **Coming soon**.

## Buckets

Each bucket provides an email inbox and private file storage. File
history lets agents and people update the same project over time and restore
earlier versions.

Use clear bucket titles and short descriptions. Tags are user-facing labels, not
filesystem breadcrumbs. Use labels that help people find their files; keep
source folders and agent task context in metadata.

Buckets hold documents, data, source files, and supported static assets. HTML, CSS, JavaScript, images, fonts, and PDFs are
all fully supported and stored as-is — nothing is stripped. Upload a local folder
(including its binaries) with `revdoku upload <dir>`, or push individual binaries with
the REST direct-upload API — both send bytes straight to object storage. The
cloud MCP file tools are text-only and have no binary upload. Forbidden file
types (executables like `.exe`, `.dmg`, `.app`, `.msi`, … and secrets like `.env`
and keys) are refused **by extension** at upload; uploaded content is also scanned
afterward and removed if it turns out to be a forbidden type.

## Share files with people and agents

Invite people to the account through Revdoku's access settings and choose the
appropriate role. Authorize each agent connection for the account or selected
buckets it needs. Share the bucket's `dashboard_url` so authorized people can open
its files, messages, and history. The link itself does not grant access.

Bucket readers can read stored email as well as other files, including any login
or recovery messages. Choose access accordingly. Receiving at a bucket address
does not grant the sender access to stored files. Share files through authorized account access.

## Work with multiple AI agents

Authorize each agent separately and select the same account and bucket within
each connection's permissions. Do not share credentials or assume a new agent
has access to every bucket.

For example, use one agent to organize incoming invoices and another to summarize them:

1. Agent 1 uses the email list cursor to find new messages and reads selected attachments,
   then saves an `invoices.csv` index in the same bucket.
2. Agent 2 reads that index and the relevant files, then saves a monthly summary
   as `summary.md` for authorized people to review in the dashboard.
3. Use bucket history to inspect updates or restore an earlier snapshot.

Append is bounded UTF-8 text, not a CSV or JSON merge operation. The caller handles
escaping and headers. Automatic write locks coordinate operations; use explicit
file/bucket locks for longer edits and release your locks afterward. Pass
`expected_bucket_revision_id` from a fresh `bucket_get` when writing or appending.
On `BUCKET_REVISION_CONFLICT`, reread the current files, reconcile changes, and
retry only the intended edit. Do not blindly replay a stale full-file overwrite.

The [API reference](https://revdoku.com/api.md#file-path-operations) covers file
operations, locks, and version history.

## Agents And MCP

Hosted MCP clients can connect to:

```text
https://app.revdoku.com/mcp
```

Use Streamable HTTP transport and Revdoku OAuth. Do not paste a Revdoku
password, API key, TOTP/backup code, or email verification code into AI chat.

Local agents can use the installed `revdoku` command. Prefer MCP tools when
available; use the CLI when the agent needs local filesystem access — the cloud
connector cannot read local files, so store a LOCAL folder with
`revdoku upload <dir>`. Binary assets (images, fonts, PDFs) upload directly to object
storage via the CLI or the REST direct-upload API; the MCP file tools
(`bucket_file_write`) are text-only.

For line-oriented text updates, the CLI can append to an existing bucket text
file without rewriting the whole file:

```sh
revdoku append leads.csv --bucket-id bkt_... --content-file new-leads.csv
```

This is only for UTF-8 text files such as `.txt`, `.md`, `.csv`, `.jsonl`, and
code files. The CLI retries short-lived bucket/file locks for append and prints
the lock owner, message, and expiry if the file remains locked.

## API

The public API reference is available at:

```text
https://revdoku.com/api.md
```

Common API flows:

- Create or update buckets.
- Upload, read, and organize files; inspect and restore versions.
- Retrieve a bucket's incoming email address and receiving state.
- Read stored messages and attachments with file operations.
- Coordinate shared files across authorized connections.

## Support

For account, billing, or access issues, email:

```text
support@revdoku.com
```

### Keep files in a private cloud bucket

```sh
revdoku upload ./project-files
revdoku files
revdoku versions
```

The first command signs in when needed and saves files in Revdoku in a private bucket. The local `.revdoku` binding identifies the bucket for later commands.
Documents, data, and source files do not need an `index.html` to be stored privately.
Use `read PATH` to read a saved file and `restore ID` to create a new current
version from an earlier snapshot. Read current storage and retention limits from
the account rather than assuming unlimited history.

### Custom receiving domains

Check custom-domain availability in Account Settings. Setup lives in Account
Settings → Domains → Email and requires an account administrator. Prefer an unused
receiving subdomain; dedicated root domains are accepted. DNS changes require the
user's authorization. Connecting a domain does not change existing bucket addresses.
Use only the full address returned by Revdoku and check `ready`. A domain switch
may return `assignment.status: pending`; poll until active or failed, keeping the
current address in use meanwhile. Never construct aliases or use `+tag` variants.
See [the email API contract](https://revdoku.com/api.md#email-domains).

## Explain the action

For intentional reads, downloads, and changes, AI agents should include an optional
`reason`: a short explanation of the purpose when known. Do not invent a reason or
include secrets, file contents, or transcripts. Do not ask the user for a reason
when the task already explains the purpose; omit it when unknown.

MCP uses `reason`; CLI uses `--reason TEXT`; REST uses a `reason` query parameter
for reads and a JSON/body field for changes. The limit is 2,000 characters.
Reasons appear in authorized Timeline and Logs views even with full request
logging disabled. Change reasons are also saved in version history; read reasons
belong to access events and never replace a saved version's reason.

```bash
revdoku read invoices.csv --bucket-id bkt_... --reason "Reconcile September expenses"
revdoku upload ./approved.csv --bucket-id bkt_... --reason "Store the approved totals"
```
