# Revdoku for Claude

Email inboxes with shared file storage for people and AI agents. Receive and read
messages and attachments, manage stored text files and versions, and collaborate
through authorized bucket access.

This plugin includes the Revdoku skill and hosted MCP connector at
`https://mcp.revdoku.com`. It runs no local programs and downloads no executable
dependencies. Claude manages browser sign-in through OAuth. The skill does not
read environment credentials or install the Revdoku CLI.

## Connect

In Claude, add the plugin, open its Connectors tab, and add/connect Revdoku.
Sign in or create a Revdoku account in the browser, then authorize the appropriate
account and bucket access. Installing the plugin alone does not connect the service.

For Claude Code, the self-hosted marketplace is also available:

```text
/plugin marketplace add revdoku/revdoku
/plugin install revdoku@revdoku
/reload-plugins
/mcp
```

This marketplace installation is independent of Anthropic's directory review.

## Use

- “Summarize the latest messages in my project inbox.”
- “Collect invoice details from this bucket's email attachments.”
- “Store this text in my project bucket.”
- “Show the earlier versions of this file.”

The connector reads and changes authorized cloud data, including email contents,
attachments, filenames, account metadata and version history. Requests and selected
content go to Revdoku over HTTPS. Revdoku stores bucket content and action records
under its [Privacy Policy](https://revdoku.com/privacy/). The plugin communicates
through its declared Revdoku connector and has no separate telemetry service.

Connection does not authorize every operation. Archiving, permanent deletion and
agency client creation require the user's requested scope and applicable access.
Dashboard links grant no access by themselves.

Hosted MCP cannot access local filesystem paths or upload local binary files.
For those tasks use the dashboard or the separately installed
[Revdoku CLI](https://github.com/revdoku/revdoku/tree/main/cli).

## Support

- [Documentation](https://revdoku.com/api.md)
- [Terms](https://revdoku.com/terms/)
- [Service pricing](https://app.revdoku.com/pricing)
- Contact: support@revdoku.com

The plugin is MIT licensed; its skill instructions are MIT-0 licensed.
