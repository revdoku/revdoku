# Revdoku API packages

Ten generated language clients cover the endpoints in [OpenAPI](https://revdoku.com/openapi.json). n8n and Zapier provide automation integrations. Use the [public package directory](https://github.com/revdoku/revdoku/blob/main/guides/api-packages.md) for source installation, current registry availability, supported operations, and the first-email walkthrough.

Each language package has a read-only List mailboxes quickstart and runnable examples for creating a mailbox, reading email, downloading an attachment and listing stored files. The setup guide also explains installation into your own application, SDK property names and error handling. GitHub source availability does not imply a registry release.

The SDKs use `https://api.revdoku.com` as their default origin; generated paths include `/v1`. The complete REST API also has operations outside the generated SDKs, including file uploads. Use the [direct HTTP examples](https://github.com/revdoku/revdoku/tree/main/examples) for those operations.

All twelve repositories are MIT-licensed. Contributions are welcome through their issues and pull requests; maintainers preserve accepted changes in the canonical schema, generator or examples before regeneration. Support: support@revdoku.com.
