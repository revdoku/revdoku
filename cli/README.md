# Revdoku CLI

A Revdoku project holds one docs site: its files, the published site, the site analytics and the support email with its tickets. Use the CLI
from your terminal or automation to publish sites, read and answer support requests and store files. This standalone installation adds one `revdoku` executable. It does not
install skills, plugins, or AI app configuration.

## Install

Use macOS, Linux, or Windows through WSL, with Bash, curl, OpenSSL, jq, base64 and
find available. For example, install jq with `brew install jq` on macOS or your
Linux package manager.

Download the installer from the [latest CLI release](https://github.com/revdoku/revdoku/releases/latest):

```sh
curl -fsSL https://github.com/revdoku/revdoku/releases/latest/download/install-cli.sh -o install-cli.sh
bash install-cli.sh
export PATH="$HOME/.local/bin:$PATH"
revdoku --version
revdoku --help
```

The installer verifies the executable against its embedded SHA-256 checksum
before replacing it. It defaults to `~/.local/bin`; use
`bash install-cli.sh --dir /your/bin` to choose a directory. It leaves shell
configuration unchanged. To update, download and run the latest installer again.

### Direct download or pinned version

Each `cli-vX.Y.Z` release includes `revdoku`, `install-cli.sh`, `LICENSE`, and
`SHA256SUMS`. Select a version on the Releases page, download the executable and
checksums from that same release, and verify before running. Run this in the
directory with those two downloaded files:

```sh
expected=$(awk '$2 == "revdoku" { print $1 }' SHA256SUMS)
actual=$(openssl dgst -sha256 revdoku | awk '{print $NF}')
if test -n "$expected" && test "$actual" = "$expected"; then
  chmod +x revdoku && ./revdoku --version
else
  echo 'Checksum mismatch; do not run this download.' >&2
fi
```

The executable is a readable Bash script, shared by supported architectures.
Its version is embedded, so it also works outside an installed skill.

## Connect and use

```sh
revdoku login
revdoku status
revdoku accounts
revdoku account get acct_...
revdoku ls
revdoku create --username acme-orders
revdoku files --project-id prj_...
revdoku tickets --project-id prj_... --status open
revdoku ticket tkt_... --project-id prj_...
revdoku ticket-messages tkt_... --project-id prj_...
revdoku ticket-messages tkt_... --message-id eml_... --project-id prj_...
revdoku ticket-download tkt_... --message-id eml_... --attachment-id eat_... --project-id prj_... --output attachment.pdf
revdoku ticket-draft tkt_... --project-id prj_...
revdoku ticket-reply tkt_... --text "Thanks, received." --project-id prj_...
revdoku ticket-update tkt_... --status solved --project-id prj_...
revdoku ticket-update tkt_... --note "Promised a refund by Friday." --expected-note "" --project-id prj_...
revdoku tickets --status pending --project-id prj_...
revdoku ticket-message-delete tkt_... --message-id eml_... --project-id prj_... --confirm-delete eml_...
revdoku github scan OWNER/NAME --project-id prj_...
revdoku github connect OWNER/NAME --repo-path docs --project-id prj_...
revdoku scan acme.com --project-id prj_...
revdoku publish --project-id prj_...
revdoku settings set --file settings.json --project-id prj_...
revdoku update --title "Acme Docs" --project-id prj_...
```

A ticket is one conversation with a requester: an email or a message left on the docs site
(`channel` `chat`). `tickets` lists them, newest activity first; filter with
`--status`, `--channel`, `--label` and `--updated-after TIME`. `ls` shows each project's `email.address`.

Use returned ticket, message and attachment IDs for ticket operations; use paths for file operations.
Run `ticket-message-delete` only after you confirm the message ID.
`ticket-reply` sends a reply from the project's address and never retries. Revdoku sends only replies:
the reply goes to the ticket's requester, when that requester passed SPF or DMARC.
There is no `--to` or `--cc`. Check `delivery.status` with `ticket-messages`.
`ticket-update --note TEXT` replaces the team's internal note. Add `--expected-note TEXT`, the note that you read
(`""` for a ticket without a note): when someone changed the note since, the answer is `TICKET_NOTE_CONFLICT` and nothing changes.
After an uncertain result, check the ticket's messages before you reply again.
A reply is sent at once. A message with `delivery.status` `awaiting_approval` is a draft of Revdoku's own agent
that a person sends in the dashboard; do not send it again, or a `declined` reply unless a person asks.
`ticket-draft` lets Revdoku's AI reply drafter write a reply from the project's docs, and waits for it. It sends nothing:
send the text with `ticket-reply`. `ticket-draft ID --read` shows the newest draft without a new one.

## Background work

A publish, a preview, the copy of a GitHub repository, a website scan and a draft run in the background. Each has `status`:
`queued`, `processing`, `ready` or `failed`. A failed one has `error` with a `code` and a `message`.
`publish`, `preview`, `scan`, `github connect`, `github sync` and `ticket-draft` wait until the status is `ready` or `failed`,
then print the answer. The exit code is 0 when it is ready, 1 when it failed and 2 when it still runs after 5 minutes.
A start that meets work that runs (`PUBLICATION_PUBLISH_IN_PROGRESS`, `GITHUB_SYNC_IN_PROGRESS`, `WEBSITE_SCAN_RUNNING` or `DRAFT_IN_PROGRESS`)
is an error: the command sent no work, so it prints the error and its `next_action` and exits 1 without a wait. It does not send the start again.
`--no-wait` answers at once; read the resource later with `site`, `github`, `scan --read` or `ticket-draft ID --read`.
A read of a resource that does not exist yet answers it as `null`: `site` of a project without a site prints `{"success": true, "data": {"publication": null}}`.
While a command waits for work that it started, `null` is not the end: it reads again.
`unpublish` does not wait. It prints the answer of a delete, `{"success": true, "data": {"deleted": true, "id": "..."}}`, and the site goes offline in the background:
`site` then shows `live` false and `offline_reason` `unpublished`. A second `unpublish` answers `PUBLICATION_NOT_FOUND`.

`revdoku create` creates an empty project. Omit `--username` to
use the title's name or a generated name. Every project gets an incoming email address on the built-in domain: the username is the
project's name, so `--username acme-docs` gives `support@acme-docs.revdoku.net`, and its site uses the same name. A custom domain takes the exact name.
An unavailable name returns `EMAIL_ALREADY_EXISTS`.
`--title TEXT` names the project; without it, the title is the username. `revdoku update --title TEXT` renames a project, and
`--description TEXT` changes its description: the only fields that `update` changes.
A project's `_repo/` folder is a read-only copy of its GitHub repository: scan it with `revdoku github scan`, connect one with `revdoku github connect`, then run `revdoku publish`.
Its `_kb/` folder is the knowledge base, which you write: `_kb/public/` is published with the site, and `_kb/private/` is never published.

| Command | What it does |
| --- | --- |
| `revdoku write _kb/private/refunds.md --file refunds.md --project-id ID` | Write a page (`.md`, `.mdx`) or an image (`.jpg`, `.png`, `.webp`). `--file -` reads a page from standard input |
| `revdoku mv _kb/private/refunds.md _kb/public/refunds.md --project-id ID` | Move or rename a knowledge base file. A move to or from `_kb/public/` needs publish access |
| `revdoku rm _kb/private/old.md --project-id ID` | Delete a knowledge base file. Its versions stay: keep the file ID of the answer |
| `revdoku restore _kb/private/refunds.md --version-id ID --project-id ID` | Make an earlier version current. `revdoku versions PATH` lists the versions. For a deleted file, use its file ID (`df_...`) in place of the path: it comes back |
| `revdoku files --folder _kb/private --project-id ID` | List the files of one folder |

`write`, `mv`, `rm` and `restore` take `--expected-project-version ID`, the `project_version` of the project that you read
(`revdoku ls`). When the project changed since, the answer is `PROJECT_VERSION_CONFLICT` and nothing changes.
A write never publishes: run `revdoku publish` to show the public files on the site.
Creation returns when receiving is ready. Use the returned address.

See [the API reference](https://support.revdoku.com/docs/api) and `revdoku --help` for commands, scopes,
quota errors, and confirmation requirements. For AI integration, use the
[skill and plugin installation guide](https://github.com/revdoku/revdoku#local-ai-apps).

## Uninstall

Remove the executable from the directory you selected. Your remote projects and
files remain. Remove `~/.revdoku/` separately only if you also want to remove
saved local credentials and preferences.

### Status and account limits

These commands print the JSON of the API on standard output. Notes for people go to standard error.

```sh
revdoku status
revdoku account limits
revdoku account limits --account-id acct_RETURNED_ID
revdoku account
```

`revdoku status` prints the answer of `GET /v1/status`: `data.status` has the account, the connection, the user,
`server_version`, `client_version` and `dashboard_url`. The connection has the shape of the answer of a sign-in, with `api_key` null.
`revdoku account limits` prints the answer of `GET /v1/account/limits`: one resource, `data.limits`, with the effective project, email and file
quotas, `credit_balance` (`left`, `monthly`, `next_refill_at`) and `usage` (null for a connection that may not read it).
`revdoku account` prints two resources in one answer: `data.status` (of `GET /v1/status`) and `data.limits` (of `GET /v1/account/limits`).

### Ticket events

| Command | Purpose |
| --- | --- |
| `revdoku webhook --project-id ID` | Read the configured endpoint |
| `revdoku webhook-set --project-id ID --webhook-url HTTPS_URL` | Set one signed webhook; save the returned secret privately |
| Add `--rotate-secret` | Replace the signing secret and cancel pending deliveries |
| `revdoku webhook-delete --project-id ID --confirm-delete ID` | Disable deliveries |
| `revdoku events-subscription --project-id ID` | Get a WebSocket URL and a short-lived subscription token |

Use `--account-id ID` to select an authorized account. A running receiver is required. See the [examples](https://github.com/revdoku/docs/tree/main/examples) for signature verification and WebSocket reconnect/catch-up. Human administrators can inspect delivery attempts and retry failures in **Analytics → Webhooks**.

### GitHub repository

A project's files can be a copy of one branch of a GitHub repository, or of one folder of it.
These commands need an account owner or administrator key with admin access to all projects.

| Command | Purpose |
| --- | --- |
| `revdoku github accounts` | List the GitHub accounts connected to the account |
| `revdoku github setup-link --project-id ID` | Print the links that a person opens, signed in to Revdoku, to add a GitHub account |
| `revdoku github repos INSTALLATION_ID` | List the repositories that one GitHub account lets Revdoku read |
| `revdoku github scan OWNER/NAME --project-id ID` | Read the file list of a branch and print `scan`: the docs folders with their format, `recommended_path`, and whether a folder looks like a site (`publishable`, `not_publishable_reason`). Nothing changes. Add `--branch`, `--repo-path` or `--installation-id`. Without `OWNER/NAME` it scans the connected repository |
| `revdoku github connect OWNER/NAME --project-id ID` | Copy the repository into the project. Revdoku only reads the repository. Add `--branch` or `--repo-path` (a folder of the branch, such as the scan's `recommended_path`; else `GITHUB_SYNC_PATH_NOT_FOUND`). A project with files needs `--project-files replace` (the repository's files replace them) |
| `revdoku github --project-id ID` | Show the repository and the `status` of its copy |
| `revdoku github sync --project-id ID` | Sync now, and wait for the copy |
| `revdoku github branches --project-id ID` | List the branches that a preview can show, in pages (`--limit`, `--cursor`) |
| `revdoku preview --project-id ID --branch NAME` | Make a 24-hour preview of that branch. Needs a live site |
| `revdoku publish --project-id ID --support-link URL` | Publish, and send visitors who want a person to your support page (an `https` page such as your GitHub Discussions). `--support form\|form_email\|email\|link\|none` sets the way without a new link; `none` leaves no way to a person |
| `revdoku publish --project-id ID --access-mode require_email --email-allowlist A,B` | Publish a site that only the listed addresses and domains open (the email-code gate). `--email-allowlist ""` removes the list. Private sites need Revdoku to turn them on for the account |
| `revdoku publish --project-id ID --confirm-source-code` | Publish a repository folder that looks like source code. Without it, a publish of such a folder without a live site answers `PUBLICATION_SOURCE_CODE` and builds nothing: a site serves every file of the folder. Use it only when the person agrees |
| `revdoku github set --project-id ID --auto-publish false` | Change `--auto-publish` |
| `revdoku github disconnect --project-id ID --confirm-delete ID` | Stop the sync. The project keeps its files |

`github connect` never retries. When the GitHub account is not connected, it prints the links for the person.

### Articles from a website

`revdoku scan URL... --project-id ID` (the addresses may come before or after the options) reads the public pages of a website, and an AI writes one article per page into `_kb/public/`.
One address reads that page and the pages it links; two or more addresses read exactly those pages. `--max-articles N` writes at most N articles.
The scan never replaces a file, and the articles wait for the next publish. It runs in the background and the command waits for it.
It is never sent again after an uncertain result: read it with `revdoku scan --read`. `revdoku scan --stop` stops the scan that runs;
the articles that it wrote stay. The scan is off unless Revdoku turned it on for the account (`WEBSITE_SCAN_UNAVAILABLE`), one scan runs
per project (`WEBSITE_SCAN_RUNNING`), and a daily limit applies (`WEBSITE_SCAN_LIMIT_REACHED`). Uses credits; see https://app.revdoku.com/pricing.json.

### Site settings

`revdoku settings --project-id ID` prints `site_settings`: the layout, the knowledge base address (`kb_path`), search indexing,
the badge, Ask, the way to a person (`support`), the header and footer (`navigation`), the color, the announcement, the redirect and
header rules (`redirects`, `headers`) and the analytics switches (`analytics`). A field is `null` when the project has no setting;
`support.handoff` is the way in force (`form` by default, `none` when no person can be reached). `revdoku settings set --file FILE --project-id ID` sends the fields of a JSON object
(`--file -` reads standard input). Only the fields that it sends change, and `null` removes a setting:

```json
{"layout": "notebook", "ask": {"title": "Questions"}, "navigation": {"links": [{"label": "Pricing", "href": "/pricing"}]}, "primary_color": "#2563eb"}
```

A change never publishes. `revdoku site` lists `republish_reasons` while the live site is older than the settings: run `revdoku publish` again.
A setting that the plan does not have answers `SITE_SETTING_UPGRADE_REQUIRED` with an upgrade link, only for a value that changes.
The analytics switches apply to the live site at once; the redirect and header rules reach it with the next publish.
The custom domain, the site address and the Email and Tickets settings change only in the dashboard.
A refused publish changes nothing, also not `--support`. A first publish that waits for the first copy is checked when the copy is done:
`site` then shows `status` `failed` with `error.code` `PUBLICATION_SOURCE_CODE`.
