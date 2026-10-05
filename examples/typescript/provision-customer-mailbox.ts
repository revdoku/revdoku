import { mkdir, open, readFile, rename, unlink, writeFile } from 'node:fs/promises';
import { randomUUID } from 'node:crypto';
import { join } from 'node:path';

const apiKey = process.env.REVDOKU_API_KEY;
const accountId = process.env.REVDOKU_ACCOUNT_ID;
const customerId = process.argv[2]; // Supply this from a trusted application job, never a public request.
if (!apiKey || !accountId || !/^acct_[A-Za-z0-9]+$/.test(accountId) || !customerId) {
  throw new Error('Set REVDOKU_API_KEY and REVDOKU_ACCOUNT_ID; pass your customer ID as the argument.');
}
const headers = { Authorization: `Bearer ${apiKey}`, 'Content-Type': 'application/json' };
const directory = process.env.REVDOKU_STATE_DIR || '.revdoku-examples';
await mkdir(directory, { recursive: true, mode: 0o700 });
const path = join(directory, `mailboxes-${accountId}.json`);
// One process owns this journal. After a crash, confirm it stopped before removing the lock.
const lock = await open(`${path}.lock`, 'wx', 0o600);
type Mailbox = { customer_id: string; title: string; mailbox_id?: string; address?: string };
let mailboxes: Mailbox[] = [];
const save = async () => {
  const temporary = `${path}.${randomUUID()}.tmp`;
  await writeFile(temporary, JSON.stringify({ account_id: accountId, mailboxes }, null, 2), { flag: 'wx', mode: 0o600 });
  await rename(temporary, path);
};
try {
  try {
    const saved = JSON.parse(await readFile(path, 'utf8'));
    if (saved.account_id !== accountId || !Array.isArray(saved.mailboxes)) throw new Error('Journal account mismatch.');
    mailboxes = saved.mailboxes;
  } catch (error) { if ((error as NodeJS.ErrnoException).code !== 'ENOENT') throw error; }
  const identity = await fetch(`https://api.revdoku.com/v1/accounts/${accountId}`, { headers, redirect: 'error', signal: AbortSignal.timeout(30000) });
  const identityResult = await identity.json();
  if (!identity.ok || identityResult.data?.account?.id !== accountId) throw new Error('Cannot access the configured account.');
  let mailbox = mailboxes.find(item => item.customer_id === customerId);
  if (mailbox && !mailbox.mailbox_id) {
    // A previous POST may have committed. Reconcile its unique title; never repeat it.
    const url = new URL('https://api.revdoku.com/v1/mailboxes');
    url.searchParams.set('account_id', accountId);
    url.searchParams.set('q', mailbox.title);
    const response = await fetch(url, { headers, redirect: 'error', signal: AbortSignal.timeout(30000) });
    const result = await response.json();
    if (!response.ok || !Array.isArray(result.data?.mailboxes)) throw new Error('Could not reconcile creation. Check the dashboard; rerun to check again.');
    const matches = result.data.mailboxes.filter((mailbox: { title: string }) => mailbox.title === mailbox!.title);
    if (matches.length !== 1 || !/^bkt_[A-Za-z0-9]+$/.test(matches[0].id)) throw new Error('Creation is uncertain. Check the dashboard before creating another mailbox.');
    mailbox.mailbox_id = matches[0].id;
    await save();
  }
  if (!mailbox) {
    mailbox = { customer_id: customerId, title: `Customer mailbox ${randomUUID()}` };
    mailboxes.push(mailbox);
    await save(); // Record intent before the only POST. This is local state, not a server retry key.
    const response = await fetch('https://api.revdoku.com/v1/mailboxes', {
      method: 'POST', headers, redirect: 'error', signal: AbortSignal.timeout(30000),
      body: JSON.stringify({ account_id: accountId, mailbox: { title: mailbox.title, email: { domain: process.env.REVDOKU_EMAIL_DOMAIN } } }),
    });
    const result = await response.json();
    const id = response.ok ? result.data?.mailbox?.id : result.error?.code === 'EMAIL_NOT_READY' ? result.error.details?.mailbox_id : undefined;
    if (typeof id === 'string' && /^bkt_[A-Za-z0-9]+$/.test(id)) {
      mailbox.mailbox_id = id;
      await save();
    } else {
      // A structured rejection means a later explicit run may try again. Unknown outcomes stay pending.
      if (response.status >= 400 && response.status < 500 && result.error?.code) {
        mailboxes = mailboxes.filter(item => item !== mailbox);
        await save();
      }
      throw new Error(`${result.error?.code || 'CREATION_UNCERTAIN'}: creation did not return a mailbox ID. Check the dashboard before retrying.`);
    }
  }
  const response = await fetch(`https://api.revdoku.com/v1/mailboxes/${mailbox.mailbox_id}?account_id=${accountId}&include_email=true`, { headers, redirect: 'error', signal: AbortSignal.timeout(30000) });
  const result = await response.json();
  if (!response.ok || result.data?.mailbox?.id !== mailbox.mailbox_id) throw new Error('Could not read the saved mailbox. No new mailbox was created.');
  const email = result.data.mailbox.email;
  if (!email?.receiving_enabled || !email.address) throw new Error(`Mailbox saved: ${mailbox.mailbox_id}. Receiving: ${email?.blocked_reason || 'pending'}. Rerun to check this mailbox.`);
  mailbox.address = email.address;
  await save();
  console.log(JSON.stringify({ account_id: accountId, ...mailbox }));
} finally {
  await lock.close();
  await unlink(`${path}.lock`);
}
