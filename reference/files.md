# Files API reference

Upload, read, organize and restore files.

Requests go to `https://api.revdoku.com`. Every path starts with `/v1`, for example `https://api.revdoku.com/v1/mailboxes`. Send `Authorization: Bearer $REVDOKU_API_KEY` from your server. Tables use JSON names; where TypeScript differs, a field shows `json_name` / `typescriptName`. Python uses the JSON names.

[All operations](https://revdoku.com/api/reference.md) · [API guide](https://revdoku.com/api.md) · [Errors](https://revdoku.com/api.md#errors) · [OpenAPI](https://revdoku.com/openapi.json)

- [Prepare a file upload (step 1 of 3)](#prepare-a-file-upload-step-1-of-3): `POST /v1/direct_uploads`
- [List files](#list-files): `GET /v1/mailboxes/{mailbox_id}/files`
- [Save an uploaded file (step 3 of 3)](#save-an-uploaded-file-step-3-of-3): `POST /v1/mailboxes/{mailbox_id}/files`
- [Find a file by path](#find-a-file-by-path): `GET /v1/mailboxes/{mailbox_id}/files/by_path`
- [Append text to a file](#append-text-to-a-file): `POST /v1/mailboxes/{mailbox_id}/files/append_text`
- [Read file metadata](#read-file-metadata): `GET /v1/mailboxes/{mailbox_id}/files/{file_id}`
- [Delete a file](#delete-a-file): `DELETE /v1/mailboxes/{mailbox_id}/files/{file_id}`
- [Get a download link for a file](#get-a-download-link-for-a-file): `GET /v1/mailboxes/{mailbox_id}/files/{file_id}/download`
- [Rename or move a file in the same mailbox](#rename-or-move-a-file-in-the-same-mailbox): `POST /v1/mailboxes/{mailbox_id}/files/{file_id}/rename`
- [Move a file](#move-a-file): `POST /v1/mailboxes/{mailbox_id}/files/{file_id}/move`
- [Copy a file](#copy-a-file): `POST /v1/mailboxes/{mailbox_id}/files/{file_id}/copy`
- [List file versions](#list-file-versions): `GET /v1/mailboxes/{mailbox_id}/files/{file_id}/versions`
- [Restore a file version](#restore-a-file-version): `POST /v1/mailboxes/{mailbox_id}/files/{file_id}/versions/{version_id}/restore`
- [Start a batch upload](#start-a-batch-upload): `POST /v1/mailboxes/{mailbox_id}/upload_sessions`
- [Get storage targets for a batch](#get-storage-targets-for-a-batch): `POST /v1/mailboxes/{mailbox_id}/upload_sessions/{session_id}/uploads`
- [Save uploaded files](#save-uploaded-files): `POST /v1/mailboxes/{mailbox_id}/upload_sessions/{session_id}/finalize_batch`
- [Finish or cancel a batch upload](#finish-or-cancel-a-batch-upload): `POST /v1/mailboxes/{mailbox_id}/upload_sessions/{session_id}/finalize`

## Prepare a file upload (step 1 of 3)

`POST /v1/direct_uploads`

Returns a storage URL. Then PUT the bytes to direct_upload.url with exactly direct_upload.headers and no API key (step 2), and save the file with POST /v1/mailboxes/{mailbox_id}/files (step 3). Identical content at the same path returns skipped=true and duplicate=true without an upload.

| Language | Call |
| --- | --- |
| TypeScript | `client.uploadFile({ mailboxId, path, content })` (runs all three upload steps) |
| Python | `client.upload_file(mailbox_id, path, content)` (runs all three upload steps) |
| TypeScript, full API | `client.api.prepareFileUpload({ prepareFileUploadRequest })` |
| Python, full API | `client.api.prepare_file_upload(prepare_file_upload_request)` |

**Request body**: TypeScript `prepareFileUploadRequest: PrepareFileUploadRequest`, Python `prepare_file_upload_request=PrepareFileUploadRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |
| `path` | string | yes | Destination path in the mailbox. Paths under _email/ return EMAIL_PATH_READ_ONLY; other top-level folders that start with _ return RESERVED_PATH. |
| `existing_file_policy` / `existingFilePolicy` | string: `replace`, `skip` | no | skip returns the existing file without an upload when the path exists. |
| `blob` | UploadBlob | yes |  |
| `blob.filename` | string | yes |  |
| `blob.byte_size` / `byteSize` | integer (int64) | yes |  |
| `blob.checksum` | string | yes |  |
| `blob.content_type` / `contentType` | string | yes |  |
| `blob.sha256` | string | yes |  |
| `blob.purpose` | string: `mailbox_file` | yes |  |
| `account_id` / `accountId` | string | no |  |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
// uploadFile runs all three steps: prepare, PUT the bytes to storage, save.
const { data } = await client.uploadFile({
  mailboxId: 'bkt_example',
  path: 'notes/todo.txt',
  content: 'Call the customer back.',
  contentType: 'text/plain',
});
console.log(data.file.id, data.version.id);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
# upload_file runs all three steps: prepare, PUT the bytes to storage, save.
response = client.upload_file("bkt_example", "notes/todo.txt", "Call the customer back.", content_type="text/plain")
print(response.data.file.id, response.data.version.id)
```

**cURL**

```sh
# Step 1: prepare. checksum is the base64 MD5 and sha256 the hex SHA-256 of the bytes.
curl -X POST "https://api.revdoku.com/v1/direct_uploads" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
  "mailbox_id": "bkt_example",
  "path": "notes/todo.txt",
  "blob": {
    "filename": "todo.txt",
    "byte_size": 23,
    "content_type": "text/plain",
    "checksum": "BASE64_MD5_OF_CONTENT",
    "sha256": "HEX_SHA256_OF_CONTENT",
    "purpose": "mailbox_file"
  }
}'

# Step 2: PUT the bytes to direct_upload.url with exactly direct_upload.headers. Send no API key.
curl -X PUT "DIRECT_UPLOAD_URL" \
  -H "Content-Type: text/plain" \
  -H "Content-MD5: BASE64_MD5_OF_CONTENT" \
  --data-binary @todo.txt

# Step 3: save the file with signed_id from step 1.
curl -X POST "https://api.revdoku.com/v1/mailboxes/bkt_example/files" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"path": "notes/todo.txt", "signed_blob_id": "SIGNED_ID_FROM_STEP_1"}'
```

**Response** `201`, `200`

| Field | Type | Description |
| --- | --- | --- |
| `signed_id` / `signedId` | string |  |
| `filename` | string |  |
| `byte_size` / `byteSize` | integer (int64) |  |
| `checksum` | string |  |
| `content_type` / `contentType` | string |  |
| `direct_upload` / `directUpload` | StorageUpload |  |
| `direct_upload.url` | string (uri) |  |
| `direct_upload.headers` | object |  |
| `file` | MailboxFile |  |
| `file.id` | string |  |
| `file.mailbox_id` / `mailboxId` | string |  |
| `file.basename` | string |  |
| `file.path` | string |  |
| `file.role` | string |  |
| `file.created_by_system` / `createdBySystem` | string |  |
| `file.deleted` | boolean |  |
| `file.version_reasons` / `versionReasons` | array of FileVersionReason | Fields: `version_id`, `reason`, `created_by_id`, `version_number`, `created_at`. |
| `file.lock` | object |  |
| `file.current_file_version` / `currentFileVersion` | FileVersion or null |  |
| `file.created_by` / `createdBy` | FileActor | Fields: `id`, `name`, `email`. |
| `file.created_at` / `createdAt` | string (date-time) |  |
| `file.updated_at` / `updatedAt` | string (date-time) |  |
| `file.deleted_at` / `deletedAt` | string (date-time) |  |
| `file.created_by_agent` / `createdByAgent` | object |  |
| `file.updated_by_agent` / `updatedByAgent` | object |  |
| `file.created_by_api_key` / `createdByApiKey` | object |  |
| `file.updated_by_api_key` / `updatedByApiKey` | object |  |
| `file.read` | boolean |  |
| `file.read_at` / `readAt` | string (date-time) or null |  |
| `file.read_by` / `readBy` | FileActor or null |  |
| `file.read_by_api_key` / `readByApiKey` | FileKey or null |  |
| `version` | FileVersion | Its fields are in [OpenAPI](https://revdoku.com/openapi.json) under `FileVersion`. |
| `skipped` | boolean |  |
| `duplicate` | boolean |  |
| `reason` | string |  |
| `details` | object |  |

Example `201`:

```json
{
  "success": true,
  "data": {
    "signed_id": "eyJfcmFpbHMi...",
    "filename": "document_7a77539cbd6d02a5.txt",
    "byte_size": 1234,
    "checksum": "rL0Y20zC+Fzt72VPzMSk2A==",
    "content_type": "text/plain",
    "direct_upload": {
      "url": "https://storage.example/upload",
      "headers": {
        "Content-Type": "text/plain",
        "Content-MD5": "rL0Y20zC+Fzt72VPzMSk2A==",
        "Content-Disposition": "inline; filename=\"document_7a77539cbd6d02a5.txt\"; filename*=UTF-8''document_7a77539cbd6d02a5.txt"
      }
    }
  }
}
```

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Upload a file](https://revdoku.com/api.md#upload-a-file)

## List files

`GET /v1/mailboxes/{mailbox_id}/files`

Lists current files, including stored emails under _email/. Listing never marks files read.

| Language | Call |
| --- | --- |
| TypeScript | `client.listFiles({ mailboxId })` |
| Python | `client.list_files(mailbox_id)` |
| TypeScript, full API | `client.api.listFiles({ mailboxId })` |
| Python, full API | `client.api.list_files(mailbox_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |
| `q` | string | no | Case-insensitive text in the path. |
| `folder` | string | no | List one folder. An empty value lists the root. |
| `limit` | integer | no |  |
| `cursor` | string | no | pagination.next_cursor from the previous page. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.listFiles({ mailboxId: 'bkt_example' });
for (const file of data.files) {
  console.log(file.id, file.path);
}
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.list_files("bkt_example")
for file in response.data.files:
    print(file.id, file.path)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/mailboxes/bkt_example/files" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `files` | array of MailboxFile | Fields as in [Prepare a file upload (step 1 of 3)](#prepare-a-file-upload-step-1-of-3). |
| `pagination` | Pagination | One page of a list. Request the next page with cursor=next_cursor and the same filters. Cursors are opaque strings: do not build or decode them. |
| `pagination.limit` | integer |  |
| `pagination.has_more` / `hasMore` | boolean | True when another page exists. |
| `pagination.next_cursor` / `nextCursor` | string or null | Cursor for the next page; null on the last page. Email lists always return a cursor so that you can poll for new mail. |

```json
{
  "success": true,
  "data": {
    "files": [
      {
        "id": "df_example",
        "mailbox_id": "bkt_example",
        "basename": "summary.txt",
        "path": "reports/summary.txt",
        "role": "source",
        "deleted": false,
        "lock": {"locked": false},
        "current_file_version": {
          "id": "dfrev_example",
          "file_id": "df_example",
          "version_number": 0,
          "name": "summary.txt",
          "mime_type": "text/plain",
          "byte_size": 1234,
          "sha256": "0d6a3c2b8f5e41a7c9b2d4e6f8a1c3e5b7d9f1a3c5e7b9d1f3a5c7e9b1d3f5a7",
          "deleted": false,
          "ready": true,
          "has_text": false,
          "created_at": "2026-10-11T12:20:00Z",
          "created_by": {
            "id": "user_example",
            "email": "ada@example.com",
            "name": "Ada Lovelace"
          },
          "updated_by": {
            "id": "user_example",
            "email": "ada@example.com",
            "name": "Ada Lovelace"
          },
          "created_by_api_key": {
            "id": "atok_example",
            "label": "Orders backend",
            "token_type": "api"
          },
          "created_by_agent": {"name": "Orders backend"},
          "updated_by_api_key": {
            "id": "atok_example",
            "label": "Orders backend",
            "token_type": "api"
          },
          "updated_by_agent": {"name": "Orders backend"},
          "read": false,
          "read_at": null,
          "read_by": null,
          "read_by_api_key": null
        },
        "created_by": {
          "id": "user_example",
          "email": "ada@example.com",
          "name": "Ada Lovelace"
        },
        "created_by_api_key": {
          "id": "atok_example",
          "label": "Orders backend",
          "token_type": "api"
        },
        "created_by_agent": {"name": "Orders backend"},
        "updated_by_api_key": {
          "id": "atok_example",
          "label": "Orders backend",
          "token_type": "api"
        },
        "updated_by_agent": {"name": "Orders backend"},
        "created_at": "2026-10-11T12:20:00Z",
        "updated_at": "2026-10-11T12:20:00Z",
        "read": false,
        "read_at": null,
        "read_by": null,
        "read_by_api_key": null
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

Guide: [Files](https://revdoku.com/api.md#files)

## Save an uploaded file (step 3 of 3)

`POST /v1/mailboxes/{mailbox_id}/files`

Saves the uploaded blob at path. An existing path gets a new version.

| Language | Call |
| --- | --- |
| TypeScript | `client.uploadFile({ mailboxId, path, content })` (runs all three upload steps) |
| Python | `client.upload_file(mailbox_id, path, content)` (runs all three upload steps) |
| TypeScript, full API | `client.api.saveUploadedFile({ mailboxId, saveUploadedFileRequest })` |
| Python, full API | `client.api.save_uploaded_file(mailbox_id, save_uploaded_file_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |

**Request body**: TypeScript `saveUploadedFileRequest: SaveUploadedFileRequest`, Python `save_uploaded_file_request=SaveUploadedFileRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `path` | string | yes | Destination path. An existing path receives a new version. Paths under _email/ return EMAIL_PATH_READ_ONLY; other top-level folders that start with _ return RESERVED_PATH. |
| `signed_blob_id` / `signedBlobId` | string | yes | data.signed_id from POST /v1/direct_uploads. |
| `name` | string | no | Display name; defaults to the last path segment. |
| `role` | string: `source`, `reference`, `generated`, `agent_output`, `export`, `artifact` | no |  |
| `existing_file_policy` / `existingFilePolicy` | string: `replace`, `skip` | no |  |
| `expected_mailbox_version` / `expectedMailboxVersion` | string | no | Mailbox version_id from your last read. A different current version returns MAILBOX_VERSION_CONFLICT and saves nothing. |
| `account_id` / `accountId` | string | no |  |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
// uploadFile runs all three steps: prepare, PUT the bytes to storage, save.
const { data } = await client.uploadFile({
  mailboxId: 'bkt_example',
  path: 'notes/todo.txt',
  content: 'Call the customer back.',
  contentType: 'text/plain',
});
console.log(data.file.id, data.version.id);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
# upload_file runs all three steps: prepare, PUT the bytes to storage, save.
response = client.upload_file("bkt_example", "notes/todo.txt", "Call the customer back.", content_type="text/plain")
print(response.data.file.id, response.data.version.id)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/mailboxes/bkt_example/files" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
  "path": "notes/todo.txt",
  "signed_blob_id": "SIGNED_ID_FROM_STEP_1"
}'
```

**Response** `201`, `200`

| Field | Type | Description |
| --- | --- | --- |
| `file` | MailboxFile | Fields as in [Prepare a file upload (step 1 of 3)](#prepare-a-file-upload-step-1-of-3). |
| `version` | FileVersion |  |
| `version.id` | string |  |
| `version.file_id` / `fileId` | string |  |
| `version.name` | string |  |
| `version.mime_type` / `mimeType` | string |  |
| `version.sha256` | string |  |
| `version.reason` | string or null |  |
| `version.created_by_system` / `createdBySystem` | string |  |
| `version.deleted` | boolean | True for the version that records a deletion. |
| `version.ready` | boolean |  |
| `version.has_text` / `hasText` | boolean |  |
| `version.version_number` / `versionNumber` | integer (int64) |  |
| `version.byte_size` / `byteSize` | integer (int64) |  |
| `version.created_at` / `createdAt` | string (date-time) |  |
| `version.created_by` / `createdBy` | FileActor | Fields: `id`, `name`, `email`. |
| `version.updated_by` / `updatedBy` | FileActor | Fields: `id`, `name`, `email`. |
| `version.created_by_agent` / `createdByAgent` | object |  |
| `version.updated_by_agent` / `updatedByAgent` | object |  |
| `version.created_by_api_key` / `createdByApiKey` | object |  |
| `version.updated_by_api_key` / `updatedByApiKey` | object |  |
| `version.read` | boolean |  |
| `version.read_at` / `readAt` | string (date-time) or null |  |
| `version.read_by` / `readBy` | FileActor or null |  |
| `version.read_by_api_key` / `readByApiKey` | FileKey or null |  |
| `created` | boolean |  |
| `skipped` | FileUploadSkip |  |
| `skipped.path` | string |  |
| `skipped.name` | string |  |
| `skipped.reason` | string |  |
| `skipped.code` | string |  |
| `skipped.input_index` / `inputIndex` | integer |  |
| `skipped.details` | object |  |
| `duplicate` | boolean |  |

Example `201`:

```json
{
  "success": true,
  "data": {
    "file": {
      "id": "df_example",
      "mailbox_id": "bkt_example",
      "basename": "summary.txt",
      "path": "reports/summary.txt",
      "role": "source",
      "deleted": false,
      "version_reasons": [],
      "lock": {"locked": false},
      "current_file_version": {
        "id": "dfrev_example",
        "file_id": "df_example",
        "version_number": 0,
        "name": "summary.txt",
        "mime_type": "text/plain",
        "byte_size": 1234,
        "sha256": "0d6a3c2b8f5e41a7c9b2d4e6f8a1c3e5b7d9f1a3c5e7b9d1f3a5c7e9b1d3f5a7",
        "deleted": false,
        "ready": true,
        "has_text": false,
        "created_at": "2026-10-11T12:20:00Z",
        "created_by": {
          "id": "user_example",
          "email": "ada@example.com",
          "name": "Ada Lovelace"
        },
        "updated_by": {
          "id": "user_example",
          "email": "ada@example.com",
          "name": "Ada Lovelace"
        },
        "created_by_api_key": {
          "id": "atok_example",
          "label": "Orders backend",
          "token_type": "api"
        },
        "created_by_agent": {"name": "Orders backend"},
        "updated_by_api_key": {
          "id": "atok_example",
          "label": "Orders backend",
          "token_type": "api"
        },
        "updated_by_agent": {"name": "Orders backend"},
        "read": false,
        "read_at": null,
        "read_by": null,
        "read_by_api_key": null
      },
      "created_by": {
        "id": "user_example",
        "email": "ada@example.com",
        "name": "Ada Lovelace"
      },
      "created_by_api_key": {"id": "atok_example", "label": "Orders backend", "token_type": "api"},
      "created_by_agent": {"name": "Orders backend"},
      "updated_by_api_key": {"id": "atok_example", "label": "Orders backend", "token_type": "api"},
      "updated_by_agent": {"name": "Orders backend"},
      "created_at": "2026-10-11T12:20:00Z",
      "updated_at": "2026-10-11T12:20:00Z",
      "read": false,
      "read_at": null,
      "read_by": null,
      "read_by_api_key": null
    },
    "version": {
      "id": "dfrev_example",
      "file_id": "df_example",
      "version_number": 0,
      "name": "summary.txt",
      "mime_type": "text/plain",
      "byte_size": 1234,
      "sha256": "0d6a3c2b8f5e41a7c9b2d4e6f8a1c3e5b7d9f1a3c5e7b9d1f3a5c7e9b1d3f5a7",
      "deleted": false,
      "ready": true,
      "has_text": false,
      "created_at": "2026-10-11T12:20:00Z",
      "created_by": {
        "id": "user_example",
        "email": "ada@example.com",
        "name": "Ada Lovelace"
      },
      "updated_by": {
        "id": "user_example",
        "email": "ada@example.com",
        "name": "Ada Lovelace"
      },
      "created_by_api_key": {"id": "atok_example", "label": "Orders backend", "token_type": "api"},
      "created_by_agent": {"name": "Orders backend"},
      "updated_by_api_key": {"id": "atok_example", "label": "Orders backend", "token_type": "api"},
      "updated_by_agent": {"name": "Orders backend"},
      "read": false,
      "read_at": null,
      "read_by": null,
      "read_by_api_key": null
    },
    "created": true
  }
}
```

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Upload a file](https://revdoku.com/api.md#upload-a-file)

## Find a file by path

`GET /v1/mailboxes/{mailbox_id}/files/by_path`

Returns file metadata only. Read content with the download endpoint. The disposition and content_url parameters return INVALID_ARGUMENT.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.getFileByPath({ mailboxId, path })` |
| Python | `client.api.get_file_by_path(mailbox_id, path)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |
| `path` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.getFileByPath({
  mailboxId: 'bkt_example',
  path: 'notes/todo.txt',
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.get_file_by_path("bkt_example", path="notes/todo.txt")
print(response.data)
```

**cURL**

```sh
curl -G "https://api.revdoku.com/v1/mailboxes/bkt_example/files/by_path" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  --data-urlencode "path=notes/todo.txt"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `file` | MailboxFile | Fields as in [Prepare a file upload (step 1 of 3)](#prepare-a-file-upload-step-1-of-3). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Error codes named above: `INVALID_ARGUMENT`.

Guide: [Files](https://revdoku.com/api.md#files)

## Append text to a file

`POST /v1/mailboxes/{mailbox_id}/files/append_text`

Appends UTF-8 text to an existing text file and creates a new version. A missing file returns MAILBOX_FILE_NOT_FOUND.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.appendText({ mailboxId, appendTextRequest })` |
| Python | `client.api.append_text(mailbox_id, append_text_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |

**Request body**: TypeScript `appendTextRequest: AppendTextRequest`, Python `append_text_request=AppendTextRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `path` | string | yes |  |
| `content` | string | yes |  |
| `newline_before` / `newlineBefore` | boolean | no |  |
| `expected_mailbox_version` / `expectedMailboxVersion` | string | no | Mailbox version_id from your last read. |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.appendText({
  mailboxId: 'bkt_example',
  appendTextRequest: { path: 'notes/todo.txt', content: 'Call the customer back.' },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, AppendTextRequest

client = Revdoku()
response = client.api.append_text(
    "bkt_example",
    AppendTextRequest(
        path="notes/todo.txt",
        content="Call the customer back.",
    ),
)
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/mailboxes/bkt_example/files/append_text" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"path": "notes/todo.txt", "content": "Call the customer back."}'
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `file` | MailboxFile | Fields as in [Prepare a file upload (step 1 of 3)](#prepare-a-file-upload-step-1-of-3). |
| `version` | FileVersion | Fields as in [Save an uploaded file (step 3 of 3)](#save-an-uploaded-file-step-3-of-3). |
| `path` | string |  |
| `appended` | boolean `true` |  |
| `appended_bytes` / `appendedBytes` | integer |  |
| `newline_inserted` / `newlineInserted` | boolean |  |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Error codes named above: `MAILBOX_FILE_NOT_FOUND`.

Guide: [Files](https://revdoku.com/api.md#files)

## Read file metadata

`GET /v1/mailboxes/{mailbox_id}/files/{file_id}`

Reading metadata never marks the file read.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.getFile({ mailboxId, fileId })` |
| Python | `client.api.get_file(mailbox_id, file_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |
| `file_id` / `fileId` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.getFile({
  mailboxId: 'bkt_example',
  fileId: 'df_example',
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.get_file("bkt_example", "df_example")
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/mailboxes/bkt_example/files/df_example" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `file` | MailboxFile | Fields as in [Prepare a file upload (step 1 of 3)](#prepare-a-file-upload-step-1-of-3). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Files](https://revdoku.com/api.md#files)

## Delete a file

`DELETE /v1/mailboxes/{mailbox_id}/files/{file_id}`

Requires mailbox-admin permission.

Files under _email/ return EMAIL_PATH_READ_ONLY; delete the email instead. Other top-level folders that start with _ return RESERVED_PATH.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.deleteFile({ mailboxId, fileId })` |
| Python | `client.api.delete_file(mailbox_id, file_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |
| `file_id` / `fileId` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.deleteFile({
  mailboxId: 'bkt_example',
  fileId: 'df_example',
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.delete_file("bkt_example", "df_example")
print(response.data)
```

**cURL**

```sh
curl -X DELETE "https://api.revdoku.com/v1/mailboxes/bkt_example/files/df_example" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `deleted` | boolean `true` |  |
| `id` | string | ID of the deleted resource. A webhook delete returns the mailbox ID. |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Error codes named above: `EMAIL_PATH_READ_ONLY`, `RESERVED_PATH`.

Guide: [Files](https://revdoku.com/api.md#files)

## Get a download link for a file

`GET /v1/mailboxes/{mailbox_id}/files/{file_id}/download`

Returns a temporary link and marks this version read. Send version_id for an older version.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.getFileDownload({ mailboxId, fileId })` |
| Python | `client.api.get_file_download(mailbox_id, file_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |
| `file_id` / `fileId` | string | yes |  |
| `version_id` / `versionId` | string | no |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.getFileDownload({
  mailboxId: 'bkt_example',
  fileId: 'df_example',
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.get_file_download("bkt_example", "df_example")
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/mailboxes/bkt_example/files/df_example/download" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `download` | Download | Temporary download link. Fetch url without an API key. Request a new link after it expires. |
| `download.url` | string (uri) |  |
| `download.filename` | string |  |
| `download.content_type` / `contentType` | string or null |  |
| `download.expires_in` / `expiresIn` | integer `900` | Seconds until the link expires. |
| `download.size_bytes` / `sizeBytes` | integer (int64) |  |
| `version` | FileVersion | Fields as in [Save an uploaded file (step 3 of 3)](#save-an-uploaded-file-step-3-of-3). |
| `previously_read` / `previouslyRead` | boolean | Read state before this request, when tracking succeeded. |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Files](https://revdoku.com/api.md#files)

## Rename or move a file in the same mailbox

`POST /v1/mailboxes/{mailbox_id}/files/{file_id}/rename`

Changes the path without uploading the content again.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.renameFile({ mailboxId, fileId, renameFileRequest })` |
| Python | `client.api.rename_file(mailbox_id, file_id, rename_file_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |
| `file_id` / `fileId` | string | yes |  |

**Request body**: TypeScript `renameFileRequest: RenameFileRequest`, Python `rename_file_request=RenameFileRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `new_path` / `newPath` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.renameFile({
  mailboxId: 'bkt_example',
  fileId: 'df_example',
  renameFileRequest: { newPath: 'notes/done.txt' },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, RenameFileRequest

client = Revdoku()
response = client.api.rename_file(
    "bkt_example",
    "df_example",
    RenameFileRequest(new_path="notes/done.txt"),
)
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/mailboxes/bkt_example/files/df_example/rename" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"new_path": "notes/done.txt"}'
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `operation` | string: `rename`, `move`, `copy` |  |
| `skipped` | boolean | True when the file already had the requested path. |
| `old_path` / `oldPath` | string |  |
| `path` | string |  |
| `source_mailbox_id` / `sourceMailboxId` | string |  |
| `target_mailbox_id` / `targetMailboxId` | string |  |
| `source_file` / `sourceFile` | MailboxFile | Fields as in [Prepare a file upload (step 1 of 3)](#prepare-a-file-upload-step-1-of-3). |
| `file` | MailboxFile | Fields as in [Prepare a file upload (step 1 of 3)](#prepare-a-file-upload-step-1-of-3). |
| `version` | FileVersion | Fields as in [Save an uploaded file (step 3 of 3)](#save-an-uploaded-file-step-3-of-3). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Files](https://revdoku.com/api.md#files)

## Move a file

`POST /v1/mailboxes/{mailbox_id}/files/{file_id}/move`

Works in the same mailbox or into target_mailbox_id. Content is not uploaded again. Send target_path for an exact path or target_folder to keep the name.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.moveFile({ mailboxId, fileId, moveFileRequest })` |
| Python | `client.api.move_file(mailbox_id, file_id, move_file_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |
| `file_id` / `fileId` | string | yes |  |

**Request body**: TypeScript `moveFileRequest: MoveFileRequest`, Python `move_file_request=MoveFileRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `target_mailbox_id` / `targetMailboxId` | string | no |  |
| `target_path` / `targetPath` | string | no |  |
| `target_folder` / `targetFolder` | string | no |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.moveFile({
  mailboxId: 'bkt_example',
  fileId: 'df_example',
  moveFileRequest: { targetFolder: 'archive' },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, MoveFileRequest

client = Revdoku()
response = client.api.move_file(
    "bkt_example",
    "df_example",
    MoveFileRequest(target_folder="archive"),
)
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/mailboxes/bkt_example/files/df_example/move" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"target_folder": "archive"}'
```

**Response** `201`

| Field | Type | Description |
| --- | --- | --- |
| `operation` | string: `rename`, `move`, `copy` |  |
| `skipped` | boolean | True when the file already had the requested path. |
| `old_path` / `oldPath` | string |  |
| `path` | string |  |
| `source_mailbox_id` / `sourceMailboxId` | string |  |
| `target_mailbox_id` / `targetMailboxId` | string |  |
| `source_file` / `sourceFile` | MailboxFile | Fields as in [Prepare a file upload (step 1 of 3)](#prepare-a-file-upload-step-1-of-3). |
| `file` | MailboxFile | Fields as in [Prepare a file upload (step 1 of 3)](#prepare-a-file-upload-step-1-of-3). |
| `version` | FileVersion | Fields as in [Save an uploaded file (step 3 of 3)](#save-an-uploaded-file-step-3-of-3). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Files](https://revdoku.com/api.md#files)

## Copy a file

`POST /v1/mailboxes/{mailbox_id}/files/{file_id}/copy`

Works in the same mailbox or into target_mailbox_id. Content is not uploaded again. Send target_path for an exact path or target_folder to keep the name.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.copyFile({ mailboxId, fileId, moveFileRequest })` |
| Python | `client.api.copy_file(mailbox_id, file_id, move_file_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |
| `file_id` / `fileId` | string | yes |  |

**Request body**: TypeScript `moveFileRequest: MoveFileRequest`, Python `move_file_request=MoveFileRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `target_mailbox_id` / `targetMailboxId` | string | no |  |
| `target_path` / `targetPath` | string | no |  |
| `target_folder` / `targetFolder` | string | no |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.copyFile({
  mailboxId: 'bkt_example',
  fileId: 'df_example',
  moveFileRequest: { targetPath: 'notes/todo-copy.txt' },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, MoveFileRequest

client = Revdoku()
response = client.api.copy_file(
    "bkt_example",
    "df_example",
    MoveFileRequest(target_path="notes/todo-copy.txt"),
)
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/mailboxes/bkt_example/files/df_example/copy" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"target_path": "notes/todo-copy.txt"}'
```

**Response** `201`

| Field | Type | Description |
| --- | --- | --- |
| `operation` | string: `rename`, `move`, `copy` |  |
| `skipped` | boolean | True when the file already had the requested path. |
| `old_path` / `oldPath` | string |  |
| `path` | string |  |
| `source_mailbox_id` / `sourceMailboxId` | string |  |
| `target_mailbox_id` / `targetMailboxId` | string |  |
| `source_file` / `sourceFile` | MailboxFile | Fields as in [Prepare a file upload (step 1 of 3)](#prepare-a-file-upload-step-1-of-3). |
| `file` | MailboxFile | Fields as in [Prepare a file upload (step 1 of 3)](#prepare-a-file-upload-step-1-of-3). |
| `version` | FileVersion | Fields as in [Save an uploaded file (step 3 of 3)](#save-an-uploaded-file-step-3-of-3). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Files](https://revdoku.com/api.md#files)

## List file versions

`GET /v1/mailboxes/{mailbox_id}/files/{file_id}/versions`

Newest first.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.listFileVersions({ mailboxId, fileId })` |
| Python | `client.api.list_file_versions(mailbox_id, file_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |
| `file_id` / `fileId` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |
| `limit` | integer | no |  |
| `cursor` | string | no | pagination.next_cursor from the previous page. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.listFileVersions({
  mailboxId: 'bkt_example',
  fileId: 'df_example',
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.list_file_versions("bkt_example", "df_example")
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/mailboxes/bkt_example/files/df_example/versions" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `versions` | array of FileVersion | Fields as in [Save an uploaded file (step 3 of 3)](#save-an-uploaded-file-step-3-of-3). |
| `pagination` | Pagination | One page of a list. Request the next page with cursor=next_cursor and the same filters. Cursors are opaque strings: do not build or decode them. Fields as in [List files](#list-files). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Files](https://revdoku.com/api.md#files)

## Restore a file version

`POST /v1/mailboxes/{mailbox_id}/files/{file_id}/versions/{version_id}/restore`

Creates a new current version with the content of the selected version. History is kept. Requires a plan with version restore.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.restoreFileVersion({ mailboxId, fileId, versionId, actionRequest })` |
| Python | `client.api.restore_file_version(mailbox_id, file_id, version_id, action_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |
| `file_id` / `fileId` | string | yes |  |
| `version_id` / `versionId` | string | yes |  |

**Request body**: TypeScript `actionRequest: ActionRequest`, Python `action_request=ActionRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.restoreFileVersion({
  mailboxId: 'bkt_example',
  fileId: 'df_example',
  versionId: 'dfrev_example',
  actionRequest: {},
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, ActionRequest

client = Revdoku()
response = client.api.restore_file_version(
    "bkt_example",
    "df_example",
    "dfrev_example",
    ActionRequest(),
)
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/mailboxes/bkt_example/files/df_example/versions/dfrev_example/restore" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{}'
```

**Response** `201`

| Field | Type | Description |
| --- | --- | --- |
| `file` | MailboxFile | Fields as in [Prepare a file upload (step 1 of 3)](#prepare-a-file-upload-step-1-of-3). |
| `version` | FileVersion | Fields as in [Save an uploaded file (step 3 of 3)](#save-an-uploaded-file-step-3-of-3). |
| `restored_from` / `restoredFrom` | FileVersion | Fields as in [Save an uploaded file (step 3 of 3)](#save-an-uploaded-file-step-3-of-3). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Files](https://revdoku.com/api.md#files)

## Start a batch upload

`POST /v1/mailboxes/{mailbox_id}/upload_sessions`

Starts an upload session for many files and returns storage targets for the first files. The session locks the mailbox for other writers; incoming email still arrives. Send files in batches with POST .../uploads, PUT the bytes to each upload.url, save each batch with POST .../finalize_batch, then call POST .../finalize. Unsaved uploads are discarded when the session expires.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.createUploadSession({ mailboxId, createUploadSessionRequest })` |
| Python | `client.api.create_upload_session(mailbox_id, create_upload_session_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |

**Request body**: TypeScript `createUploadSessionRequest: CreateUploadSessionRequest`, Python `create_upload_session_request=CreateUploadSessionRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `files` | array of UploadSessionFile | no | Optional first batch. Send the rest with POST .../uploads. |
| `files[].path` | string | yes | Destination path in the mailbox. Paths under _email/ return EMAIL_PATH_READ_ONLY; other top-level folders that start with _ return RESERVED_PATH. |
| `files[].byte_size` / `byteSize` | integer (int64) | yes |  |
| `files[].content_type` / `contentType` | string | yes |  |
| `files[].checksum` | string | yes | Base64-encoded MD5 of the bytes. |
| `files[].sha256` | string | yes | Hex SHA-256 of the bytes. |
| `expected_file_count` / `expectedFileCount` | integer | no | Total files you will upload in this session. Used for progress. |
| `client_session_key` / `clientSessionKey` | string | no | Your own key for this batch. Repeating it with the same credential while the session is pending returns that session instead of a new one. |
| `existing_file_policy` / `existingFilePolicy` | string: `replace`, `skip` | no | skip keeps existing files at the same paths. |
| `expected_mailbox_version` / `expectedMailboxVersion` | string | no | Mailbox version_id from your last read. A different current version returns MAILBOX_VERSION_CONFLICT. |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { createHash } from 'node:crypto';
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const mailboxId = 'bkt_example';
const bytes = Buffer.from('Quarterly numbers');
// 1. Start the session with the first batch. Send more files later with client.api.addUploadSessionFiles.
const { data: started } = await client.api.createUploadSession({
  mailboxId,
  createUploadSessionRequest: {
    expectedFileCount: 1,
    files: [{
      path: 'reports/q3.txt',
      byteSize: bytes.length,
      contentType: 'text/plain',
      checksum: createHash('md5').update(bytes).digest('base64'),
      sha256: createHash('sha256').update(bytes).digest('hex'),
    }],
  },
});
const sessionId = started.mailboxUploadSession.id;
// 2. PUT the bytes to each storage target with exactly its headers. Send no API key.
for (const item of started.uploads ?? []) {
  const response = await fetch(item.upload.url, { method: 'PUT', headers: item.upload.headers, body: new Uint8Array(bytes) });
  if (!response.ok) throw new Error(`Storage upload failed: HTTP ${response.status}`);
}
// 3. Save the uploaded batch, then finish the session.
await client.api.saveUploadSessionBatch({ mailboxId, sessionId });
const { data: finished } = await client.api.finalizeUploadSession({
  mailboxId,
  sessionId,
  finalizeUploadSessionRequest: { complete: true },
});
console.log(finished.mailboxUploadSession.status);
```

**Python**

```python
import base64
import hashlib

import urllib3
from revdoku import CreateUploadSessionRequest, FinalizeUploadSessionRequest, Revdoku, UploadSessionFile

client = Revdoku()
mailbox_id = "bkt_example"
data = b"Quarterly numbers"
# 1. Start the session with the first batch. Send more files later with client.api.add_upload_session_files.
started = client.api.create_upload_session(mailbox_id, CreateUploadSessionRequest(
    expected_file_count=1,
    files=[UploadSessionFile(
        path="reports/q3.txt",
        byte_size=len(data),
        content_type="text/plain",
        checksum=base64.b64encode(hashlib.md5(data).digest()).decode(),
        sha256=hashlib.sha256(data).hexdigest(),
    )],
)).data
session_id = started.mailbox_upload_session.id
# 2. PUT the bytes to each storage target with exactly its headers. Send no API key.
for item in started.uploads or []:
    response = urllib3.request("PUT", item.upload.url, body=data, headers=item.upload.headers)
    if response.status >= 300:
        raise RuntimeError(f"Storage upload failed: HTTP {response.status}")
# 3. Save the uploaded batch, then finish the session.
client.api.save_upload_session_batch(mailbox_id, session_id)
finished = client.api.finalize_upload_session(mailbox_id, session_id, FinalizeUploadSessionRequest(complete=True))
print(finished.data.mailbox_upload_session.status)
```

**cURL**

```sh
# 1. Start the session. checksum is the base64 MD5 and sha256 the hex SHA-256 of each file.
curl -X POST "https://api.revdoku.com/v1/mailboxes/bkt_example/upload_sessions" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
  "expected_file_count": 1,
  "files": [{"path": "reports/q3.txt", "byte_size": 17, "content_type": "text/plain", "checksum": "BASE64_MD5", "sha256": "HEX_SHA256"}]
}'

# 2. PUT the bytes to each uploads[].upload.url with exactly uploads[].upload.headers. Send no API key.

# 3. Save the uploaded batch, then finish the session.
curl -X POST "https://api.revdoku.com/v1/mailboxes/bkt_example/upload_sessions/bus_example/finalize_batch" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
curl -X POST "https://api.revdoku.com/v1/mailboxes/bkt_example/upload_sessions/bus_example/finalize" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"complete": true}'
```

**Response** `201`

| Field | Type | Description |
| --- | --- | --- |
| `mailbox_upload_session` / `mailboxUploadSession` | UploadSession |  |
| `mailbox_upload_session.id` | string |  |
| `mailbox_upload_session.mailbox_id` / `mailboxId` | string |  |
| `mailbox_upload_session.status` | string: `pending`, `finalized`, `expired`, `failed` | pending accepts uploads. failed means canceled; its unsaved files were discarded. |
| `mailbox_upload_session.base_mailbox_version_id` / `baseMailboxVersionId` | string or null | Mailbox version when the session started. |
| `mailbox_upload_session.target_mailbox_version_id` / `targetMailboxVersionId` | string or null | Mailbox version created by the final save. |
| `mailbox_upload_session.uploads_expire_at` / `uploadsExpireAt` | string (date-time) or null | Unsaved uploads are discarded after this time. |
| `mailbox_upload_session.session_closed_at` / `sessionClosedAt` | string (date-time) or null |  |
| `mailbox_upload_session.files_count` / `filesCount` | integer |  |
| `mailbox_upload_session.pending_files_count` / `pendingFilesCount` | integer |  |
| `mailbox_upload_session.uploaded_files_count` / `uploadedFilesCount` | integer |  |
| `mailbox_upload_session.finalized_files_count` / `finalizedFilesCount` | integer |  |
| `mailbox_upload_session.skipped_files_count` / `skippedFilesCount` | integer |  |
| `mailbox_upload_session.skipped_code_counts` / `skippedCodeCounts` | object | Skipped files per skip code. |
| `mailbox_upload_session.failed_files_count` / `failedFilesCount` | integer |  |
| `uploads` | array of UploadSessionUpload | Create and uploads only: storage targets for the files that need bytes. |
| `uploads[].input_index` / `inputIndex` | integer |  |
| `uploads[].path` | string |  |
| `uploads[].name` | string |  |
| `uploads[].signed_blob_id` / `signedBlobId` | string |  |
| `uploads[].upload` | StorageUpload | Fields: `url`, `headers`. |
| `uploaded` | array of UploadedFile | Files saved by this request (at most 250). |
| `uploaded[].input_index` / `inputIndex` | integer |  |
| `uploaded[].path` | string |  |
| `uploaded[].file` | MailboxFile | Fields: see `MailboxFile` in [OpenAPI](https://revdoku.com/openapi.json). |
| `uploaded[].version` | FileVersion | Fields: see `FileVersion` in [OpenAPI](https://revdoku.com/openapi.json). |
| `uploaded[].created` | boolean | False when the path received a new version. |
| `uploaded_count` / `uploadedCount` | integer |  |
| `uploaded_truncated` / `uploadedTruncated` | boolean |  |
| `created_count` / `createdCount` | integer |  |
| `updated_count` / `updatedCount` | integer |  |
| `skipped` | array of FileUploadSkip | Files left unchanged, for example identical content (DUPLICATE_FILE_VERSION). Fields as in [Save an uploaded file (step 3 of 3)](#save-an-uploaded-file-step-3-of-3). |
| `skipped_count` / `skippedCount` | integer |  |
| `skipped_truncated` / `skippedTruncated` | boolean |  |
| `finalize_pending` / `finalizePending` | boolean | Finalize only: true when more files remain. Call finalize again after Retry-After. |
| `remaining_files_count` / `remainingFilesCount` | integer |  |
| `message` | string |  |

```json
{
  "success": true,
  "data": {
    "mailbox_upload_session": {
      "id": "bus_example",
      "mailbox_id": "bkt_example",
      "status": "pending",
      "base_mailbox_version_id": "bktrv_example",
      "target_mailbox_version_id": null,
      "uploads_expire_at": "2026-10-11T14:00:00Z",
      "session_closed_at": null,
      "files_count": 2,
      "pending_files_count": 2,
      "uploaded_files_count": 0,
      "finalized_files_count": 0,
      "skipped_files_count": 0,
      "skipped_code_counts": {},
      "failed_files_count": 0
    },
    "uploads": [
      {
        "input_index": 0,
        "path": "reports/q3.pdf",
        "name": "q3.pdf",
        "signed_blob_id": "eyJfcmFpbHMi...",
        "upload": {
          "url": "https://storage.example/upload",
          "headers": {
            "Content-Type": "application/pdf",
            "Content-MD5": "rL0Y20zC+Fzt72VPzMSk2A=="
          }
        }
      }
    ],
    "uploaded": [],
    "uploaded_count": 0,
    "uploaded_truncated": false,
    "created_count": 0,
    "updated_count": 0,
    "skipped": [],
    "skipped_count": 0,
    "skipped_truncated": false
  }
}
```

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Upload many files](https://revdoku.com/api.md#upload-many-files)

## Get storage targets for a batch

`POST /v1/mailboxes/{mailbox_id}/upload_sessions/{session_id}/uploads`

Returns upload.url and upload.headers for each file that needs bytes. Repeating a path returns a fresh target, for example after a failed PUT. Files with identical content are skipped.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.addUploadSessionFiles({ mailboxId, sessionId, addUploadSessionFilesRequest })` |
| Python | `client.api.add_upload_session_files(mailbox_id, session_id, add_upload_session_files_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |
| `session_id` / `sessionId` | string | yes | mailbox_upload_session.id from the create response. |

**Request body**: TypeScript `addUploadSessionFilesRequest: AddUploadSessionFilesRequest`, Python `add_upload_session_files_request=AddUploadSessionFilesRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `files` | array of UploadSessionFile | yes |  |
| `files[].path` | string | yes | Destination path in the mailbox. Paths under _email/ return EMAIL_PATH_READ_ONLY; other top-level folders that start with _ return RESERVED_PATH. |
| `files[].byte_size` / `byteSize` | integer (int64) | yes |  |
| `files[].content_type` / `contentType` | string | yes |  |
| `files[].checksum` | string | yes | Base64-encoded MD5 of the bytes. |
| `files[].sha256` | string | yes | Hex SHA-256 of the bytes. |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.addUploadSessionFiles({
  mailboxId: 'bkt_example',
  sessionId: 'bus_example',
  addUploadSessionFilesRequest: {
    files: [
      {
        path: 'notes/todo.txt',
        byteSize: 23,
        contentType: 'text/plain',
        checksum: 'BASE64_MD5_OF_CONTENT',
        sha256: 'HEX_SHA256_OF_CONTENT',
      },
    ],
  },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, AddUploadSessionFilesRequest, UploadSessionFile

client = Revdoku()
response = client.api.add_upload_session_files(
    "bkt_example",
    "bus_example",
    AddUploadSessionFilesRequest(
        files=[
            UploadSessionFile(
                path="notes/todo.txt",
                byte_size=23,
                content_type="text/plain",
                checksum="BASE64_MD5_OF_CONTENT",
                sha256="HEX_SHA256_OF_CONTENT",
            ),
        ],
    ),
)
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/mailboxes/bkt_example/upload_sessions/bus_example/uploads" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
  "files": [
    {
      "path": "notes/todo.txt",
      "byte_size": 23,
      "content_type": "text/plain",
      "checksum": "BASE64_MD5_OF_CONTENT",
      "sha256": "HEX_SHA256_OF_CONTENT"
    }
  ]
}'
```

**Response** `201`

| Field | Type | Description |
| --- | --- | --- |
| `mailbox_upload_session` / `mailboxUploadSession` | UploadSession | Fields as in [Start a batch upload](#start-a-batch-upload). |
| `uploads` | array of UploadSessionUpload | Create and uploads only: storage targets for the files that need bytes. Fields as in [Start a batch upload](#start-a-batch-upload). |
| `uploaded` | array of UploadedFile | Files saved by this request (at most 250). Fields as in [Start a batch upload](#start-a-batch-upload). |
| `uploaded_count` / `uploadedCount` | integer |  |
| `uploaded_truncated` / `uploadedTruncated` | boolean |  |
| `created_count` / `createdCount` | integer |  |
| `updated_count` / `updatedCount` | integer |  |
| `skipped` | array of FileUploadSkip | Files left unchanged, for example identical content (DUPLICATE_FILE_VERSION). Fields as in [Save an uploaded file (step 3 of 3)](#save-an-uploaded-file-step-3-of-3). |
| `skipped_count` / `skippedCount` | integer |  |
| `skipped_truncated` / `skippedTruncated` | boolean |  |
| `finalize_pending` / `finalizePending` | boolean | Finalize only: true when more files remain. Call finalize again after Retry-After. |
| `remaining_files_count` / `remainingFilesCount` | integer |  |
| `message` | string |  |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Upload many files](https://revdoku.com/api.md#upload-many-files)

## Save uploaded files

`POST /v1/mailboxes/{mailbox_id}/upload_sessions/{session_id}/finalize_batch`

Saves up to limit files whose bytes were uploaded. Call it after each batch to keep each request short. DIRECT_UPLOAD_NOT_FOUND names a file whose bytes are missing in error.details.path; upload it again and retry.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.saveUploadSessionBatch({ mailboxId, sessionId })` |
| Python | `client.api.save_upload_session_batch(mailbox_id, session_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |
| `session_id` / `sessionId` | string | yes | mailbox_upload_session.id from the create response. |

**Request body** (optional): TypeScript `saveUploadSessionBatchRequest: SaveUploadSessionBatchRequest`, Python `save_upload_session_batch_request=SaveUploadSessionBatchRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `limit` | integer | no | Files to save in this request. |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.saveUploadSessionBatch({
  mailboxId: 'bkt_example',
  sessionId: 'bus_example',
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.save_upload_session_batch("bkt_example", "bus_example")
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/mailboxes/bkt_example/upload_sessions/bus_example/finalize_batch" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `mailbox_upload_session` / `mailboxUploadSession` | UploadSession | Fields as in [Start a batch upload](#start-a-batch-upload). |
| `uploads` | array of UploadSessionUpload | Create and uploads only: storage targets for the files that need bytes. Fields as in [Start a batch upload](#start-a-batch-upload). |
| `uploaded` | array of UploadedFile | Files saved by this request (at most 250). Fields as in [Start a batch upload](#start-a-batch-upload). |
| `uploaded_count` / `uploadedCount` | integer |  |
| `uploaded_truncated` / `uploadedTruncated` | boolean |  |
| `created_count` / `createdCount` | integer |  |
| `updated_count` / `updatedCount` | integer |  |
| `skipped` | array of FileUploadSkip | Files left unchanged, for example identical content (DUPLICATE_FILE_VERSION). Fields as in [Save an uploaded file (step 3 of 3)](#save-an-uploaded-file-step-3-of-3). |
| `skipped_count` / `skippedCount` | integer |  |
| `skipped_truncated` / `skippedTruncated` | boolean |  |
| `finalize_pending` / `finalizePending` | boolean | Finalize only: true when more files remain. Call finalize again after Retry-After. |
| `remaining_files_count` / `remainingFilesCount` | integer |  |
| `message` | string |  |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Error codes named above: `DIRECT_UPLOAD_NOT_FOUND`.

Guide: [Upload many files](https://revdoku.com/api.md#upload-many-files)

## Finish or cancel a batch upload

`POST /v1/mailboxes/{mailbox_id}/upload_sessions/{session_id}/finalize`

complete=true saves the remaining uploaded files, creates one mailbox version and releases the lock. A 202 response with finalize_pending=true means more files remain: call finalize again after Retry-After. complete=false cancels the session and discards its unsaved files. Finalizing a finished session returns it unchanged.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.finalizeUploadSession({ mailboxId, sessionId })` |
| Python | `client.api.finalize_upload_session(mailbox_id, session_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |
| `session_id` / `sessionId` | string | yes | mailbox_upload_session.id from the create response. |

**Request body** (optional): TypeScript `finalizeUploadSessionRequest: FinalizeUploadSessionRequest`, Python `finalize_upload_session_request=FinalizeUploadSessionRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `complete` | boolean | no | false cancels the session. |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.finalizeUploadSession({
  mailboxId: 'bkt_example',
  sessionId: 'bus_example',
  finalizeUploadSessionRequest: { complete: true },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, FinalizeUploadSessionRequest

client = Revdoku()
response = client.api.finalize_upload_session(
    "bkt_example",
    "bus_example",
    FinalizeUploadSessionRequest(complete=True),
)
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/mailboxes/bkt_example/upload_sessions/bus_example/finalize" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"complete": true}'
```

**Response** `200`, `202`

| Field | Type | Description |
| --- | --- | --- |
| `mailbox_upload_session` / `mailboxUploadSession` | UploadSession | Fields as in [Start a batch upload](#start-a-batch-upload). |
| `uploads` | array of UploadSessionUpload | Create and uploads only: storage targets for the files that need bytes. Fields as in [Start a batch upload](#start-a-batch-upload). |
| `uploaded` | array of UploadedFile | Files saved by this request (at most 250). Fields as in [Start a batch upload](#start-a-batch-upload). |
| `uploaded_count` / `uploadedCount` | integer |  |
| `uploaded_truncated` / `uploadedTruncated` | boolean |  |
| `created_count` / `createdCount` | integer |  |
| `updated_count` / `updatedCount` | integer |  |
| `skipped` | array of FileUploadSkip | Files left unchanged, for example identical content (DUPLICATE_FILE_VERSION). Fields as in [Save an uploaded file (step 3 of 3)](#save-an-uploaded-file-step-3-of-3). |
| `skipped_count` / `skippedCount` | integer |  |
| `skipped_truncated` / `skippedTruncated` | boolean |  |
| `finalize_pending` / `finalizePending` | boolean | Finalize only: true when more files remain. Call finalize again after Retry-After. |
| `remaining_files_count` / `remainingFilesCount` | integer |  |
| `message` | string |  |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Upload many files](https://revdoku.com/api.md#upload-many-files)
