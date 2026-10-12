import { Revdoku } from "@revdoku/api";

const key = process.env.REVDOKU_API_KEY;
const id = process.env.REVDOKU_BUCKET_ID;
if (!key || !id) throw new Error("Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID");
const api = new Revdoku({ apiKey: key, accountId: process.env.REVDOKU_ACCOUNT_ID || undefined });
let cursor: string | undefined;
const seen = new Set<string>();
for (;;) {
  const { data: page } = await api.listFiles({
    mailboxId: id,
    limit: 100,
    cursor,
    accountId: process.env.REVDOKU_ACCOUNT_ID || undefined,
  });
  for (const file of page.files) console.log(JSON.stringify(file));
  if (!page.pagination.hasMore) break;
  cursor = page.pagination.nextCursor ?? undefined;
  if (!cursor || seen.has(cursor))
    throw new Error("File pagination did not advance");
  seen.add(cursor);
}
