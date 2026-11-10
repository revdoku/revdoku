# Authentication API reference

Sign-in helpers for the CLI and AI agents. Backend applications use an API key from the dashboard.

Requests go to `https://api.revdoku.com`. Every path starts with `/v1`, for example `https://api.revdoku.com/v1/buckets`. Send `Authorization: Bearer $REVDOKU_API_KEY` from your server. Tables use JSON names; where TypeScript differs, a field shows `json_name` / `typescriptName`. Python uses the JSON names.

Operations that need no API key run before you have one. They use the generated `DefaultApi` class instead of `Revdoku`, so their errors are `ResponseError` (TypeScript) or `ApiException` (Python), not `RevdokuError`.

[All operations](https://revdoku.com/api/reference.md) · [API guide](https://revdoku.com/api.md) · [Errors](https://revdoku.com/api.md#errors) · [OpenAPI](https://revdoku.com/openapi.json)

- [Email a sign-in code](#email-a-sign-in-code): `POST /v1/auth/sign_in_code`
- [Exchange a sign-in code for an API key](#exchange-a-sign-in-code-for-an-api-key): `POST /v1/auth/sign_in_code/verify`
- [Exchange a one-time dashboard connection code for an API key](#exchange-a-one-time-dashboard-connection-code-for-an-api-key): `POST /v1/auth/grant/exchange`
- [Create a dashboard link](#create-a-dashboard-link): `POST /v1/auth/dashboard_link`

## Email a sign-in code

`POST /v1/auth/sign_in_code`

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
curl -X POST "https://api.revdoku.com/v1/auth/sign_in_code" \
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

`POST /v1/auth/sign_in_code/verify`

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
| `permission_scope` / `permissionScope` | string: `bucket_read`, `bucket_write`, `bucket_admin` | no |  |
| `bucket_access` / `bucketAccess` | string: `all`, `selected` | no |  |
| `bucket_ids` / `bucketIds` | array of string | no | Required when bucket_access is selected. |
| `bucket_permissions` / `bucketPermissions` | object | no | Optional access per selected bucket ID: read or write. Without an entry, a bucket gets write, or read when permission_scope is bucket_read. |
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
curl -X POST "https://api.revdoku.com/v1/auth/sign_in_code/verify" \
  -H "Content-Type: application/json" \
  -d '{"email": "you@example.com", "code": "123456"}'
```

**Response** `201`

| Field | Type | Description |
| --- | --- | --- |
| `api_key` / `apiKey` | string |  |
| `account_id` / `accountId` | string |  |
| `account_name` / `accountName` | string |  |
| `scope` | string: `bucket_read`, `bucket_write`, `bucket_admin` |  |
| `bucket_access` / `bucketAccess` | string: `all`, `selected` |  |
| `bucket_ids` / `bucketIds` | array of string |  |
| `bucket_permissions` / `bucketPermissions` | object |  |
| `account_connection_limits` / `accountConnectionLimits` | object |  |
| `expires_at` / `expiresAt` | string (date-time) or null |  |
| `manage_access` / `manageAccess` | object |  |
| `buckets` | array of object |  |
| `guidance` | string |  |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Authentication](https://revdoku.com/api.md#authentication)

## Exchange a one-time dashboard connection code for an API key

`POST /v1/auth/grant/exchange`

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
curl -X POST "https://api.revdoku.com/v1/auth/grant/exchange" \
  -H "Content-Type: application/json" \
  -d '{"grant_token": "ONE_TIME_CODE"}'
```

**Response** `201`

| Field | Type | Description |
| --- | --- | --- |
| `api_key` / `apiKey` | string |  |
| `account_id` / `accountId` | string |  |
| `account_name` / `accountName` | string |  |
| `scope` | string: `bucket_read`, `bucket_write`, `bucket_admin` |  |
| `bucket_access` / `bucketAccess` | string: `all`, `selected` |  |
| `bucket_ids` / `bucketIds` | array of string |  |
| `bucket_permissions` / `bucketPermissions` | object |  |
| `account_connection_limits` / `accountConnectionLimits` | object |  |
| `expires_at` / `expiresAt` | string (date-time) or null |  |
| `manage_access` / `manageAccess` | object |  |
| `buckets` | array of object |  |
| `guidance` | string |  |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Authentication](https://revdoku.com/api.md#authentication)

## Create a dashboard link

`POST /v1/auth/dashboard_link`

Returns a dashboard URL for a path such as /buckets. The user signs in normally; the link grants no access.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.createDashboardLink({ createDashboardLinkRequest })` |
| Python | `client.api.create_dashboard_link(create_dashboard_link_request)` |

**Request body**: TypeScript `createDashboardLinkRequest: CreateDashboardLinkRequest`, Python `create_dashboard_link_request=CreateDashboardLinkRequest(...)`.

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
const { data } = await client.api.createDashboardLink({
  createDashboardLinkRequest: { redirectPath: '/buckets' },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, CreateDashboardLinkRequest

client = Revdoku()
response = client.api.create_dashboard_link(
    CreateDashboardLinkRequest(redirect_path="/buckets"),
)
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/auth/dashboard_link" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"redirect_path": "/buckets"}'
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
