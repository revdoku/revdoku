import { readFile, stat } from 'node:fs/promises';
import { basename, extname } from 'node:path';
import { bucketId, createClient, run, safePath } from './client.js';

await run(async () => {
  const local = process.argv[2];
  if (!local) throw new Error('Usage: upload-file.js LOCAL_FILE [BUCKET_PATH]');
  const info = await stat(local);
  if (!info.isFile() || info.size > 64 * 1024 * 1024) throw new Error('Choose a file of at most 64 MiB for this example.');
  const path = safePath(process.argv[3] ?? basename(local));
  const types: Record<string, string> = { '.txt': 'text/plain', '.md': 'text/markdown', '.json': 'application/json' };
  const bytes = await readFile(local); const client = createClient(); const id = bucketId();
  await client.uploadFile(id, path, bytes, types[extname(local).toLowerCase()] ?? 'application/octet-stream');
  const downloaded = await client.readFile(id, path);
  if (!bytes.equals(downloaded)) throw new Error('Readback did not match the uploaded bytes.');
  console.log(`Uploaded and verified ${bytes.length} bytes at ${path}`);
});
