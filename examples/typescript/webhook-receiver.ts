import { createServer } from 'node:http';
import { createHash, createHmac, timingSafeEqual } from 'node:crypto';
import { mkdir, access, writeFile } from 'node:fs/promises';

const secret = process.env.REVDOKU_WEBHOOK_SECRET;
const apiKey = process.env.REVDOKU_API_KEY;
const mailboxId = process.env.REVDOKU_BUCKET_ID;
const accountId = process.env.REVDOKU_ACCOUNT_ID;
if (!secret || !apiKey || !mailboxId) throw new Error('Set REVDOKU_WEBHOOK_SECRET, REVDOKU_API_KEY and REVDOKU_BUCKET_ID.');
await mkdir('.revdoku-examples/webhooks', { recursive: true, mode: 0o700 });
const processing = new Set<string>();
const server = createServer(async (request, response) => {
  let eventId: string | undefined;
  let claimed = false;
  try {
    if (request.method !== 'POST' || request.url !== '/webhook') { response.writeHead(404).end(); return; }
    const chunks: Buffer[] = [];
    let bytes = 0;
    for await (const chunk of request) {
      bytes += chunk.length;
      if (bytes > 16384) { response.writeHead(413).end(); return; }
      chunks.push(chunk);
    }
    const body = Buffer.concat(chunks);
    const timestamp = request.headers['x-revdoku-timestamp'];
    const signature = request.headers['x-revdoku-signature'];
    if (typeof timestamp !== 'string' || !/^\d{10}$/.test(timestamp) || Math.abs(Date.now() / 1000 - Number(timestamp)) > 300 ||
        typeof signature !== 'string' || !/^v1=[a-f0-9]{64}$/.test(signature)) { response.writeHead(401).end(); return; }
    const expected = createHmac('sha256', secret).update(`${timestamp}.`).update(body).digest();
    if (!timingSafeEqual(expected, Buffer.from(signature.slice(3), 'hex'))) { response.writeHead(401).end(); return; }
    const event = JSON.parse(body.toString('utf8'));
    if (event.type !== 'email.received' || event.data?.mailbox_id !== mailboxId || (accountId && event.data?.account_id !== accountId) ||
        event.id !== request.headers['x-revdoku-event-id'] || !/^eml_[A-Za-z0-9]+$/.test(event.data?.email_id)) { response.writeHead(400).end(); return; }
    eventId = event.id;
    const marker = `.revdoku-examples/webhooks/${createHash('sha256').update(eventId!).digest('hex')}`;
    try { await access(marker); response.writeHead(204).end(); return; }
    catch (error) { if ((error as NodeJS.ErrnoException).code !== 'ENOENT') throw error; }
    if (processing.has(eventId!)) { response.writeHead(503, { 'Retry-After': '5' }).end(); return; }
    processing.add(eventId!);
    claimed = true;
    const url = new URL(`https://api.revdoku.com/v1/mailboxes/${encodeURIComponent(mailboxId)}/emails/${encodeURIComponent(event.data.email_id)}`);
    url.searchParams.set('account_id', event.data.account_id);
    url.searchParams.set('purpose', 'background');
    const emailResponse = await fetch(url, { headers: { Authorization: `Bearer ${apiKey}` }, redirect: 'error', signal: AbortSignal.timeout(8000) });
    if (!emailResponse.ok) throw new Error(`Read email: HTTP ${emailResponse.status}`);
    const email = (await emailResponse.json()).data.email;
    console.log(JSON.stringify({ id: email.id, subject: email.subject }));
    // Save only after processing succeeds. Use email.id to deduplicate your own
    // downstream effects; a crash between processing and saving can repeat them.
    await writeFile(marker, '', { mode: 0o600 });
    response.writeHead(204).end();
  } catch { response.writeHead(503, { 'Retry-After': '5' }).end(); }
  finally { if (claimed && eventId) processing.delete(eventId); }
});
server.listen(Number(process.env.PORT || 8080), '127.0.0.1', () => {
  const address = server.address();
  console.log(`Listening on http://127.0.0.1:${typeof address === 'object' && address?.port}/webhook; expose it through your HTTPS proxy.`);
});
