using Revdoku.Api.Api;
using Revdoku.Api.Client;

var key = Environment.GetEnvironmentVariable("REVDOKU_API_KEY");
if (string.IsNullOrEmpty(key)) throw new Exception("Set REVDOKU_API_KEY");
var account = Environment.GetEnvironmentVariable("REVDOKU_ACCOUNT_ID");
var api = new DefaultApi(new Configuration { AccessToken = key });
var offset = 0;
while (true) {
    var page = (await api.ListMailboxesAsync(accountId: string.IsNullOrEmpty(account) ? null : account, status: "active", limit: 100, offset: offset)).Data;
    foreach (var mailbox in page.Mailboxes) Console.WriteLine($"{mailbox.Id} {mailbox.Email?.Address ?? mailbox.Id}");
    if (!page.Pagination.HasMore) break;
    var next = page.Pagination.NextOffset;
    if (next == null || next <= offset) throw new Exception("Mailbox pagination did not advance");
    offset = next.Value;
}
