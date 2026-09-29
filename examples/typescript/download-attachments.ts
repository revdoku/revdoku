import { bucketId, createClient, emailId, run, saveAttachment } from './client.js';

await run(async () => {
  const selected = process.argv[2];
  if (!selected) throw new Error('Usage: download-attachments.js EMAIL_ID [OUTPUT_DIRECTORY]');
  const client = createClient(); const id = bucketId();
  const message = await client.readEmail(id, emailId(selected), true);
  for (const [index, attachment] of (message.attachments ?? []).entries()) {
    const bytes = await client.downloadEmail(id, selected, attachment.id);
    const destination = await saveAttachment(process.argv[3] ?? 'downloads', index, attachment.filename.replace(/[\\/]/g, '_'), bytes);
    console.log(`Saved ${bytes.length} bytes to ${destination}`);
  }
  console.log(`Attachments downloaded: ${message.attachments?.length ?? 0}`);
});
