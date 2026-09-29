// Imported only by offline subprocess tests. Every unknown request fails closed.
import assert from 'node:assert/strict';

let readinessChecks = 0;
let upload;
const folder = '_email/inbox/sender/example/delivery/';
const mail = { subject: 'Fixture message', from: 'sender@example.test', body_text: 'Fixture body',
  body_status: 'complete', received_at: '2026-09-29T00:00:00Z',
  attachments: [{ path: 'attachments/note.txt', original_filename: '../untrusted.txt', size_bytes: 5 }] };
const ok = data => Response.json({ data });

globalThis.fetch = async (input, options = {}) => {
  const url = new URL(input);
  const headers = new Headers(options.headers);
  const body = options.body && typeof options.body === 'string' ? JSON.parse(options.body) : null;
  if (url.origin === 'https://app.revdoku.com') {
    assert.equal(headers.get('Authorization'), 'Bearer offline-fixture-key');
    assert.equal(options.redirect, 'error');
    if ((options.method ?? 'GET') === 'GET') assert.equal(url.searchParams.get('account_id'), 'acct_fixture');
    else assert.equal(body.account_id, 'acct_fixture');
    if (url.pathname === '/api/v1/buckets') {
      assert.equal(body.bucket.metadata._revdoku_client_create_key, 'fixture-create-v1');
      return ok({ bucket: { id: 'bkt_fixture', title: body.bucket.title, dashboard_url: 'https://app.revdoku.com/buckets/bkt_fixture' } });
    }
    if (url.pathname.endsWith('/inbound_email')) return ok({ address: 'fixture@revdokumail.com',
      ready: ++readinessChecks > (process.env.FIXTURE_PENDING ? 1 : 0), blocked_reason: 'routing_pending', received_count: 2 });
    if (url.pathname.endsWith('/files/by_path')) return ok({ url: `https://storage.example/file?path=${encodeURIComponent(url.searchParams.get('path'))}` });
    if (url.pathname.endsWith('/files') && options.method === 'POST') {
      assert.equal(body.signed_blob_id, 'fixture-signed-id'); assert.equal(body.path, 'project/notes.txt'); return ok({ file: { id: 'file_uploaded' } });
    }
    if (url.pathname.endsWith('/files')) {
      const offset = Number(url.searchParams.get('offset'));
      assert.equal(url.searchParams.get('q'), '_email/');
      return ok({ files: [{ id: `file_${offset}`, path: `${folder}${offset ? 'second/' : ''}message.json` }],
        pagination: { has_more: offset === 0, next_offset: offset === 0 ? 1 : null } });
    }
    if (url.pathname === '/api/v1/direct_uploads') {
      assert.equal(body.blob.purpose, 'bucket_file'); assert.equal(body.bucket_id, 'bkt_fixture');
      return ok({ signed_id: 'fixture-signed-id', direct_upload: { url: 'https://storage.example/upload', headers: { 'Content-Type': body.blob.content_type } } });
    }
    if (url.pathname === '/api/v1/account/profile') {
      if (process.env.FIXTURE_QUOTA) return Response.json({ error: { code: 'BUCKET_CREATION_LIMIT_REACHED', message: 'Monthly creation limit reached', details: { resets_at: '2026-10-01T00:00:00Z' } } }, { status: 429 });
      return ok({ profile: { current_account: { plan_contract: { plan: { name: 'Fixture' }, limits: { max_buckets: 25, api_rate_limit_requests_per_minute: 120 }, bucket_creation_usage: { used: 1, remaining: 74, monthly_limit: 75, resets_at: '2026-10-01T00:00:00Z' } } } } });
    }
  } else if (url.origin === 'https://storage.example') {
    assert.equal(headers.get('Authorization'), null); assert.equal(headers.get('Cookie'), null);
    if (url.pathname === '/upload' && options.method === 'PUT') { upload = Buffer.from(options.body); return new Response(null); }
    const path = url.searchParams.get('path');
    if (path.endsWith('/message.json')) return Response.json(mail);
    if (path.endsWith('/attachments/note.txt')) return new Response('hello');
    if (path === 'project/notes.txt' && upload) return new Response(upload);
  }
  throw new Error(`Unexpected offline request: ${url.origin}${url.pathname}`);
};
