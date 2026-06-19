# Building a Revdoku App (agent prompt + conventions)

This is the default guidance for an agent (or person) building a **Revdoku app
site** — a published bucket website backed by a per-bucket database (Cloudflare
D1 in production, local SQLite in development). Paste the relevant parts into
your build prompt. It describes how named actions work and the **prebuilt tables
and structures** you should use.

## Core model

- Publish the bucket with `site_type: "app"`. Ordinary `website` sites stay
  static-only and reject app routes.
- Keep a private app contract at `.revdoku.app.json` when possible. It is stored
  with the bucket draft and excluded from the live published bundle. Use it to
  document purpose, data model summary, actions, publish mode, and rollback
  notes for future agents.
- The bucket gets **one database, created once** (it is never reset or
  re-provisioned; for a fresh schema, create a new bucket). The database is
  deleted only when the bucket is permanently deleted.
- You define the database through authenticated API/MCP calls:
  - **schema** — `CREATE TABLE` / `CREATE INDEX` / `ALTER TABLE ... ADD COLUMN`
    (additive only; `DROP`, WHERE-less `DELETE`/`UPDATE`, and `PRAGMA` are
    rejected to protect data).
  - **named actions** — an `operations` manifest of SQL templates.
    `public: true` makes an action a visitor endpoint at
    `/_revdoku/app/<name>`. `public: false` actions are owner/agent-only admin
    actions invoked via
    `bucket_app_database_run_operation` (never reachable by visitors).
  - Use `bucket_app_database_get` first when returning to an existing app. Show
    the live `schema_objects` and named actions before modifying schema, data, or
    action definitions.
- **Parameters** bind via `?` placeholders (always parameterize — never
  interpolate). Param sources: `body`, `query`, `visitor` (`key` = stable
  per-visitor id; `email` = verified gate email on password+email sites),
  `system` (`uuid`, `now`), `literal`, and the default `input` (body then query).
- **Spam protection** for anonymous-write actions: every public write action
  must use Turnstile, but Revdoku provides a **built-in platform Turnstile key**
  for `*.revdoku.site` sites, so you provision nothing for normal sites.
  `bucket_app_database_get` returns
  `app_database.turnstile_required_for_public_writes` and
  `app_database.turnstile_site_key`; render the Turnstile widget with that site
  key and send `cf_turnstile_token` (or the widget's
  `cf-turnstile-response`) in the body for every public write request.
  Advanced owners can set bucket-specific Turnstile keys to use their own widget:
  save `CLOUDFLARE_TURNSTILE_SITE_KEY` (a public variable) and
  `CLOUDFLARE_TURNSTILE_SECRET_KEY` (a secret) via the `/turnstile` or
  `/variables` endpoint (or `bucket_env_set`). Bucket-specific keys are required
  for custom domains with public write actions unless Revdoku explicitly manages
  that custom hostname on the shared widget.

The published page calls public website actions on the same origin:

```js
const res = await fetch("/_revdoku/app/list_items?category=ui", { headers: { Accept: "application/json" } });
const { ok, result } = await res.json(); // result[0].results is the row array
```

### Turnstile on public writes (client integration)

When `turnstile_required_for_public_writes` is true, every public **write** must
carry a Turnstile token. Load the script, render **one visible managed widget**,
read its token on submit, and reset it after each write:

```html
<!-- in <head> or before </body> -->
<script src="https://challenges.cloudflare.com/turnstile/v0/api.js" async defer></script>
<!-- visible widget, placed in/near the write form -->
<div id="cf-turnstile"></div>
```

```js
const SITE_KEY = "…";            // app_database.turnstile_site_key
let widgetId = null;
(function render() {
  if (window.turnstile) widgetId = turnstile.render("#cf-turnstile", { sitekey: SITE_KEY });
  else setTimeout(render, 100);
})();

async function submitIdea(title) {
  const token = (widgetId !== null && turnstile.getResponse(widgetId)) || "";
  if (!token) return alert("Please complete the verification check.");
  const res = await fetch("/_revdoku/app/submit_idea", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ title, cf_turnstile_token: token }),
  });
  turnstile.reset(widgetId); // fresh token for the next write
  // handle res…
}
```

