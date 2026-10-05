import { mkdir, readFile, rename, writeFile } from 'node:fs/promises';
import { randomUUID } from 'node:crypto';
const apiKey = process.env.REVDOKU_API_KEY;
if (!apiKey)
    throw new Error('Set REVDOKU_API_KEY in your local .env file.');
const accountId = process.env.REVDOKU_ACCOUNT_ID;
const headers = { Authorization: `Bearer ${apiKey}`, 'Content-Type': 'application/json' };
const mailboxId = process.env.REVDOKU_BUCKET_ID;
if (!mailboxId || !/^bkt_[A-Za-z0-9]+$/.test(mailboxId))
    throw new Error('Set REVDOKU_BUCKET_ID.');
await mkdir('.revdoku-examples', { recursive: true, mode: 0o700 });
const checkpoint = `.revdoku-examples/${accountId ?? 'default'}-${mailboxId}.json`;
if (accountId && !/^acct_[A-Za-z0-9]+$/.test(accountId))
    throw new Error('Invalid account ID.');
let cursor;
try {
    cursor = JSON.parse(await readFile(checkpoint, 'utf8')).cursor;
}
catch (error) {
    if (error.code !== 'ENOENT')
        throw error;
}
let count = 0;
for (let page = 0; page < 100; page++) {
    const url = new URL(`https://api.revdoku.com/v1/mailboxes/${mailboxId}/emails`);
    if (accountId)
        url.searchParams.set('account_id', accountId);
    if (cursor)
        url.searchParams.set('cursor', cursor);
    let response = await fetch(url, { headers, redirect: 'error', signal: AbortSignal.timeout(30000) });
    let result = await response.json();
    // A new mailbox may need a moment to build its email index. Retry only this read.
    for (let attempt = 0; !response.ok && result.error?.code === 'EMAIL_INDEX_BUILDING' && attempt < 3; attempt++) {
        await new Promise(resolve => setTimeout(resolve, 1000 * 2 ** attempt));
        response = await fetch(url, { headers, redirect: 'error', signal: AbortSignal.timeout(30000) });
        result = await response.json();
    }
    if (!response.ok)
        throw new Error(`${result.error.code}: ${result.error.message}`);
    for (const summary of result.data.emails) {
        const detailUrl = new URL(`https://api.revdoku.com/v1/mailboxes/${mailboxId}/emails/${encodeURIComponent(summary.id)}`);
        if (accountId)
            detailUrl.searchParams.set('account_id', accountId);
        const detail = await fetch(detailUrl, { headers, redirect: 'error', signal: AbortSignal.timeout(30000) });
        const decoded = await detail.json();
        if (!detail.ok)
            throw new Error(`${decoded.error.code}: ${decoded.error.message}`);
        const mail = decoded.data.email;
        console.log(JSON.stringify({ id: mail.id, from: mail.from, subject: mail.subject,
            body_status: mail.body_status, attachments: mail.attachments }));
        if (process.argv.includes('--show-body'))
            console.log(mail.body_text ?? '[Download original for full content]');
        count++;
    }
    const pagination = result.data.pagination;
    if (pagination.has_more && (!pagination.next_cursor || pagination.next_cursor === cursor))
        throw new Error('Cursor did not advance.');
    cursor = pagination.next_cursor;
    // Save only after this page is processed. Deduplicate downstream effects by email ID.
    const temporary = `${checkpoint}.${randomUUID()}.tmp`;
    await writeFile(temporary, JSON.stringify({ cursor }), { flag: 'wx', mode: 0o600 });
    await rename(temporary, checkpoint);
    if (!pagination.has_more)
        break;
    if (page === 99)
        throw new Error('Page limit reached. Rerun to continue from the checkpoint.');
}
console.log(`New messages read: ${count}`);
// GET does not change read status. PATCH /emails/:id with {read:true} does.
