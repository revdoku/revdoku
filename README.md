# Revdoku

**Cloud storage with an email address for every bucket.** Store documents, data,
and project files; receive email and attachments in the same bucket; share files
with authorized people and AI agents. Files and incoming messages stay private
within your account access permissions.

Use the CLI for local files, hosted MCP for AI agents, or the REST API for your own
integrations. Buckets keep version history so you can review changes and restore
earlier files.

## Prompt for an AI agent

```text
Connect Revdoku so you can store and organize my files, read incoming email, and work with shared buckets.

Follow https://revdoku.com/llms-install.md. If you have shell and filesystem access, install and use the local CLI. Otherwise, connect through hosted MCP.

Complete sign-in in the browser, check the connection, and ask what I want to do with my files or incoming email.
```

## Store and share files

Use `revdoku upload ./project-files` to save a local folder privately. Read files, inspect history, and
restore earlier versions through the CLI, MCP, API, or dashboard. All stored files
can be downloaded from Revdoku at any time.

Share the bucket's dashboard link with people who have account access. Authorize
each AI connection separately for the intended buckets. A dashboard link does not
grant access by itself. Agents can work on the same files with locks and revision
checks to coordinate changes.

See the [storage quick start](./docs.md#keep-files-in-a-private-cloud-bucket),
[file sharing](./docs.md#share-files-with-people-and-agents), and
[multiple-agent example](./docs.md#work-with-multiple-ai-agents).

## Receive email in a bucket

Each bucket has its own incoming email address. Bucket creation returns the
address and receiving state; for an existing bucket, use
`bucket_get(include_inbound_email: true)` with write access or **Bucket settings →
Email**. Check `inbound_email.ready` before using the address.

Receive invoices, documents, project updates, or authorized service verification
messages. Each accepted email is saved as original `message.eml`, decoded
`message.json`, readable `message.md`, and attachment files. Authorized people and agents can read these
with the same file tools used for other bucket content.

Compare `inbound_email.received_count` to detect new mail, then read
`last_received_path + "message.json"` for the body and attachment paths. Anyone
knowing the address can email the bucket; reading its contents requires access.
See [incoming email](docs.md#receive-email-and-third-party-verification-messages)
and the [API contract](api.md#incoming-email-into-a-bucket).

## Accounts and limits

Create an account at <https://app.revdoku.com/users/sign_up> and connect in the
browser. Never paste account credentials or verification codes into AI chat.
Free includes 1 active bucket, 1 GiB storage, 30 incoming emails and 128 MiB incoming
data/month, and 1 address rotation/month. Files (including PDFs) and complete emails
are limited to 10 MiB each; email size includes MIME encoding.
Read current prices and limits at <https://app.revdoku.com/pricing> or
<https://app.revdoku.com/pricing.json>.

Private storage and collaboration follow the [Terms of Use](https://revdoku.com/terms/).
Contact `support@revdoku.com` for account, billing, or access questions.

## Local AI apps

The installer supports `codex`, `claude-code`, `cursor`, `antigravity`,
`opencode`, `grok-build`, `hermes`, `openclaw`, and `all` through the
`REVDOKU_AGENT` environment variable. Automatic setup installs for Codex and
any other detected clients.

Install the public skill and CLI:

```sh
npx skills add revdoku/revdoku --skill revdoku -g
```

To target one agent, add `--agent codex` (or `claude-code`, `cursor`, etc.).
This also avoids the upstream PromptScript global-install error.

If npm is unavailable:

```sh
curl -fsSL https://revdoku.com/install.sh | bash
```

The skill runs its bundled CLI. The shell installer verifies the CLI and skill
files against embedded SHA-256 hashes before installation. If verification fails,
fetch the current installer and retry. Download-source overrides are unsupported.

`npx skills` installs the CLI inside the skill, without adding `revdoku` to
your shell `PATH`. Agents use the bundled `scripts/revdoku.sh` with the same
arguments as the commands below.

Store or update a local folder:

```sh
revdoku upload ./project-files
```

The first run opens browser sign-in when credentials are missing. Re-running
updates the same bucket. New accounts can be created on the web signup page.

Useful commands:

- `revdoku upload [PATH]` — store or update private files.
- `revdoku files`, `revdoku read PATH` — list and read stored files and email.
- `revdoku versions`, `revdoku restore ID` — inspect and restore history.
- `revdoku status`, `revdoku ls` — inspect the connection and buckets.
- `revdoku dashboard`, `revdoku --help` — open the dashboard or command reference.

## Hosted and web agents

The hosted MCP endpoint is `https://app.revdoku.com/mcp`. All tools use OAuth.
If the user has no Revdoku account, direct them to browser signup before using
account tools.

Hosted agents cannot read files from the user's computer. Use the local Revdoku CLI for
local folders, JavaScript bundles, images, fonts, PDFs, and other binary assets.
MCP can directly write generated text files.

## Tutorials

Per AI client guides:

- Setup hub: <https://revdoku.com/connect/>
- ChatGPT: <https://revdoku.com/chatgpt/>
- Codex: <https://revdoku.com/codex/>
- Claude: <https://revdoku.com/claude/>
- Claude Desktop and terminal agents:
  <https://revdoku.com/claude-desktop-terminal/>
- Gemini: <https://revdoku.com/gemini/>
- Hermes: <https://revdoku.com/hermes/>

Use those tutorials when manual setup or troubleshooting is needed. Follow the
user's file storage, sharing, or incoming-email goal.

## Public package

This repository contains the Revdoku CLI, skill, API documentation, and
Claude/Codex/Cursor plugin manifests. The hosted MCP implementation runs at
`https://app.revdoku.com/mcp`. MCP manifests use OAuth, and every tool descriptor requires OAuth.

See [CHANGELOG.md](./CHANGELOG.md) and [api.md](./api.md).

### Pro Agency client accounts

Run `revdoku status` to see the credential's default account and authorized
accounts. Each identity includes `account_kind` (`standard`, `agency`, or `client`),
the separate `client_name`, and `agency_account` when the parent is granted.
`kind` remains a compatibility alias. Use `--account-id ID` on each command to target a client; omitting it
always uses the credential's main account. The Agency owner must explicitly
include client accounts when connecting or in Account → Access.

```bash
revdoku account create-client "Client files" --client-name "Acme Studio" --account-id acct_agency
revdoku ls --account-id acct_...
revdoku upload ./project-files --account-id acct_...
```

Pro Agency shares capacity, credits, and member seats across one agency and
nine client accounts. Each client keeps separate files, members, and branding.
Account names and client names can differ. Unknown client names stay unset.
`revdoku account --account-id ID` shows a client’s identity and provider guidance;
client billing data remains restricted to the agency owner. Browser switching
does not change the CLI credential’s default account.

### Custom receiving domains

Custom email domains are an invitation-only paid pilot. Setup lives in Account
Settings → Domains → Email and requires an account administrator. Prefer an unused
receiving subdomain; dedicated root domains are accepted. DNS changes require the
user's authorization. Connecting a domain does not change existing bucket addresses.
Use only the full address returned by Revdoku and check `ready`. A domain switch
may return `assignment.status: pending`; poll until active or failed, keeping the
current address in use meanwhile. Never construct aliases or use `+tag` variants.
See [the email API contract](https://revdoku.com/api.md#custom-receiving-domains-invitation-only-pilot).
