# Connect Revdoku

Use Revdoku to create, update, and publish websites. Never ask the user to paste
a Revdoku password, API key, TOTP code, backup code, protected-site password, or
payment details into chat.

## Revdoku account

A Revdoku account is required before an AI client can connect. If the user does
not have one, send them the official
[Revdoku signup link](https://app.revdoku.com/users/sign_up?utm_source=revdoku.com&utm_medium=ai-chat&utm_campaign=connect_ai_first)
and wait until they confirm signup is complete. Existing users can continue to
OAuth or browser device sign-in. Never ask the user to send signup details or
email verification codes back into chat.

## Cloud AI clients

For ChatGPT, Claude, Gemini, or another cloud client that supports remote MCP:

1. Add a connector named `Revdoku` with URL `https://app.revdoku.com/mcp`.
2. Complete the Revdoku OAuth flow in the browser.
3. Reconnect the client if needed, then verify that Revdoku tools are available.

## Local agents and the CLI

For a local agent or a task that needs files from the user's computer, use the
official setup guide at `https://revdoku.com/local-install/` and install the
Revdoku CLI and skill:

```sh
curl -fsSL https://revdoku.com/install.sh | bash
```

Then run:

```sh
~/.revdoku/bin/revdoku --login
```

Ask the user to approve the browser device sign-in screen. The client stores the
credential securely in `~/.revdoku/credentials`; never print or repeat it. Use
the privacy-preserving email-code endpoints only as a fallback. If the fallback
does not complete, return to browser device sign-in rather than asking for other
authentication secrets.

Verify the connection with `~/.revdoku/bin/revdoku status`. Publish a local
folder with `~/.revdoku/bin/revdoku p <dir>` only when the user asks for a live
website. If `~/.revdoku/bin` is already on `PATH`, the shorter `revdoku` command
is equivalent.

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
