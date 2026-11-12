# Revdoku CLI

Revdoku provides buckets: each has a mailbox, private files and an optional site. Use the CLI
from your terminal or automation to read email and attachments and store files. This standalone installation adds one `revdoku` executable. It does not
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
revdoku files --bucket-id bkt_...
revdoku tickets --bucket-id bkt_... --status open
revdoku ticket tkt_... --bucket-id bkt_...
revdoku ticket-messages tkt_... --bucket-id bkt_...
revdoku ticket-messages tkt_... --message-id eml_... --bucket-id bkt_...
revdoku ticket-download tkt_... --message-id eml_... --attachment-id df_... --bucket-id bkt_... --output attachment.pdf
revdoku ticket-reply tkt_... --text "Thanks, received." --bucket-id bkt_...
revdoku ticket-update tkt_... --status solved --bucket-id bkt_...
revdoku ticket-message-delete tkt_... --message-id eml_... --bucket-id bkt_... --confirm-delete eml_...
revdoku upload ./project-files --bucket-id bkt_...
```

A ticket is one conversation with a requester: an email or a message left on the docs site
(`channel` `chat`). `tickets` lists them, newest activity first; filter with
`--status`, `--channel`, `--label` and `--updated-after TIME`. `ls` shows each bucket's `email.address`.

Use returned ticket, message and attachment IDs for ticket operations; use paths for file operations.
Run `ticket-message-delete` only after you confirm the message ID.
`ticket-reply` sends a reply from the bucket's address and never retries. Revdoku sends only replies:
the reply goes to the ticket's requester, when that requester passed SPF or DMARC.
There is no `--to` or `--cc`. Check `delivery.status` with `ticket-messages`.
After an uncertain result, check the ticket's messages before you reply again.
A person sends, edits or declines an `awaiting_approval` reply in
the dashboard; do not send it again, or a `declined` reply unless a person asks.

Uploading without an existing mailbox binding can create a bucket and consume
creation capacity. Pass `--bucket-id` to store files in an existing mailbox. `revdoku create` creates an empty bucket. Omit `--username` to
use the title's name or a generated name. On `revdokumail.com`, the username is the bucket's name, with no
suffix: `--username acme-docs` gives `acme-docs@revdokumail.com`, and its site uses the same name. A custom domain takes the exact name.
An unavailable name returns `EMAIL_ALREADY_EXISTS`.
`--title TEXT` names the bucket; without it, the title is the username.
`--template docs-api` (API docs) or `--template docs-product` (the docs of an app) starts the bucket with a docs site; then run `revdoku publish`.
Creation returns when receiving is ready. Use the returned address.

See [the API reference](https://docs.revdoku.com/api) and `revdoku --help` for commands, scopes,
quota errors, and confirmation requirements. For AI integration, use the
[skill and plugin installation guide](https://github.com/revdoku/revdoku#local-ai-apps).

## Uninstall

Remove the executable from the directory you selected. Your remote buckets and
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
| `revdoku webhook --bucket-id ID` | Read the configured endpoint |
| `revdoku webhook-set --bucket-id ID --webhook-url HTTPS_URL` | Set one signed webhook; save the returned secret privately |
| Add `--rotate-secret` | Replace the signing secret and cancel pending deliveries |
| `revdoku webhook-delete --bucket-id ID --confirm-delete ID` | Disable deliveries |
| `revdoku events-subscription --bucket-id ID` | Get a WebSocket URL and a short-lived subscription token |

Use `--account-id ID` to select an authorized account. A running receiver is required. See the [examples](https://github.com/revdoku/docs/tree/main/examples) for signature verification and WebSocket reconnect/catch-up. Human administrators can inspect delivery attempts and retry failures in **Analytics → Webhooks**.

### GitHub repository

A bucket's files can be a copy of one branch of a GitHub repository, or of one folder of it.
These commands need an account owner or administrator key with admin access to all buckets.

| Command | Purpose |
| --- | --- |
| `revdoku github accounts` | List the GitHub accounts connected to the account |
| `revdoku github setup-link --bucket-id ID` | Print the links that a person opens, signed in to Revdoku, to add a GitHub account |
| `revdoku github repos INSTALLATION_ID` | List the repositories that one GitHub account lets Revdoku read |
| `revdoku github connect OWNER/NAME --bucket-id ID` | Copy the repository into the bucket. Add `--branch`, `--repo-path` or `--push-revdoku-edits false`. A bucket with files needs `--bucket-files replace` (the repository's files replace them) or `--bucket-files copy` (they become the first commit of an empty repository) |
| `revdoku github --bucket-id ID` | Show the repository and its sync state. Publish after `last_synced_at` is set |
| `revdoku github sync --bucket-id ID` | Sync now |
| `revdoku github branches --bucket-id ID` | List the branches that a preview can show |
| `revdoku preview --bucket-id ID --branch NAME` | Make a 24-hour preview of that branch. Needs a live site |
| `revdoku github set --bucket-id ID --auto-commit true` | Change `--auto-publish`, `--push-revdoku-edits` or `--auto-commit` |
| `revdoku github disconnect --bucket-id ID --confirm-delete ID` | Stop the sync. The bucket keeps its files |

`github connect` never retries. When the GitHub account is not connected, it prints the links for the person.
