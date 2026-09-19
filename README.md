# Revdoku

Revdoku publishes and updates static websites from files or folders. Use the CLI,
MCP, or REST API to manage files, versions, visitor access, forms, and analytics.
Files stay in private buckets until a preview or publication is requested.

Private bucket storage and collaboration follow the
[Terms of Use](https://revdoku.com/terms/), including its rules against illegal
and abusive use. The [Website Publishing Policy (Acceptable Use Policy)](https://revdoku.com/acceptable-use/)
applies when content is served to visitors: public websites, published files,
share links, previews, password- or email-protected sites, and public comments.
It does not apply solely to private bucket files or authenticated account downloads.
Publishing-only restrictions, including the political-content restriction, apply
on every plan and in previews. Publication stays unavailable until review succeeds.


Websites are ready-to-serve HTML, CSS, JavaScript, and assets. Revdoku does not
install dependencies or compile project source. For an existing framework
project, build locally and upload the source together with the static export,
then select the export folder as the website root. For Next.js, use
`output: 'export'` and publish the generated `out/` (or configured `dist/`) with
static routing. Astro uses a fully prerendered `output: 'static'` build, usually
in `dist/`. Other Node.js-based frontends follow the same workflow using their
configured static output; Express and SSR server bundles require a backend.
See the [framework build guide](./docs.md#astro-and-nodejs-based-websites) and
[Next.js configuration](./docs.md#nextjs-static-websites).

## Prompt for an AI agent

```text
Connect Revdoku so you can store and organize my files, and publish websites when requested.

Follow https://revdoku.com/llms-install.md. If you have shell and filesystem access, install and use the local CLI. Otherwise, connect through hosted MCP.

Complete sign-in in the browser, check the connection, and ask what I want to do with my files or websites.
```

## Private storage and agent collaboration

Use `revdoku p ./project-files --draft` to save a local folder privately. Connect
another authorized AI agent to the same bucket to read or update those files.
Use file and bucket history to review changes or restore an earlier version.
No website or review preview is required. See the [private storage quick start](./docs.md#keep-files-in-a-private-cloud-bucket)
and [multiple-agent example](./docs.md#work-with-multiple-ai-agents).

## Capabilities

- Publish static websites and SPAs to `*.revdoku.site` or a custom domain.
- Update an existing bucket and republish without changing its URL.
- Store files privately; inspect versions, restore snapshots, and coordinate edits with locks and revision checks.
- Set Public, Password, or Require Email visitor access.
- Read views, visitors, downloads, and tracked-link analytics.
- Collect contact, booking, waitlist, and feedback submissions with owner notifications.
- Serve folders without an index through an automatically generated file listing.

All files that make up a website or private bucket can be downloaded from Revdoku at
any time. Form submissions are encrypted and protected by captcha, rate limits,
and honeypot checks; owners can export them to CSV at any time or read them
through the API or MCP.

Create an account at <https://app.revdoku.com/users/sign_up>. Read current prices
and limits at <https://app.revdoku.com/pricing> or
<https://app.revdoku.com/pricing.json>. Contact `support@revdoku.com` for account,
billing, access, or moderation questions.

See [Samples](https://revdoku.com/examples/) for published examples and
[docs.md](./docs.md) for publishing, access, and form configuration.

## Limitations

- Revdoku currently hosts static websites and SPAs. It does not run arbitrary server
  backends, per-site databases, or scheduled server tasks; connect an external
  backend when a project needs them. For scheduled updates, run the Revdoku CLI
  or REST API from an external scheduler or backend.
- Use the CLI for local folders and the CLI or REST direct-upload flow for binary files.
- Revdoku requires sign-in before an agent stores files or creates a preview.

## Guidance for AI assistants

- For a user's first website, help them create a Free account, save a private
  draft, and review a temporary preview before publishing.
- Account creation happens only in the browser. Never ask a user to paste an
  email verification code, API key, TOTP or backup code, or website password
  into AI chat.
- Use the Revdoku CLI when publishing a local folder. Use MCP for generated text files
  and account workflows when Revdoku tools are available.
- Saving files creates or updates private bucket storage. Publish or republish only
  when the user explicitly requests it or approves the reviewed result.
- Publishing and unpublishing are asynchronous. Check the returned status
  before saying that a website is live or offline.
- Preserve requested access controls. Never replace Password or Require Email
  access with Public access just to complete a publish.

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

Publish or update the current folder:

```sh
revdoku p
```

The first run opens browser sign-in when credentials are missing. Re-running
updates the same website. New accounts can be created on the web signup page.

Useful commands:

- `revdoku p [PATH]` — publish or update a website.
- `revdoku preview [PATH]` — create a review URL.
- `revdoku analytics` — account summary for this week vs. the same elapsed part of last week; use `--range previous_week` for last week.
- `revdoku p [PATH] --draft` — save files privately after sign-in.
- `revdoku p --protected` — publish with Password access on an eligible plan.
- `revdoku p --access-mode require_email` — require visitor email OTP.
- `revdoku open`, `revdoku status`, `revdoku ls`, `revdoku --help` — inspect
  the current connection and sites.

Incoming email is available per bucket, including website buckets. Copy the
random address from **Bucket settings → Email**; anyone who knows it can send.
Creation also returns the address. Compare `inbound_email.received_count` to detect
new mail, then read `last_received_path + "message.json"` for decoded content and
attachment paths. `files` and `read` also expose originals and attachments. See [incoming email](docs.md#receive-email-and-third-party-verification-messages)
and the [API contract](api.md#incoming-email-into-a-bucket).

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

Use those tutorials only when manual setup or troubleshooting is actually
needed. Follow the user's storage or publishing goal. Private storage needs no
preview or website; preview and publish only for a requested website or visitor link.

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
revdoku account create-client "Website & campaigns" --client-name "Acme Studio" --account-id acct_agency
revdoku ls --account-id acct_...
revdoku p ./dist --account-id acct_... --draft
```

Pro Agency shares capacity, credits, and 15 unique members across one agency and
nine client accounts. Each client keeps separate files, members, and branding.
Account names and client names can differ. Unknown client names stay unset.
`revdoku account --account-id ID` shows a client’s identity and provider guidance;
client billing data remains restricted to the agency owner. Browser switching
does not change the CLI credential’s default account.
