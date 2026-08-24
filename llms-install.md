# Revdoku agent setup

Use the shortest working path. Do not make the user configure a connector,
create an account, or open a second terminal before seeing a website.

## Public prompt

```text
I'd like you to set up Revdoku so you can publish a website for me for free.

Browser-only chat: don't install anything. Direct me to your setup guide—Claude: https://revdoku.com/claude/; ChatGPT: https://revdoku.com/chatgpt/; other products: https://revdoku.com/<lowercase-hyphenated-product-name>/.

With terminal access, run `npx skills add revdoku/revdoku --skill revdoku -g`; without npm, run `curl -fsSL https://revdoku.com/install.sh | bash`.

Then review https://revdoku.com/docs and ask what I'd like to publish.
```

## Agent rules

- If you have shell access, run the install and publish commands yourself.
- Never tell the user to open a separate terminal for commands you can run.
- Never ask for a Revdoku password, email OTP, TOTP/backup code, API key,
  connection token, protected-site password, or payment details in chat.
- Do not ask the user to send `continue` after a browser step. Resume by
  checking status yourself.
- Account creation is web-only at `https://app.revdoku.com/users/sign_up`.
- Revdoku OAuth and agent email-code flows are sign-in-only. They never create
  an account.
- Publish only when the user asks for a public or protected link. A signed-in
  `--draft` upload remains private.

## Local agent with shell access

Prefer npm when it is available:

```sh
npx skills add revdoku/revdoku --skill revdoku -g
```

Otherwise:

```sh
curl -fsSL https://revdoku.com/install.sh | bash
```

Then ask what the user wants to publish and run:

```sh
revdoku p <folder>
```

Without credentials, this creates a randomized public 24-hour preview and
prints a browser claim link. It does not create an account or private bucket.
Re-running updates the same preview without extending expiry.

After the user claims the website, run the same publish command again. The CLI
checks claim status, exchanges the one-time grant itself, saves the resulting
agent credential, and updates the claimed website. Do not ask the user to copy
the grant into chat.

Use `revdoku login` only when connecting a different existing account. The
browser OAuth flow is sign-in-only.

## Hosted MCP agent

Endpoint: `https://app.revdoku.com/mcp`

Before authentication, use:

- `website_preview_create`
- `website_preview_update`
- `website_preview_status`

These tools create only a public 24-hour preview. Share the returned
`public_url` and `claim_url`. When creating one, pass `ai_source` as `chatgpt`,
`claude`, `codex`, or `gemini` when known. After claim, call status again. The MCP response
then asks the host to start OAuth when an account tool is called. Revdoku's
OAuth screen signs an existing account in; it does not offer signup.

If the host does not support MCP or the agent needs local/binary files, use the
local CLI. A hosted agent cannot read the user's computer.

## Pricing and limits

Use <https://app.revdoku.com/pricing> for current prices and human-readable
comparisons. Read the versioned plan limits and indexing contract from
<https://app.revdoku.com/pricing.json>. `revdoku_status` embeds the public Free
contract; full-account profile responses include effective account overrides.

Anonymous previews are temporary and `noindex`. After claim, a permanent public
Free website is indexable by default. Password, Require Email, and temporary
preview websites remain `noindex`. No tier injects a Revdoku footer or badge.

## Troubleshooting tutorials

Link one tutorial only when the simple flow is unavailable or the user asks:

Client guides use the lowercase product name, with spaces replaced by hyphens:
`https://revdoku.com/<client>/` (for example, `/cursor/` and `/antigravity/`).

- Setup hub: <https://revdoku.com/connect/>
- ChatGPT: <https://revdoku.com/chatgpt/>
- Codex: <https://revdoku.com/codex/>
- Claude: <https://revdoku.com/claude/>
- Claude Desktop/terminal: <https://revdoku.com/claude-desktop-terminal/>
- Gemini: <https://revdoku.com/gemini/>
- Hermes: <https://revdoku.com/hermes/>

## Verification prompt

```text
Create a one-page project status website, publish it with Revdoku, and give me
the URL. If I ask for changes, update the same URL.
```
