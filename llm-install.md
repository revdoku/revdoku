# Revdoku agent setup

Canonical instructions: [llms-install.md](./llms-install.md).

```text
I'd like you to set up Revdoku: the website publishing service for AI agents.

Install as a skill if I have npm: npx skills add revdoku/revdoku --skill revdoku -g

If not, do this instead: curl -fsSL https://revdoku.com/install.sh | bash

After installing, review the docs at https://revdoku.com/docs and ask me what I'd like to publish
```

The first public preview needs no account. Account creation happens only at
`https://app.revdoku.com/users/sign_up`; OAuth and agent email-code flows are
sign-in-only.