- **Use the default (managed) appearance on a visible widget.** Do **not** use
  `appearance: "interaction-only"` on a hidden widget: a visitor Cloudflare
  decides to challenge would have nothing to solve, so no token is ever issued
  and every write fails. A visible managed widget stays unobtrusive for most
  visitors and only shows a checkbox when a challenge is actually needed.
- A console message like `Blocked a frame with origin
  https://challenges.cloudflare.com … Protocols, domains, and ports must match`
  is emitted by Cloudflare's own challenge iframe and is **harmless** — it does
  not affect token issuance, so do not chase it.
- A complete, copy-paste reference frontend lives in the public client repo at
  `templates/app-frontend-example/` (`index.html` + `app.js`): a single screen
  that lists rows and submits a Turnstile-protected write.

Starter schemas and named actions for waitlists, leaderboards, voting, link
feeds, CRM boards, changelogs, research databases, and dashboards live in
the public client repo at
`https://github.com/revdoku/revdoku/tree/main/templates`
(`templates/app-safe-actions.json`). MCP does not embed hidden templates; call
`bucket_app_database_get` and read its `template_source` field for the current
template location. Each template includes `recommended_access` and
`data_sensitivity`; follow the recommended access mode unless the owner
explicitly overrides it. `public: true` means website-callable, not necessarily
safe for an open public website — for password templates, those actions are
intended to run behind the protected website gate.

## Prebuilt / reserved structures

### `.revdoku.app.json` — app contract (private)

Any dotfile or dot-folder (anything whose name starts with `.`, e.g.
`.revdoku.app.json`, `.gitignore`, `.git/…`) is **never served** on the published
website — but it is still stored and **version-tracked**, so editing it marks the
site as having unpublished changes and republishing clears that. Dependency
lockfiles, `wrangler.toml`, and build scripts are treated the same way. The one
exception is **`.well-known/`** (e.g. `security.txt`, app-association files), which
is served normally; a dotfile nested inside it (`.well-known/.secret`) is still hidden.

Create or update this file before publishing an app site:

```json
{
  "purpose": "Waitlist for the launch page",
  "publish_mode": "app",
  "data_model": {
    "tables": ["leads", "_revdoku_events"],
    "summary": "Visitor-submitted leads with owner notifications."
  },
  "safe_actions": {
    "public": ["submit_lead"],
    "private": ["advance_lead", "mark_contacted"]
  },
  "rollback_notes": "Use bucket version history for files. App data is persistent; export before destructive account/bucket operations."
}
```

Do not place the contract under `.revdoku/`; local clients skip that directory.

### `_revdoku_events` — owner notifications (reserved)

To notify the bucket owner about activity (a new lead, a new submission), the
app **inserts a row into a reserved `_revdoku_events` table**. Revdoku
sweeps it (about every 15 minutes — notifications are intentionally
**non-real-time** in v1), surfaces un-notified rows as **in-app notifications on
the Revdoku account**, and marks them notified. The same rows are also readable
per bucket at any time via MCP (`bucket_app_database_notifications`) and the REST
notifications endpoint, and shown in the bucket's view.

Create the table and write to it from Turnstile-protected public website
actions:

```sql
CREATE TABLE IF NOT EXISTS _revdoku_events (
  id TEXT PRIMARY KEY,
  kind TEXT,           -- e.g. "lead", "submission", "vote"
  summary TEXT,        -- short owner-facing line (no secrets)
  created_at TEXT NOT NULL,
  notified_at TEXT     -- set by Revdoku's sweep; leave NULL on insert
);
```

```json
"add_lead": {
  "public": true, "method": "POST", "turnstile": true,
  "sql": "INSERT INTO _revdoku_events (id, kind, summary, created_at) VALUES (?, 'lead', ?, ?)",
  "params": [
    { "name": "uuid", "source": "system" },
    { "name": "summary", "source": "body", "key": "email" },
    { "name": "now", "source": "system" }
  ]
}
```

