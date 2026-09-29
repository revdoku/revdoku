import { createClient, requiredEnv, run, type Bucket } from './client.js';

await run(async () => {
  const client = createClient();
  const key = requiredEnv('REVDOKU_CREATE_KEY');
  if (!/^[A-Za-z0-9._:-]{1,200}$/.test(key)) throw new Error('Creation key must contain 1–200 letters, digits, dots, underscores, colons or hyphens.');
  const { bucket } = await client.api<{ bucket: Bucket }>('/api/v1/buckets', {
    method: 'POST', retrySafe: true,
    body: { idempotency_key: key, bucket: { title: process.argv[2] ?? 'API inbox' } },
  });
  console.log(`Bucket: ${bucket.id}`);
  console.log(`Dashboard: ${bucket.dashboard_url}`);
  const inbox = await client.waitForInbox(bucket.id);
  console.log(`Receiving ready: ${inbox.address}`);
  console.log('Set REVDOKU_BUCKET_ID to this bucket ID for the remaining examples.');
});
