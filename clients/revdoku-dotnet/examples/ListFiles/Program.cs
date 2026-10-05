using Newtonsoft.Json;
using Revdoku.Api.Api;
using Revdoku.Api.Client;

var key = Environment.GetEnvironmentVariable("REVDOKU_API_KEY");
var mailbox = Environment.GetEnvironmentVariable("REVDOKU_BUCKET_ID");
if (string.IsNullOrEmpty(key) || string.IsNullOrEmpty(mailbox)) throw new Exception("Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID");
var account = Environment.GetEnvironmentVariable("REVDOKU_ACCOUNT_ID");
var api = new DefaultApi(new Configuration { AccessToken = key });
var offset = 0;
while (true)
{
    var page = (await api.ListMailboxFilesAsync(mailbox, limit: 100, offset: offset,
        accountId: string.IsNullOrEmpty(account) ? null : account)).Data;
    foreach (var file in page.Files) Console.WriteLine(JsonConvert.SerializeObject(file));
    if (!page.Pagination.HasMore) break;
    var next = page.Pagination.NextOffset;
    if (next == null || next <= offset) throw new Exception("File pagination did not advance");
    offset = next.Value;
}
