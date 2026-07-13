# Quick-Publish Template Assets

This folder is the editable and generated source for the template gallery used
by the dashboard, anonymous quick-publish embed, and public Revdoku clients. The
builder copies generated ZIPs, WebP previews, and metadata into
`apps/web/app/assets/quick_publish_examples/` when run inside `revdoku-ee`, so
normal Rails deployments ship the catalog without an R2 upload. In the public
tooling repository it builds and validates the client templates without creating
Rails-only paths.

The 20 active keys are declared in `build_examples.py`. Every key has:

- `sources/<key>/` — editable static site or private workspace files;
- `<key>.zip` — deterministic generated package;
- `previews/<key>.webp` — rendered gallery preview;
- a generated entry in `metadata.json`.

Legacy ZIPs, previews, and source folders remain in this directory for reference.
Because their keys are not in `EXAMPLES`, the builder leaves them untouched and
excludes them from generated metadata, app synchronization, and R2 uploads.

Build packages and synchronize the Rails assets:

```bash
python3 apps/clients/revdoku/templates/quick-publish-examples/build_examples.py
```

Re-render previews from the source sites with headless Chrome and `cwebp`:

```bash
python3 apps/clients/revdoku/templates/quick-publish-examples/build_examples.py --render-previews
```

PDF examples keep editable print HTML under `_source/`; those files are excluded
from ZIPs. Re-render them when their sources change:

```bash
python3 apps/clients/revdoku/templates/quick-publish-examples/build_examples.py --render-pdfs
```

Validate sources, local references, ZIP contents, metadata, previews, and the
Rails asset copies without writing files:

```bash
python3 apps/clients/revdoku/templates/quick-publish-examples/build_examples.py --check
```

The optional public-R2 override uploads all active ZIPs and previews:

```bash
deployment/scripts/setup/39-upload-quick-publish-examples.sh \
  --deployment-profile main-eu-central-1 \
  --source-dir apps/clients/revdoku/templates/quick-publish-examples
```

The anonymous embed reads `QuickPublishExamples.anonymous_cards`; the dashboard
reads `SITE_TEMPLATES`. Keep their keys, access modes, forms, category assignments,
and asset-version fallbacks aligned. Selecting a dashboard template creates a
private draft; it never publishes without a separate explicit action.
