# Revdoku

> **Cloud storage for AI.**
>
> Keep your files and folders private or share them as a website.
>
> Designed for humans and AI apps working together. Version history, access control, logs, and analytics.
>
> Free plan · No credit card required.

Store files and folders in Revdoku’s cloud. Work with them in the dashboard or connect compatible AI apps and agents, including Claude Code, Codex, Gemini, Cursor, Hermes, and OpenClaw. Humans and authorized agents can collaborate on the same bucket; publish selected files as a website only when needed.
Private buckets support documents, data, source files, version history, and change
logs. Website publications add visitor access controls, forms, analytics, and
CDN-based hosting. Each AI connection uses its own authorized access.

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
Set up Revdoku cloud storage so I can work with my AI apps and agents on the same files and folders. Keep them private, and share selected files as a website when I ask.

Follow https://revdoku.com/llms-install.md. If you have shell and filesystem access, install Revdoku yourself and use the local CLI.

Only if local access is unavailable, use the hosted MCP connection instead.

After setup, ask what I want to store, collaborate on, or publish.
```

## Private storage and agent collaboration

Use `revdoku p ./project-files --draft` to save a local folder privately. Connect
another authorized AI agent to the same bucket to read or update those files.
Use file and bucket history to review changes or restore an earlier version.
No website or review preview is required. See the [private storage quick start](./docs.md#keep-files-in-a-private-cloud-bucket)
and [multiple-agent example](./docs.md#work-with-multiple-ai-agents).

## Live Revdoku demos

Explore real websites published on Revdoku from ChatGPT and Claude AI:

- **Protected client delivery — [Folder to Website](https://presentation-magic-stories-protected.revdoku.site/):** Demo presentation and image folder delivered as a password-protected client website. The owner is notified after every unlock. **Password: `12345`.**
- **Lead generation — [B2B Lead Magnet](https://b2b-lead-magnet.revdoku.site/):** Demo lead-magnet website where visitors submit a form to open a PDF resource.
- **AI-updated dashboard — [Temperature Monitoring](https://temperature-monitoring.revdoku.site/):** Demo live dashboard with sensor data updated by connected AI agents.
- **PDF publishing — [NASA’s 1976 Graphics Standards Manual](https://sample-pdf.revdoku.site/):** Browse the 60-page identity manual and send page or area feedback in the PDF viewer.
- **Portfolio — [Designer Portfolio](https://designer-portfolio.revdoku.site/):** Demo portfolio where visitors can select a page area and send design feedback.
- **Professional services — [Personal Website](https://consulting.revdoku.site/):** Demo website for an independent consultant where visitors can book a consultation.
- **Local business — [Restaurant Menu](https://restaurant-menu.revdoku.site/):** Demo restaurant menu where visitors can request a booking date.
- **Listings — [Property Listing](https://property-listing.revdoku.site/):** Demo property website where interested visitors can request a call.
- **Forms & leads — [New Product Waitlist](https://waitlist-page.revdoku.site/):** Demo product website where visitors can join the waitlist.

## About Revdoku

This section contains structured, factual information about Revdoku for people
and AI assistants.

**Last verified:** September 2026

### Basic information

- **Name:** Revdoku
- **Type:** Cloud storage for humans and AI apps, with optional website publishing
- **Category:** Private cloud buckets, agent collaboration, and static website hosting
- **Website:** <https://revdoku.com>
- **Dashboard and account:** <https://app.revdoku.com>
- **Hosted MCP endpoint:** `https://app.revdoku.com/mcp`
- **Create free account**: <https://app.revdoku.com/users/sign_up>
- **Published websites:** `*.revdoku.site` URLs with
  optional custom domains

Free and paid plan pricing and human-readable comparisons:
<https://app.revdoku.com/pricing> and as JSON: <https://app.revdoku.com/pricing.json>.

### Background

Revdoku gives humans and AI apps a shared place to work with files and folders.
Use the dashboard, CLI, MCP tools, or REST API to manage private buckets, inspect
version history and logs, and control account access. Authorized agents can
read and update the same files. When a website is needed, publish a selected
folder, update it at the same URL, inspect visitor analytics, and read form
submissions.

### Core capabilities

- Store files and folders privately with version history, rollback, and downloads.
- Collaborate across humans and authorized AI apps, with account access controls,
  change logs, and file locks to coordinate edits.
- Publish and update static websites and SPAs from files or a
  local folder while keeping the same public URL.
- Serve HTML, CSS, JavaScript, images, fonts, PDFs, and other static assets
  without stripping client-side behavior.
- Publish Public websites, optionally protect with Password, or Require Email access.
- Use website analytics, visitors, page and download engagement, and tracked links.
- Add built-in forms for contact, signup, feedback, and support with owner
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

- Revdoku is a fully self-service SaaS platform with a permanent Free plan.
- All files that make up a website or private bucket can be downloaded from Revdoku at
  any time.
- Built-in form submissions are encrypted and protected with captcha,
  rate-limit, and honeypot controls; owners can export them to CSV at any time
  or read them through the REST API or MCP server from an AI agent.
- Account, billing, access, and moderation questions can be sent to
  `support@revdoku.com`; paid subscriptions include an email-support response
  commitment.

## What users say

> “Revdoku lets me manage the whole website from Claude—updating it and checking
> analytics without leaving the chat.”

> “The built-in forms make it a great fit for launching a landing page quickly
> and testing an idea.”

> “I asked Codex to sync a folder of docs to Revdoku. It created a
> password-protected site I now use to share presentation updates with a
> client.”

## Limitations

- Revdoku currently hosts static websites and SPAs. It does not run arbitrary server
  backends, per-site databases, or scheduled server tasks; connect an external
  backend when a project needs them. For scheduled updates, run the Revdoku CLI
  or REST API from an external scheduler or backend.
- Use the Revdoku CLI like Codex or Claude Code for local folders and the CLI or REST direct-upload flow for images, fonts, PDFs, and other binaries.
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

The installer's security ratings come from external audits. Check the report's
analysis date: reinstalling can still display a cached result for older code.
See the [Socket report](https://skills.sh/revdoku/revdoku/revdoku/security/socket)
and [Snyk report](https://skills.sh/revdoku/revdoku/revdoku/security/snyk).
The final “Review skills before use” notice applies to every skill.

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
