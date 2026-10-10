import { Revdoku } from "@revdoku/api";

const key = process.env.REVDOKU_API_KEY;
if (!key) throw new Error("Set REVDOKU_API_KEY");
const api = new Revdoku({ apiKey: key, accountId: process.env.REVDOKU_ACCOUNT_ID || undefined });
let offset = 0;
for (;;) {
  const { data: page } = await api.listMailboxes({ accountId: process.env.REVDOKU_ACCOUNT_ID || undefined, status: "active", limit: 100, offset });
  for (const mailbox of page.mailboxes) console.log(mailbox.id, mailbox.email?.address || mailbox.id);
  if (!page.pagination.hasMore) break;
  const next = page.pagination.nextOffset;
  if (next == null || next <= offset) throw new Error("Mailbox pagination did not advance");
  offset = next;
}
