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
  return spawnSync(process.execPath, ['--import', fixture, example(name), ...args], { cwd, encoding: 'utf8', timeout: 10000,
    env: { ...process.env, REVDOKU_API_KEY: 'offline-fixture-key', REVDOKU_BUCKET_ID: 'bkt_fixture',
      REVDOKU_ACCOUNT_ID: 'acct_fixture', REVDOKU_CREATE_KEY: 'fixture-create-v1', ...env } });
}
function success(result) { assert.equal(result.status, 0, result.stderr); assert.doesNotMatch(result.stdout + result.stderr, /offline-fixture-key/); return result.stdout; }

test('all five command-line examples run offline, with pagination and persisted checkpoints', async () => {
  const cwd = await mkdtemp(join(tmpdir(), 'revdoku-examples-'));
  try {
    assert.match(success(run(cwd, 'create-inbox', ['Example'], { FIXTURE_PENDING: '1' })), /Receiving ready: fixture@revdokumail.com/);
    const first = success(run(cwd, 'read-mail', ['--show-body']));
    assert.match(first, /New messages read: 2/); assert.match(first, /Fixture body/);
    assert.match(success(run(cwd, 'read-mail')), /New messages read: 0/);
    assert.match(success(run(cwd, 'download-attachments', ['_email/inbox/sender/example/delivery/message.json'])), /Attachments downloaded: 1/);
    assert.equal(await readFile(join(cwd, 'downloads/1-note.txt'), 'utf8'), 'hello');
    await writeFile(join(cwd, 'notes.txt'), 'fixture upload');
    assert.match(success(run(cwd, 'upload-file', ['notes.txt', 'project/notes.txt'])), /Uploaded and verified 14 bytes/);
    assert.match(success(run(cwd, 'quotas-and-retries')), /"remaining": 74/);
    const quota = run(cwd, 'quotas-and-retries', [], { FIXTURE_QUOTA: '1' });
    assert.equal(quota.status, 1); assert.match(quota.stderr, /Allowance resets at 2026-10-01/);
  } finally { await rm(cwd, { recursive: true, force: true }); }
});
