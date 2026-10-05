using Revdoku.Api.Api;
using Revdoku.Api.Client;

var key = Environment.GetEnvironmentVariable("REVDOKU_API_KEY");
if (string.IsNullOrEmpty(key)) throw new Exception("Set REVDOKU_API_KEY");
var account = Environment.GetEnvironmentVariable("REVDOKU_ACCOUNT_ID");
var api = new DefaultApi(new Configuration { AccessToken = key });
var result = await api.ListMailboxesAsync(string.IsNullOrEmpty(account) ? null : account);
foreach (var mailbox in result.Data.Mailboxes) Console.WriteLine($"{mailbox.Id} {mailbox.Email?.Address ?? mailbox.Id}");
