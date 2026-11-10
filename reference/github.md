# GitHub API reference

Connect a GitHub repository to a bucket: its files become a copy of one branch, and each push updates them.

Requests go to `https://api.revdoku.com`. Every path starts with `/v1`, for example `https://api.revdoku.com/v1/buckets`. Send `Authorization: Bearer $REVDOKU_API_KEY` from your server. Tables use JSON names; where TypeScript differs, a field shows `json_name` / `typescriptName`. Python uses the JSON names.

[All operations](https://revdoku.com/api/reference.md) · [API guide](https://revdoku.com/api.md) · [Errors](https://revdoku.com/api.md#errors) · [OpenAPI](https://revdoku.com/openapi.json)

- [List connected GitHub accounts](#list-connected-github-accounts): `GET /v1/account/github/installations`
- [List the repositories of a GitHub account](#list-the-repositories-of-a-github-account): `GET /v1/account/github/installations/{installation_id}/repositories`
- [Read the GitHub repository of a bucket](#read-the-github-repository-of-a-bucket): `GET /v1/buckets/{bucket_id}/github`
- [Connect a GitHub repository](#connect-a-github-repository): `POST /v1/buckets/{bucket_id}/github`
- [Change GitHub sync settings](#change-github-sync-settings): `PATCH /v1/buckets/{bucket_id}/github`
- [Disconnect the GitHub repository](#disconnect-the-github-repository): `DELETE /v1/buckets/{bucket_id}/github`
- [Sync the GitHub repository now](#sync-the-github-repository-now): `POST /v1/buckets/{bucket_id}/github/sync`
- [List the branches that can get a preview](#list-the-branches-that-can-get-a-preview): `GET /v1/buckets/{bucket_id}/github/branches`
- [Get the links to add a GitHub account](#get-the-links-to-add-a-github-account): `GET /v1/buckets/{bucket_id}/github/setup_link`

## List connected GitHub accounts

`GET /v1/account/github/installations`

Returns the GitHub accounts and organizations where a person installed the Revdoku GitHub App for this account. Each one reads the repositories that its owner chose on GitHub. Needs an account owner or administrator key with admin access to all buckets. To add a GitHub account, get the links with getGithubSetupLink.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.listGithubInstallations()` |
| Python | `client.api.list_github_installations()` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |
| `limit` | integer | no |  |
| `cursor` | string | no | pagination.next_cursor from the previous page. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.listGithubInstallations();
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.list_github_installations()
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/account/github/installations" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `installations` | array of GithubInstallation |  |
| `installations[].installation_id` / `installationId` | integer | Pass it to listGithubRepositories, and optionally to connectGithubRepository. |
| `installations[].github_account_login` / `githubAccountLogin` | string |  |
| `installations[].github_account_type` / `githubAccountType` | string | User or Organization. |
| `installations[].settings_url` / `settingsUrl` | string (uri) | The installation's page on GitHub, where its owner chooses the repositories that Revdoku can read. |
| `installations[].repository_selection` / `repositorySelection` | string: `all`, `selected` | all: every repository of the account. selected: only the repositories that its owner chose. |
| `pagination` | Pagination | One page of a list. Request the next page with cursor=next_cursor and the same filters. Cursors are opaque strings: do not build or decode them. |
| `pagination.limit` | integer |  |
| `pagination.has_more` / `hasMore` | boolean | True when another page exists. |
| `pagination.next_cursor` / `nextCursor` | string or null | Cursor for the next page; null on the last page. Email lists always return a cursor so that you can poll for new mail. |

```json
{
  "success": true,
  "data": {
    "installations": [
      {
        "installation_id": 51234567,
        "github_account_login": "acme",
        "github_account_type": "Organization",
        "settings_url": "https://github.com/organizations/acme/settings/installations/51234567",
        "repository_selection": "selected"
      }
    ],
    "pagination": {"limit": 50, "has_more": false, "next_cursor": null}
  }
}
```

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [GitHub repositories](https://revdoku.com/api.md#github-repositories)

## List the repositories of a GitHub account

`GET /v1/account/github/installations/{installation_id}/repositories`

Returns the repositories that one connected GitHub account lets Revdoku read, A-Z by full name. A repository that is not listed needs access on GitHub: give the account's settings_url to its owner. Needs an account owner or administrator key with admin access to all buckets.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.listGithubRepositories({ installationId })` |
| Python | `client.api.list_github_repositories(installation_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `installation_id` / `installationId` | integer | yes | installation_id of a connected GitHub account. |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |
| `limit` | integer | no |  |
| `cursor` | string | no | pagination.next_cursor from the previous page. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.listGithubRepositories({ installationId: 1 });
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.list_github_repositories(1)
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/account/github/installations/1/repositories" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `repositories` | array of GithubRepository |  |
| `repositories[].id` | integer | GitHub repository ID. |
| `repositories[].owner` | string | Pass as repo_owner to connectGithubRepository. |
| `repositories[].name` | string | Pass as repo_name. |
| `repositories[].full_name` / `fullName` | string |  |
| `repositories[].default_branch` / `defaultBranch` | string |  |
| `repositories[].private` / `_private` | boolean |  |
| `repositories[].archived` | boolean |  |
| `repositories[].html_url` / `htmlUrl` | string (uri) |  |
| `pagination` | Pagination | One page of a list. Request the next page with cursor=next_cursor and the same filters. Cursors are opaque strings: do not build or decode them. Fields as in [List connected GitHub accounts](#list-connected-github-accounts). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [GitHub repositories](https://revdoku.com/api.md#github-repositories)

## Read the GitHub repository of a bucket

`GET /v1/buckets/{bucket_id}/github`

Returns the bucket's GitHub repository and its sync state. github is null when the bucket never had one. After connectGithubRepository, read it until last_synced_at is set (the first copy is done) or sync_state is error.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.getGithubSync({ bucketId })` |
| Python | `client.api.get_github_sync(bucket_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.getGithubSync({ bucketId: 'bkt_example' });
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.get_github_sync("bkt_example")
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/buckets/bkt_example/github" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `github` | GithubSync or null |  |

```json
{
  "success": true,
  "data": {
    "github": {
      "id": "bgh_8xQ2kL4mN7pR",
      "bucket_id": "bkt_5Gh3Lm9Qx2Tz",
      "installation_id": 51234567,
      "repo_owner": "acme",
      "repo_name": "docs",
      "repo_full_name": "acme/docs",
      "repository_url": "https://github.com/acme/docs",
      "branch": "main",
      "repo_path": null,
      "sync_state": "idle",
      "last_error": null,
      "next_retry_at": null,
      "last_synced_at": "2026-11-09T10:15:00Z",
      "last_synced_commit_sha": "4f1c2e9a7b3d5f6081a2c3d4e5f60718293a4b5c",
      "last_synced_commit_message": "Add the quickstart page",
      "auto_publish": true,
      "push_revdoku_edits": false,
      "auto_commit": false,
      "pending_count": 0,
      "pending_changes": [],
      "pull_request": null,
      "skipped_files": [],
      "auto_publish_error": null,
      "dashboard_url": "https://app.revdoku.com/buckets/view?account_id=acct_3Fh8Qm2Lx9Tw&id=bkt_5Gh3Lm9Qx2Tz&site=github&view=site",
      "created_at": "2026-11-09T10:14:20Z",
      "updated_at": "2026-11-09T10:15:00Z"
    }
  }
}
```

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [GitHub repositories](https://revdoku.com/api.md#github-repositories)

## Connect a GitHub repository

`POST /v1/buckets/{bucket_id}/github`

Makes the bucket's files a copy of one branch of a repository, or of one folder of it. The first sync copies the files, and each later push to the branch updates them. The bucket must have no files of its own; its email and agent folders may stay. GitHub stays the source: Revdoku never copies a bucket into a repository. Needs an account owner or administrator key with admin access to all buckets. A connected GitHub account must read the repository: 403 GITHUB_APP_NOT_INSTALLED gives the links for the person in error.details.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.connectGithubRepository({ bucketId, connectGithubRepositoryRequest })` |
| Python | `client.api.connect_github_repository(bucket_id, connect_github_repository_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |

**Request body**: TypeScript `connectGithubRepositoryRequest: ConnectGithubRepositoryRequest`, Python `connect_github_repository_request=ConnectGithubRepositoryRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `github` | GithubConnect | yes |  |
| `github.repo_owner` / `repoOwner` | string | yes | The GitHub account or organization that owns the repository. |
| `github.repo_name` / `repoName` | string | yes |  |
| `github.branch` | string | no | The branch to copy. Default: the repository's default branch. |
| `github.repo_path` / `repoPath` | string | no | One folder of the repository as the bucket root, such as docs. Default: the whole repository. |
| `github.installation_id` / `installationId` | integer | no | The connected GitHub account that reads the repository. Default: the connected account of repo_owner. |
| `github.push_revdoku_edits` / `pushRevdokuEdits` | boolean | no | False makes the files a read-only copy of the repository. Default: true. |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.connectGithubRepository({
  bucketId: 'bkt_example',
  connectGithubRepositoryRequest: { github: { repoOwner: 'example', repoName: 'example' } },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, ConnectGithubRepositoryRequest, GithubConnect

client = Revdoku()
response = client.api.connect_github_repository(
    "bkt_example",
    ConnectGithubRepositoryRequest(
        github=GithubConnect(repo_owner="example", repo_name="example"),
    ),
)
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/buckets/bkt_example/github" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"github": {"repo_owner": "example", "repo_name": "example"}}'
```

**Response** `201`

| Field | Type | Description |
| --- | --- | --- |
| `github` | GithubSync | The GitHub repository of a bucket. The bucket's files are a copy of one branch, or of one folder of it. |
| `github.id` | string | Link ID. |
| `github.bucket_id` / `bucketId` | string |  |
| `github.installation_id` / `installationId` | integer | The connected GitHub account (Revdoku GitHub App installation) that reads the repository. |
| `github.repo_owner` / `repoOwner` | string | The GitHub account or organization that owns the repository. |
| `github.repo_name` / `repoName` | string |  |
| `github.repo_full_name` / `repoFullName` | string | owner/name. |
| `github.repository_url` / `repositoryUrl` | string (uri) |  |
| `github.branch` | string |  |
| `github.repo_path` / `repoPath` | string or null | The repository folder that is the bucket root. Null: the whole repository. |
| `github.sync_state` / `syncState` | string: `idle`, `syncing`, `waiting_locked`, `error`, `disconnected` | idle: nothing runs. syncing: a sync runs. waiting_locked: the bucket is locked and the sync tries again later. error: see last_error and next_retry_at. disconnected: the repository is no longer connected. |
| `github.last_error` / `lastError` | GithubSyncError or null | Why the last sync failed or waits, or why GitHub disconnected the repository. |
| `github.next_retry_at` / `nextRetryAt` | string (date-time) or null | When a failed sync tries again. Null after the last try: sync again after the cause is fixed. |
| `github.last_synced_at` / `lastSyncedAt` | string (date-time) or null | When the last sync finished. Null until the first copy is done. |
| `github.last_synced_commit_sha` / `lastSyncedCommitSha` | string or null | The commit of the branch that the files show. |
| `github.last_synced_commit_message` / `lastSyncedCommitMessage` | string or null |  |
| `github.auto_publish` / `autoPublish` | boolean | The site publishes again after each sync. The first publish is publishBucket. |
| `github.push_revdoku_edits` / `pushRevdokuEdits` | boolean | Edits made in Revdoku can go to GitHub. False: the files are a read-only copy of the repository. |
| `github.auto_commit` / `autoCommit` | boolean | Each sync commits the edits made in Revdoku to the branch. False: they wait in pending_changes until a person publishes them in the dashboard. |
| `github.pending_count` / `pendingCount` | integer | Edits made in Revdoku that are not on the branch. |
| `github.pending_changes` / `pendingChanges` | array of object | The first 200 of these edits. Fields: `path`, `status`. |
| `github.pull_request` / `pullRequest` | object or null |  |
| `github.skipped_files` / `skippedFiles` | array of object | Repository files that the last sync left out, for example files that are too large or stored in Git LFS. Fields: `path`, `code`, `reason`. |
| `github.auto_publish_error` / `autoPublishError` | GithubSyncError or null | Why the site was not published again after the last sync. |
| `github.dashboard_url` / `dashboardUrl` | string or null | The bucket's GitHub page in the dashboard. It grants no access. |
| `github.created_at` / `createdAt` | string (date-time) |  |
| `github.updated_at` / `updatedAt` | string (date-time) |  |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Error codes named above: `GITHUB_APP_NOT_INSTALLED`.

Guide: [GitHub repositories](https://revdoku.com/api.md#github-repositories)

## Change GitHub sync settings

`PATCH /v1/buckets/{bucket_id}/github`

Sets auto_publish and the mode of edits made in Revdoku: push_revdoku_edits false makes the files a read-only copy, auto_commit true commits edits to the branch at each sync, and auto_commit false keeps them in pending_changes until a person publishes them in the dashboard. Needs an account owner or administrator key with admin access to all buckets.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.updateGithubSync({ bucketId, updateGithubSyncRequest })` |
| Python | `client.api.update_github_sync(bucket_id, update_github_sync_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |

**Request body**: TypeScript `updateGithubSyncRequest: UpdateGithubSyncRequest`, Python `update_github_sync_request=UpdateGithubSyncRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `github` | GithubSyncSettings | yes |  |
| `github.auto_publish` / `autoPublish` | boolean | no | Publish the site again after each sync. |
| `github.push_revdoku_edits` / `pushRevdokuEdits` | boolean | no | False makes the files a read-only copy of the repository. |
| `github.auto_commit` / `autoCommit` | boolean | no | True commits the edits made in Revdoku to the branch at each sync. False keeps them for a person to publish in the dashboard. |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.updateGithubSync({
  bucketId: 'bkt_example',
  updateGithubSyncRequest: { github: {} },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, GithubSyncSettings, UpdateGithubSyncRequest

client = Revdoku()
response = client.api.update_github_sync(
    "bkt_example",
    UpdateGithubSyncRequest(github=GithubSyncSettings()),
)
print(response.data)
```

**cURL**

```sh
curl -X PATCH "https://api.revdoku.com/v1/buckets/bkt_example/github" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"github": {}}'
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `github` | GithubSync | The GitHub repository of a bucket. The bucket's files are a copy of one branch, or of one folder of it. Fields as in [Connect a GitHub repository](#connect-a-github-repository). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [GitHub repositories](https://revdoku.com/api.md#github-repositories)

## Disconnect the GitHub repository

`DELETE /v1/buckets/{bucket_id}/github`

Stops the sync. The bucket keeps its files and its site. A later read shows the link with sync_state disconnected; connect the same repository again to continue its copy. Needs an account owner or administrator key with admin access to all buckets.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.disconnectGithubRepository({ bucketId })` |
| Python | `client.api.disconnect_github_repository(bucket_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.disconnectGithubRepository({
  bucketId: 'bkt_example',
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.disconnect_github_repository("bkt_example")
print(response.data)
```

**cURL**

```sh
curl -X DELETE "https://api.revdoku.com/v1/buckets/bkt_example/github" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `deleted` | boolean `true` |  |
| `id` | string | ID of the deleted resource. A webhook delete returns the bucket ID. |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [GitHub repositories](https://revdoku.com/api.md#github-repositories)

## Sync the GitHub repository now

`POST /v1/buckets/{bucket_id}/github/sync`

Copies new commits of the branch now and tries a failed sync again. Pushes sync without this call; use it after an error, or after a person changed access on GitHub. enqueued is false when a sync already runs. Needs an account owner or administrator key with admin access to all buckets.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.syncGithubRepository({ bucketId })` |
| Python | `client.api.sync_github_repository(bucket_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |

**Request body** (optional): TypeScript `actionRequest: ActionRequest`, Python `action_request=ActionRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.syncGithubRepository({
  bucketId: 'bkt_example',
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.sync_github_repository("bkt_example")
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/buckets/bkt_example/github/sync" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `202`

| Field | Type | Description |
| --- | --- | --- |
| `github` | GithubSync | The GitHub repository of a bucket. The bucket's files are a copy of one branch, or of one folder of it. Fields as in [Connect a GitHub repository](#connect-a-github-repository). |
| `enqueued` | boolean | False when a sync already runs. |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [GitHub repositories](https://revdoku.com/api.md#github-repositories)

## List the branches that can get a preview

`GET /v1/buckets/{bucket_id}/github/branches`

Returns the branches of the bucket's GitHub repository, without the linked branch (the site shows it), A-Z. Pass one as branch to previewBucket. Requires bucket publish permission. 404 GITHUB_SYNC_NOT_CONNECTED without a repository.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.listGithubBranches({ bucketId })` |
| Python | `client.api.list_github_branches(bucket_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.listGithubBranches({
  bucketId: 'bkt_example',
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.list_github_branches("bkt_example")
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/buckets/bkt_example/github/branches" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `branches` | array of string |  |

```json
{"success": true, "data": {"branches": ["next", "pricing-page"]}}
```

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Error codes named above: `GITHUB_SYNC_NOT_CONNECTED`.

Guide: [GitHub repositories](https://revdoku.com/api.md#github-repositories)

## Get the links to add a GitHub account

`GET /v1/buckets/{bucket_id}/github/setup_link`

Returns the links that a person opens to add a GitHub account or organization to this Revdoku account. Only the person who owns this key or AI connection can finish the step, signed in to Revdoku, within 30 minutes. Give install_url to install the Revdoku GitHub App; on GitHub the person chooses the account and the repositories. Give authorization_url when the App is already installed on that GitHub account; the person then selects Connect on the bucket's GitHub page. Then list the connected GitHub accounts until the new one shows. Needs an account owner or administrator key with admin access to all buckets.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.getGithubSetupLink({ bucketId })` |
| Python | `client.api.get_github_setup_link(bucket_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.getGithubSetupLink({
  bucketId: 'bkt_example',
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.get_github_setup_link("bkt_example")
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/buckets/bkt_example/github/setup_link" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `setup_link` / `setupLink` | GithubSetupLink | Links for a person's step on GitHub. Only the person who owns this key or AI connection can finish it, signed in to Revdoku. Never ask for GitHub passwords or tokens. |
| `setup_link.install_url` / `installUrl` | string (uri) | Installs the Revdoku GitHub App on a GitHub account or organization and connects it. On GitHub the person chooses the repositories. |
| `setup_link.authorization_url` / `authorizationUrl` | string (uri) | For a GitHub account where the App is already installed. After it, the person selects Connect on the bucket's GitHub page. |
| `setup_link.expires_at` / `expiresAt` | string (date-time) | The links work for 30 minutes. |
| `setup_link.dashboard_url` / `dashboardUrl` | string or null | The bucket's GitHub page in the dashboard. The person sees the result there, and another owner or administrator can add the GitHub account there. |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [GitHub repositories](https://revdoku.com/api.md#github-repositories)
