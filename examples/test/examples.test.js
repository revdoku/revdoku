import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import { mkdtemp, readFile, rm, writeFile } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { fileURLToPath } from 'node:url';

const example = name => fileURLToPath(new URL(`../javascript/${name}.js`, import.meta.url));
const fixture = fileURLToPath(new URL('./mock-api.js', import.meta.url));
function run(cwd, name, args = [], env = {}) {
  return spawnSync(process.execPath, ['--import', fixture, example(name), ...args], { cwd, encoding: 'utf8', timeout: 12000,
    env: { ...process.env, REVDOKU_API_KEY: 'offline-fixture-key', REVDOKU_BUCKET_ID: 'bkt_fixture',
      REVDOKU_ACCOUNT_ID: 'acct_fixture', ...env } });
}
function success(result) { assert.equal(result.status, 0, result.stderr); assert.doesNotMatch(result.stdout + result.stderr, /offline-fixture-key/); return result.stdout; }

test('all five command-line examples run offline, with pagination and persisted checkpoints', async () => {
  const cwd = await mkdtemp(join(tmpdir(), 'revdoku-examples-'));
  try {
    assert.match(success(run(cwd, 'create-inbox', ['Example'], {})), /Receiving ready: fixture@revdokumail.com/);
    const first = success(run(cwd, 'read-mail', ['--show-body']));
    assert.match(first, /New messages read: 2/); assert.match(first, /Fixture body/);
    assert.match(success(run(cwd, 'read-mail')), /New messages read: 0/);
    assert.match(success(run(cwd, 'download-attachments', ['eml_first', 'df_note'])), /Saved 5 bytes/);
    assert.equal(await readFile(join(cwd, 'downloads/attachment-note.txt'), 'utf8'), 'hello');
    await writeFile(join(cwd, 'notes.txt'), 'fixture upload');
    assert.match(success(run(cwd, 'upload-file', ['notes.txt', 'project/notes.txt'])), /Uploaded and verified 14 bytes/);
    assert.match(success(run(cwd, 'quotas-and-retries')), /"max_buckets": 25/);
    const quota = run(cwd, 'quotas-and-retries', [], { FIXTURE_QUOTA: '1' });
    assert.equal(quota.status, 1); assert.match(quota.stderr, /Allowance resets at 2026-10-01/);
  } finally { await rm(cwd, { recursive: true, force: true }); }
});

test('cold email indexes recover with bounded read retries and leave checkpoints unchanged on failure', async () => {
  const cwd = await mkdtemp(join(tmpdir(), 'revdoku-index-retry-'));
  try {
    const unavailable = run(cwd, 'read-mail', [], { FIXTURE_INDEX_BUILDING: 'always' });
    assert.equal(unavailable.status, 1, unavailable.stderr);
    assert.match(unavailable.stderr, /EMAIL_INDEX_BUILDING/);
    assert.match(success(run(cwd, 'read-mail', [], { FIXTURE_INDEX_BUILDING: 'twice' })), /New messages read: 2/);
  } finally { await rm(cwd, { recursive: true, force: true }); }
});

test('published webhook receiver rejects forged/stale requests and deduplicates real signatures', { timeout: 15000 }, async () => {
  const { spawn } = await import('node:child_process');
  const { createHmac } = await import('node:crypto');
  const { once } = await import('node:events');
  const cwd = await mkdtemp(join(tmpdir(), 'revdoku-hook-'));
  const secret = 'offline-signing-secret';
  const child = spawn(process.execPath, ['--import', fixture, example('webhook-receiver')], {
    cwd, env: { ...process.env, PORT: '0', FIXTURE_EMAIL_DELAY: '1', REVDOKU_WEBHOOK_SECRET: secret, REVDOKU_API_KEY: 'offline-fixture-key', REVDOKU_BUCKET_ID: 'bkt_fixture', REVDOKU_ACCOUNT_ID: 'acct_fixture' }
  });
  let stdout = '', stderr = '';
  child.stdout.on('data', bytes => { stdout += bytes; });
  child.stderr.on('data', bytes => { stderr += bytes; });
  try {
    for (let attempt = 0; !stdout.includes('Listening on') && attempt < 100; attempt++) await new Promise(resolve => setTimeout(resolve, 20));
    const url = stdout.match(/http:\/\/127\.0\.0\.1:\d+\/webhook/)?.[0];
    assert.ok(url, stderr);
    const body = JSON.stringify({ id: 'email.received:eml_first', type: 'email.received', data: { email_id: 'eml_first', bucket_id: 'bkt_fixture', account_id: 'acct_fixture' } });
    const timestamp = String(Math.floor(Date.now() / 1000));
    const headers = { 'Content-Type': 'application/json', 'X-Revdoku-Event-Id': 'email.received:eml_first', 'X-Revdoku-Timestamp': timestamp,
      'X-Revdoku-Signature': 'v1=' + createHmac('sha256', secret).update(timestamp + '.' + body).digest('hex') };
    assert.equal((await fetch(url, { method: 'POST', headers, body: body + ' ' })).status, 401);
    assert.equal((await fetch(url, { method: 'POST', headers: { ...headers, 'X-Revdoku-Timestamp': '1000000000' }, body })).status, 401);
    const concurrent = await Promise.all([1, 2].map(() => fetch(url, { method: 'POST', headers, body })));
    assert.deepEqual(concurrent.map(response => response.status).sort(), [204, 503]);
    assert.equal((await fetch(url, { method: 'POST', headers, body })).status, 204);
    assert.equal(stdout.match(/Fixture message/g)?.length, 1);
    assert.doesNotMatch(stdout + stderr, /offline-signing-secret|offline-fixture-key/);
  } finally {
    const closed = once(child, 'exit'); child.kill('SIGTERM'); await closed;
    await rm(cwd, { recursive: true, force: true });
  }
});

