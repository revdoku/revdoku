using Revdoku.Api.Api;
using Revdoku.Api.Client;
using Revdoku.Api.Model;

var names = new[] { "REVDOKU_API_KEY", "REVDOKU_BUCKET_ID", "REVDOKU_EMAIL_ID", "REVDOKU_ATTACHMENT_ID", "REVDOKU_DOWNLOAD_PATH" };
var values = names.Select(name => Environment.GetEnvironmentVariable(name)).ToArray();
if (values.Any(string.IsNullOrEmpty)) throw new Exception("Set all required environment variables");
var account = Environment.GetEnvironmentVariable("REVDOKU_ACCOUNT_ID");
var api = new DefaultApi(new Configuration { AccessToken = values[0] });
var download = (await api.DownloadEmailAttachmentAsync(values[1]!, values[2]!, values[3]!,
    accountId: string.IsNullOrEmpty(account) ? null : account)).Data.Download;
var url = new Uri(download.Url);
if (download.Authentication != EmailDownload.AuthenticationEnum.None || url.Scheme != "https" || url.UserInfo.Length > 0)
    throw new Exception("Expected an HTTPS download without API authentication");
// A separate client sends no API bearer token and follows no redirects.
using var handler = new HttpClientHandler { AllowAutoRedirect = false };
using var http = new HttpClient(handler) { Timeout = TimeSpan.FromSeconds(60) };
using var response = await http.GetAsync(url);
if (response.StatusCode != System.Net.HttpStatusCode.OK)
    throw new Exception($"Download failed: HTTP {(int)response.StatusCode}");
var bytes = await response.Content.ReadAsByteArrayAsync();
using var file = new FileStream(values[4]!, FileMode.CreateNew, FileAccess.Write);
await file.WriteAsync(bytes);
Console.WriteLine(values[4]);
