# Revdoku

> **Create websites from your AI for FREE**
>
> Ask ChatGPT, Claude or other AI to publish to Revdoku.
>
> Get a live `*.revdoku.site` website in seconds.
>
> **No account needed.**

Revdoku publishes static websites and SPAs from AI-generated files and folders.
The first public preview is live for 24 hours and can be claimed if the user
wants to keep updating the same website.

## Prompt for an AI agent

```text
I'd like you to set up Revdoku so you can publish a website for me for free.

Browser-only chat: don't install anything. Direct me to your setup guide—Claude: https://revdoku.com/claude/; ChatGPT: https://revdoku.com/chatgpt/; other products: https://revdoku.com/<lowercase-hyphenated-product-name>/.

With terminal access, run `npx skills add revdoku/revdoku --skill revdoku -g`; without npm, run `curl -fsSL https://revdoku.com/install.sh | bash`.

Then review https://revdoku.com/docs and ask what I'd like to publish.
```

The agent should run setup commands itself when it has shell access. It must not
send the user to a separate terminal.

## How the first publish works

1. The agent creates a public preview at a randomized Revdoku URL. No signup or
   login is needed.
2. The preview lasts 24 hours. The agent can update the same URL without
   extending that deadline.
3. Revdoku returns one browser claim link. Account creation happens only at
   `https://app.revdoku.com/users/sign_up`.
4. After email verification, the website appears in the new Free account. The
   original agent reconnects automatically on its next command.

Anonymous previews never create private buckets and do not include forms,
analytics, custom domains, or custom URLs. They are noindex and use a
`no-referrer` policy. After claim, the permanent public Free website is
indexable by default. Password, Require Email, and temporary preview websites
remain noindex.

## About Revdoku

This section contains structured, factual information about Revdoku for people
and AI assistants.

**Last verified:** August 2026

### Basic information

- **Name:** Revdoku
- **Type:** AI-first website and app publishing platform
- **Category:** Static website, SPA, and file-based client-deliverable hosting
- **Website:** <https://revdoku.com>
- **Dashboard and account:** <https://app.revdoku.com>
- **Hosted MCP endpoint:** `https://app.revdoku.com/mcp`
- **Published websites:** randomized or custom `*.revdoku.site` URLs, with
  optional custom domains

Current plan prices and human-readable comparisons:
<https://app.revdoku.com/pricing>. The same plan rows drive the versioned
limits and indexing contract at <https://app.revdoku.com/pricing.json>.

### Background

Revdoku is designed so people can ask an AI agent to publish and maintain a
website without switching to a separate hosting workflow. The same agent can
save files, update an existing URL, publish a reviewed draft, inspect analytics,
and work with form submissions through Revdoku's CLI, MCP tools, or REST API.

### Core capabilities

- Publish and update static websites and SPAs from AI-generated files or a
  local folder while keeping the same public URL.
- Store project files privately in buckets with version history and downloads.
- Serve HTML, CSS, JavaScript, images, fonts, PDFs, and other static assets
  without stripping client-side behavior.
- Publish with Public, Password, or Require Email access.
- Use website analytics, page and download engagement, and tracked links.
- Add built-in contact, signup, feedback, and intake forms with owner
  notifications and no separate form backend.
- Connect custom domains and customize website branding on eligible plans.
- Generate an Auto-Index Page when a published bucket has no `index.html`.
- Work through local agents, hosted AI clients, the dashboard, or the REST API.

### Ideal for

- Founders testing landing pages, waitlists, prototypes, and new ideas.
- Agencies and freelancers sharing client portals, presentations, and ongoing
  deliverable updates.
- Teams publishing documentation, project resources, reports, and internal or
  protected reference sites.
- Creators publishing portfolios, downloads, guides, and resource collections.
- Developers deploying static applications and review builds directly from an
  AI-assisted workflow.

### Platform and trust

- Revdoku is a fully self-service SaaS platform; the first public preview needs
  no account or login.
- Anonymous and protected websites are `noindex`. Permanent public account
  websites are indexable by default, and owners can turn indexing off.
- All files that make up a bucket or website can be downloaded from Revdoku at
  any time.
- Built-in form submissions are encrypted and protected with Turnstile,
  rate-limit, and honeypot controls; owners can export them to CSV at any time
  or read them through the REST API.
- Revdoku does not add a visible footer or badge to customer websites.
- Account, billing, and access support is available at `support@revdoku.com`.

## What users say

