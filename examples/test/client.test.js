import test from 'node:test';
import assert from 'node:assert/strict';
import { mkdtemp, readFile, rm } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { ApiError, attachmentPath, createClient, retryDelay, saveAttachment } from '../javascript/client.js';

const ok = data => Response.json({ data });
const client = (fetch, extra = {}) => createClient({ apiKey: 'test-only-secret', accountId: '', fetch, sleep: async () => {}, ...extra });

test('selects authorized accounts in every query or write body', async () => {
  const calls = [];
  const api = client(async (url, options) => { calls.push([url, options]); return ok({}); }, { accountId: 'acct_client' });
  await api.api('/api/v1/status');
  await api.api('/api/v1/buckets', { method: 'POST', body: { bucket: { title: 'Inbox' } } });
  assert.equal(calls[0][0].searchParams.get('account_id'), 'acct_client');
  assert.deepEqual(JSON.parse(calls[1][1].body), { account_id: 'acct_client', bucket: { title: 'Inbox' } });
  assert.equal(calls[0][1].redirect, 'error');
});

test('retries temporary throttling and honors Retry-After', async () => {
  let calls = 0; const waits = [];
  const api = client(async () => ++calls === 1
    ? Response.json({ error: { code: 'RATE_LIMIT_EXCEEDED' } }, { status: 429, headers: { 'Retry-After': '2' } }) : ok({ done: true }),
  { sleep: async ms => waits.push(ms) });
  assert.deepEqual(await api.api('/api/v1/status'), { done: true });
  assert.deepEqual(waits, [2000]);
  assert.equal(retryDelay('Thu, 01 Jan 1970 00:00:03 GMT', 0, 1000), 2000);
});

test('monthly quotas stop immediately and retain structured reset information', async () => {
  let calls = 0;
  const api = client(async () => { calls++; return Response.json({ error: { code: 'BUCKET_CREATION_LIMIT_REACHED', message: 'Limit reached', details: { resets_at: '2026-10-01T00:00:00Z' } } }, { status: 429 }); });
  await assert.rejects(api.api('/api/v1/buckets', { method: 'POST', retrySafe: true, body: {} }), error => {
    assert.ok(error instanceof ApiError); assert.equal(error.details.resets_at, '2026-10-01T00:00:00Z'); return true;
  });
  assert.equal(calls, 1);
});

test('never automatically retries an uncertain non-idempotent write', async () => {
  let calls = 0;
  const api = client(async () => { calls++; throw new Error('network failure'); });
  await assert.rejects(api.api('/api/v1/direct_uploads', { method: 'POST', body: {} }), /Check the result/);
  assert.equal(calls, 1);
});

test('caps retries and refuses a wait beyond the request deadline', async () => {
  let calls = 0;
  const api = client(async () => { calls++; return Response.json({}, { status: 503 }); });
  await assert.rejects(api.api('/api/v1/status'), ApiError); assert.equal(calls, 4);
  calls = 0;
  const slow = client(async () => { calls++; return Response.json({}, { status: 429, headers: { 'Retry-After': '86400' } }); });
  await assert.rejects(slow.api('/api/v1/status'), ApiError); assert.equal(calls, 1);
});

test('pagination advances and includes every page', async () => {
  const offsets = [];
  const api = client(async url => { const offset = Number(url.searchParams.get('offset')); offsets.push(offset); return ok({ files: [{ id: `file${offset}` }], pagination: { has_more: offset === 0, next_offset: offset === 0 ? 1 : null } }); });
  assert.equal((await api.listFiles('bkt_example')).length, 2); assert.deepEqual(offsets, [0, 1]);
  const stuck = client(async () => ok({ files: [], pagination: { has_more: true, next_offset: 0 } }));
  await assert.rejects(stuck.listFiles('bkt_example'), /did not advance/);
});

test('signed downloads omit API credentials across redirects and enforce a byte limit', async () => {
  const requests = [];
  const api = client(async (url, options) => {
    requests.push([url, options]);
    if (url.origin === 'https://app.revdoku.com') return ok({ url: 'https://storage.example/first' });
    if (url.pathname === '/first') return new Response(null, { status: 302, headers: { Location: 'https://storage2.example/file' } });
    return new Response('hello');
  });
  assert.equal((await api.readFile('bkt_example', 'notes.txt')).toString(), 'hello');
  for (const [, options] of requests.slice(1)) assert.equal(new Headers(options.headers).get('Authorization'), null);
  await assert.rejects(api.readFile('bkt_example', 'notes.txt', 2), /size limit/);
});

test('uploads use checksums, isolated storage headers, and an explicit file attachment', async () => {
  const calls = [];
  const api = client(async (url, opts) => {
    calls.push([url, opts]);
    if (url.pathname === '/api/v1/direct_uploads') return ok({ signed_id: 'signed-test', direct_upload: { url: 'https://storage.example/blob', headers: { 'Content-Type': 'text/plain' } } });
    return url.origin === 'https://storage.example' ? new Response(null, { status: 200 }) : ok({ file: {} });
  });
  await api.uploadFile('bkt_example', 'notes.txt', Buffer.from('hello'), 'text/plain');
  const blob = JSON.parse(calls[0][1].body).blob;
  assert.equal(blob.checksum, 'XUFAKrxLKna5cZ2REBfFkg==');
  assert.equal(blob.sha256, '2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824');
  assert.equal(new Headers(calls[1][1].headers).get('Authorization'), null);
  assert.deepEqual(JSON.parse(calls[2][1].body), { path: 'notes.txt', signed_blob_id: 'signed-test' });
});

test('rejects unsafe storage URLs and credential-bearing storage headers', async () => {
  const api = client(async () => ok({ url: 'http://storage.example/file' }));
  await assert.rejects(api.readFile('bkt_example', 'notes.txt'), /HTTPS/);
  const upload = client(async () => ok({ signed_id: 'x', direct_upload: { url: 'https://storage.example/file', headers: { Authorization: 'must-not-send' } } }));
  await assert.rejects(upload.uploadFile('bkt_example', 'notes.txt', Buffer.from('x')), /Credentials/);
});

test('keeps attachment downloads in their selected folder and never overwrites', async () => {
  const folder = await mkdtemp(join(tmpdir(), 'revdoku-attachment-'));
  try {
    assert.equal(attachmentPath('_email/inbox/demo/message.json', 'attachments/a.txt'), '_email/inbox/demo/attachments/a.txt');
    for (const path of ['../secret', 'attachments/../../secret', '/etc/passwd', 'attachments\\secret']) assert.throws(() => attachmentPath('_email/inbox/demo/message.json', path));
    const target = await saveAttachment(folder, 0, 'attachments/a.txt', Buffer.from('original'));
    await assert.rejects(saveAttachment(folder, 0, 'attachments/a.txt', Buffer.from('overwrite')), { code: 'EEXIST' });
    assert.equal(await readFile(target, 'utf8'), 'original');
  } finally { await rm(folder, { recursive: true, force: true }); }
});
