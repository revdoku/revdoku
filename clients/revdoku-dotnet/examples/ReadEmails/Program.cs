using Newtonsoft.Json;
using Revdoku.Api.Api;
using Revdoku.Api.Client;

var key = Environment.GetEnvironmentVariable("REVDOKU_API_KEY");
var mailbox = Environment.GetEnvironmentVariable("REVDOKU_BUCKET_ID");
if (string.IsNullOrEmpty(key) || string.IsNullOrEmpty(mailbox)) throw new Exception("Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID");
var account = Environment.GetEnvironmentVariable("REVDOKU_ACCOUNT_ID");
if (string.IsNullOrEmpty(account)) account = null;
var api = new DefaultApi(new Configuration { AccessToken = key });
string? cursor = null;
var seen = new HashSet<string>();
while (true)
{
    var page = (await api.ListEmailsAsync(mailbox, accountId: account, limit: 100, order: "asc", read: false, cursor: cursor)).Data;
    foreach (var summary in page.Emails)
    {
        var email = (await api.GetEmailAsync(mailbox, summary.Id, accountId: account)).Data.Email;
        Console.WriteLine(JsonConvert.SerializeObject(new { id = email.Id, subject = email.Subject,
            body_status = email.BodyStatus, body_text = email.BodyText, attachments = email.Attachments }));
    }
    if (!page.Pagination.HasMore) break;
    cursor = page.Pagination.NextCursor;
    if (string.IsNullOrEmpty(cursor) || !seen.Add(cursor)) throw new Exception("Email pagination did not advance");
}
// Reading does not change shared read/unread status.
