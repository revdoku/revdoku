import { spawn } from 'node:child_process';
import { fileURLToPath } from 'node:url';
const apiKey = process.env.REVDOKU_API_KEY;
const bucketId = process.env.REVDOKU_BUCKET_ID;
const accountId = process.env.REVDOKU_ACCOUNT_ID;
if (!apiKey || !bucketId || !/^bkt_[A-Za-z0-9]+$/.test(bucketId))
    throw new Error('Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID.');
if (accountId && !/^acct_[A-Za-z0-9]+$/.test(accountId))
    throw new Error('Invalid account ID.');
let stopped = false;
let socket;
for (const signal of ['SIGINT', 'SIGTERM'])
    process.on(signal, () => { stopped = true; socket?.close(); });
let backoff = 1000;
let catchup = Promise.resolve();
while (!stopped) {
    try {
        const ticketUrl = new URL(`https://api.revdoku.com/v1/buckets/${bucketId}/email/subscription`);
        if (accountId)
            ticketUrl.searchParams.set('account_id', accountId);
        const response = await fetch(ticketUrl, { headers: { Authorization: `Bearer ${apiKey}` }, redirect: 'error', signal: AbortSignal.timeout(30000) });
        const result = await response.json();
        if (!response.ok) {
            if ([401, 403, 404].includes(response.status)) {
                console.error(result.error);
                break;
            }
            throw new Error(`Subscription request failed: HTTP ${response.status}`);
        }
        const subscription = result.data.subscription;
        const url = new URL(subscription.websocket_url);
        // The API returns the app's cable endpoint; never put the reusable API key in the URL.
        if (url.protocol !== 'wss:')
            throw new Error('Expected a secure WebSocket URL.');
        url.searchParams.set('email_subscription_token', subscription.token);
        const ws = new WebSocket(url, 'actioncable-v1-json');
        socket = ws;
        const identifier = JSON.stringify({ channel: subscription.channel, account_id: subscription.account_id, bucket_id: subscription.bucket_id });
        let lastMessage = Date.now();
        let pending = false;
        let reading = false;
        const readNewMail = () => {
            pending = true;
            if (reading)
                return;
            reading = true;
            // Reuse the ordinary HTTP example: it paginates and saves a durable cursor.
            catchup = catchup.then(async () => {
                while (pending && !stopped) {
                    pending = false;
                    // Emit each processed page before its cursor advances, even if a later page fails.
                    await new Promise((resolve, reject) => {
                        const child = spawn(process.execPath, [fileURLToPath(new URL('./read-mail.js', import.meta.url))], { stdio: ['ignore', 'inherit', 'inherit'] });
                        child.once('error', reject);
                        child.once('close', (code, signal) => code === 0 ? resolve() : reject(new Error(`read-mail exited with ${signal ?? code}`)));
                    });
                }
            }).catch(error => { console.error('Catch-up failed:', error.message); ws.close(); }).finally(() => { reading = false; });
        };
        const heartbeat = setInterval(() => { if (Date.now() - lastMessage > 15000)
            ws.close(); }, 5000);
        await new Promise(resolve => {
            ws.addEventListener('open', () => ws.send(JSON.stringify({ command: 'subscribe', identifier })));
            ws.addEventListener('message', message => {
                lastMessage = Date.now();
                try {
                    const frame = JSON.parse(String(message.data));
                    if (frame.type === 'confirm_subscription') {
                        backoff = 1000;
                        readNewMail();
                    }
                    if (frame.message?.type === 'email.received')
                        readNewMail();
                    if (frame.type === 'reject_subscription' || (frame.type === 'disconnect' && frame.reconnect === false)) {
                        console.error('Subscription ended. Check the API key and mailbox permissions.');
                        stopped = true;
                    }
                    if (frame.type === 'reject_subscription' || frame.type === 'disconnect')
                        ws.close();
                }
                catch {
                    ws.close();
                }
            });
            ws.addEventListener('error', () => ws.close());
            ws.addEventListener('close', () => { clearInterval(heartbeat); resolve(); }, { once: true });
        });
        await catchup;
    }
    catch (error) {
        console.error(error instanceof Error ? error.message : error);
    }
    if (!stopped)
        await new Promise(resolve => setTimeout(resolve, backoff + Math.random() * 500));
    backoff = Math.min(backoff * 2, 30000);
}
