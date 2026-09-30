// Shared example helpers. Edit TypeScript, then run npm run build in examples/.
import { createHash } from 'node:crypto';
import { mkdir, writeFile } from 'node:fs/promises';
import { basename, resolve } from 'node:path';
const API_ORIGIN = 'https://api.revdoku.com';
const APP_ORIGIN = 'https://app.revdoku.com';
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
export function emailId(value) {
    if (!/^eml_[A-Za-z0-9]+$/.test(value))
        throw new Error('Expected an eml_ email identifier.');
    return value;
}
const sleep = (ms) => new Promise(resolve => setTimeout(resolve, ms));
export function retryDelay(value, attempt) {
    if (value) {
        const seconds = Number(value);
        const delay = Number.isFinite(seconds) ? seconds * 1000 : Date.parse(value) - Date.now();
        if (Number.isFinite(delay))
            return Math.max(0, delay);
    }
    return Math.min(500 * 2 ** attempt, 5000) + Math.floor(Math.random() * 250);
}
export function createClient() {
    const apiKey = requiredEnv('REVDOKU_API_KEY');
    const accountId = process.env.REVDOKU_ACCOUNT_ID?.trim();
    if (accountId && !/^acct_[A-Za-z0-9]+$/.test(accountId))
        throw new Error('Invalid account identifier.');
    async function api(path, opts = {}) {
        if (!path.startsWith('/v1/'))
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
                response = await fetch(url, {
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
                await sleep(500);
                continue;
            }
            const payload = await response.json().catch(() => ({}));
            if (response.ok) {
                if (payload.success !== true || payload.data === undefined || payload.error !== undefined)
                    throw new Error('Invalid API success response.');
                return payload.data;
            }
            const error = new ApiError(response.status, payload.error?.code ?? 'HTTP_ERROR', payload.error?.message ?? `HTTP ${response.status}`, payload.error?.details, payload.error?.request_id);
            const details = Array.isArray(error.details) ? {} : error.details;
            const monthlyQuota = error.code === 'BUCKET_CREATION_LIMIT_REACHED' || typeof details.resets_at === 'string';
            const transient = response.status === 429 || [502, 503, 504].includes(response.status) ||
                (response.status === 409 && ['DATABASE_BUSY_RETRY', 'BUCKET_FILE_PATH_INDEX_BACKFILL_PENDING'].includes(error.code));
            const retryAfter = response.headers.get('Retry-After') ?? (details.retry_after == null ? null : String(details.retry_after));
            const delay = retryDelay(retryAfter, attempt);
            if (!canRetry || monthlyQuota || !transient || attempt >= 3 || Date.now() + delay >= deadline)
                throw error;
            await sleep(delay);
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
            const response = await fetch(target, { ...init, headers, redirect: 'manual', signal: AbortSignal.timeout(30000) });
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
        const { url } = await api(`/v1/buckets/${bucketId(id)}/files/by_path?${query}`);
        const response = await storage(url);
        return readBytes(response, maxBytes);
    }
    async function readBytes(response, maxBytes = MAX_BYTES) {
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
    async function listEmails(id, cursor) {
        const params = new URLSearchParams({ limit: '100', ...(cursor ? { cursor } : {}) });
        return api(`/v1/buckets/${bucketId(id)}/emails?${params}`);
    }
    async function readEmail(id, messageId, background = false) {
        const { email } = await api(`/v1/buckets/${bucketId(id)}/emails/${emailId(messageId)}?purpose=${background ? 'background' : 'open'}`);
        return email;
    }
    async function downloadEmail(id, messageId, attachmentId) {
        if (attachmentId && !/^df_[A-Za-z0-9]+$/.test(attachmentId))
            throw new Error('Invalid attachment identifier.');
        const path = `/v1/buckets/${bucketId(id)}/emails/${emailId(messageId)}/${attachmentId ? `attachments/${attachmentId}` : 'raw'}`;
        const { download } = await api(path);
        let response;
        if (download.authentication === 'bearer') {
            const url = new URL(download.url);
            // Protected downloads may use the app's original Rails route.
            const approved = (url.origin === API_ORIGIN && url.pathname === path) ||
                (url.origin === APP_ORIGIN && url.pathname === `/api${path}`);
            if (!approved || url.username || url.password)
                throw new Error('Invalid authenticated download URL.');
            if (accountId)
                url.searchParams.set('account_id', accountId);
            response = await fetch(url, { redirect: 'error', signal: AbortSignal.timeout(30000),
                headers: { Authorization: `Bearer ${apiKey}` } });
            if (!response.ok)
                throw new Error(`Download returned HTTP ${response.status}.`);
        }
        else if (download.authentication === 'none') {
            response = await storage(download.url);
        }
        else
            throw new Error('Unknown download authentication mode.');
        return readBytes(response);
    }
    async function listFiles(id, query = '') {
        const files = [];
        let offset = 0;
        for (let page = 0; page < 1000; page++) {
            const params = new URLSearchParams({ limit: '100', offset: String(offset), q: query });
            const result = await api(`/v1/buckets/${bucketId(id)}/files?${params}`);
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
            const inbox = await api(`/v1/buckets/${bucketId(id)}/email`, { timeoutMs: Math.min(30000, deadline - Date.now()) });
            if (inbox.ready)
                return inbox;
            if (inbox.blocked_reason && inbox.blocked_reason !== 'routing_pending')
                throw new Error(`Receiving is blocked: ${inbox.blocked_reason}. Check inbox settings.`);
            await sleep(Math.min(2000, Math.max(0, deadline - Date.now())));
        }
        throw new Error('Receiving is still pending. Re-run with the same creation key or check the existing inbox.');
    }
    async function uploadFile(id, path, bytes, contentType = 'application/octet-stream') {
        safePath(path);
        bucketId(id);
        if (bytes.length > MAX_BYTES)
            throw new Error('This example supports files up to 64 MiB; account limits also apply.');
        const descriptor = await api('/v1/direct_uploads', {
            method: 'POST', body: { bucket_id: id, path, blob: { filename: basename(path), byte_size: bytes.length,
                    checksum: createHash('md5').update(bytes).digest('base64'), sha256: createHash('sha256').update(bytes).digest('hex'), content_type: contentType, purpose: 'bucket_file' } },
        });
        await storage(descriptor.direct_upload.url, { method: 'PUT', headers: descriptor.direct_upload.headers, body: new Uint8Array(bytes) });
        await api(`/v1/buckets/${id}/files`, { method: 'POST', body: { path, signed_blob_id: descriptor.signed_id } });
    }
    return { api, readFile, listFiles, listEmails, readEmail, downloadEmail, waitForInbox, uploadFile };
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
            if (!Array.isArray(error.details) && error.details.resets_at)
                console.error(`Allowance resets at ${error.details.resets_at}.`);
            if (error.requestId)
                console.error(`Support request ID: ${error.requestId}`);
        }
        else
            console.error(error instanceof Error ? error.message : 'Example failed.');
        process.exitCode = 1;
    }
}
