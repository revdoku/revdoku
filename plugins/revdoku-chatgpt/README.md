# Revdoku for ChatGPT

Mailboxes for AI agents. Read the email and attachments that arrive in a Revdoku
mailbox, reply to the people who wrote, and manage stored files.

This plugin contains the Revdoku skill only. ChatGPT connects to the hosted
Revdoku MCP server at `https://mcp.revdoku.com` and signs in through OAuth in the
browser. The plugin runs no local programs and does not install the Revdoku CLI.

## Package

`plugin.json` is the portable manifest. `skills/revdoku/SKILL.md` is the skill,
and `assets/` holds the square logo and composer icon. The submission ZIP also
contains the skill's `LICENSE` and `VERSION`.

Build and check the ZIP from the source repository:

```sh
ruby scripts/build-chatgpt-plugin.rb
```

The ZIP has no MCP configuration. The remote MCP server URL, OAuth details,
reviewer access and tool annotation justifications go into the submission form.
