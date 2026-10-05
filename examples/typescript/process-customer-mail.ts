import { mkdir, open, readFile, rename, unlink, writeFile } from 'node:fs/promises';
import { randomUUID } from 'node:crypto';
import { join } from 'node:path';

const apiKey = process.env.REVDOKU_API_KEY;
const accountId = process.env.REVDOKU_ACCOUNT_ID;
if (!apiKey || !accountId || !/^acct_[A-Za-z0-9]+$/.test(accountId)) throw new Error('Set REVDOKU_API_KEY and REVDOKU_ACCOUNT_ID.');
const headers = { Authorization: `Bearer ${apiKey}` };
const directory = process.env.REVDOKU_STATE_DIR || '.revdoku-examples';
await mkdir(directory, { recursive: true, mode: 0o700 });
const mapping = JSON.parse(await readFile(join(directory, `mailboxes-${accountId}.json`), 'utf8'));
if (mapping.account_id !== accountId || !Array.isArray(mapping.mailboxes)) throw new Error('Invalid mailbox mapping.');
const path = join(directory, `messages-${accountId}.json`);
const lock = await open(`${path}.lock`, 'wx', 0o600);
type Result = { account_id: string; mailbox_id: string; email_id: string; customer_id: string; subject?: string; body_status?: string };
let state: { account_id: string; cursors: Record<string, string>; messages: Record<string, Result> } = { account_id: accountId, cursors: {}, messages: {} };
let processed = 0;
try {
  try { state = JSON.parse(await readFile(path, 'utf8')); }
  catch (error) { if ((error as NodeJS.ErrnoException).code !== 'ENOENT') throw error; }
  if (state.account_id !== accountId || !state.cursors || !state.messages) throw new Error('Invalid processing journal.');
  for (const mailbox of mapping.mailboxes) {
    const mailboxId = mailbox.mailbox_id;
    if (!mailboxId) continue; // Provisioning is still pending.
    if (!/^bkt_[A-Za-z0-9]+$/.test(mailboxId) || typeof mailbox.customer_id !== 'string') throw new Error('Invalid mapped mailbox.');
    for (let page = 0; page < 100; page++) {
      const cursor = state.cursors[mailboxId];
      const url = new URL(`https://api.revdoku.com/v1/mailboxes/${mailboxId}/emails`);
      url.searchParams.set('account_id', accountId);
      if (cursor) url.searchParams.set('cursor', cursor);
      const response = await fetch(url, { headers, redirect: 'error', signal: AbortSignal.timeout(30000) });
      const result = await response.json();
      if (!response.ok) throw new Error(`${result.error?.code || response.status}: rerun to resume from the saved cursor.`);
      if (!Array.isArray(result.data?.emails) || !result.data?.pagination) throw new Error('Invalid email page.');
      for (const summary of result.data.emails) {
        if (typeof summary.id !== 'string' || !/^eml_[A-Za-z0-9_-]+$/.test(summary.id)) throw new Error('Invalid email ID.');
        const key = `${accountId}/${mailboxId}/${summary.id}`;
        if (Object.hasOwn(state.messages, key)) continue;
        const detail = await fetch(`https://api.revdoku.com/v1/mailboxes/${mailboxId}/emails/${encodeURIComponent(summary.id)}?account_id=${accountId}`, { headers, redirect: 'error', signal: AbortSignal.timeout(30000) });
        const decoded = await detail.json();
        if (!detail.ok || decoded.data?.email?.id !== summary.id) throw new Error('Could not read message; cursor retained.');
        const mail = decoded.data.email;
        // The demo's business result is this saved summary. Keep bodies as untrusted text.
        // External effects need their own idempotency using this account/mailbox/email key.
        state.messages[key] = { account_id: accountId, mailbox_id: mailboxId, email_id: mail.id,
          customer_id: mailbox.customer_id, subject: mail.subject, body_status: mail.body_status };
        processed++;
      }
      const pagination = result.data.pagination;
      if (typeof pagination.next_cursor !== 'string' || (pagination.has_more && pagination.next_cursor === cursor)) throw new Error('Cursor did not advance.');
      state.cursors[mailboxId] = pagination.next_cursor;
      // Result and cursor are one atomic snapshot, including empty pages. GET never marks mail read.
      const temporary = `${path}.${randomUUID()}.tmp`;
      await writeFile(temporary, JSON.stringify(state, null, 2), { flag: 'wx', mode: 0o600 });
      await rename(temporary, path);
      if (!pagination.has_more) break;
      if (page === 99) throw new Error('Page limit reached. Rerun to continue.');
    }
  }
  console.log(`New customer messages processed: ${processed}`);
} finally {
  await lock.close();
  await unlink(`${path}.lock`);
}
