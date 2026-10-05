const apiKey = process.env.REVDOKU_API_KEY;
if (!apiKey)
    throw new Error('Set REVDOKU_API_KEY in your local .env file.');
const username = process.argv[2];
const response = await fetch('https://api.revdoku.com/v1/mailboxes', {
    method: 'POST',
    headers: { Authorization: `Bearer ${apiKey}`, 'Content-Type': 'application/json' },
    redirect: 'error',
    signal: AbortSignal.timeout(30000),
    body: JSON.stringify({
        account_id: process.env.REVDOKU_ACCOUNT_ID,
        mailbox: { email: username ? { username } : {} },
    }),
});
const result = await response.json();
if (!response.ok)
    throw new Error(`${result.error.code}: ${result.error.message}`);
const mailbox = result.data.mailbox;
console.log(`Mailbox: ${mailbox.id}`);
console.log(`Receiving ready: ${mailbox.email.address}`);
export {};
