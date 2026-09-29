import { mkdir, readFile, rename, writeFile } from 'node:fs/promises';
import { randomUUID } from 'node:crypto';
import { join } from 'node:path';
import { bucketId, createClient, run } from './client.js';
await run(async () => {
    const id = bucketId();
    const client = createClient();
    const directory = '.revdoku-examples';
    await mkdir(directory, { recursive: true, mode: 0o700 });
    const statePath = join(directory, `${id}-read.json`);
    let saved = { bucket_id: id };
    try {
        saved = JSON.parse(await readFile(statePath, 'utf8'));
    }
    catch (error) {
        if (error.code !== 'ENOENT')
            throw error;
    }
    if (saved.bucket_id !== id || (saved.cursor !== undefined && typeof saved.cursor !== 'string'))
        throw new Error('Mail checkpoint does not match this bucket.');
    let fresh = 0;
    for (let page = 0; page < 1000; page++) {
        const result = await client.listEmails(id, saved.cursor);
        for (const summary of result.emails) {
            const mail = await client.readEmail(id, summary.id);
            console.log(JSON.stringify({ id: mail.id, from: mail.from, subject: mail.subject, body_status: mail.body_status, attachments: mail.attachments?.length ?? 0 }));
            if (process.argv.includes('--show-body'))
                console.log(mail.body_text ?? '[Body unavailable; download the original]');
            fresh++;
        }
        if (result.pagination.has_more && saved.cursor === result.pagination.next_cursor)
            throw new Error('Email pagination did not advance.');
        saved.cursor = result.pagination.next_cursor;
        // Commit after processing each page. Repeated work after a crash is possible;
        // production consumers should make their own side effects idempotent by mail.id.
        const temporary = `${statePath}.${randomUUID()}.tmp`;
        await writeFile(temporary, JSON.stringify(saved) + '\n', { flag: 'wx', mode: 0o600 });
        await rename(temporary, statePath);
        if (!result.pagination.has_more) {
            console.log(`New messages read: ${fresh}`);
            return;
        }
    }
    throw new Error('Example page limit reached; rerun to continue from the checkpoint.');
});
