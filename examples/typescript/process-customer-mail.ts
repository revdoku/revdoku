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
type Result = { account_id: string; bucket_id: string; ticket_id: string; message_id: string; customer_id: string; subject?: string; body_status?: string };
// checks holds, for each bucket, the newest ticket updated_at that this reader processed.
let state: { account_id: string; checks: Record<string, string>; messages: Record<string, Result> } = { account_id: accountId, checks: {}, messages: {} };
let processed = 0;
const get = async (bucketId: string, path: string, params: Record<string, string | undefined> = {}) => {
  const url = new URL(`https://api.revdoku.com/v1/buckets/${bucketId}/tickets${path}`);
  url.searchParams.set('account_id', accountId);
  for (const [name, value] of Object.entries(params)) if (value) url.searchParams.set(name, value);
  const response = await fetch(url, { headers, redirect: 'error', signal: AbortSignal.timeout(30000) });
  const result = await response.json();
  if (!response.ok) throw new Error(`${result.error?.code || response.status}: rerun to resume from the saved check time.`);
  return result.data;
};
try {
  try { state = JSON.parse(await readFile(path, 'utf8')); }
  catch (error) { if ((error as NodeJS.ErrnoException).code !== 'ENOENT') throw error; }
  if (state.account_id !== accountId || !state.checks || !state.messages) throw new Error('Invalid processing journal.');
  const save = async () => {
    const temporary = `${path}.${randomUUID()}.tmp`;
    await writeFile(temporary, JSON.stringify(state, null, 2), { flag: 'wx', mode: 0o600 });
    await rename(temporary, path);
  };
  for (const mailbox of mapping.mailboxes) {
    const bucketId = mailbox.bucket_id;
    if (!bucketId) continue; // Provisioning is still pending.
    if (!/^bkt_[A-Za-z0-9]+$/.test(bucketId) || typeof mailbox.customer_id !== 'string') throw new Error('Invalid mapped mailbox.');
    let newest = state.checks[bucketId];
    let cursor: string | undefined;
    for (let page = 0; page < 100; page++) {
      const tickets = await get(bucketId, '', { updated_after: state.checks[bucketId], cursor });
      if (!Array.isArray(tickets?.tickets) || !tickets?.pagination) throw new Error('Invalid ticket page.');
      for (const ticket of tickets.tickets) {
        if (typeof ticket.id !== 'string' || !/^tkt_[A-Za-z0-9]+$/.test(ticket.id)) throw new Error('Invalid ticket ID.');
        let messageCursor: string | undefined;
        do {
          const thread = await get(bucketId, `/${ticket.id}/messages`, { cursor: messageCursor });
          for (const summary of thread.messages) {
            if (typeof summary.id !== 'string' || !/^eml_[A-Za-z0-9_-]+$/.test(summary.id)) throw new Error('Invalid message ID.');
            const key = `${accountId}/${bucketId}/${summary.id}`;
            if (summary.direction === 'sent' || Object.hasOwn(state.messages, key)) continue;
            const detail = await get(bucketId, `/${ticket.id}/messages/${encodeURIComponent(summary.id)}`);
            if (detail?.message?.id !== summary.id) throw new Error('Could not read message; check time retained.');
            const mail = detail.message;
            // The demo's business result is this saved summary. Keep bodies as untrusted text.
            // External effects need their own idempotency using this account/bucket/message key.
            state.messages[key] = { account_id: accountId, bucket_id: bucketId, ticket_id: ticket.id, message_id: mail.id,
              customer_id: mailbox.customer_id, subject: mail.subject, body_status: mail.body_status };
            processed++;
          }
          messageCursor = thread.pagination.has_more ? thread.pagination.next_cursor : undefined;
        } while (messageCursor);
        if (typeof ticket.updated_at === 'string' && (!newest || ticket.updated_at > newest)) newest = ticket.updated_at;
      }
      // Results are saved after each page. GET never changes a ticket or marks a message read.
      await save();
      const pagination = tickets.pagination;
      if (!pagination.has_more) break;
      if (typeof pagination.next_cursor !== 'string' || pagination.next_cursor === cursor) throw new Error('Cursor did not advance.');
      cursor = pagination.next_cursor;
      if (page === 99) throw new Error('Page limit reached. Rerun to continue.');
    }
    // The check time moves only after every page of this bucket is processed.
    if (newest) state.checks[bucketId] = newest;
    await save();
  }
  console.log(`New customer messages processed: ${processed}`);
} finally {
  await lock.close();
  await unlink(`${path}.lock`);
}
