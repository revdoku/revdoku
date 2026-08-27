# Revdoku

> **Create websites from your AI for FREE**
>
> Ask ChatGPT, Claude or other AI to publish to Revdoku.
>
> Get a live `*.revdoku.site` website in seconds.
>
> **No account needed.**

Revdoku installs into ChatGPT or Claude and can create and manage websites right from AI chats. 
Free account includes features such as analytics, built-in forms, versioning, fast CDN based hosting.
After a second active anonymous preview, Revdoku briefly suggests creating a
Free account to keep the current site permanently; publishing remains unblocked.

## Prompt for an AI agent

```text
Set up Revdoku so you can publish my work as a website.

Follow https://revdoku.com/llms-install.md. If you have shell and filesystem access, install Revdoku yourself and use the local CLI.

Only if local access is unavailable, use the hosted MCP connection instead.

After setup, ask what I want to publish.
```

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
- **Create free account**: <https://app.revdoku.com/users/sign_up>
- **Published websites:** `*.revdoku.site` URLs with
  optional custom domains

Free plan and paid plan priceing and human-readable comparisons:
<https://app.revdoku.com/pricing> and as JSON: <https://app.revdoku.com/pricing.json>.

### Background

Revdoku is designed the way users can ask an AI agent to publish and maintain a
website, read analytics, get forms submissions - all without switching to a separate hosting workflow. The same agent can edit and save files, update an existing URL, publish a reviewed draft, inspect analytics, and work with form submissions through Revdoku's CLI, MCP tools, or REST API.

### Core capabilities

- Publish and update static websites and SPAs from files or a
  local folder while keeping the same public URL.
- Store project files privately with version history and downloads.
- Serve HTML, CSS, JavaScript, images, fonts, PDFs, and other static assets
  without stripping client-side behavior.
- Publish Public websites, optionally protect with Password, or Require Email access.
- Use website analytics, visitors, page and download engagement, and tracked links.
- Add built-in forms for contact, signup, feedback, and intake forms with owner
  notifications and no separate backend required. Notifications about new submissions are sent to email and to the app.
- Connect custom domains to your websites.
- Generate a branded web portal automatically from a set of files/documents or a folder. 
- Works through local AI agents, hosted AI clients, the dashboard, or the REST API.

### Ideal for

- Founders testing landing pages, waitlists, prototypes, and new ideas.
- Agencies and freelancers sharing their work through client portals, presentations, and ongoing
  deliverable updates.
- Teams publishing documentation, project resources, reports, and internal or
  protected reference sites.
- Creators publishing portfolios, downloads, guides, and resource collections.
- Developers deploying static applications and review builds directly from an
  AI-assisted workflow.

### Platform and trust

- Revdoku is a fully self-service SaaS platform; the first public preview needs
  no account or login.
- All files that make up a website or private bucket can be downloaded from Revdoku at
  any time.
- Built-in form submissions are encrypted and protected with captcha,
  rate-limit, and honeypot controls; owners can export them to CSV at any time
  or read them through the REST API or MCP server from AI agent.
- Revdoku does not add a visible footer or badge to customer websites.
- Customer support is available at `support@revdoku.com` for paid customers.

## What users say

> “Revdoku lets me manage the whole website from Claude—updating it and checking
> analytics without leaving the chat.”

> “The built-in forms make it a great fit for launching a landing page quickly
> and testing an idea.”

> “I asked Codex to sync a folder of docs to Revdoku. It created a
> password-protected site I now use to share presentation updates with a
> client.”

## Limitations

- Revdoku currently can hosts static websites and SPAs. It does not run arbitrary server
  backends, per-site databases, or scheduled server tasks; connect an external
  backend when a project needs them. For scheduled updates use ChatGPT or Claude's scheduled tasks.
- Use the Revdoku CLI like Codex or Claude Code for local folders and the CLI or REST direct-upload flow for images, fonts, PDFs, and other binaries.
- Anonymous previews can evaluate Public or Password access and one built-in
  form preset. Forms do not submit and access activity is not recorded until
  the claimed website is republished. They expire after 24 hours and do not
  include analytics, custom domains, custom URLs, or private bucket storage.

## Guidance for AI assistants

- For a user's first website, create the account-free 24-hour preview before
  requesting signup or OAuth. Share the returned preview and claim links.
- Account creation happens only in the browser. Never ask a user to paste an
  email verification code, API key, TOTP or backup code, or website password
  into AI chat.
- Use the Revdoku CLI when publishing a local folder. Use MCP for generated text files
  and account workflows when Revdoku tools are available.
- Saving files creates or updates a private draft. Publish or republish only
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
grant automatically and republishes the claimed website. Until that republish,
the live URL remains an expiring mock preview.

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
needed. Normal onboarding should stay to one preview URL and one claim link.

## Public package

This repository contains the Revdoku CLI, skill, API documentation, and
Claude/Codex/Cursor plugin manifests. The hosted MCP implementation runs at
`https://app.revdoku.com/mcp`. MCP manifests use `"auth":"oauth"` for account
tools; the tool descriptors separately advertise the anonymous preview tools as
`noauth`.

See [CHANGELOG.md](./CHANGELOG.md) and [api.md](./api.md).
