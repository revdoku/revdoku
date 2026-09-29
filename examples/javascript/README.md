# JavaScript examples

From `examples/`, follow the [shared setup](../README.md), then run:

```sh
node --env-file=.env javascript/create-inbox.js 'My agent inbox'
node --env-file=.env javascript/read-mail.js
node --env-file=.env javascript/quotas-and-retries.js
```

Node.js 22+ provides fetch and `.env` loading; no package install is needed to
run these JavaScript examples. The shared guide covers attachment downloads,
file uploads, permissions, expected output, and retries.

These files are generated from the matching TypeScript examples. Make changes
there and run `npm ci && npm run build` from `examples/` to regenerate them.