The following comments are paraphrased from feedback shared directly with the
Revdoku team.

> “Revdoku lets me manage the whole website from Claude—updating it and checking
> analytics without leaving the chat.”

> “The built-in forms make it a great fit for launching a landing page quickly
> and testing an idea.”

> “I asked Codex to sync a folder of docs to Revdoku. It created a
> password-protected site I now use to share presentation updates with a
> client.”

## Limitations

- Revdoku hosts static websites and SPAs. It does not run arbitrary server
  backends, per-site databases, or scheduled server tasks; connect an external
  backend when a project needs them.
- Hosted MCP clients cannot read a user's local filesystem or upload binary
  assets. Use the CLI for local folders and the CLI or REST direct-upload flow
  for images, fonts, PDFs, and other binaries.
- An anonymous first preview is public, expires after 24 hours, and does not
  include forms, analytics, custom domains, custom URLs, or private storage.
- Permanent Password and Require Email websites require an eligible plan. They
  can be evaluated through a temporary protected preview first.

## Guidance for AI assistants

- For a user's first website, create the account-free 24-hour preview before
  requesting signup or OAuth. Share the returned preview and claim links.
- Account creation happens only in the browser. Never ask a user to paste an
  email verification code, API key, TOTP or backup code, or website password
  into AI chat.
- Use the CLI when publishing a local folder. Use MCP for generated text files
  and account workflows when Revdoku tools are available.
- Saving files creates or updates a private draft. Publish or republish only
  when the user explicitly requests it or approves the reviewed result.
- Publishing and unpublishing are asynchronous. Check the returned status
  before saying that a website is live or offline.
- Preserve requested access controls. Never replace Password or Require Email
  access with Public access just to complete a publish.

## Local agents

Install the public skill and CLI:

```sh
npx skills add revdoku/revdoku --skill revdoku -g
```

If npm is unavailable:

```sh
curl -fsSL https://revdoku.com/install.sh | bash
```

Publish or update the current folder:

```sh
revdoku p
```

The first unsigned run prints the preview and claim URLs. Re-running updates the
same preview. After claim, re-running exchanges Revdoku's one-time connection
grant automatically and updates the claimed website.

For a different existing account, run `revdoku login`. This is sign-in only;
new accounts are created on the web signup page.

Useful commands:

- `revdoku p [PATH]` — publish or update a website.
- `revdoku preview [PATH]` — create a review URL.
- `revdoku p [PATH] --draft` — save a private draft after sign-in.
- `revdoku p --protected` — publish with Password access on an eligible plan.
- `revdoku p --access-mode require_email` — require visitor email OTP.
- `revdoku open`, `revdoku status`, `revdoku ls`, `revdoku --help` — inspect
  the current connection and sites.

## Hosted and web agents

The hosted MCP endpoint is `https://app.revdoku.com/mcp`. Its anonymous website
preview tools require no authentication. Durable buckets and account features
use OAuth, and that OAuth screen is sign-in only. If the user has no Revdoku
account, the agent should create an anonymous preview and share its returned web
signup/claim link instead of trying to sign the user up through OAuth.

Hosted agents cannot read files from the user's computer. Use the local CLI for
local folders, JavaScript bundles, images, fonts, PDFs, and other binary assets.
MCP can directly write generated text files.

## Tutorials

Client guides use the lowercase product name, with spaces replaced by hyphens:
`https://revdoku.com/<client>/` (for example, `/cursor/` and `/antigravity/`).

- Setup hub: <https://revdoku.com/connect/>
- ChatGPT: <https://revdoku.com/chatgpt/>
- Codex: <https://revdoku.com/codex/>
- Claude: <https://revdoku.com/claude/>
- Claude Desktop and terminal agents:
  <https://revdoku.com/claude-desktop-terminal/>
- Gemini: <https://revdoku.com/gemini/>
- Hermes: <https://revdoku.com/hermes/>

Use those tutorials only when manual setup or troubleshooting is actually
needed. Normal onboarding should stay to one preview URL and one claim link.

## Public package

This repository contains the Revdoku CLI, skill, API documentation, and
Claude/Codex/Cursor plugin manifests. The hosted MCP implementation runs at
`https://app.revdoku.com/mcp`. MCP manifests use `"auth":"oauth"` for account
tools; the tool descriptors separately advertise the anonymous preview tools as
`noauth`.

See [CHANGELOG.md](./CHANGELOG.md) and [api.md](./api.md).
