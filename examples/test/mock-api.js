// Imported only by offline subprocess tests. Every unknown request fails closed.
import assert from 'node:assert/strict';
import { readFileSync, writeFileSync } from 'node:fs';

let upload;
let emailListAttempts = 0;
const folder = '_email/inbox/sender/example/delivery/';
const mail = { subject: 'Fixture message', from: 'sender@example.test', body_text: 'Fixture body',
  body_status: 'complete', received_at: '2026-09-29T00:00:00Z',
  attachments: [{ id: 'df_note', filename: 'note.txt', size_bytes: 5 }] };
const ok = data => Response.json({ success: true, data });

globalThis.fetch = async (input, options = {}) => {
  const url = new URL(input);
  const headers = new Headers(options.headers);
  const body = options.body && typeof options.body === 'string' ? JSON.parse(options.body) : null;
  if (url.origin === 'https://api.revdoku.com') {
    assert.equal(headers.get('Authorization'), 'Bearer offline-fixture-key');
    assert.equal(options.redirect, 'error');
    if (url.pathname === '/v1/accounts/acct_fixture') return ok({ account: { id: 'acct_fixture' } });
    if ((options.method ?? 'GET') === 'GET') assert.equal(url.searchParams.get('account_id'), 'acct_fixture');
    else assert.equal(body.account_id, 'acct_fixture');
    if (process.env.FIXTURE_CUSTOMERS && (url.pathname === '/v1/buckets' || /^\/v1\/buckets\/bkt_\d+$/.test(url.pathname))) {
      let buckets = [];
      try { buckets = JSON.parse(readFileSync('.fixture-buckets.json', 'utf8')); }
      catch (error) { if (error.code !== 'ENOENT') throw error; }
      if (options.method === 'POST') {
        assert.equal(body.idempotency_key, undefined);
        const bucket = { id: `bkt_${buckets.length + 1}`, title: body.bucket.title,
          email: { address: `fixture${buckets.length + 1}@revdokumail.com`, receiving_enabled: true } };
        buckets.push(bucket);
        writeFileSync('.fixture-buckets.json', JSON.stringify(buckets));
        if (process.env.FIXTURE_CREATE === 'lost') throw new TypeError('Connection dropped after commit');
        if (process.env.FIXTURE_CREATE === 'not_ready') return Response.json({ error: { code: 'EMAIL_NOT_READY', details: { bucket_id: bucket.id } } }, { status: 503 });
        return ok({ bucket });
      }
      if (url.pathname === '/v1/buckets') return ok({ buckets: buckets.filter(bucket => bucket.title === url.searchParams.get('q')) });
      const bucket = buckets.find(bucket => bucket.id === url.pathname.split('/').at(-1));
      assert.ok(bucket);
      if (process.env.FIXTURE_CREATE === 'not_ready') bucket.email = { ...bucket.email, receiving_enabled: false, blocked_reason: 'routing_pending' };
      return ok({ bucket });
    }
    if (url.pathname === '/v1/buckets') {
      assert.equal(body.idempotency_key, undefined);
      return ok({ bucket: { id: 'bkt_fixture', title: body.bucket.title, email: { address: 'fixture@revdokumail.com', receiving_enabled: true, sending_enabled: false }, dashboard_url: 'https://app.revdoku.com/buckets/bkt_fixture' } });
    }
    if (url.pathname.endsWith('/email/subscription')) return ok({ subscription: {
      token: 'offline-ticket', websocket_url: 'wss://app.revdoku.com/cable', channel: 'EmailReceivedChannel',
      account_id: 'acct_fixture', bucket_id: 'bkt_fixture'
    } });
    if (url.pathname.endsWith('/emails')) {
      emailListAttempts++;
      if (process.env.FIXTURE_INDEX_BUILDING === 'always') {
        assert.ok(emailListAttempts <= 4, 'Read retries must be bounded');
      }
      if (process.env.FIXTURE_INDEX_BUILDING === 'always' ||
          (process.env.FIXTURE_INDEX_BUILDING === 'twice' && emailListAttempts <= 2)) {
        return Response.json({ error: { code: 'EMAIL_INDEX_BUILDING', message: 'Email index is being prepared' } }, { status: 503 });
      }
      const cursor = url.searchParams.get('cursor');
      if (process.env.FIXTURE_WATCH_RECOVERY && cursor === 'next') {
        try {
          writeFileSync('.fixture-page-failed', '', { flag: 'wx' });
          return Response.json({ error: { code: 'UNAVAILABLE', message: 'Later page failed once' } }, { status: 503 });
        } catch (error) { if (error.code !== 'EEXIST') throw error; }
      }
      return ok({ emails: cursor === 'end' ? [] : [{ id: cursor ? 'eml_second' : 'eml_first' }],
        pagination: { has_more: !cursor, next_cursor: cursor ? 'end' : 'next' } });
    }
    if (url.pathname.endsWith('/attachments/df_note')) return ok({ download: { url: 'https://storage.example/file?path=attachments/note.txt', filename: 'note.txt', authentication: 'none' } });
    if (url.pathname.includes('/emails/eml_')) {
      if (process.env.FIXTURE_EMAIL_DELAY) await new Promise(resolve => setTimeout(resolve, 250));
      return ok({ email: { id: url.pathname.split('/').at(-1), ...mail } });
    }
    if (url.pathname.endsWith('/files/by_path')) {
      assert.equal(url.searchParams.get('content_url'), '1', 'A file download descriptor needs content_url=1');
      return ok({ url: `https://storage.example/file?path=${encodeURIComponent(url.searchParams.get('path'))}` });
    }
    if (url.pathname.endsWith('/files') && options.method === 'POST') {
      assert.equal(body.signed_blob_id, 'fixture-signed-id'); assert.equal(body.path, 'project/notes.txt'); return ok({ file: { id: 'file_uploaded' } });
    }
    if (url.pathname.endsWith('/files')) {
      const offset = Number(url.searchParams.get('offset'));
      assert.equal(url.searchParams.get('q'), '_email/');
      return ok({ files: [{ id: `file_${offset}`, path: `${folder}${offset ? 'second/' : ''}message.json` }],
        pagination: { has_more: offset === 0, next_offset: offset === 0 ? 1 : null } });
    }
    if (url.pathname === '/v1/direct_uploads') {
      assert.equal(body.blob.purpose, 'bucket_file'); assert.equal(body.bucket_id, 'bkt_fixture');
      return ok({ signed_id: 'fixture-signed-id', direct_upload: { url: 'https://storage.example/upload', headers: { 'Content-Type': body.blob.content_type } } });
    }
    if (url.pathname === '/v1/account/limits') {
      if (process.env.FIXTURE_QUOTA) return Response.json({ error: { code: 'BUCKET_CREATION_LIMIT_REACHED', message: 'Monthly creation limit reached', details: { resets_at: '2026-10-01T00:00:00Z' } } }, { status: 429 });
      return ok({ account_id: 'acct_fixture', limits: { max_buckets: 25, api_rate_limit_requests_per_minute: 120 } });
    }
  } else if (url.origin === 'https://storage.example') {
    assert.equal(headers.get('Authorization'), null); assert.equal(headers.get('Cookie'), null);
    if (url.pathname === '/upload' && options.method === 'PUT') { upload = Buffer.from(options.body); return new Response(null); }
    const path = url.searchParams.get('path');
    if (path.endsWith('/message.json')) return Response.json(mail);
    if (path.endsWith('attachments/note.txt')) return new Response('hello');
    if (path === 'project/notes.txt' && upload) return new Response(upload);
  }
  throw new Error(`Unexpected offline request: ${url.origin}${url.pathname}`);
};

