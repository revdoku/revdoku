# API reference

Requests go to `https://api.revdoku.com`. Every path starts with `/v1`, for example `https://api.revdoku.com/v1/buckets`. Send `Authorization: Bearer $REVDOKU_API_KEY` from your server; never put the key in a browser or a chat.
Responses use `{"success": true, "data": ...}`. Errors use `{"success": false, "error": {"code": ..., "message": ...}}`; branch on `error.code`.
The SDKs keep this envelope: TypeScript fields are camelCase, Python fields use the JSON names.

[OpenAPI](https://revdoku.com/openapi.json) · [Quickstart](https://revdoku.com/docs/quickstart.md) · [TypeScript SDK](https://revdoku.com/docs/sdks/typescript.md) · [Python SDK](https://revdoku.com/docs/sdks/python.md) · [API guide](https://revdoku.com/api.md)

## [Authentication](https://revdoku.com/api/reference/authentication.md)

Sign-in helpers for the CLI and AI agents. Backend applications use an API key from the dashboard.

Operations that need no API key run before you have one. They use the generated `DefaultApi` class instead of `Revdoku`, so their errors are `ResponseError` (TypeScript) or `ApiException` (Python), not `RevdokuError`.

| Operation | HTTP | TypeScript | Python |
| --- | --- | --- | --- |
| [Email a sign-in code](https://revdoku.com/api/reference/authentication.md#email-a-sign-in-code) | `POST /v1/auth/sign_in_code` | `new DefaultApi().requestSignInCode` | `DefaultApi().request_sign_in_code` |
| [Exchange a sign-in code for an API key](https://revdoku.com/api/reference/authentication.md#exchange-a-sign-in-code-for-an-api-key) | `POST /v1/auth/sign_in_code/verify` | `new DefaultApi().verifySignInCode` | `DefaultApi().verify_sign_in_code` |
| [Exchange a one-time dashboard connection code for an API key](https://revdoku.com/api/reference/authentication.md#exchange-a-one-time-dashboard-connection-code-for-an-api-key) | `POST /v1/auth/grant/exchange` | `new DefaultApi().exchangeConnectionGrant` | `DefaultApi().exchange_connection_grant` |
| [Create a dashboard link](https://revdoku.com/api/reference/authentication.md#create-a-dashboard-link) | `POST /v1/auth/dashboard_link` | `client.api.createDashboardLink` | `client.api.create_dashboard_link` |

## [Accounts](https://revdoku.com/api/reference/accounts.md)

Connection status, granted accounts and limits.

| Operation | HTTP | TypeScript | Python |
| --- | --- | --- | --- |
| [Read the connection and selected account](https://revdoku.com/api/reference/accounts.md#read-the-connection-and-selected-account) | `GET /v1/status` | `client.api.getStatus` | `client.api.get_status` |
| [List accounts granted to this credential](https://revdoku.com/api/reference/accounts.md#list-accounts-granted-to-this-credential) | `GET /v1/accounts` | `client.api.listAccounts` | `client.api.list_accounts` |
| [Create a client account](https://revdoku.com/api/reference/accounts.md#create-a-client-account) | `POST /v1/accounts` | `client.api.createClientAccount` | `client.api.create_client_account` |
| [Read one granted account](https://revdoku.com/api/reference/accounts.md#read-one-granted-account) | `GET /v1/accounts/{account_id}` | `client.api.getAccount` | `client.api.get_account` |
| [Read effective account limits](https://revdoku.com/api/reference/accounts.md#read-effective-account-limits) | `GET /v1/account/limits` | `client.api.getAccountLimits` | `client.api.get_account_limits` |

## [Buckets](https://revdoku.com/api/reference/buckets.md)

Create, read, archive and delete buckets.

| Operation | HTTP | TypeScript | Python |
| --- | --- | --- | --- |
| [List buckets](https://revdoku.com/api/reference/buckets.md#list-buckets) | `GET /v1/buckets` | `client.listBuckets` | `client.list_buckets` |
| [Create a bucket](https://revdoku.com/api/reference/buckets.md#create-a-bucket) | `POST /v1/buckets` | `client.createBucket` | `client.create_bucket` |
| [Read a bucket](https://revdoku.com/api/reference/buckets.md#read-a-bucket) | `GET /v1/buckets/{bucket_id}` | `client.getBucket` | `client.get_bucket` |
| [Update a bucket title, description or metadata](https://revdoku.com/api/reference/buckets.md#update-a-bucket-title-description-or-metadata) | `PATCH /v1/buckets/{bucket_id}` | `client.api.updateBucket` | `client.api.update_bucket` |
| [Permanently delete an archived bucket](https://revdoku.com/api/reference/buckets.md#permanently-delete-an-archived-bucket) | `DELETE /v1/buckets/{bucket_id}` | `client.api.deleteBucket` | `client.api.delete_bucket` |
| [Archive a bucket](https://revdoku.com/api/reference/buckets.md#archive-a-bucket) | `POST /v1/buckets/{bucket_id}/archive` | `client.api.archiveBucket` | `client.api.archive_bucket` |
| [Unarchive a bucket](https://revdoku.com/api/reference/buckets.md#unarchive-a-bucket) | `POST /v1/buckets/{bucket_id}/unarchive` | `client.api.unarchiveBucket` | `client.api.unarchive_bucket` |
| [Lock a bucket or some of its files](https://revdoku.com/api/reference/buckets.md#lock-a-bucket-or-some-of-its-files) | `POST /v1/buckets/{bucket_id}/lock` | `client.api.lockBucket` | `client.api.lock_bucket` |
| [Remove your lock](https://revdoku.com/api/reference/buckets.md#remove-your-lock) | `POST /v1/buckets/{bucket_id}/unlock` | `client.api.unlockBucket` | `client.api.unlock_bucket` |

## [Tickets](https://revdoku.com/api/reference/tickets.md)

Support tickets: each conversation that someone started with the bucket, by email, a message left on the docs site or page feedback. Read them, reply to the requester, solve and label them.

| Operation | HTTP | TypeScript | Python |
| --- | --- | --- | --- |
| [List tickets](https://revdoku.com/api/reference/tickets.md#list-tickets) | `GET /v1/buckets/{bucket_id}/tickets` | `client.listTickets` | `client.list_tickets` |
| [Read a ticket](https://revdoku.com/api/reference/tickets.md#read-a-ticket) | `GET /v1/buckets/{bucket_id}/tickets/{ticket_id}` | `client.getTicket` | `client.get_ticket` |
| [Solve, reopen or label a ticket](https://revdoku.com/api/reference/tickets.md#solve-reopen-or-label-a-ticket) | `PATCH /v1/buckets/{bucket_id}/tickets/{ticket_id}` | `client.api.updateTicket` | `client.api.update_ticket` |
| [List the messages of a ticket](https://revdoku.com/api/reference/tickets.md#list-the-messages-of-a-ticket) | `GET /v1/buckets/{bucket_id}/tickets/{ticket_id}/messages` | `client.listTicketMessages` | `client.list_ticket_messages` |
| [Reply to the requester](https://revdoku.com/api/reference/tickets.md#reply-to-the-requester) | `POST /v1/buckets/{bucket_id}/tickets/{ticket_id}/messages` | `client.replyToTicket` | `client.reply_to_ticket` |
| [Read a message](https://revdoku.com/api/reference/tickets.md#read-a-message) | `GET /v1/buckets/{bucket_id}/tickets/{ticket_id}/messages/{message_id}` | `client.getTicketMessage` | `client.get_ticket_message` |
| [Delete a message](https://revdoku.com/api/reference/tickets.md#delete-a-message) | `DELETE /v1/buckets/{bucket_id}/tickets/{ticket_id}/messages/{message_id}` | `client.api.deleteTicketMessage` | `client.api.delete_ticket_message` |
| [Get a download link for the original email](https://revdoku.com/api/reference/tickets.md#get-a-download-link-for-the-original-email) | `GET /v1/buckets/{bucket_id}/tickets/{ticket_id}/messages/{message_id}/raw` | `client.api.getTicketMessageOriginalDownload` | `client.api.get_ticket_message_original_download` |
| [Get a download link for an attachment](https://revdoku.com/api/reference/tickets.md#get-a-download-link-for-an-attachment) | `GET /v1/buckets/{bucket_id}/tickets/{ticket_id}/messages/{message_id}/attachments/{attachment_id}` | `client.getAttachmentDownload` | `client.get_attachment_download` |

## [Events](https://revdoku.com/api/reference/events.md)

Ticket events of every channel: one signed webhook per bucket and live WebSocket subscriptions.

| Operation | HTTP | TypeScript | Python |
| --- | --- | --- | --- |
| [Read the webhook](https://revdoku.com/api/reference/events.md#read-the-webhook) | `GET /v1/buckets/{bucket_id}/webhook` | `client.api.getWebhook` | `client.api.get_webhook` |
| [Set the webhook](https://revdoku.com/api/reference/events.md#set-the-webhook) | `PUT /v1/buckets/{bucket_id}/webhook` | `client.api.setWebhook` | `client.api.set_webhook` |
| [Remove the webhook](https://revdoku.com/api/reference/events.md#remove-the-webhook) | `DELETE /v1/buckets/{bucket_id}/webhook` | `client.api.deleteWebhook` | `client.api.delete_webhook` |
| [Get a live event subscription ticket](https://revdoku.com/api/reference/events.md#get-a-live-event-subscription-ticket) | `GET /v1/buckets/{bucket_id}/events/subscription` | `client.api.getEventSubscription` | `client.api.get_event_subscription` |

## [Files](https://revdoku.com/api/reference/files.md)

Upload, read, organize and restore files.

| Operation | HTTP | TypeScript | Python |
| --- | --- | --- | --- |
| [List files](https://revdoku.com/api/reference/files.md#list-files) | `GET /v1/buckets/{bucket_id}/files` | `client.listFiles` | `client.list_files` |
| [Save an uploaded file (step 3 of 3)](https://revdoku.com/api/reference/files.md#save-an-uploaded-file-step-3-of-3) | `POST /v1/buckets/{bucket_id}/files` | `client.uploadFile` | `client.upload_file` |
| [Find a file by path](https://revdoku.com/api/reference/files.md#find-a-file-by-path) | `GET /v1/buckets/{bucket_id}/files/by_path` | `client.api.getFileByPath` | `client.api.get_file_by_path` |
| [Append text to a file](https://revdoku.com/api/reference/files.md#append-text-to-a-file) | `POST /v1/buckets/{bucket_id}/files/append_text` | `client.api.appendText` | `client.api.append_text` |
| [Read file metadata](https://revdoku.com/api/reference/files.md#read-file-metadata) | `GET /v1/buckets/{bucket_id}/files/{file_id}` | `client.api.getFile` | `client.api.get_file` |
| [Delete a file](https://revdoku.com/api/reference/files.md#delete-a-file) | `DELETE /v1/buckets/{bucket_id}/files/{file_id}` | `client.api.deleteFile` | `client.api.delete_file` |
| [Get a download link for a file](https://revdoku.com/api/reference/files.md#get-a-download-link-for-a-file) | `GET /v1/buckets/{bucket_id}/files/{file_id}/download` | `client.api.getFileDownload` | `client.api.get_file_download` |
| [Rename or move a file in the same bucket](https://revdoku.com/api/reference/files.md#rename-or-move-a-file-in-the-same-bucket) | `POST /v1/buckets/{bucket_id}/files/{file_id}/rename` | `client.api.renameFile` | `client.api.rename_file` |
| [Move a file](https://revdoku.com/api/reference/files.md#move-a-file) | `POST /v1/buckets/{bucket_id}/files/{file_id}/move` | `client.api.moveFile` | `client.api.move_file` |
| [Copy a file](https://revdoku.com/api/reference/files.md#copy-a-file) | `POST /v1/buckets/{bucket_id}/files/{file_id}/copy` | `client.api.copyFile` | `client.api.copy_file` |
| [List file versions](https://revdoku.com/api/reference/files.md#list-file-versions) | `GET /v1/buckets/{bucket_id}/files/{file_id}/versions` | `client.api.listFileVersions` | `client.api.list_file_versions` |
| [Restore a file version](https://revdoku.com/api/reference/files.md#restore-a-file-version) | `POST /v1/buckets/{bucket_id}/files/{file_id}/versions/{version_id}/restore` | `client.api.restoreFileVersion` | `client.api.restore_file_version` |
| [Prepare a file upload (step 1 of 3)](https://revdoku.com/api/reference/files.md#prepare-a-file-upload-step-1-of-3) | `POST /v1/buckets/{bucket_id}/uploads` | `client.uploadFile` | `client.upload_file` |
| [Start a batch upload](https://revdoku.com/api/reference/files.md#start-a-batch-upload) | `POST /v1/buckets/{bucket_id}/upload_sessions` | `client.api.createUploadSession` | `client.api.create_upload_session` |
| [Get storage targets for a batch](https://revdoku.com/api/reference/files.md#get-storage-targets-for-a-batch) | `POST /v1/buckets/{bucket_id}/upload_sessions/{session_id}/uploads` | `client.api.addUploadSessionFiles` | `client.api.add_upload_session_files` |
| [Save uploaded files](https://revdoku.com/api/reference/files.md#save-uploaded-files) | `POST /v1/buckets/{bucket_id}/upload_sessions/{session_id}/finalize_batch` | `client.api.saveUploadSessionBatch` | `client.api.save_upload_session_batch` |
| [Finish or cancel a batch upload](https://revdoku.com/api/reference/files.md#finish-or-cancel-a-batch-upload) | `POST /v1/buckets/{bucket_id}/upload_sessions/{session_id}/finalize` | `client.api.finalizeUploadSession` | `client.api.finalize_upload_session` |

## [Publications](https://revdoku.com/api/reference/publications.md)

A bucket's site: publish its files, preview them for 24 hours, or take the site down.

| Operation | HTTP | TypeScript | Python |
| --- | --- | --- | --- |
| [Get the site](https://revdoku.com/api/reference/publications.md#get-the-site) | `GET /v1/buckets/{bucket_id}/publication` | `client.api.getPublication` | `client.api.get_publication` |
| [Publish the site](https://revdoku.com/api/reference/publications.md#publish-the-site) | `POST /v1/buckets/{bucket_id}/publication` | `client.api.publishBucket` | `client.api.publish_bucket` |
| [Unpublish the site](https://revdoku.com/api/reference/publications.md#unpublish-the-site) | `DELETE /v1/buckets/{bucket_id}/publication` | `client.api.unpublishBucket` | `client.api.unpublish_bucket` |
| [Get the preview](https://revdoku.com/api/reference/publications.md#get-the-preview) | `GET /v1/buckets/{bucket_id}/publication/preview` | `client.api.getPublicationPreview` | `client.api.get_publication_preview` |
| [Preview the site](https://revdoku.com/api/reference/publications.md#preview-the-site) | `POST /v1/buckets/{bucket_id}/publication/preview` | `client.api.previewBucket` | `client.api.preview_bucket` |

## [GitHub](https://revdoku.com/api/reference/github.md)

Connect a GitHub repository to a bucket: its files become a copy of one branch, and each push updates them.

| Operation | HTTP | TypeScript | Python |
| --- | --- | --- | --- |
| [List connected GitHub accounts](https://revdoku.com/api/reference/github.md#list-connected-github-accounts) | `GET /v1/account/github/installations` | `client.api.listGithubInstallations` | `client.api.list_github_installations` |
| [List the repositories of a GitHub account](https://revdoku.com/api/reference/github.md#list-the-repositories-of-a-github-account) | `GET /v1/account/github/installations/{installation_id}/repositories` | `client.api.listGithubRepositories` | `client.api.list_github_repositories` |
| [Read the GitHub repository of a bucket](https://revdoku.com/api/reference/github.md#read-the-github-repository-of-a-bucket) | `GET /v1/buckets/{bucket_id}/github` | `client.api.getGithubSync` | `client.api.get_github_sync` |
| [Connect a GitHub repository](https://revdoku.com/api/reference/github.md#connect-a-github-repository) | `POST /v1/buckets/{bucket_id}/github` | `client.api.connectGithubRepository` | `client.api.connect_github_repository` |
| [Change GitHub sync settings](https://revdoku.com/api/reference/github.md#change-github-sync-settings) | `PATCH /v1/buckets/{bucket_id}/github` | `client.api.updateGithubSync` | `client.api.update_github_sync` |
| [Disconnect the GitHub repository](https://revdoku.com/api/reference/github.md#disconnect-the-github-repository) | `DELETE /v1/buckets/{bucket_id}/github` | `client.api.disconnectGithubRepository` | `client.api.disconnect_github_repository` |
| [Sync the GitHub repository now](https://revdoku.com/api/reference/github.md#sync-the-github-repository-now) | `POST /v1/buckets/{bucket_id}/github/sync` | `client.api.syncGithubRepository` | `client.api.sync_github_repository` |
| [Get the links to add a GitHub account](https://revdoku.com/api/reference/github.md#get-the-links-to-add-a-github-account) | `GET /v1/buckets/{bucket_id}/github/setup_link` | `client.api.getGithubSetupLink` | `client.api.get_github_setup_link` |
