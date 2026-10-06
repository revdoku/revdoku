import com.revdoku.api.ApiClient;
import com.revdoku.api.endpoints.DefaultApi;
import com.revdoku.api.model.EmailDownload;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.time.Duration;

public class DownloadAttachment {
    public static void main(String[] args) throws Exception {
        String[] names = {"REVDOKU_API_KEY", "REVDOKU_BUCKET_ID", "REVDOKU_EMAIL_ID", "REVDOKU_ATTACHMENT_ID", "REVDOKU_DOWNLOAD_PATH"};
        for (String name : names) if (System.getenv(name) == null || System.getenv(name).isEmpty()) throw new IllegalArgumentException("Set " + name);
        String key = System.getenv("REVDOKU_API_KEY");
        String account = System.getenv("REVDOKU_ACCOUNT_ID");
        var client = new ApiClient().setRequestInterceptor(request -> request.header("Authorization", "Bearer " + key));
        var download = new DefaultApi(client).getEmailAttachmentDownloadUrl(System.getenv("REVDOKU_BUCKET_ID"),
            System.getenv("REVDOKU_EMAIL_ID"), System.getenv("REVDOKU_ATTACHMENT_ID"),
            account == null || account.isEmpty() ? null : account, null, null).getData().getDownload();
        var url = URI.create(download.getUrl().toString());
        if (download.getAuthentication() != EmailDownload.AuthenticationEnum.NONE || !"https".equals(url.getScheme()) || url.getHost() == null || url.getUserInfo() != null)
            throw new IllegalArgumentException("Expected an HTTPS download without API authentication");
        // This separate client has no API bearer token and follows no redirects.
        var http = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(30)).followRedirects(HttpClient.Redirect.NEVER).build();
        var response = http.send(HttpRequest.newBuilder(url).timeout(Duration.ofSeconds(60)).GET().build(), HttpResponse.BodyHandlers.ofByteArray());
        if (response.statusCode() != 200) throw new IllegalStateException("Download failed: HTTP " + response.statusCode());
        Files.write(Path.of(System.getenv("REVDOKU_DOWNLOAD_PATH")), response.body(), StandardOpenOption.CREATE_NEW);
        System.out.println(System.getenv("REVDOKU_DOWNLOAD_PATH"));
    }
}
