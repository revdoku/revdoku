# Bulk file uploads

Use `https://api.revdoku.com/v1` with your bearer API key. For one file, see
[Upload a file](https://revdoku.com/api.md#upload-a-file).

Use the CLI for a local folder: `revdoku upload ./folder --mailbox-id ID`.
To implement folder uploads yourself:

1. Open an upload session with the expected file count.
2. Request upload URLs for a small batch of files.
3. Upload each file, then finalize that batch.
4. Repeat until all files are uploaded.
5. Complete the session.

| Option or event | Behavior |
| --- | --- |
| `delete_missing: true` | Full-folder sync: remove omitted destination files only when the entire session completes. Omit for ordinary uploads. |
| Connection interrupted | Already finalized files remain saved. |
| Session expires | Unfinished uploads are abandoned and the write lock is released. |
| `complete: false` | Cancel remaining work and release the lock. |

```http
POST /v1/mailboxes/bkt_.../upload_sessions
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "expected_file_count": 123
}
```

Then request descriptors for one subbatch:

```http
POST /v1/mailboxes/bkt_.../upload_sessions/bus_.../uploads
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "files": [
    {
      "path": "index.html",
      "name": "index.html",
      "byte_size": 1234,
      "checksum": "BASE64_MD5",
      "content_type": "text/html",
      "sha256": "HEX_SHA256"
    }
  ]
}
```

Use `data.uploads[].upload.url` and `data.uploads[].upload.headers` for the
object-storage `PUT`. Do not send Revdoku authorization headers to object
storage. After each successful descriptor subbatch, commit a bounded batch:

```http
POST /v1/mailboxes/bkt_.../upload_sessions/bus_.../finalize_batch
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "limit": 12
}
```

Repeat descriptor and finalize subbatches until all selected files are uploaded.

Close the session when all uploads are done. Use `complete:false` only when
canceling or interrupting the upload; it closes the session and releases the
lock without committing any unfinalized staged uploads.

```http
POST /v1/mailboxes/bkt_.../upload_sessions/bus_.../finalize
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "complete": true
}
```

For large sessions, finalization can take several requests.

| Finalize result | Meaning |
| --- | --- |
| HTTP `202` | More files remain to be finalized. |
| `data.finalize_pending` | `true` while work remains. |
| `data.remaining_files_count` | Files still waiting for finalization. |
| `Retry-After` header | Delay before calling the same finalize endpoint again. |

Repeat finalization until the pending flag is no longer true.
