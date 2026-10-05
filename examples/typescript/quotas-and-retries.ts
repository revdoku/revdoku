import { setTimeout as delay } from 'node:timers/promises';

const apiKey = process.env.REVDOKU_API_KEY;
if (!apiKey) throw new Error('Set REVDOKU_API_KEY in your local .env file.');
const accountId = process.env.REVDOKU_ACCOUNT_ID;
const headers = { Authorization: `Bearer ${apiKey}`, 'Content-Type': 'application/json' };

const url = new URL('https://api.revdoku.com/v1/account/limits');
if (accountId) url.searchParams.set('account_id', accountId);
for (let attempt = 0; attempt < 4; attempt++) {
  const response = await fetch(url, { headers, redirect: 'error', signal: AbortSignal.timeout(10000) });
  const result = await response.json();
  if (response.ok) {
    console.log(JSON.stringify(result.data.limits, null, 2));
    break;
  }
  const error = result.error;
  if (error.details?.resets_at) throw new Error(`${error.code}: ${error.message}. Allowance resets at ${error.details.resets_at}`);
  const temporary = response.status === 429 || [502, 503, 504].includes(response.status);
  if (!temporary || attempt === 3) throw new Error(`${error.code}: ${error.message}`);
  const retryAfter = response.headers.get('Retry-After');
  const milliseconds = retryAfter && /^\d+$/.test(retryAfter) ? Number(retryAfter) * 1000 :
    retryAfter ? Date.parse(retryAfter) - Date.now() : 1000 * 2 ** attempt;
  if (!Number.isFinite(milliseconds) || milliseconds > 10000) throw new Error('Rate limited. Retry later.');
  await delay(Math.max(0, milliseconds));
}
// Retry read requests only. After an uncertain creation result, check your mailboxes.
