# Revdoku

Revdoku publishes your docs as a site from GitHub or uploaded files. AI agents read the site
through its MCP server, visitors ask questions and get answers from the docs (Ask), and support requests arrive as tickets.

- [Start free](https://app.revdoku.com/users/sign_up)
- [Documentation](https://docs.revdoku.com)
- [Pricing](https://app.revdoku.com/pricing)
- Support: support@revdoku.com

This repository holds the Revdoku client tooling: the skill, the plugins and the `revdoku`
command-line tool. The documentation and the examples are in
[revdoku/docs](https://github.com/revdoku/docs).

## Connect your AI app

Connect your AI app to create buckets, edit and publish docs, read site analytics and answer tickets.

The hosted MCP server is `https://mcp.revdoku.com`. Add it as a connector in Claude, ChatGPT
or another AI app, then sign in through the browser. It uses OAuth, and every tool needs the sign-in.
See the [MCP guide](https://docs.revdoku.com/mcp).

Or paste this prompt into your AI app:

```text
Connect Revdoku so you can create buckets, edit and publish my docs, read site analytics and answer support tickets. Follow https://revdoku.com/llms-install.md to set up access. If I need an account, guide me to https://app.revdoku.com/users/sign_up?utm_source=revdoku&utm_medium=prompt&utm_campaign=connect to complete signup in my browser. Keep verification codes and credentials out of chat. Verify access, then continue my task or ask what I want to do. If I have no task yet, ask whether to publish docs from a GitHub repository or start from a template, then publish and show the site address.
```

[llms-install.md](./llms-install.md) is the setup guide for AI agents.
Create your account in the browser. Keep verification codes, passwords and API keys out of AI chat.

## Local AI apps

Install the skill with its bundled CLI:

```sh
npx skills add revdoku/revdoku --skill revdoku -g
```

To install for one agent, add `--agent codex` (or `claude-code`, `cursor` and so on).

If npm is not available:

```sh
curl -fsSL https://revdoku.com/install.sh | bash
```

The installer supports `codex`, `claude-code`, `cursor`, `antigravity`, `opencode`,
`grok-build`, `hermes`, `openclaw` and `all` through the `REVDOKU_AGENT` environment variable.
It checks the CLI and the skill files against SHA-256 hashes before it installs them.
`uninstall.sh` removes them.

Plugins:

- Claude Code: `/plugin marketplace add revdoku/revdoku`, then `/plugin install revdoku@revdoku`.
- Codex: `codex plugin marketplace add revdoku/revdoku`, then select Revdoku in the plugin browser.
- Gemini CLI: `gemini extensions install https://github.com/revdoku/revdoku`.
- Hermes: `hermes skills install revdoku/revdoku/skills/revdoku`.

A hosted AI app cannot read files on your computer. Use the skill or the CLI for local folders.

## Command-line tool

The standalone `revdoku` command needs no AI app:

```sh
curl -fsSL https://github.com/revdoku/revdoku/releases/latest/download/install-cli.sh -o install-cli.sh
bash install-cli.sh
revdoku login
revdoku create --title "Acme docs" --template docs-api
revdoku publish --bucket-id bkt_...
```

`create` prints the ID of the new bucket (`bkt_...`). Use it in `--bucket-id`, or set `REVDOKU_BUCKET_ID`.
To publish your own files, add them with `revdoku upload ./docs --bucket-id bkt_...` first.

See [cli/README.md](./cli/README.md) or the [CLI guide](https://docs.revdoku.com/cli).

## For developers

The REST API and the SDKs (`npm install revdoku`, `pip install revdoku`) are in the documentation:

- [Quickstart](https://docs.revdoku.com/quickstart)
- [API guide](https://docs.revdoku.com/api) and [API reference](https://docs.revdoku.com/api-reference)
- [TypeScript SDK](https://docs.revdoku.com/sdks/typescript) ([source](https://github.com/revdoku/revdoku-typescript)) and
  [Python SDK](https://docs.revdoku.com/sdks/python) ([source](https://github.com/revdoku/revdoku-python))
- [Examples](https://github.com/revdoku/docs/tree/main/examples)
- [Changelog](https://docs.revdoku.com/changelog)

## License

MIT. The skill and its bundled CLI can also be used under MIT-0: see the `LICENSE` of the skill.
The [Terms of Use](https://revdoku.com/terms/) apply to the service.
