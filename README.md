# Revdoku

**Email mailboxes with shared file storage for people and AI agents.** Give an agent
or project its own mailbox to receive messages and attachments. Each mailbox is a
private storage mailbox with its own email address, where you can also store and
share documents, data, and project files with authorized people and agents.

Ask your agent to summarize incoming mail, collect invoices and attachments, or
monitor replies to submissions. Use hosted MCP for AI agents, the CLI for local
files and mailbox access, or the REST API for your own integrations. Mailboxes keep
file versions so you can review changes and restore earlier files.

The skill supports uploads and file changes as well as reading mail. It also
supports mailbox archiving, permanent mailbox deletion, and agency client account
creation when explicitly requested and authorized. Permanent deletion requires
approval for the exact account and mailbox. Local CLI use stores Revdoku credentials
and state on your machine; host tool permissions remain in control.

## For developers

| Start here | What you get |
| --- | --- |
| [Language SDKs, n8n and Zapier](./guides/api-packages.md) | Working installation paths, supported operations, and a first-email walkthrough. |
| [API signup](./api.md#direct-api-signup) | Create an account, first mailbox, and API key after owner authorization and email verification. |
| [Standalone CLI](./cli/README.md) | Terminal installation and usage without an AI integration. |
| [Versioned CLI downloads](https://github.com/revdoku/revdoku/releases/latest) | A portable Bash executable, installer, and SHA-256 checksums. |
| [JavaScript examples](./examples/javascript/README.md) | Runnable Node.js examples with no runtime dependencies. |
| [TypeScript examples](./examples/typescript/README.md) | The same workflows with types and shared source. |
| [API reference](./api.md) · [OpenAPI](./openapi.json) | Authentication, mailbox creation, incoming mail, and private storage. |

The examples cover creating a ready mailbox,
reading incoming messages, downloading attachments, uploading and reading files,
and handling quotas and retries. CLI, examples, skills, and plugins share this
repository. For agent setup, see [Local AI apps](#local-ai-apps).

## Prompt for an AI agent

```text
Connect Revdoku so you can create and manage email mailboxes for my AI agents, read emails and attachments, and store files. Follow https://revdoku.com/llms-install.md to set up access. If I need an account, check https://revdoku.com/api.md#direct-api-signup. Use API signup when you can handle my authorization and email verification privately; otherwise guide me through browser signup. Keep verification codes and credentials out of chat. Verify access, then continue my task or ask what I want to do.
```

## Receive and read email

Each mailbox has its own incoming email address. Mailbox creation returns the
address and receiving state; for an existing mailbox, use
`mailbox_get(include_email: true)` with write access or **Mailbox settings →
Email**. Check `email.receiving_enabled` before using the address.

With the CLI, run `revdoku mailbox --mailbox-id bkt_...` to retrieve the address,
readiness, and activity. Use `revdoku emails --mailbox-id bkt_...` to list mail and
`revdoku email eml_... --mailbox-id bkt_...` to read it.

Receive invoices, documents, project updates, or authorized service verification
messages. Each accepted email is saved as original `message.eml`, decoded
`message.json`, readable `message.md`, and attachment files. Authorized people and agents can read these
through the email API and tools; file tools also expose the stored representations.

Use `mailbox_email_list` or the CLI `emails` command with a saved `next_cursor`
to poll for incoming messages. `mailbox_email_get` returns a message directly;
`mailbox_email_download` retrieves attachments or the original. Anyone
knowing the address can email the mailbox; reading its contents requires access.
See [incoming email](docs.md#receive-and-read-email)
and the [API contract](api.md#incoming-email-into-a-mailbox).

## Additional file storage

Use `revdoku upload ./project-files` to save a local folder privately. Read files, inspect history, and
restore earlier versions through the CLI, MCP, API, or dashboard. All stored files
can be downloaded from Revdoku at any time.

Share the mailbox's dashboard link with people who have account access. Authorize
each AI connection separately for the intended mailboxes. A dashboard link does not
grant access by itself. Agents can work on the same files with locks and revision
checks to coordinate changes.

See the [storage quick start](./docs.md#storing-files-inside-a-mailbox) and
[sharing access and coordinating edits](./docs.md#share-access-and-coordinate-edits).

## Start free

Use [API signup](./api.md#direct-api-signup) or [MCP signup](./mcp.md#direct-mcp-signup)
from a private client with the human owner's authorization and email verification.
You can also create an account at <https://app.revdoku.com/users/sign_up>.
Keep account credentials and verification codes out of AI chat.
You can start free. See [pricing](https://app.revdoku.com/pricing) for current plans.

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

Hermes can install the complete skill directly:

```sh
hermes skills install revdoku/revdoku/skills/revdoku
```

To subscribe to this repository as a Hermes source, use
`hermes skills tap add revdoku/revdoku`.

Claude Code users can run `/plugin marketplace add revdoku/revdoku`, then
`/plugin install revdoku@revdoku`. Codex users can add the repository with
`codex plugin marketplace add revdoku/revdoku` and select Revdoku in the plugin browser.
Gemini CLI users can run `gemini extensions install https://github.com/revdoku/revdoku`.

The Revdoku-owned skill and bundled CLI may also be used under MIT-0; see the
skill's `LICENSE`. The repository's default license remains MIT. Third-party
dependencies retain their own licenses.

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
updates the same mailbox. New accounts can be created on the web signup page.

Useful commands:

- `revdoku upload PATH` — store or update private files.
- `revdoku files`, `revdoku read PATH` — list and read stored files and email.
- `revdoku mailbox --mailbox-id ID` — check the incoming address and receiving state.
- `revdoku versions`, `revdoku restore ID` — inspect and restore history.
- `revdoku status`, `revdoku ls` — inspect the connection and mailboxes.
- `revdoku dashboard`, `revdoku --help` — open the dashboard or command reference.

## Hosted and web agents

The hosted MCP endpoint is `https://mcp.revdoku.com`. Signup tools are public; account tools use OAuth. See [MCP signup](mcp.md#direct-mcp-signup).
Create an account through private MCP signup or browser signup, then connect with
OAuth before using account tools.

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
`https://mcp.revdoku.com`. MCP manifests use OAuth, and every tool descriptor requires OAuth.

See [CHANGELOG.md](./CHANGELOG.md), [api.md](./api.md), and the
[MCP mailbox guide](./mcp.md).

### Agency client accounts

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

An agency and its clients share account capacity. Each client keeps separate
files, members, and branding.
Account names and client names can differ. Unknown client names stay unset.
`revdoku account --account-id ID` shows a client’s identity and provider guidance;
client billing data remains restricted to the agency owner. Browser switching
does not change the CLI credential’s default account.

### Custom receiving domains

Check custom-domain availability in Account Settings. Setup lives in Account
Settings → Domains → Email and requires an account administrator. Prefer an unused
receiving subdomain; dedicated root domains are accepted. DNS changes require the
user's authorization. Connecting a domain does not change existing mailbox addresses.
Use only the full address returned by Revdoku and check `receiving_enabled`. A domain switch
may return `assignment.status: pending`; poll until active or failed, keeping the
current address in use meanwhile. Never construct aliases or use `+tag` variants.
See [the email API contract](https://revdoku.com/api.md#custom-email-domains).

### CLI safety boundaries

Uploads require an explicit path; use `revdoku upload .` to select the current
folder. `revdoku upload PATH --dry-run` lists files, exclusions and bytes without
connecting or changing a mailbox. The public CLI connects to the Revdoku API only
at `https://api.revdoku.com`. `--url` and `REVDOKU_URL` also accept the previous
`https://app.revdoku.com` setting and route its API calls to the new host.
Browser sign-in and dashboard links use `https://app.revdoku.com`.
Storage transfers use approved HTTPS origins.

`revdoku delete --account-id ACCOUNT --mailbox-id MAILBOX` previews permanent
deletion. Review the target and irreversible effect with the user, then repeat with
`--confirm-delete TOKEN` using that preview's token. It expires after ten minutes
and is consumed before submission. On an uncertain response, check mailbox status
before creating another preview. Existing scripts must supply upload paths and
use the deletion confirmation step.

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
revdoku read invoices.csv --mailbox-id bkt_... --reason "Reconcile September expenses"
revdoku upload ./approved.csv --mailbox-id bkt_... --reason "Store the approved totals"
```
