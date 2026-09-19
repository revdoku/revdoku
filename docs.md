# Revdoku Docs

Use the Revdoku CLI or MCP to upload files, publish a website, and update it at
the same URL. Buckets store files and version history; publication is a separate
operation. Websites support access controls, forms, and analytics.

Private bucket storage and collaboration follow the
[Terms of Use](https://revdoku.com/terms/), including its rules against illegal
and abusive use. The [Website Publishing Policy (Acceptable Use Policy)](https://revdoku.com/acceptable-use/)
applies when content is served to visitors: public websites, published files,
share links, previews, password- or email-protected sites, and public comments.
It does not apply solely to private bucket files or authenticated account downloads.
Publishing-only restrictions, including the political-content restriction, apply
on every plan and in previews. Publication stays unavailable until review succeeds.

## Quick Start

If npm is available, install the Revdoku skill:

```sh
npx skills add revdoku/revdoku --skill revdoku -g
```

Add `--agent codex` (or your agent's name) to select one target and avoid
unsupported global targets such as PromptScript.

Otherwise install the local client and skill:

```sh
curl -fsSL https://revdoku.com/install.sh | bash
```

The shell installer adds the `revdoku` command and installs the Revdoku skill
for Codex plus any detected local agents. Set `REVDOKU_AGENT` to `codex`,
`claude-code`, `cursor`, `antigravity`, `opencode`, `grok-build`, `hermes`,
`openclaw`, or `all` to choose explicitly.

The examples below use `revdoku` as shorthand. With `npx skills`, run
`scripts/revdoku.sh` from the installed skill directory. With the shell
installer, use `~/.revdoku/bin/revdoku` if it is not on your shell `PATH`.

### Keep files in a private cloud bucket

```sh
revdoku p ./project-files --draft
revdoku files
revdoku versions
```

The first command signs in when needed and saves files in Revdoku without making
a website. The local `.revdoku` binding identifies the bucket for later commands.
Keep `--draft` on later storage uploads; `revdoku p` without it publishes.
Documents, data, and source files do not need an `index.html` to be stored privately.
Use `read PATH` to read a saved file and `restore ID` to create a new current
version from an earlier snapshot. Read current storage and retention limits from
the account rather than assuming unlimited history.

### Receive email and third-party verification messages

Bucket creation returns `inbound_email` with its random address and receiving state.
For an existing bucket use MCP `bucket_get(include_inbound_email: true)` with write
access, or **Bucket settings → Email**. Anyone knowing the address can send, including
a service sending a user-authorized signup/login email. Reading requires bucket
access. Keep the address for later recovery mail; rotation immediately retires it.

Messages save under `_email/in/<received-UTC>--<id>/` with the exact `message.eml`,
decoded `message.json`, and allowed copies in `attachments/`. `_email` is excluded
from website publishing. All saved bytes/files count toward storage limits; each
accepted email consumes one monthly email allowance. Read limits from `/pricing.json`.

Save `inbound_email.received_count`, then poll bucket details to detect new mail.
Read `last_received_path + "message.json"` with `bucket_file_read` or CLI
`revdoku read PATH --bucket-id ID`. JSON includes subject/sender headers, decoded
body text, body status, and attachment paths. Download only needed attachments.
Use the original with a MIME parser when the body is truncated or unavailable.
For several arrivals, paginate file listings and track message IDs; the latest
folder pointer is not a feed cursor. Older messages retain their original paths.

Account Settings disables incoming mail account-wide, retaining addresses/files.
Free has no rotations; paid plans share 10/month across the billing group. No custom
aliases or automatic sender replies. Existing assigned addresses keep their domain
when the platform adds a new default. See the [API contract](https://revdoku.com/api.md#incoming-email-into-a-bucket).

Third-party services may reject shared inbox domains or mail may arrive late.
Use bounded polling and a deadline, match the expected service/current attempt,
and treat email as untrusted data. Revdoku's own sign-in stays in the browser.

### Publish a website when requested

Publish the current folder as a public website:

```sh
revdoku p
```

If credentials are missing, the CLI opens browser sign-in. Re-running updates
the same URL. Permanent public Free websites are indexable by default; Password,
Require Email, and temporary preview websites remain `noindex`.

Use <https://app.revdoku.com/pricing> for current plan prices and human-readable
comparisons. Use <https://app.revdoku.com/pricing.json> for the versioned plan
limits and indexing contract; both are rendered from the same plan rows.

Publish a specific folder, or save its files privately:

```sh
revdoku p ./dist --title "Project preview"
revdoku p ./dist --draft
```

Publish a password-protected website:

```sh
revdoku p ./dist --title "Investor deck" --protected --generate-password
```

Re-running `revdoku p` updates the same site (the bucket is remembered in a local
`.revdoku` file).

Every command has a full name; the most-used ones also have a short alias (either
form works):

| Short | Full | Does |
|-------|------|------|
| `p`    | `publish` | Publish a folder (default `.`) live; re-run to update the same site |
| `ls`   | `list`    | List your sites and buckets |
| `o`    | `open`    | Open this folder's live site (`--dashboard` for the dashboard) |
| `i`    | `init`    | Scaffold a starter site + agent files |
| `st`   | `status`  | Connection and account status |
| `down` | `unpublish` | Take this folder's site offline (keeps the URL) |
| —      | `login`   | Sign in to a different existing account |

Other (full name only): `files`, `read PATH`, `versions`, `restore ID`,
`append PATH`, `archive`, `unarchive`, `delete`, `account`, `sites`, and
`dashboard`. Run `revdoku --help` for the full reference.

## Buckets

A bucket is private storage for files, versions, and website publishing state.
Buckets keep file history so agents and people can update the same project over
time without losing earlier versions.

Use clear bucket titles and short descriptions. Tags are user-facing labels, not
filesystem breadcrumbs. For website uploads, use a simple `website` label only
when it helps organization; store project names, source folders, or task context
in metadata instead.

Buckets hold documents, data, source files, and supported static assets. HTML, CSS, JavaScript, images, fonts, and PDFs are
all fully supported and stored as-is — nothing is stripped. Upload a local folder
(including its binaries) with `revdoku p <dir> --draft`, or push individual binaries with
the REST direct-upload API — both send bytes straight to object storage. The
cloud MCP file tools are text-only and have no binary upload. Forbidden file
types (executables like `.exe`, `.dmg`, `.app`, `.msi`, … and secrets like `.env`
and keys) are refused **by extension** at upload; uploaded content is also scanned
afterward and removed if it turns out to be a forbidden type.

## Work with multiple AI agents

Authorize each agent separately and select the same account and bucket within
each connection's permissions. Do not share credentials or assume a new agent
has access to every bucket.

For example, use one agent to collect fictional demo leads and another to enrich them:

1. Agent 1 uses `bucket_file_write` to create `leads.csv` with `name,email` headers,
   then `bucket_file_append_text` to append rows such as
   `Avery Chen,avery@example.com`. These files are saved in Revdoku.
2. Agent 2 reads the saved file with `bucket_file_read` and prepares a short pitch
   for each lead, then saves `leads-enriched.csv` to the same Revdoku bucket.
3. Use bucket versions and change history to inspect the updates or restore an
   earlier snapshot. No preview, website, or outgoing email is required.

Append is bounded UTF-8 text, not a CSV or JSON merge operation. The caller handles
escaping and headers. Automatic write locks coordinate operations; use explicit
file/bucket locks for longer edits and release your locks afterward. Pass
`expected_bucket_revision_id` from a fresh `bucket_get` when writing or appending.
On `BUCKET_REVISION_CONFLICT`, reread the current files, reconcile changes, and
retry only the intended edit. Do not blindly replay a stale full-file overwrite.

The [API reference](https://revdoku.com/api.md#file-path-operations) covers file
operations, locks, and version history. Website visitor analytics are separate
from private-file history and account change logs.

## Publishing

Revdoku hosts static websites and SPAs. JavaScript and client-side interactivity
are fully supported and served as-is. There is no need to avoid scripts or
prefer CSS-only output.

**To publish a LOCAL folder, use `revdoku p <dir>`.** The cloud MCP connector
cannot read your local filesystem, so the CLI is the correct tool for a folder on
disk (it uploads everything, including binaries). Use hosted MCP for remote text-file operations and website settings.

Revdoku supports two website modes:

- `static`: normal static files using `index.html`, `index.htm`, or a lone top-level HTML file as the home page.
- `spa`: single-page apps where app routes fall back to the index page.
With no index, a lone top-level HTML file becomes the home page automatically.
Every other missing-index site gets an Auto-Index Page that lists files. Supported
document, data, image, audio, and video links open in the file viewer even when
visited directly; HTML rows remain website pages. Custom Auto-Index templates must
include `{{files}}` or `{{ files }}`; supported macros are `{{title}}`,
`{{description}}`, `{{files}}`, `{{theme_switch}}`, `{{account_name}}`, and
`{{account_logo}}`, with optional whitespace inside the braces.

Republishing the same bucket updates the existing website and keeps the same
public URL. Unpublishing removes public access while keeping the bucket and
reserved URL for later republish.

Permanent public account websites allow search indexing by default. Owners can
turn off **Allow search engines to index this public website** through the
dashboard or the API/MCP `allow_search_indexing` bucket setting. Password,
Require Email and temporary preview websites are always
`noindex`. Turning the setting on removes only Revdoku's platform `noindex`
controls; a website's own `noindex` tag still applies, and indexing is never
guaranteed.

Publish, unpublish, and large delete requests are asynchronous. After starting
one, check the returned publication or bucket status separately before telling a
user that the website is live, public access is removed, or deletion is finished.

Saving files does not publish them. Treat bucket writes as **Save draft** and
publish tools as **Publish** or **Republish**.

### Astro and Node.js-based websites

Node.js can run a website's build tools locally. Revdoku serves the resulting
HTML, CSS, JavaScript, and assets; it does not run `npm install`, `npm run build`,
`npm start`, Express, or an SSR server. A folder named `dist/` is suitable only
if it contains a complete static website, not compiled server code.

| Project | Local build | Output to upload with the source | Website routing |
| --- | --- | --- | --- |
| Astro, fully prerendered | `npm run build` / `astro build` with `output: 'static'` | `dist/`, or configured `outDir`, including `_astro/` assets | `static` |
| Vite frontend, such as React or Vue | Project build script, usually `npm run build` | `dist/`, or configured `build.outDir`, including all assets | `spa` if client-side routes need index fallback; otherwise `static` |
| Other Node.js-based build tools | Inspect `package.json`, the lockfile, and framework config; run the static build/export script | The actual browser-ready output folder, which may be `dist/`, `build/`, or `out/` | Match the generated site's routing |

Astro defaults to `output: 'static'` and writes to `dist/`. Every route must be
prerendered: check for routes that opt out with `prerender = false`, server
islands, actions, or other request-time features. A fully static site needs no
server adapter. If an existing project uses SSR, adapt those features first;
uploading only its `dist/client/` assets does not replace server-rendered pages.
[Astro deployment guide](https://docs.astro.build/en/guides/deploy/) and
[output configuration](https://docs.astro.build/en/reference/configuration-reference/#output).

Vite frontend builds also default to `dist/`; inspect `build.outDir` if the
project overrides it. A Vite SSR bundle still requires a server.
[Vite static deployment guide](https://vite.dev/guide/static-deploy.html).

Install dependencies and build locally using the project's package manager and
lockfile. Verify the output contains the home page, generated routes, and their
scripts, styles, images, and fonts. Upload source **plus the complete output**,
excluding secrets, dependencies, and caches. The CLI skips `node_modules/`,
`.astro/`, and `.next/`, while preserving generated `_astro/` and `_next/` assets
and gitignored output folders.

For a project named `my-site` with static output in `dist/`, run from its parent:

```sh
revdoku p ./my-site --publish-folder my-site/dist --site-mode static
```

Use the same path and routing options with `revdoku preview`.
To save a private draft, omit publication-only routing options:

```sh
revdoku p ./my-site --publish-folder my-site/dist --draft
```

Set `--site-mode` when previewing or publishing.
For a client-side SPA that needs route fallback, use `--site-mode spa` instead.
The CLI retains the project prefix, so the selected folder is `my-site/dist`,
not just `dist`. In API/MCP preview and publish calls, set
`publication_root_directory: "my-site/dist"` and the matching `site_mode`.
If files were uploaded directly as `dist/index.html`, select `dist` instead.
Source stays private; only the selected output is served at the website root.

Verify that exact stored root contains publishable files. Updated servers reject
a missing or empty selection and preserve the previous site on republish. Older
servers can fall back to the whole bucket; always verify the stored output first.
Rebuild locally and upload refreshed output after source changes, then republish
the same bucket. GitHub sync also
requires the generated output in the synced repository. Wait for `ready`, then
check the home page, direct nested URLs, and assets. SPA mode supplies route
fallback only; it does not build or run a backend.

### Next.js static websites

Use plain HTML/CSS/JavaScript for a simple new website. An existing Next.js
website works when it can be exported entirely as static files. Revdoku serves
the files you upload; it does not install dependencies, compile the project,
or run a Next.js server.

Merge these settings into the project's existing Next.js config (preserve its
module format and other settings). For `next.config.mjs`:

```js
const nextConfig = {
  output: 'export',
  distDir: 'dist',
  trailingSlash: true,
  images: { unoptimized: true },
};

export default nextConfig;
```

`output: 'export'` enables the static export. Its default folder is `out/`;
`distDir: 'dist'` selects `dist/` in export mode. `distDir` alone does not make
a server build static, and `.next/` or standalone server output is not a static
website. `trailingSlash: true` emits nested routes as `about/index.html`;
Revdoku also resolves exported `about.html` files. For `next/image`, use
`unoptimized: true` or retain a static-compatible custom image loader.
[Next.js static export reference](https://nextjs.org/docs/app/guides/static-exports).

Run the project's dependency install and build locally using its package manager
and lockfile (for npm with a lockfile: `npm ci`, then `npm run build` with a build
script that runs `next build`). Verify `dist/index.html` and the complete
`dist/_next/` assets exist. Dynamic routes need all paths generated at build
time (`generateStaticParams` in the App Router, or `getStaticPaths` with
`fallback: false` in the Pages Router). SSR, Server Actions, request-dependent
API routes, ISR, middleware/proxy, and the default image optimization server
need a static-compatible alternative or an external backend. A failed export
must be fixed before publishing; SPA mode cannot supply a server.

Upload the project source **and** the complete export into one bucket. The CLI
skips secrets, `node_modules/`, and `.next/` caches, and includes export folders
even when they are gitignored. For a project folder named `my-site`, run from
its parent directory:

```sh
revdoku p ./my-site --publish-folder my-site/dist --draft
revdoku preview ./my-site --publish-folder my-site/dist --site-mode static
# When ready to publish the main website:
revdoku p ./my-site --publish-folder my-site/dist --site-mode static
```

The CLI preserves the project folder name: files are stored as
`my-site/app/...`, `my-site/package.json`, and `my-site/dist/...`.
`--publish-folder` is a **bucket-relative path**, so use `my-site/dist`, or
`my-site/out` for the default export. Source files stay private and versioned;
only the export is served, with `my-site/dist/index.html` at `/` and
`my-site/dist/_next/...` at `/_next/...`. Do not add `/dist` as a Next.js
`basePath` or asset prefix just because that folder holds the export.

For API/MCP publishing, set `publication_root_directory` to that same stored
path and `site_mode: "static"`. If files were uploaded directly as
`dist/index.html`, the root is simply `dist`. Verify the selected folder contains
the exported home page and assets before preview/publish. Updated servers reject
empty selections; older servers can fall back to the whole bucket.
Hosted MCP cannot run local builds or
upload binaries; use a local agent with the CLI or REST direct uploads.

After every source change, rebuild locally, upload the refreshed export, and
republish the same bucket. Wait for `ready`, then verify the home page, a direct
nested route, scripts, styles, and images. No additional compilation runs on
Revdoku. GitHub sync likewise needs the exported files included in the synced
repository; syncing source alone does not build the website.

### Bucket previews

An authenticated bucket preview is a temporary, `noindex` copy of the saved
draft at a `preview-...` URL. It never changes the main website and does not
count against live or protected-site limits. Every bucket preview expires 24
hours after the build finishes; its lifetime cannot be customized. Re-running the
preview republishes the same preview URL with a new 24-hour window.

Free accounts include one permanent Password website. Require Email and other
eligible paid access or presentation settings can still be evaluated in this
preview before upgrading; form customization continues to follow the plan.

Use `--site-mode spa` for static client-side apps that need route fallback;
omit it or use `--site-mode static` for normal static sites. A project-local
`.revdoku` binding remembers the chosen site mode for later republishes.

If the account becomes read-only, existing files remain available to inspect or
download. Open Revdoku in the browser to review the available account actions;
do not retry blocked mutations indefinitely. For a suspension, relay the common
notice, link to the [Acceptable Use Policy](https://revdoku.com/acceptable-use/),
and remind the user they can download their bucket files and contact
support@revdoku.com for more details. Do not infer reasons, expose review details,
or create replacements to evade the hold.

## Data access and exports

All files that make up a bucket or website can be downloaded from Revdoku at
any time. Built-in form submissions are encrypted and protected by Turnstile
and honeypot controls. Owners can export submission data to CSV at any time in
Bucket → Forms, or read it through the REST API.
Built-in forms can appear inline, as floating widgets, or in Revdoku-managed
popups opened by buttons styled by the website.

Generic outbound form webhooks and self-service submission-retention policies
are not currently available.

## Protected Websites

Protected websites use Password or Require Email access:

- Password access generates or keeps a shared website password.
- Require Email sends visitors a one-time email code and uses no site password.
- Notify the owner on every successful protected access when access
  notifications are enabled.

Visitor-provided email is shared with the site owner for access tracking. The
gate displays that notice before access.

## Website Analytics And Tracking

Published websites record Revdoku analytics and browser-side client events by
default. Use `--no-tracking` to disable both for a publish or republish. Scripts
that need separate control can use `--no-analytics` for server-side website
analytics and `--no-client-events` for browser-side Revdoku event tracking.
Analytics page-path breakdowns exclude scripts, styles, images, and other support
assets. Explicit file downloads and document-page engagement are reported in
their own breakdowns.

## Runtime limitations

Revdoku serves static files and SPAs. Use external services for:

- Custom server backends, arbitrary server code, or per-bucket databases → use
  an external backend or a static/SPA-compatible workflow.
- Cron jobs / scheduled server tasks → run the Revdoku CLI or REST API from an
  external scheduler or backend.
- A client-side AI/LLM proxy for published sites → Revdoku sites are on the
  public internet, so an open AI key would be abused; call your own backend.
- Importing code from another site at runtime / shared cross-account libraries →
  vendor the assets into the bucket you publish.

## Agents And MCP

Hosted MCP clients can connect to:

```text
https://app.revdoku.com/mcp
```

Use Streamable HTTP transport and Revdoku OAuth. Do not paste a Revdoku
password, API key, TOTP/backup code, or email verification code into AI chat.

Local agents can use the installed `revdoku` command. Prefer MCP tools when
available; use the CLI when the agent needs local filesystem access — the cloud
connector cannot read local files, so a LOCAL folder must be published with
`revdoku p <dir>`. Binary assets (images, fonts, PDFs) upload directly to object
storage via the CLI or the REST direct-upload API; the MCP file tools
(`bucket_file_write`) are text-only.

For line-oriented text updates, the CLI can append to an existing bucket text
file without rewriting the whole file:

```sh
revdoku append leads.csv --bucket-id bkt_... --content-file new-leads.csv
```

This is only for UTF-8 text files such as `.txt`, `.md`, `.csv`, `.jsonl`, and
code files. The CLI retries short-lived bucket/file locks for append and prints
the lock owner, message, and expiry if the file remains locked.

## API

The public API reference is available at:

```text
https://revdoku.com/api.md
```

Common API flows:

- Create or update buckets.
- Upload files through direct uploads or publish sessions.
- Publish or unpublish bucket websites.
- Manage custom domains.
- Read bucket analytics and protected-access contacts.

## Support

For account, billing, or access issues, email:

```text
support@revdoku.com
```
