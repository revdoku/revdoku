# Revdoku App Templates

`app-safe-actions.json` contains starter schemas and named-action manifests for
common Revdoku app-site patterns.

Public location:

- https://github.com/revdoku/revdoku/tree/main/templates
- https://github.com/revdoku/revdoku/blob/main/templates/app-safe-actions.json

Agents should:

1. Call `bucket_app_database_get` first for existing buckets.
2. Read the public template source from `bucket_app_database_get.template_source`
   when using MCP, or from this repository's `templates/` folder when using the
   public client repo.
3. Pick the closest template and adapt names/fields conservatively. Respect
   `recommended_access`: templates marked `password` should be published with a
   protected website gate unless the owner explicitly asks otherwise.
4. Treat `data_sensitivity` as a publishing guardrail. A `public: true` action is
   website-callable, not always safe for an open public site; on password
   templates those actions are intended to run behind the protected website gate.
5. Store a private `.revdoku.app.json` contract file describing the app purpose,
   data model, actions, publish mode, and rollback notes.
6. Apply the template with `bucket_app_database_setup`.
7. Publish with `site_type: "app"` only when requested, then check publication
   status separately until the async publish is ready or failed.
