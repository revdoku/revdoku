import { readFile, stat } from 'node:fs/promises';
import { basename } from 'node:path';
import { createHash } from 'node:crypto';

const apiKey = process.env.REVDOKU_API_KEY;
if (!apiKey) throw new Error('Set REVDOKU_API_KEY in your local .env file.');
const accountId = process.env.REVDOKU_ACCOUNT_ID;
const headers = { Authorization: `Bearer ${apiKey}`, 'Content-Type': 'application/json' };
const mailboxId = process.env.REVDOKU_BUCKET_ID;
if (!mailboxId || !/^bkt_[A-Za-z0-9]+$/.test(mailboxId)) throw new Error('Set REVDOKU_BUCKET_ID.');

const local = process.argv[2];
if (!local) throw new Error('Usage: upload-file.js LOCAL_FILE [MAILBOX_PATH]');
const path = process.argv[3] ?? basename(local);
if (path.startsWith('/') || path.split('/').some(p => p === '..' || !p) || path.includes('\\')) throw new Error('Use a relative file path.');
const info = await stat(local);
if (!info.isFile() || info.size > 64 * 1024 * 1024) throw new Error('Choose a file of at most 64 MiB.');
const bytes = await readFile(local);
const descriptor = await fetch('https://api.revdoku.com/v1/direct_uploads', {
  method: 'POST', headers, redirect: 'error', signal: AbortSignal.timeout(30000),
  body: JSON.stringify({ account_id: accountId, mailbox_id: mailboxId, path,
    blob: { filename: basename(path), byte_size: bytes.length, content_type: 'application/octet-stream',
      purpose: 'mailbox_file', checksum: createHash('md5').update(bytes).digest('base64'),
      sha256: createHash('sha256').update(bytes).digest('hex') } }),
});
const result = await descriptor.json();
if (!descriptor.ok) throw new Error(`${result.error.code}: ${result.error.message}`);
const upload = result.data.direct_upload;
const uploadUrl = new URL(upload.url);
if (uploadUrl.protocol !== 'https:' || uploadUrl.username || uploadUrl.password) throw new Error('Invalid upload URL.');
// Only the returned storage headers go to storage, never the Revdoku API key.
const put = await fetch(uploadUrl, { method: 'PUT', headers: upload.headers, body: bytes,
  redirect: 'error', signal: AbortSignal.timeout(60000) })
  .catch(() => { throw new Error('Storage upload failed.'); });
if (!put.ok) throw new Error(`Upload HTTP ${put.status}`);
const attach = await fetch(`https://api.revdoku.com/v1/mailboxes/${mailboxId}/files`, {
  method: 'POST', headers, redirect: 'error', signal: AbortSignal.timeout(30000),
  body: JSON.stringify({ account_id: accountId, path, signed_blob_id: result.data.signed_id }),
});
const attached = await attach.json();
if (!attach.ok) throw new Error(`${attached.error.code}: ${attached.error.message}`);
// Check the existing file if a write response is lost before repeating it.
const fileUrl = new URL(`https://api.revdoku.com/v1/mailboxes/${mailboxId}/files/by_path`);
fileUrl.searchParams.set('path', path);
fileUrl.searchParams.set('content_url', '1');
if (accountId) fileUrl.searchParams.set('account_id', accountId);
const readback = await fetch(fileUrl, { headers, redirect: 'error', signal: AbortSignal.timeout(30000) });
const file = await readback.json();
if (!readback.ok) throw new Error(`${file.error.code}: ${file.error.message}`);
const downloadUrl = new URL(file.data.url);
if (downloadUrl.protocol !== 'https:') throw new Error('Invalid download URL.');
const downloaded = await fetch(downloadUrl, { redirect: 'error', signal: AbortSignal.timeout(30000) })
  .catch(() => { throw new Error('Readback download failed.'); });
if (!downloaded.ok || !bytes.equals(Buffer.from(await downloaded.arrayBuffer()))) throw new Error('Readback failed or differed from uploaded bytes.');
console.log(`Uploaded and verified ${bytes.length} bytes at ${path}`);
