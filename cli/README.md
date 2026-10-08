# Revdoku CLI

Use Revdoku from your terminal or automation to read email and attachments
and store additional files. This standalone installation adds one `revdoku` executable. It does not
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
checksums from that same release, and verify before running:

```sh
# In the directory containing those two downloaded files:
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
revdoku mailbox --mailbox-id bkt_...
revdoku files --mailbox-id bkt_...
revdoku emails --mailbox-id bkt_...
revdoku email eml_... --mailbox-id bkt_...
revdoku email-status eml_... --mailbox-id bkt_... --read false
revdoku email-download eml_... --mailbox-id bkt_... --attachment-id df_... --output attachment.pdf
# Delete only after confirming the email ID:
revdoku email-delete eml_... --mailbox-id bkt_... --confirm-delete eml_...
revdoku upload ./project-files --mailbox-id bkt_...
```

Use returned email and attachment IDs for message operations; use paths for file operations.
`mailbox` reports the receiving address, readiness, and message activity. Revdoku
receives email and attachments.

Create accounts at https://app.revdoku.com/users/sign_up. CLI sign-in uses browser OAuth.

For automation, set `REVDOKU_API_KEY` through your secret manager or environment.
Use `--account-id acct_...` when selecting another authorized account. Credentials
and selection state otherwise live under `~/.revdoku/`; keep them private.

Uploading without an existing mailbox binding can create a mailbox and consume
creation capacity. `revdoku create` creates an empty mailbox. Omit `--username` to
generate a name. Free adds a permanent 12-character random suffix to the requested
prefix. An exact available name requires a paid plan. Reserved shared-domain words
return an explanation and guidance for using your own verified domain.
Creation returns when receiving is ready. Use the returned address.

See [the API reference](../api.md) and `revdoku --help` for commands, scopes,
quota errors, and confirmation requirements. For AI integration, use the
[skill and plugin installation guide](../README.md#local-ai-apps).

## Uninstall

Remove the executable from the directory you selected. Your remote mailboxes and
files remain. Remove `~/.revdoku/` separately only if you also want to remove
saved local credentials and preferences.

### Account limits

```sh
revdoku account limits
revdoku account limits --account-id acct_RETURNED_ID
```

Returns effective mailbox and file quotas under `data.limits`.

### New email notifications

| Command | Purpose |
| --- | --- |
| `revdoku webhook --mailbox-id ID` | Read the configured endpoint |
| `revdoku webhook-set --mailbox-id ID --webhook-url HTTPS_URL` | Set one signed webhook; save the returned secret privately |
| Add `--rotate-secret` | Replace the signing secret and cancel pending deliveries |
| `revdoku webhook-delete --mailbox-id ID --confirm-delete ID` | Disable deliveries |
| `revdoku email-subscription --mailbox-id ID` | Get a WebSocket URL and short-lived ticket |

Use `--account-id ID` to select an authorized account. A running receiver is required. See the [examples](../examples/README.md) for signature verification and WebSocket reconnect/catch-up. Human administrators can inspect delivery attempts and retry failures in **Analytics → Webhooks**.
