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
revdoku ticket-reply tkt_... --text "Thanks, received." --project-id prj_...
revdoku ticket-update tkt_... --status solved --project-id prj_...
revdoku ticket-update tkt_... --note "Promised a refund by Friday." --project-id prj_...
revdoku tickets --status pending --project-id prj_...
revdoku ticket-message-delete tkt_... --message-id eml_... --project-id prj_... --confirm-delete eml_...
revdoku github connect OWNER/NAME --project-id prj_...
```

A ticket is one conversation with a requester: an email or a message left on the docs site
(`channel` `chat`). `tickets` lists them, newest activity first; filter with
`--status`, `--channel`, `--label` and `--updated-after TIME`. `ls` shows each project's `email.address`.

Use returned ticket, message and attachment IDs for ticket operations; use paths for file operations.
Run `ticket-message-delete` only after you confirm the message ID.
`ticket-reply` sends a reply from the project's address and never retries. Revdoku sends only replies:
the reply goes to the ticket's requester, when that requester passed SPF or DMARC.
There is no `--to` or `--cc`. Check `delivery.status` with `ticket-messages`.
After an uncertain result, check the ticket's messages before you reply again.
A person sends, edits or declines an `awaiting_approval` reply in
the dashboard; do not send it again, or a `declined` reply unless a person asks.

`revdoku create` creates an empty project. Omit `--username` to
use the title's name or a generated name. Every project gets an incoming email address on the built-in domain: the username is the
project's name, so `--username acme-docs` gives `support@acme-docs.revdoku.net`, and its site uses the same name. A custom domain takes the exact name.
An unavailable name returns `EMAIL_ALREADY_EXISTS`.
`--title TEXT` names the project; without it, the title is the username.
A project's `_repo/` folder is a read-only copy of its GitHub repository: connect one with `revdoku github connect`, then run `revdoku publish`.
Its `_kb/` folder is the knowledge base, which you write: `_kb/public/` is published with the site, and `_kb/private/` is never published.

| Command | What it does |
| --- | --- |
| `revdoku write _kb/private/refunds.md --file refunds.md --project-id ID` | Write a page (`.md`, `.mdx`) or an image (`.jpg`, `.png`, `.webp`). `--file -` reads a page from standard input |
| `revdoku mv _kb/private/refunds.md _kb/public/refunds.md --project-id ID` | Move or rename a knowledge base file. A move to or from `_kb/public/` needs publish access |
| `revdoku rm _kb/private/old.md --project-id ID` | Delete a knowledge base file. Its versions stay: keep the file ID of the answer |
| `revdoku restore _kb/private/refunds.md --version-id ID --project-id ID` | Make an earlier version current. `revdoku versions PATH` lists the versions. For a deleted file, use its file ID (`df_...`) in place of the path: it comes back |
| `revdoku files --folder _kb/private --project-id ID` | List the files of one folder |

A write never publishes: run `revdoku publish` to show the public files on the site.
Creation returns when receiving is ready. Use the returned address.

See [the API reference](https://support.revdoku.com/docs/api) and `revdoku --help` for commands, scopes,
quota errors, and confirmation requirements. For AI integration, use the
[skill and plugin installation guide](https://github.com/revdoku/revdoku#local-ai-apps).

## Uninstall

Remove the executable from the directory you selected. Your remote projects and
files remain. Remove `~/.revdoku/` separately only if you also want to remove
saved local credentials and preferences.

### Account limits

```sh
revdoku account limits
revdoku account limits --account-id acct_RETURNED_ID
```

Returns effective mailbox and file quotas under `data.limits`.

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
| `revdoku github connect OWNER/NAME --project-id ID` | Copy the repository into the project. Revdoku only reads the repository. Add `--branch` or `--repo-path`. A project with files needs `--project-files replace` (the repository's files replace them) |
| `revdoku github --project-id ID` | Show the repository and its sync state. Publish after `last_synced_at` is set |
| `revdoku github sync --project-id ID` | Sync now |
| `revdoku github branches --project-id ID` | List the branches that a preview can show |
| `revdoku preview --project-id ID --branch NAME` | Make a 24-hour preview of that branch. Needs a live site |
| `revdoku publish --project-id ID --support-link URL` | Publish, and send visitors who want a person to your support page (an `https` page such as your GitHub Discussions). `--support form\|form_email\|email\|link` sets the way without a new link |
| `revdoku github set --project-id ID --auto-publish false` | Change `--auto-publish` |
| `revdoku github disconnect --project-id ID --confirm-delete ID` | Stop the sync. The project keeps its files |

`github connect` never retries. When the GitHub account is not connected, it prints the links for the person.