// Test-only transport; published examples use the native WebSocket unchanged.
if (process.env.FIXTURE_SOCKET_END) {
  globalThis.WebSocket = class extends EventTarget {
    constructor(url) {
      super();
      assert.equal(new URL(url).searchParams.get('email_subscription_token'), 'offline-ticket');
      setTimeout(() => this.dispatchEvent(new Event('open')), 0);
    }
    send() {
      this.dispatchEvent(new MessageEvent('message', { data: JSON.stringify({ type: process.env.FIXTURE_SOCKET_END, reconnect: false }) }));
    }
    close() { this.dispatchEvent(new Event('close')); }
  };
}

if (process.env.FIXTURE_WATCH_RECOVERY) {
  globalThis.WebSocket = class extends EventTarget {
    timer;
    closed = false;
    constructor(url) {
      super();
      assert.equal(new URL(url).searchParams.get('email_subscription_token'), 'offline-ticket');
      setTimeout(() => this.dispatchEvent(new Event('open')), 0);
    }
    send() {
      this.dispatchEvent(new MessageEvent('message', { data: JSON.stringify({ type: 'confirm_subscription' }) }));
      this.timer = setInterval(() => {
        let cursor;
        try { cursor = JSON.parse(readFileSync('.revdoku-examples/acct_fixture-bkt_fixture.json', 'utf8')).cursor; }
        catch (error) { if (error.code !== 'ENOENT') throw error; }
        if (cursor === 'end') {
          this.dispatchEvent(new MessageEvent('message', { data: JSON.stringify({ type: 'disconnect', reconnect: false }) }));
        }
      }, 20);
    }
    close() {
      if (this.closed) return;
      this.closed = true;
      clearInterval(this.timer);
      this.dispatchEvent(new Event('close'));
    }
  };
}
