using Revdoku.Api.Api;
using Revdoku.Api.Client;

var key = Environment.GetEnvironmentVariable("REVDOKU_API_KEY");
if (string.IsNullOrEmpty(key)) throw new Exception("Set REVDOKU_API_KEY");
var account = Environment.GetEnvironmentVariable("REVDOKU_ACCOUNT_ID");
var api = new DefaultApi(new Configuration { AccessToken = key });
string? cursor = null;
var seen = new HashSet<string>();
while (true) {
    var page = (await api.ListMailboxesAsync(accountId: string.IsNullOrEmpty(account) ? null : account, status: "active", limit: 100, cursor: cursor)).Data;
    foreach (var mailbox in page.Mailboxes) Console.WriteLine($"{mailbox.Id} {mailbox.Email?.Address ?? mailbox.Id}");
    if (!page.Pagination.HasMore) break;
    cursor = page.Pagination.NextCursor;
    if (string.IsNullOrEmpty(cursor) || !seen.Add(cursor)) throw new Exception("Mailbox pagination did not advance");
}
