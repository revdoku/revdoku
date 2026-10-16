# Authentication API reference

Sign-in helpers for the CLI and AI agents. Backend applications use an API key from the dashboard.

Requests go to `https://api.revdoku.com`. Every path starts with `/v1`, for example `https://api.revdoku.com/v1/mailboxes`. Send `Authorization: Bearer $REVDOKU_API_KEY` from your server. Tables use JSON names; where TypeScript differs, a field shows `json_name` / `typescriptName`. Python uses the JSON names.

Operations that need no API key run before you have one. They use the generated `DefaultApi` class instead of `Revdoku`, so their errors are `ResponseError` (TypeScript) or `ApiException` (Python), not `RevdokuError`.

[All operations](https://revdoku.com/api/reference.md) · [API guide](https://revdoku.com/api.md) · [Errors](https://revdoku.com/api.md#errors) · [OpenAPI](https://revdoku.com/openapi.json)

- [Email a sign-in code](#email-a-sign-in-code): `POST /v1/agent_auth/request_code`
- [Exchange a sign-in code for an API key](#exchange-a-sign-in-code-for-an-api-key): `POST /v1/agent_auth/verify_code`
- [Exchange a one-time dashboard connection code for an API key](#exchange-a-one-time-dashboard-connection-code-for-an-api-key): `POST /v1/agent_auth/exchange_grant`
- [Create a dashboard link for the user](#create-a-dashboard-link-for-the-user): `POST /v1/agent_auth/browser_login_link`

## Email a sign-in code

`POST /v1/agent_auth/request_code`

Needs no API key.

Sends a six-digit code to an existing account email. The response is the same for every address, so it never reveals whether an account exists. Create new accounts in the browser at https://app.revdoku.com/users/sign_up.

| Language | Call |
| --- | --- |
| TypeScript | `new DefaultApi().requestSignInCode({ requestSignInCodeRequest })` |
| Python | `DefaultApi().request_sign_in_code(request_sign_in_code_request)` |

**Request body**: TypeScript `requestSignInCodeRequest: RequestSignInCodeRequest`, Python `request_sign_in_code_request=RequestSignInCodeRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `email` | string (email) | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { DefaultApi } from 'revdoku';

// This operation needs no API key, so it uses the generated API class.
const api = new DefaultApi();
const { data } = await api.requestSignInCode({
  requestSignInCodeRequest: { email: 'you@example.com' },
});
console.log(data);
```

**Python**

```python
from revdoku import DefaultApi, RequestSignInCodeRequest

# This operation needs no API key, so it uses the generated API class.
api = DefaultApi()
response = api.request_sign_in_code(
    RequestSignInCodeRequest(email="you@example.com"),
)
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/agent_auth/request_code" \
  -H "Content-Type: application/json" \
  -d '{"email": "you@example.com"}'
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `message` | string |  |
| `email` | string |  |
| `expires_in_seconds` / `expiresInSeconds` | integer |  |
| `fallback_url` / `fallbackUrl` | string (uri) |  |
| `hint` | string |  |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Authentication](https://revdoku.com/api.md#authentication)

## Exchange a sign-in code for an API key

`POST /v1/agent_auth/verify_code`

Needs no API key.

Creates an AI agent connection for an account owner or administrator. Accounts with two-factor authentication must use browser sign-in.

| Language | Call |
| --- | --- |
| TypeScript | `new DefaultApi().verifySignInCode({ verifySignInCodeRequest })` |
| Python | `DefaultApi().verify_sign_in_code(verify_sign_in_code_request)` |

**Request body**: TypeScript `verifySignInCodeRequest: VerifySignInCodeRequest`, Python `verify_sign_in_code_request=VerifySignInCodeRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `email` | string (email) | yes |  |
| `code` | string | yes | Six digits; spaces are ignored. |
| `label` | string | no | Connection name shown in Account access. |
| `permission_scope` / `permissionScope` | string: `mailbox_read`, `mailbox_write`, `mailbox_admin` | no |  |
| `mailbox_access` / `mailboxAccess` | string: `all`, `selected` | no |  |
| `mailbox_ids` / `mailboxIds` | array of string | no | Required when mailbox_access is selected. |
| `mailbox_permissions` / `mailboxPermissions` | object | no | Optional access per selected mailbox ID: read or write. Without an entry, a mailbox gets write, or read when permission_scope is mailbox_read. |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { DefaultApi } from 'revdoku';

// This operation needs no API key, so it uses the generated API class.
const api = new DefaultApi();
const { data } = await api.verifySignInCode({
  verifySignInCodeRequest: { email: 'you@example.com', code: '123456' },
});
console.log(data);
```

**Python**

```python
from revdoku import DefaultApi, VerifySignInCodeRequest

# This operation needs no API key, so it uses the generated API class.
api = DefaultApi()
response = api.verify_sign_in_code(
    VerifySignInCodeRequest(email="you@example.com", code="123456"),
)
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/agent_auth/verify_code" \
  -H "Content-Type: application/json" \
  -d '{"email": "you@example.com", "code": "123456"}'
```

**Response** `201`

| Field | Type | Description |
| --- | --- | --- |
| `api_key` / `apiKey` | string |  |
| `account_id` / `accountId` | string |  |
| `account_name` / `accountName` | string |  |
| `scope` | string: `mailbox_read`, `mailbox_write`, `mailbox_admin` |  |
| `mailbox_access` / `mailboxAccess` | string: `all`, `selected` |  |
| `mailbox_ids` / `mailboxIds` | array of string |  |
| `mailbox_permissions` / `mailboxPermissions` | object |  |
| `account_connection_limits` / `accountConnectionLimits` | object |  |
| `expires_at` / `expiresAt` | string (date-time) or null |  |
| `manage_access` / `manageAccess` | object |  |
| `mailboxes` | array of object |  |
| `guidance` | string |  |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Authentication](https://revdoku.com/api.md#authentication)

## Exchange a one-time dashboard connection code for an API key

`POST /v1/agent_auth/exchange_grant`

Needs no API key.

The dashboard creates the one-time code when a signed-in administrator copies a connection prompt.

| Language | Call |
| --- | --- |
| TypeScript | `new DefaultApi().exchangeConnectionGrant({ exchangeConnectionGrantRequest })` |
| Python | `DefaultApi().exchange_connection_grant(exchange_connection_grant_request)` |

**Request body**: TypeScript `exchangeConnectionGrantRequest: ExchangeConnectionGrantRequest`, Python `exchange_connection_grant_request=ExchangeConnectionGrantRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `grant_token` / `grantToken` | string | yes |  |
| `label` | string | no |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { DefaultApi } from 'revdoku';

// This operation needs no API key, so it uses the generated API class.
const api = new DefaultApi();
const { data } = await api.exchangeConnectionGrant({
  exchangeConnectionGrantRequest: { grantToken: 'ONE_TIME_CODE' },
});
console.log(data);
```

**Python**

```python
from revdoku import DefaultApi, ExchangeConnectionGrantRequest

# This operation needs no API key, so it uses the generated API class.
api = DefaultApi()
response = api.exchange_connection_grant(
    ExchangeConnectionGrantRequest(grant_token="ONE_TIME_CODE"),
)
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/agent_auth/exchange_grant" \
  -H "Content-Type: application/json" \
  -d '{"grant_token": "ONE_TIME_CODE"}'
```

**Response** `201`

| Field | Type | Description |
| --- | --- | --- |
| `api_key` / `apiKey` | string |  |
| `account_id` / `accountId` | string |  |
| `account_name` / `accountName` | string |  |
| `scope` | string: `mailbox_read`, `mailbox_write`, `mailbox_admin` |  |
| `mailbox_access` / `mailboxAccess` | string: `all`, `selected` |  |
| `mailbox_ids` / `mailboxIds` | array of string |  |
| `mailbox_permissions` / `mailboxPermissions` | object |  |
| `account_connection_limits` / `accountConnectionLimits` | object |  |
| `expires_at` / `expiresAt` | string (date-time) or null |  |
| `manage_access` / `manageAccess` | object |  |
| `mailboxes` | array of object |  |
| `guidance` | string |  |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Authentication](https://revdoku.com/api.md#authentication)

## Create a dashboard link for the user

`POST /v1/agent_auth/browser_login_link`

Returns a dashboard URL for a path such as /mailboxes. The user signs in normally; the link grants no access.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.createBrowserLink({ createBrowserLinkRequest })` |
| Python | `client.api.create_browser_link(create_browser_link_request)` |

**Request body**: TypeScript `createBrowserLinkRequest: CreateBrowserLinkRequest`, Python `create_browser_link_request=CreateBrowserLinkRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `redirect_path` / `redirectPath` | string | no |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.createBrowserLink({
  createBrowserLinkRequest: { redirectPath: '/mailboxes' },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, CreateBrowserLinkRequest

client = Revdoku()
response = client.api.create_browser_link(
    CreateBrowserLinkRequest(redirect_path="/mailboxes"),
)
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/agent_auth/browser_login_link" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"redirect_path": "/mailboxes"}'
```

**Response** `201`

| Field | Type | Description |
| --- | --- | --- |
| `url` | string (uri) | Dashboard link. The user signs in normally; the link grants nothing. |
| `path` | string |  |
| `single_use` / `singleUse` | boolean |  |
| `requires_login` / `requiresLogin` | boolean |  |
| `redirect_path` / `redirectPath` | string |  |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Authentication](https://revdoku.com/api.md#authentication)
