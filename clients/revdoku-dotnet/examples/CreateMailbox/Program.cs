using Revdoku.Api.Api;
using Revdoku.Api.Client;
using Revdoku.Api.Model;

var key = Environment.GetEnvironmentVariable("REVDOKU_API_KEY");
if (string.IsNullOrEmpty(key)) throw new Exception("Set REVDOKU_API_KEY");
var account = Environment.GetEnvironmentVariable("REVDOKU_ACCOUNT_ID");
var api = new DefaultApi(new Configuration { AccessToken = key });
try
{
    var result = await api.CreateMailboxAsync(new CreateMailboxRequest(
        accountId: string.IsNullOrEmpty(account) ? null : account,
        mailbox: new CreateMailboxRequestMailbox(title: "Example mailbox")));
    Console.WriteLine($"{result.Data.Mailbox.Id} {result.Data.Mailbox.Email.Address}");
}
catch (ApiException error)
{
    Console.Error.WriteLine($"HTTP {error.ErrorCode}: {error.ErrorContent}");
    if (error.Headers != null && error.Headers.TryGetValue("Retry-After", out var delay))
        Console.Error.WriteLine($"Retry-After: {string.Join(", ", delay)}");
    Console.Error.WriteLine("Creation was not confirmed. Check existing mailboxes before another creation attempt.");
    Environment.ExitCode = 1;
}
catch (Exception)
{
    Console.Error.WriteLine("Creation response unavailable. Check existing mailboxes before another creation attempt.");
    Environment.ExitCode = 1;
}
