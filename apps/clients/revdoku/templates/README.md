# Revdoku App Templates

`app-safe-actions.json` contains starter schemas and named-action manifests for
common Revdoku app-site patterns.

Agents should:

1. Call `bucket_app_database_get` first for existing buckets.
2. Pick the closest template and adapt names/fields conservatively.
3. Store a private `.revdoku.app.json` contract file describing the app purpose,
   data model, actions, publish mode, and rollback notes.
4. Apply the template with `bucket_app_database_setup`.
5. Publish with `site_type: "app"` only when requested.