test('live example stops when the server refuses a subscription or disallows reconnect', async () => {
  const cwd = await mkdtemp(join(tmpdir(), 'revdoku-watch-'));
  try {
    for (const type of ['disconnect', 'reject_subscription']) {
      const result = run(cwd, 'watch-mail', [], { FIXTURE_SOCKET_END: type });
      success(result);
      assert.match(result.stderr, /Subscription ended/);
    }
  } finally { await rm(cwd, { recursive: true, force: true }); }
});

test('live catch-up emits checkpointed messages even when a later page fails', async () => {
  const cwd = await mkdtemp(join(tmpdir(), 'revdoku-watch-recovery-'));
  try {
    const result = run(cwd, 'watch-mail', [], {
      FIXTURE_WATCH_RECOVERY: '1',
      NODE_OPTIONS: [process.env.NODE_OPTIONS, '--import', JSON.stringify(fixture)].filter(Boolean).join(' ')
    });
    const output = success(result);
    const messages = output.trim().split('\n').filter(line => line.startsWith('{')).map(line => JSON.parse(line).id);
    assert.deepEqual(messages, ['eml_first', 'eml_second']);
    assert.match(result.stderr, /Catch-up failed/);
    assert.equal(JSON.parse(await readFile(join(cwd, '.revdoku-examples/acct_fixture-bkt_fixture.json'))).cursor, 'end');
  } finally { await rm(cwd, { recursive: true, force: true }); }
});


test('customer mapping and processing survive restarts without cross-customer or repeated work', async () => {
  const cwd = await mkdtemp(join(tmpdir(), 'revdoku-customers-'));
  const env = { FIXTURE_CUSTOMERS: '1' };
  try {
    const alice = JSON.parse(success(run(cwd, 'provision-customer-inbox', ['alice'], env)));
    const same = JSON.parse(success(run(cwd, 'provision-customer-inbox', ['alice'], env)));
    const bob = JSON.parse(success(run(cwd, 'provision-customer-inbox', ['bob'], env)));
    assert.equal(alice.bucket_id, same.bucket_id);
    assert.notEqual(alice.bucket_id, bob.bucket_id);
    assert.equal(JSON.parse(await readFile(join(cwd, '.fixture-buckets.json'))).length, 2);
    assert.match(success(run(cwd, 'process-customer-mail', [], env)), /processed: 4/);
    assert.match(success(run(cwd, 'process-customer-mail', [], env)), /processed: 0/);
    const path = join(cwd, '.revdoku-examples/messages-acct_fixture.json');
    const state = JSON.parse(await readFile(path, 'utf8'));
    assert.deepEqual(Object.values(state.messages).map(item => item.customer_id).sort(), ['alice', 'alice', 'bob', 'bob']);
    state.cursors = {}; // Replay discovery after a lost checkpoint or duplicate event.
    await writeFile(path, JSON.stringify(state));
    assert.match(success(run(cwd, 'process-customer-mail', [], env)), /processed: 0/);
    await writeFile(path + '.lock', '');
    assert.equal(run(cwd, 'process-customer-mail', [], env).status, 1, 'A second process must not overwrite the journal');
  } finally { await rm(cwd, { recursive: true, force: true }); }
});

test('uncertain creation and saved-but-unready receiving recover using reads only', async () => {
  for (const failure of ['lost', 'not_ready']) {
    const cwd = await mkdtemp(join(tmpdir(), 'revdoku-provision-recovery-'));
    try {
      const result = run(cwd, 'provision-customer-inbox', ['alice'], { FIXTURE_CUSTOMERS: '1', FIXTURE_CREATE: failure });
      assert.equal(result.status, 1);
      const recovered = JSON.parse(success(run(cwd, 'provision-customer-inbox', ['alice'], { FIXTURE_CUSTOMERS: '1' })));
      assert.equal(recovered.bucket_id, 'bkt_1');
      assert.equal(JSON.parse(await readFile(join(cwd, '.fixture-buckets.json'))).length, 1, 'Recovery must not create another bucket');
    } finally { await rm(cwd, { recursive: true, force: true }); }
  }
});
