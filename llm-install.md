# Revdoku agent setup

Canonical instructions: [llms-install.md](./llms-install.md).

```text
I'd like you to set up Revdoku so you can publish a website for me for free.

Browser-only chat: don't install anything. Direct me to your setup guide—Claude: https://revdoku.com/claude/; ChatGPT: https://revdoku.com/chatgpt/; other products: https://revdoku.com/<lowercase-hyphenated-product-name>/.

With terminal access, run `npx skills add revdoku/revdoku --skill revdoku -g`; without npm, run `curl -fsSL https://revdoku.com/install.sh | bash`.

Then review https://revdoku.com/docs and ask what I'd like to publish.
```

The first public preview needs no account. Account creation happens only at
`https://app.revdoku.com/users/sign_up`; OAuth and agent email-code flows are
sign-in-only.
