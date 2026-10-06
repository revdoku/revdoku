# Authentication for existing accounts

REST endpoints use `https://api.revdoku.com`; OAuth endpoints use
`https://app.revdoku.com`.

Most REST clients use an API key from **Account → Access**. Send it as
`Authorization: Bearer YOUR_API_KEY`. For a new account, use [direct signup](https://revdoku.com/api.md#direct-api-signup).
Hosted MCP setup is documented in the [MCP guide](https://revdoku.com/mcp.md).

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/v1/agent_auth/status` | API-key status alias for agents; same connection payload as `/v1/status`. |
| `POST` | `/v1/agent_auth/request_code` | Request an email verification code without revealing whether the email has a Revdoku account. Existing-user sign-in only; use browser signup or the separate API signup flow for a new identity. |
| `POST` | `/v1/agent_auth/verify_code` | Verify the email code and create an API key when the code is valid. |
| `POST` | `/v1/agent_auth/browser_login_link` | Return a stable dashboard URL (legacy endpoint name; normal sign-in is required). |
| `POST` | `/oauth/device_authorization` | Start OAuth device authorization for local CLI/agent clients. |
| `GET` / `POST` | `/oauth/device` | Browser page where the user enters/approves a device code. |
| `POST` | `/oauth/token` | Exchange OAuth authorization codes, device codes, or refresh tokens. |

## OAuth Device Authorization

Local CLI/device-code flow:

```http
POST /oauth/register
Content-Type: application/json

{
  "client_name": "Codex on laptop",
  "redirect_uris": [],
  "grant_types": [
    "urn:ietf:params:oauth:grant-type:device_code",
    "refresh_token"
  ],
  "response_types": [],
  "token_endpoint_auth_method": "none"
}

POST /oauth/device_authorization
Content-Type: application/json

{
  "client_id": "mcp_client_...",
  "scope": "revdoku:mcp",
  "resource": "https://mcp.revdoku.com"
}
```

1. Open the returned browser link and show the Connection ID to the human.
2. The human checks the same ID in Revdoku and selects **Confirm Connection**.
3. Poll the token endpoint until approval or expiry.
4. Store the returned credential privately. Permissions can be reduced in **Account → Access**.

| Field | Purpose |
| --- | --- |
| `verification_uri_complete` | Browser approval link. |
| `user_code` | Connection ID for visual confirmation; never request it in chat. |
| `device_code` | Private code used while polling the token endpoint. |
| `interval` | Minimum delay between polls. |
| `revdoku_api_key` | Revdoku extension returned after approval for local REST tooling. |



Local agents should prefer OAuth device authorization over email-code login. The
client registers with grant type
`urn:ietf:params:oauth:grant-type:device_code`, calls
`POST /oauth/device_authorization`, shows the returned `verification_uri_complete`
and presents `user_code` as a **Connection ID**, then polls `POST /oauth/token`.
The user confirms the matching Connection ID in the browser.

Pending poll responses use standard device-flow errors:

| Error | Meaning |
| --- | --- |
| `authorization_pending` | User has not approved yet; wait `interval` seconds and poll again. |
| `slow_down` | Increase the polling interval. |
| `access_denied` | User denied the browser prompt. |
| `expired_token` | Device code expired; start again. |

Successful device-code token responses include normal OAuth fields plus
`revdoku_api_key`, a durable `revdoku_...` key for local REST API clients.
The browser approval screen defaults to selected mailboxes and `mailbox_read` when
the client does not request a scope. Choose the mailboxes and permission on that
screen. Selecting all existing mailboxes keeps a fixed selection; **All current and
future mailboxes** is a separate choice. Read access supports message/file reads;
provisioning new mailboxes requires account-wide `mailbox_admin`.

## Permission scopes

| Scope | Meaning |
| --- | --- |
| `mailbox_read` | List and read allowed mailbox files only. |
| `mailbox_write` | Create and update allowed mailbox files. |
| `mailbox_admin` | Create, update, and manage allowed mailboxes. |

| Input | Purpose |
| --- | --- |
| `permission_scope` | Choose one of the permissions above; bound to consent. |
| OAuth `scope` | Protocol scope: `revdoku:mcp`, optionally `offline_access`. |
| Email-code `scope` | Legacy alias for `permission_scope` on email-code key creation only. |

OAuth/device requests and dashboard one-time connection prompts default to
`mailbox_read` when permission is omitted. Legacy email-code login and raw API-key creation default to `mailbox_admin`;
request an explicit permission for those flows. Direct signup creates an account-wide
`mailbox_admin` key. Invalid values are rejected. Account → Access defaults
new keys to selected mailboxes and read permission.

## POST /v1/agent_auth/request_code

The request returns the same success shape for every syntactically valid email.
It does not reveal whether an account exists, is locked, or has two-factor authentication.

| Response field | Purpose |
| --- | --- |
| `fallback_url` | Browser sign-in link if no code arrives or email-code verification fails. |
| `hint` | Explanation of the fallback. |

Use browser sign-in when required. Never ask for passwords, TOTP codes or backup
codes through an AI chat.

```json
{
  "email": "person@example.com"
}
```

## POST /v1/agent_auth/verify_code

Verify a privately entered email code for an eligible account.

| Result | Behavior |
| --- | --- |
| Success | Returns a Revdoku API key. Store it privately. |
| `INVALID_CODE` | Verification failed; also covers locked accounts or accounts requiring two-factor authentication. |
| `error.details.fallback_url` | Browser sign-in link. |
| `error.details.hint` | Recovery explanation. |

Use browser device sign-in after verification fails; do not repeatedly submit codes.

```json
{
  "email": "person@example.com",
  "code": "123456",
  "label": "Codex on laptop",
  "permission_scope": "mailbox_admin",
  "mailbox_access": "all"
}
```

For selected-mailbox access, use:

```json
{
  "mailbox_access": "selected",
  "mailbox_ids": [
    "bkt_..."
  ],
  "mailbox_permissions": {
    "bkt_...": "write"
  }
}
```

## POST /v1/agent_auth/browser_login_link

Requires `Authorization`. This compatibility endpoint returns a stable internal
dashboard URL and never exchanges an API key for a browser session. The user
signs in normally if the browser has no active Revdoku session.

```json
{
  "redirect_path": "/account/access"
}
```

Common `redirect_path` values:

| Path | Destination |
| --- | --- |
| `/mailboxes` | Mailbox dashboard. |
| `/account/access` | Members, agents, and API keys. |

## Activity attribution

Optional: identify your client in activity logs. These headers are not required
to create a mailbox or read email.

```http
User-Agent: MyRevdokuClient/1.0 (codex)
X-Revdoku-Agent: codex
X-Revdoku-Agent-Client: chatgpt
X-Revdoku-Agent-Version: 1.0.0
X-Revdoku-Agent-Run-Id: run_20260520_001
X-Revdoku-Agent-Project: support-mailbox
X-Revdoku-Agent-Task: check-new-messages
```
