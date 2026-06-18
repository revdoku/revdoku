# App frontend reference (`app-frontend-example`)

A minimal, framework-free single screen that demonstrates the **client** half of
a Revdoku app site: reading a list and submitting a **Turnstile-protected** write.
Pair it with a backend template from `../app-safe-actions.json` (e.g. `voting`,
`feedback_dashboard`, or `waitlist`) that exposes a public `list_ideas` read and a
public `submit_idea` write with `"turnstile": true`.

## Files

- `index.html` — loads the Turnstile script and holds the widget container.
- `app.js` — read/write fetch calls, the D1 result-envelope unwrap, and the
  Turnstile token handling.

## Before publishing

1. Set `SITE_KEY` in `app.js` to `app_database.turnstile_site_key` from
   `bucket_app_database_get`.
2. Rename `list_ideas` / `submit_idea` to match your actual action names.

## Turnstile rules that matter

- Render **one visible managed widget** (`turnstile.render("#cf-turnstile",
  { sitekey })`). Do **not** use `appearance: "interaction-only"` on a hidden
  widget — a visitor Cloudflare decides to challenge would have nothing to solve,
  so no token is ever issued and **every write fails**. A visible managed widget
  stays unobtrusive for most visitors and only shows a checkbox when needed.
- Send the token as `cf_turnstile_token` in every public write body; call
  `turnstile.reset(widgetId)` after each write to get a fresh token.
- A console message like `Blocked a frame with origin
  https://challenges.cloudflare.com … Protocols, domains, and ports must match`
  comes from Cloudflare's own challenge iframe and is **harmless** — it does not
  affect token issuance.

See `../../app-building-guide.md` → "Turnstile on public writes" for the full
contract.
