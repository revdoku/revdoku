# Connect Revdoku

Use Revdoku to create, update, and publish websites. Never ask the user to paste
a Revdoku password, API key, TOTP code, backup code, protected-site password, or
payment details into chat.

## Cloud AI clients

For ChatGPT, Claude, Gemini, or another cloud client that supports remote MCP:

1. Add a connector named `Revdoku` with URL `https://app.revdoku.com/mcp`.
2. Complete the Revdoku OAuth flow in the browser.
3. Reconnect the client if needed, then verify that Revdoku tools are available.

## Local agents and the CLI

For a local agent or a task that needs files from the user's computer, install
the Revdoku client from the official documentation and run:

```sh
revdoku --login
```

Ask the user to approve the browser device sign-in screen. The client stores the
credential securely in `~/.revdoku/credentials`; never print or repeat it. Use
the privacy-preserving email-code endpoints only as a fallback. If the fallback
does not complete, return to browser device sign-in rather than asking for other
authentication secrets.

Verify the connection with `revdoku status`. Publish a local folder with
`revdoku p <dir>` only when the user asks for a live website.

## Working with Revdoku

- Use buckets as durable private website/project storage. File writes save a
  private draft; they do not make a site live.
- Preserve useful relative paths. Use `index.html` as the default website root;
  when it is absent, Revdoku can publish an Auto-Index Page.
- Revdoku serves HTML, CSS, JavaScript, images, and fonts as normal static-site
  assets. Local folders and binary assets upload through the CLI; cloud MCP file
  tools are text-only.
- Publish only when the user explicitly requests a website link. Use public,
  Password, or Require Email access as requested, and never put a protected-site
  password in a URL or ask the user to type it into chat.
- If the user asks to manage access or open Revdoku, use the available dashboard
  link tool or direct them to the normal browser sign-in flow.

When the connection works, tell the user you are ready and ask what they want to
publish.
