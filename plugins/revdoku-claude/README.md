# Revdoku for Claude

Revdoku publishes your docs as a site from a GitHub repository. AI agents read the site
through its MCP server, visitors ask questions, and support requests arrive as tickets.
Connect Claude to create projects, connect GitHub, publish docs, read site analytics and answer tickets.

This plugin includes the Revdoku skill and hosted MCP connector at
`https://mcp.revdoku.com`. It runs no local programs and downloads no executable
dependencies. Claude manages browser sign-in through OAuth. The skill does not
read environment credentials or install the Revdoku CLI.

## Connect

In Claude, add the plugin, open its Connectors tab, and add/connect Revdoku.
Sign in or create a Revdoku account in the browser, then authorize the appropriate
account and project access. Installing the plugin alone does not connect the service.

For Claude Code, the self-hosted marketplace is also available:

```text
/plugin marketplace add revdoku/revdoku
/plugin install revdoku@revdoku
/reload-plugins
/mcp
```

This marketplace installation is independent of Anthropic's directory review.

## Use

- “Publish the latest changes of my docs site.”
- “Show what visitors of my docs site could not find this week.”
- “Reply to the latest question in the support tickets of my docs site.”

The connector reads and changes authorized cloud data, including email contents,
attachments, filenames and account metadata. Requests and selected
content go to Revdoku over HTTPS. Revdoku stores project content and action records
under its [Privacy Policy](https://revdoku.com/privacy/). The plugin communicates
through its declared Revdoku connector and has no separate telemetry service.

Connection does not authorize every operation. Archiving, permanent deletion and
agency client creation require the user's requested scope and applicable access.
Dashboard links grant no access by themselves.

A project's files are a read-only copy of its GitHub repository. Change the files on GitHub.

## Support

- [Documentation](https://support.revdoku.com/docs/api)
- [Terms](https://revdoku.com/terms/)
- [Service pricing](https://app.revdoku.com/pricing)
- Contact: support@revdoku.com

The plugin is MIT licensed; its skill instructions are MIT-0 licensed.
