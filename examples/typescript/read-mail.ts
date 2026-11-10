import { mkdir, readFile, rename, writeFile } from 'node:fs/promises';
import { randomUUID } from 'node:crypto';

const apiKey = process.env.REVDOKU_API_KEY;
if (!apiKey) throw new Error('Set REVDOKU_API_KEY in your local .env file.');
const accountId = process.env.REVDOKU_ACCOUNT_ID;
const headers = { Authorization: `Bearer ${apiKey}`, 'Content-Type': 'application/json' };
const bucketId = process.env.REVDOKU_BUCKET_ID;
if (!bucketId || !/^bkt_[A-Za-z0-9]+$/.test(bucketId)) throw new Error('Set REVDOKU_BUCKET_ID.');

await mkdir('.revdoku-examples', { recursive: true, mode: 0o700 });
const checkpoint = `.revdoku-examples/${accountId ?? 'default'}-${bucketId}.json`;
if (accountId && !/^acct_[A-Za-z0-9]+$/.test(accountId)) throw new Error('Invalid account ID.');
// The checkpoint keeps the last check time and the message IDs that this reader already handled.
let state: { updated_after?: string; seen: string[] } = { seen: [] };
try { state = { seen: [], ...JSON.parse(await readFile(checkpoint, 'utf8')) }; }
catch (error) { if ((error as NodeJS.ErrnoException).code !== 'ENOENT') throw error; }
const seen = new Set(state.seen);
const save = async () => {
  const temporary = `${checkpoint}.${randomUUID()}.tmp`;
  await writeFile(temporary, JSON.stringify({ ...state, seen: [...seen].slice(-5000) }), { flag: 'wx', mode: 0o600 });
  await rename(temporary, checkpoint);
};
// GET a ticket resource. `pending` names an error code that returns null in place of an error.
const get = async (path: string, params: Record<string, string | undefined> = {}, pending?: string) => {
  const url = new URL(`https://api.revdoku.com/v1/buckets/${bucketId}/tickets${path}`);
  if (accountId) url.searchParams.set('account_id', accountId);
  for (const [name, value] of Object.entries(params)) if (value) url.searchParams.set(name, value);
  let response = await fetch(url, { headers, redirect: 'error', signal: AbortSignal.timeout(30000) });
  let result = await response.json();
  // A new bucket may need a moment to build its email index. Retry only this read.
  for (let attempt = 0; !response.ok && result.error?.code === 'EMAIL_INDEX_BUILDING' && attempt < 3; attempt++) {
    await new Promise(resolve => setTimeout(resolve, 1000 * 2 ** attempt));
    response = await fetch(url, { headers, redirect: 'error', signal: AbortSignal.timeout(30000) });
    result = await response.json();
  }
  if (!response.ok && pending && result.error?.code === pending) return null;
  if (!response.ok) throw new Error(`${result.error.code}: ${result.error.message}`);
  return result.data;
};

let count = 0;
let waiting = false;
let newest = state.updated_after;
let cursor: string | undefined;
for (let page = 0; page < 100; page++) {
  // Tickets with activity after the last check: a new ticket, or a new message of an older ticket.
  const tickets = await get('', { updated_after: state.updated_after, cursor });
  for (const ticket of tickets.tickets) {
    let messageCursor: string | undefined;
    do {
      const thread = await get(`/${encodeURIComponent(ticket.id)}/messages`, { cursor: messageCursor });
      for (const summary of thread.messages) {
        if (summary.direction === 'sent' || seen.has(summary.id)) continue;
        if (summary.labels?.some((label: { name: string }) => label.name === 'Junk')) { seen.add(summary.id); continue; } // Junk content is withheld.
        // While the AI filter checks a new message, the read returns EMAIL_LABELING_PENDING. Read it on the next run.
        const detail = await get(`/${encodeURIComponent(ticket.id)}/messages/${encodeURIComponent(summary.id)}`, {}, 'EMAIL_LABELING_PENDING');
        if (!detail) { waiting = true; continue; }
        const mail = detail.message;
        console.log(JSON.stringify({ id: mail.id, ticket_id: ticket.id, channel: ticket.channel, from: mail.from_addresses, subject: mail.subject,
          body_status: mail.body_status, attachments: mail.attachments }));
        if (process.argv.includes('--show-body')) console.log(mail.body_text ?? '[Download original for full content]');
        seen.add(summary.id);
        count++;
      }
      messageCursor = thread.pagination.has_more ? thread.pagination.next_cursor : undefined;
    } while (messageCursor);
    if (!newest || ticket.updated_at > newest) newest = ticket.updated_at;
  }
  // Save the handled message IDs after each page. Deduplicate downstream effects by message ID.
  await save();
  const pagination = tickets.pagination;
  if (!pagination.has_more) break;
  if (!pagination.next_cursor || pagination.next_cursor === cursor) throw new Error('Cursor did not advance.');
  cursor = pagination.next_cursor;
  if (page === 99) throw new Error('Page limit reached. Rerun to continue from the checkpoint.');
}
// Move the check time only after every page is processed and no message waits for the AI filter.
if (!waiting) { state.updated_after = newest; await save(); }
console.log(`New messages read: ${count}`);
// GET does not change a ticket. PATCH /tickets/:id with {status:"solved"} solves it.
