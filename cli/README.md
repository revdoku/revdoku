# Revdoku CLI

Use Revdoku from your terminal or automation to store files and read incoming
email. This standalone installation adds one `revdoku` executable. It does not
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
revdoku ls
revdoku inbox --bucket-id bkt_...
revdoku files --bucket-id bkt_...
revdoku read '_email/inbox/.../message.json' --bucket-id bkt_...
revdoku upload ./project-files --bucket-id bkt_...
```

Use a returned file path rather than constructing an email path yourself.
`inbox` reports the receiving address, readiness, and message activity. Revdoku
receives email and attachments; sending and replies are unavailable.

For automation, set `REVDOKU_API_KEY` through your secret manager or environment.
Use `--account-id acct_...` when selecting another authorized account. Credentials
and selection state otherwise live under `~/.revdoku/`; keep them private.

Uploading without an existing bucket binding can create a bucket and consume
creation capacity. The CLI currently has no standalone empty-inbox creation
command; use the [API examples](../examples/README.md) for that workflow.

See [the API reference](../api.md) and `revdoku --help` for commands, scopes,
quota errors, and confirmation requirements. For AI integration, use the
[skill and plugin installation guide](../README.md#local-ai-apps).

## Uninstall

Remove the executable from the directory you selected. Your remote buckets and
files remain. Remove `~/.revdoku/` separately only if you also want to remove
saved local credentials and preferences.
