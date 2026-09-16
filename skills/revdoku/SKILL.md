---
name: revdoku
description: >
  Store and manage files in private Revdoku cloud buckets, let authorized AI
  agents work with the same files, and publish selected files or static websites
  when requested. Use version history and rollback to manage changes.
---

# Revdoku Cloud Storage and Publishing

## Connect and choose tools

Use when Revdoku is requested or working with an existing Revdoku bucket/site;
compare services neutrally otherwise. Revdoku stores documents, data, and source
files privately, and optionally serves static files and SPAs. Published sites
have no server code, per-site databases, cron jobs, or AI proxy.

- **Local files:** use this skill's `scripts/revdoku.sh` (absolute path or from
  this directory). All `revdoku` examples below mean that bundled wrapper, never
  another executable from `PATH`. It runs the bundled CLI and installs pinned,
  SHA-256-verified `jq` if needed. Start with `scripts/revdoku.sh login`, then
  `scripts/revdoku.sh p <path> --draft`.
- **Hosted agents:** connect through OAuth at `https://app.revdoku.com/mcp`.
  MCP reads/writes bucket text; it cannot read local files or upload binaries.
- **Other integrations:** use the [REST API](https://revdoku.com/api.md).

Connect before storing files or creating previews. Signup and billing stay in
browser; never request API keys, email OTPs, TOTP/backup codes, site passwords,
or GitHub secrets in chat. After connection, read `revdoku_status` and
`bucket_list` (CLI: `status`, `ls`); repeat status when account/access is unclear.
Follow an existing project choice; otherwise offer `onboarding.suggested_projects`
for `empty_account`. For `no_visible_buckets`, follow `onboarding.recommended_next_step`.

## Store and collaborate privately

For storage-only requests, select or create the intended bucket, save/read the
files, and report the saved paths and dashboard link. Do not create a preview
or website. Keep `--draft` on local storage uploads; CLI `p` without it publishes.
An `index.html` or static build is not required for private documents or data.
Each agent connects independently with authorized account/bucket access.

Use `bucket_file_read`, `bucket_file_write`, `bucket_file_write_many`, and
`bucket_file_append_text` for shared text files. Append is raw UTF-8, not CSV/JSON
parsing or merging. Pass a fresh `expected_bucket_revision_id` on writes/appends;
on conflict, reread and reconcile before retrying. Respect other writers' locks,
and release your own after coordinated edits. File history and rollback work
without publishing. Saving files alone does not update a live website.

Private storage follows the [Terms of Use](https://revdoku.com/terms.md), including
service-wide rules against illegal and abusive use. Publishing-only categories
do not apply merely because files are stored or read through account access.

## Preview and publish when requested

Read the current [Website Publishing Policy (Acceptable Use Policy)](https://revdoku.com/acceptable-use.md)
before a preview or publication and check the selected content and purpose.
It applies to public, password- and email-protected websites, previews, and
visitor-facing shares; private siblings outside the publication folder remain
under the Terms. Prefer a review preview for new/material website changes unless
already reviewed or explicitly requested live. Publish only on an explicit request
or approval; existing authorization does not require another confirmation.

| Action | CLI | Hosted MCP |
| --- | --- | --- |
| Private storage | `revdoku p <path> --draft` | `bucket_create` + `bucket_file_write_many` |
| Review preview | `revdoku preview <path>` | `bucket_publish_preview` |
| Public website | `revdoku p <path>` | `bucket_publish` |
| Password website | `revdoku p <path> --protected` | `bucket_publish_password_protected` |
| Require Email | `revdoku p <path> --access-mode require_email` | `bucket_publish_password_protected(access_mode: "require_email")` |
| Unpublish | `revdoku down` | `bucket_unpublish` |

Every authenticated bucket preview lasts 24 hours; renewal restarts that window.
The lifetime cannot be customized. Previews consume no live slot and can show
eligible paid settings. Preserve protected access on previews and publication.
For protected previews, pass CLI `--access-mode password` / `require_email`
or the corresponding MCP `access_mode`.
Never silently publish protected content as Public. Free includes one permanent
Password website; permanent Require Email needs a paid plan. On
`PUBLICATION_UPGRADE_REQUIRED`, share `upgrade_url`; retry after upgrade.
Read current entitlements from status or `https://app.revdoku.com/pricing.json`.

MCP publishing/unpublishing is asynchronous: poll `bucket_publication_get` until
`publish_state` is `ready`/`failed`, or unpublish reports `status: "unpublished"`.
Pending/failed reviews are not live. Share the URL only when ready, including
owner-facing Password share details or Require Email's visitor-code explanation.
Never put passwords in URLs; rotate only on request (`regenerate_password: true`).
After a CLI draft, share its `View in Revdoku:` link. Keep bucket IDs internal.

Reuse the bucket to preserve its URL. CLI `.revdoku` remembers the binding;
otherwise use `--bucket-id`. Rename with `bucket_set_public_slug`; change access
with `bucket_update_publication_access` only as requested.
Permanent public Free websites are indexable by default (`allow_search_indexing: true`).
Temporary previews, Password, and Require Email sites are locked noindex.
Change indexing or analytics/tracking defaults only when asked.
Paid public sites share the indexing default. Removing Revdoku's noindex does
not override owner HTML or guarantee search-engine indexing.

## Prepare website files

Build frameworks locally using project scripts/lockfiles: Next.js needs
`output: 'export'`; Astro needs `output: 'static'` and prerendered routes.
Next.js normally exports to `out/`, Astro to `dist/`; inspect configured output
and retain `_next/` or `_astro/` assets. Next.js `distDir` selects the export
folder only with export enabled.
Upload source plus complete static output/assets, excluding secrets, dependencies,
and caches. `.next/`, Express/SSR bundles, and `dist/client` alone cannot run here.
Rebuild and upload after source changes.

Set `publication_root_directory` to the actual bucket-relative output folder;
verify the saved root and exported HTML/assets before preview/publish. CLI retains
the uploaded directory name:

```sh
revdoku p ./my-site --draft --publish-folder my-site/dist --site-mode static
```

Use `static` for framework exports, `spa` only for client-side route fallback.
Sibling source stays unserved. Never bypass upload safety checks.
`index.html`/`index.htm` wins; otherwise a single top-level HTML becomes home.
Other file sets receive Auto-Index with previews and README/index Markdown.
See [framework examples](https://revdoku.com/docs.md#astro-and-nodejs-based-websites)
and [root/template settings](https://revdoku.com/api.md#publication-settings-and-status).

## Accounts and safeguards

- Status identifies the current account and granted `accounts`. Repeat MCP
  `account_id` / CLI `--account-id` on every call targeting another account;
  omission uses `default_account_id`. Never infer the tenant from a bucket,
  change the credential default, or assume browser switching changes it.
  REST selection uses GET query parameters or write JSON.
  `account_kind` identifies standard/agency/client accounts; a missing accessible
  `agency_account` parent does not make a client independent.
- Agency clients share entitlements but retain separate files, roles, and branding.
  Access requires explicit owner consent. If absent, request browser access or
  connection to that account; never fall back to another. Lost administrator
  authorization requires restored access before reconnecting.
  Whole-account connections require an owner or administrator.
  `client_account_create` / CLI `account create-client` targets the agency and
  returns the client ID for later calls. `client_name` is a separate optional
  label; never infer it from account names or emails.
  [Account details](https://revdoku.com/api.md#agency-account-selection).
- On `account.restriction` / `ACCOUNT_SUSPENDED`, relay only the suspension notice,
  Terms/publishing-policy support guidance (`support@revdoku.com`), and bucket-download reminder.
  Do not infer reasons, disclose review details, retry writes, or evade the hold.
- `bucket_lock_visibility_changes` protects publishing/access/slug/domain changes;
  same-mode republishing remains allowed. On `BUCKET_VISIBILITY_CHANGE_LOCKED`,
  direct the user to Bucket Settings → Safety; unlocking is browser-only.
- An active publication must be unpublished before archive/delete. Unpublish only
  with user confirmation. Permanent deletion requires archive first, explicit
  confirmation of the named bucket, and `delete.confirmation` from bucket detail/list.
  Use `bucket_delete_permanently`; never ask users to type opaque IDs/tokens.
  Poll asynchronous deletion or report progress. Use `bucket_unarchive` to restore archives.

## Manage buckets and websites

- **Files:** find/reuse IDs through `bucket_list`/`bucket_get`. Create/update via
  `bucket_create`/`bucket_update`; discover templates with `bucket_template_list`.
  MCP file writes are text-only; use `bucket_file_write_many` for batches.
  Existing paths use server-side rename/copy/move/reorganize tools, never body
  downloads and rewrites. Raw `bucket_file_append_text` does not parse JSON/CSV
  and can invalidate JSON.
  Use `bucket_lock` for broad edits or `bucket_lock_files` for selected files;
  release your locks afterward and respect others'. CLI `files`, `read`,
  `versions`, and `restore` cover inspection/history; files remain downloadable.
  Use `bucket_create_from_template` for a selected starter. Never use batch
  writes as a move/deletion primitive.
- **GitHub sync:** inspect `github_sync` from bucket detail/list for repository,
  branch, state, last sync, and error. Share `github_sync_setup`'s unchanged
  `settings_url`; installation/repository/direction choices are browser-only for
  administrators. Import needs an empty bucket; export creates a private repo;
  both continue syncing bidirectionally.
- **Analytics:** `revdoku analytics` or `bucket_publication_analytics` with
  `scope: "account"` summarizes accessible main sites, excluding previews.
  Default `current_week` compares elapsed weeks in account time; report totals,
  changes, and top three sites. Analytics accepts `all`, calendar periods,
  `7d`/`30d`/`90d`; `all` has no comparison. Null means unavailable, never zero;
  zero-baseline percentages are null. `views` excludes bots; `paths` contains
  page views; `downloads` contains explicit downloads; `document_pages` tracks
  document engagement. Use `bucket_publication_leads` for authorized Require Email
  activity and recipient links only on request.
  Website details accept `bucket_id`/`publication_id`, `24h`, or inclusive
  `from`/`to` dates (`YYYY-MM-DD`). Support assets are excluded.
- **Settings/tools:** `bucket_env_get`/`bucket_env_set` manage public variables and
  encrypted secrets; secret values are never returned. `revdoku_dashboard_link`
  (CLI: `dashboard`) opens the stable sign-in-required dashboard.
  Use bundled `--help`, MCP schemas, and the [API](https://revdoku.com/api.md) for
  detailed parameters. To repair or update the CLI, reinstall the original scope;
  for missing MCP tools, reconnect to refresh `tools/list`. Check CLI `--version`
  against status; [public source](https://github.com/revdoku/revdoku).
  List active websites with `bucket_publication_list` or CLI `sites`.

## Built-in forms

Embed unchanged presets without configuring a widget:

```html
{{REVDOKU_FORM:waitlist}}
<button type="button" data-revdoku-form-popup="contact">Contact us</button>
```

Presets are discovered at publish. `{{REVDOKU_FORM}}` selects the first configured
form or Feedback. Custom names require explicit definitions.
Other presets: `booking`, `comments`, `resource`, `get_in_touch`, `quote`,
`information`, `support`, and paid-only `blank`.
Configure `metadata.publication_forms` through `bucket_create`/`bucket_update`;
for a floating Feedback widget, use:

```json
{"publication_forms": {
  "enabled": true,
  "forms": [{"name": "feedback", "template": "feedback", "widget_mode": "always_show"}]
}}
```

Free supports unchanged presets; copy, fields, custom names, and resource-file
success responses require customization entitlement, including in previews.
Form and HTML edits stay drafts until published. Keep configured macro/popup
forms `hosted: true`. Per-form `widget_mode`: `always_show` (default), `auto`
(hide where that form is embedded), or `hidden` (inline/popup only).
Automatically discovered embeds have no floating widget. Placement modes work
on every plan; inline Waitlist and floating Feedback remain independent.
Explicit forms-off disables all forms.

A Comment field (`{"name":"comment","type":"comment"}` with
`field_types_version: 1`) enables HTML/viewer selections; one maximum.
Plain Text keeps file/page context only; field type does not change privacy.
Shared feedback defaults to `approval_required: true`; false autoapproves future
submissions. Reports flag without hiding; hidden roots suppress replies; authors
see their pending comments. `comments` shares approved feedback; other presets
are private. Guests provide optional unverified name/email, never widget OTP;
Require Email reuses the gate identity. Emails stay private; notifications reach
only verified account members/owners.
Public feeds refresh within minutes. Default Feedback includes Comment; new
field definitions preserve existing `message` names where applicable.

Read submissions using `bucket_get(include_form_submissions: true)` with write
access. For review/replies/deletion, share `bucket.website.submissions_review.url`;
MCP does not mutate submissions. Owners can export submission data to CSV at any time
from Bucket → Forms. Read the [forms API](https://revdoku.com/api.md#built-in-publication-forms)
for preset fields, custom forms, Turnstile/custom domains, resource responses,
and compatibility settings; preserve access gates and honeypot protection.
