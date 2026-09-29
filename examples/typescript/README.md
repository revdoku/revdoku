# TypeScript examples

From `examples/`, follow the [shared setup](../README.md), then compile and run:

```sh
npm ci
npm run build
node --env-file=.env javascript/create-inbox.js 'My agent inbox'
node --env-file=.env javascript/read-mail.js
npm run check
```

The `.ts` files here compile into `../javascript/`. Both directories implement
the same workflows. The shared guide includes all five commands, permissions,
expected output, and quota handling. There is no Revdoku SDK dependency.
