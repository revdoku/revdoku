import { attachmentPath, bucketId, createClient, run, safePath, saveAttachment } from './client.js';
await run(async () => {
    const messagePath = process.argv[2];
    if (!messagePath)
        throw new Error('Usage: download-attachments.js MESSAGE_JSON_PATH [OUTPUT_DIRECTORY]');
    safePath(messagePath);
    if (!messagePath.startsWith('_email/') || !messagePath.endsWith('/message.json'))
        throw new Error('Select a message.json path returned by read-mail.');
    const client = createClient();
    const id = bucketId();
    const message = JSON.parse((await client.readFile(id, messagePath, 512 * 1024)).toString('utf8'));
    if (!Array.isArray(message.attachments))
        throw new Error('Message has no attachment list.');
    for (const [index, attachment] of message.attachments.entries()) {
        const path = attachmentPath(messagePath, attachment.path);
        const bytes = await client.readFile(id, path);
        const destination = await saveAttachment(process.argv[3] ?? 'downloads', index, attachment.path, bytes);
        console.log(`Saved ${bytes.length} bytes to ${destination}`);
    }
    console.log(`Attachments downloaded: ${message.attachments.length}`);
});