Keep `summary` short and free of sensitive data — it is shown to the owner. This
mechanism is identical whether the named action runs through Rails (Path A) or the
edge runtime; Revdoku reads the rows from the database either way.

### Recommended patterns

- **Contact / lead form:** a `leads` table + a public `submit_lead` insert
  (Turnstile on), plus a `_revdoku_events` insert so the owner is pinged.
  Owners read leads with `bucket_app_database_query`.
- **One vote per visitor:** `UNIQUE(item_id, visitor_key)` +
  `INSERT OR IGNORE`, binding `{ "source": "visitor", "key": "key" }`.
- **Edit-your-own-row:** scope the `WHERE` to the visitor —
  `UPDATE ... WHERE id = ? AND created_by = ?` with a `visitor` param.
- **Admin actions** (advance lead, approve item): `public: false` agent actions
  invoked via `bucket_app_database_run_operation`.

## Common scenarios

### 1. Static site, no database (landing page / clickable prototype)

Most sites need **no app database at all**. Publish the bucket as an ordinary
`website` (static HTML/CSS/JS, or a clickable prototype) and skip every
app-database step. Do **not** call `bucket_app_database_setup` — provisioning is
always explicit and opt-in, so a static publish never creates a database and
never incurs database cost. Only reach for an app database when the page needs
to read or write durable data at the edge.

### 2. Feedback dashboard (submit ideas, vote, rank by votes, notify owner)

Use the **`feedback_dashboard`** template in
the public `templates/app-safe-actions.json` manifest. Public actions: `submit_idea` (one statement;
an `AFTER INSERT` trigger writes a row to `_revdoku_events` so the owner
is pinged on every submission), `vote` (one vote per visitor via
`UNIQUE(idea_id, visitor_key)` + `INSERT OR IGNORE`), and `list_ideas` (ideas
ranked by vote count, newest as tiebreak). `hide_idea` is a private moderation
action. The owner sees new submissions as in-app Revdoku notifications (the
~15-minute sweep) and can read them anytime with
`bucket_app_database_notifications`.

### 3. Support center (searchable articles, search logging, suggestions)

Use the **`support_center`** template. Articles carry a STORED generated
`search_text` column (`lower(title||body||tags)`); the public `search_articles`
action matches it with `LIKE` (portable across D1 and local SQLite — for a very
large corpus switch `articles` to an FTS5 virtual table). `log_search` records
every query and its result count for analysis; `suggest` returns type-ahead
suggestions ranked by how often each prior search was used (so suggestions
improve as the site is used). Owners author articles via the private
`upsert_article` action and review demand with `search_analytics` (top queries
and zero-result searches). Frontend flow: call `search_articles`, render
results, then `log_search` with the query + result count; call `suggest` as the
user types.

## Backups, download & rollback

Every app database is backed up automatically and on demand — visitor-submitted
data is never trapped:

- **Automatic daily backups.** Revdoku snapshots every ready app database once a
  day and retains the most recent backups (the oldest are pruned). No setup.
- **Snapshot now / list / download.** `bucket_app_database_snapshot` takes a
  backup immediately; `bucket_app_database_snapshots` lists retained snapshots
  (id, filename, size, kind, schema version, time) with a download path. The
  REST endpoints are `POST/GET /api/v1/buckets/<id>/app_database/snapshots` and
  `GET .../app_database/snapshots/download?snapshot_id=<id>` (redirects to a
  short-lived signed URL). In production a snapshot is the D1 **SQL dump**; in
  development it is the raw SQLite file.
- **Rollback.** The live database is **append-and-evolve only and is never reset
  in place** (that invariant is what keeps visitor data safe). To roll back,
  download a snapshot and **import its SQL into a new bucket's app database**,
  then publish that bucket. Record the snapshot you rolled from in
  `.revdoku.app.json`'s `rollback_notes`.

## Data residency

Production app databases on the EU deployment are created with Cloudflare D1
`jurisdiction: "eu"`, so personal data stays in the EU. App Workers (the runtime)
execute on Cloudflare's global edge but persist nothing outside the EU-pinned
database — keep personal data in the database, not in edge-side stores.
