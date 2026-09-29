// Shared example helpers. Edit TypeScript, then run npm run build in examples/.
import { createHash } from 'node:crypto';
import { mkdir, writeFile } from 'node:fs/promises';
import { basename, resolve } from 'node:path';
const API_ORIGIN = 'https://app.revdoku.com';
const MAX_BYTES = 64 * 1024 * 1024;
export class ApiError extends Error {
    status;
    code;
    details;
    requestId;
    constructor(status, code, message, details = {}, requestId) {
        super(message);
        this.status = status;
        this.code = code;
        this.details = details;
        this.requestId = requestId;
    }
}
export function requiredEnv(name) {
    const value = process.env[name]?.trim();
    if (!value)
        throw new Error(`Set ${name} in your local .env file.`);
    return value;
}
export function bucketId(value = requiredEnv('REVDOKU_BUCKET_ID')) {
    if (!/^bkt_[A-Za-z0-9]+$/.test(value))
        throw new Error('Expected a bkt_ bucket identifier.');
    return value;
}
export function safePath(value) {
    if (!value || /[\\\x00-\x1f]/.test(value) || value.split('/').some(p => !p || p === '.' || p === '..')) {
        throw new Error('Expected a safe bucket-relative file path.');
    }
    return value;
}
export function attachmentPath(messagePath, attachment) {
    safePath(messagePath);
    safePath(attachment);
    if (!messagePath.startsWith('_email/') || !messagePath.endsWith('/message.json') || !attachment.startsWith('attachments/')) {
        throw new Error('Attachment must belong to the selected message folder.');
    }
    return messagePath.slice(0, -'message.json'.length) + attachment;
}
const sleep = (ms) => new Promise(resolve => setTimeout(resolve, ms));
export function retryDelay(value, attempt, now = Date.now()) {
    if (value) {
        const seconds = Number(value);
        const delay = Number.isFinite(seconds) ? seconds * 1000 : Date.parse(value) - now;
        if (Number.isFinite(delay))
            return Math.max(0, delay);
    }
    return Math.min(500 * 2 ** attempt, 5000) + Math.floor(Math.random() * 250);
}
// Dependency injection is for offline tests; credentials only go to API_ORIGIN.
export function createClient(options = {}) {
    const apiKey = options.apiKey ?? requiredEnv('REVDOKU_API_KEY');
    const accountId = options.accountId ?? process.env.REVDOKU_ACCOUNT_ID?.trim();
    if (accountId && !/^acct_[A-Za-z0-9]+$/.test(accountId))
        throw new Error('Invalid account identifier.');
    const transport = options.fetch ?? fetch;
    const pause = options.sleep ?? sleep;
    async function api(path, opts = {}) {
        if (!path.startsWith('/api/v1/'))
            throw new Error('Expected an API-relative path.');
        const url = new URL(path, API_ORIGIN);
        if (url.origin !== API_ORIGIN)
            throw new Error('Invalid API origin.');
        const method = opts.method ?? 'GET';
        if (accountId && ['GET', 'HEAD'].includes(method))
            url.searchParams.set('account_id', accountId);
        const body = accountId && !['GET', 'HEAD'].includes(method)
            ? { ...(opts.body ?? {}), account_id: accountId } : opts.body;
        const canRetry = method === 'GET' || opts.retrySafe === true;
        const deadline = Date.now() + (opts.timeoutMs ?? 30000);
        for (let attempt = 0;; attempt++) {
            let response;
            try {
                response = await transport(url, {
                    method, redirect: 'error', signal: AbortSignal.timeout(Math.max(1, deadline - Date.now())),
                    headers: { Authorization: `Bearer ${apiKey}`, Accept: 'application/json',
                        'Content-Type': 'application/json' },
                    ...(body === undefined ? {} : { body: JSON.stringify(body) }),
                });
            }
            catch {
                // A write may have committed before a lost response. Retry only when safe.
                if (!canRetry || attempt >= 3 || Date.now() + 1000 >= deadline)
                    throw new Error('Request failed or timed out. Check the result before repeating a write.');
                await pause(500);
                continue;
            }
            const payload = await response.json().catch(() => ({}));
            if (response.ok) {
                if (payload.data === undefined)
                    throw new Error('API response did not contain data.');
                return payload.data;
            }
            const error = new ApiError(response.status, payload.error?.code ?? 'HTTP_ERROR', payload.error?.message ?? `HTTP ${response.status}`, payload.error?.details, payload.error?.request_id);
            const monthlyQuota = error.code === 'BUCKET_CREATION_LIMIT_REACHED' || typeof error.details.resets_at === 'string';
            const transient = response.status === 429 || [502, 503, 504].includes(response.status) ||
                (response.status === 409 && ['DATABASE_BUSY_RETRY', 'BUCKET_FILE_PATH_INDEX_BACKFILL_PENDING'].includes(error.code));
            const retryAfter = response.headers.get('Retry-After') ?? (error.details.retry_after == null ? null : String(error.details.retry_after));
            const delay = retryDelay(retryAfter, attempt);
            if (!canRetry || monthlyQuota || !transient || attempt >= 3 || Date.now() + delay >= deadline)
                throw error;
            await pause(delay);
        }
    }
    async function storage(url, init = {}) {
        for (let redirects = 0; redirects < 5; redirects++) {
            const target = new URL(url);
            if (target.protocol !== 'https:' || target.username || target.password)
                throw new Error('Storage URL must use HTTPS without embedded credentials.');
            const headers = new Headers(init.headers);
            if (headers.has('Authorization') || headers.has('Cookie'))
                throw new Error('Credentials must not be sent to object storage.');
            const response = await transport(target, { ...init, headers, redirect: 'manual', signal: AbortSignal.timeout(30000) });
            if ([301, 302, 303, 307, 308].includes(response.status) && (init.method ?? 'GET') === 'GET') {
                const location = response.headers.get('Location');
                await response.body?.cancel();
                if (!location)
                    throw new Error('Storage redirect is missing a location.');
                url = new URL(location, target).href;
                continue;
            }
            if (!response.ok)
                throw new Error(`Storage request returned HTTP ${response.status}.`);
            return response;
        }
        throw new Error('Too many storage redirects.');
    }
    async function readFile(id, path, maxBytes = MAX_BYTES) {
        const query = new URLSearchParams({ path: safePath(path), content_url: '1' });
        const { url } = await api(`/api/v1/buckets/${bucketId(id)}/files/by_path?${query}`);
        const response = await storage(url);
        if (Number(response.headers.get('Content-Length')) > maxBytes) {
            await response.body?.cancel();
            throw new Error('File exceeds the example download size limit.');
        }
        const reader = response.body?.getReader();
        if (!reader)
            throw new Error('Storage response has no body.');
        const chunks = [];
        let size = 0;
        try {
            while (true) {
                const { done, value } = await reader.read();
                if (done)
                    break;
                size += value.byteLength;
                if (size > maxBytes)
                    throw new Error('File exceeds the example download size limit.');
                chunks.push(value);
            }
        }
        finally {
            await reader.cancel();
        }
        return Buffer.concat(chunks);
    }
    async function listFiles(id, query = '') {
        const files = [];
        let offset = 0;
        for (let page = 0; page < 1000; page++) {
            const params = new URLSearchParams({ limit: '100', offset: String(offset), q: query });
            const result = await api(`/api/v1/buckets/${bucketId(id)}/files?${params}`);
            files.push(...result.files);
            if (!result.pagination.has_more)
                return files;
            if (result.pagination.next_offset == null || result.pagination.next_offset <= offset)
                throw new Error('File pagination did not advance.');
            offset = result.pagination.next_offset;
        }
        throw new Error('Example pagination limit reached.');
    }
    async function waitForInbox(id, timeoutMs = 120000) {
        const deadline = Date.now() + timeoutMs;
        while (Date.now() < deadline) {
            const inbox = await api(`/api/v1/buckets/${bucketId(id)}/inbound_email`, { timeoutMs: Math.min(30000, deadline - Date.now()) });
            if (inbox.ready)
                return inbox;
            if (inbox.blocked_reason && inbox.blocked_reason !== 'routing_pending')
                throw new Error(`Receiving is blocked: ${inbox.blocked_reason}. Check inbox settings.`);
            await pause(Math.min(2000, Math.max(0, deadline - Date.now())));
        }
        throw new Error('Receiving is still pending. Re-run with the same creation key or check the existing inbox.');
    }
    async function uploadFile(id, path, bytes, contentType = 'application/octet-stream') {
        safePath(path);
        bucketId(id);
        if (bytes.length > MAX_BYTES)
            throw new Error('This example supports files up to 64 MiB; account limits also apply.');
        const descriptor = await api('/api/v1/direct_uploads', {
            method: 'POST', body: { bucket_id: id, path, blob: { filename: basename(path), byte_size: bytes.length,
                    checksum: createHash('md5').update(bytes).digest('base64'), sha256: createHash('sha256').update(bytes).digest('hex'), content_type: contentType, purpose: 'bucket_file' } },
        });
        await storage(descriptor.direct_upload.url, { method: 'PUT', headers: descriptor.direct_upload.headers, body: new Uint8Array(bytes) });
        await api(`/api/v1/buckets/${id}/files`, { method: 'POST', body: { path, signed_blob_id: descriptor.signed_id } });
    }
    return { api, readFile, listFiles, waitForInbox, uploadFile };
}
export async function saveAttachment(directory, index, attachment, bytes) {
    safePath(attachment);
    await mkdir(directory, { recursive: true, mode: 0o700 });
    const name = basename(attachment).replace(/[^A-Za-z0-9._-]/g, '_');
    const target = resolve(directory, `${index + 1}-${name}`);
    await writeFile(target, bytes, { flag: 'wx', mode: 0o600 });
    return target;
}
export async function run(main) {
    try {
        await main();
    }
    catch (error) {
        if (error instanceof ApiError) {
            console.error(`${error.code}: ${error.message}`);
            if (error.details.resets_at)
                console.error(`Allowance resets at ${error.details.resets_at}.`);
            if (error.requestId)
                console.error(`Support request ID: ${error.requestId}`);
        }
        else
            console.error(error instanceof Error ? error.message : 'Example failed.');
        process.exitCode = 1;
    }
}
