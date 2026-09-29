import { mkdir, readFile, rename, writeFile } from 'node:fs/promises';
import { randomUUID } from 'node:crypto';
import { join } from 'node:path';
import { bucketId, createClient, run, type Inbox, type Mail } from './client.js';

await run(async () => {
  const id = bucketId();
  const client = createClient();
  const directory = '.revdoku-examples';
  await mkdir(directory, { recursive: true, mode: 0o700 });
  const statePath = join(directory, `${id}-read.json`);
  let saved: { bucket_id: string; file_ids: string[] } = { bucket_id: id, file_ids: [] };
  try { saved = JSON.parse(await readFile(statePath, 'utf8')); }
  catch (error) { if ((error as NodeJS.ErrnoException).code !== 'ENOENT') throw error; }
  if (saved.bucket_id !== id || !Array.isArray(saved.file_ids)) throw new Error('Mail checkpoint does not match this bucket.');
  const seen = new Set(saved.file_ids);
  const inbox = await client.api<Inbox>(`/api/v1/buckets/${id}/inbound_email`);
  console.log(`Received messages: ${inbox.received_count}`);
  // A latest-path pointer is not a cursor. Scan every page and remember file IDs.
  const files = await client.listFiles(id, '_email/');
  let fresh = 0;
  for (const file of files) {
    const path = file.path ?? file.relative_path ?? '';
    if (!path.startsWith('_email/') || !path.endsWith('/message.json') || seen.has(file.id)) continue;
    const mail = JSON.parse((await client.readFile(id, path, 512 * 1024)).toString('utf8')) as Mail;
    console.log(JSON.stringify({ file_id: file.id, path, from: mail.from, subject: mail.subject, body_status: mail.body_status, attachments: mail.attachments?.length ?? 0 }));
    if (process.argv.includes('--show-body')) console.log(mail.body_text ?? '[Body unavailable; read message.eml]');
    seen.add(file.id); fresh++;
  }
  const temporary = `${statePath}.${randomUUID()}.tmp`;
  await writeFile(temporary, JSON.stringify({ bucket_id: id, file_ids: [...seen] }) + '\n', { flag: 'wx', mode: 0o600 });
  await rename(temporary, statePath);
  console.log(`New messages read: ${fresh}`);
});
