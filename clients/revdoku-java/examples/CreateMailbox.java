import com.revdoku.api.ApiClient;
import com.revdoku.api.ApiException;
import com.revdoku.api.endpoints.DefaultApi;
import com.revdoku.api.model.CreateMailboxRequest;
import com.revdoku.api.model.CreateMailboxRequestMailbox;

public class CreateMailbox {
    public static void main(String[] args) throws Exception {
        String key = System.getenv("REVDOKU_API_KEY");
        if (key == null || key.isEmpty()) throw new IllegalArgumentException("Set REVDOKU_API_KEY");
        String account = System.getenv("REVDOKU_ACCOUNT_ID");
        var client = new ApiClient().setRequestInterceptor(request -> request.header("Authorization", "Bearer " + key));
        try {
            var result = new DefaultApi(client).createMailbox(new CreateMailboxRequest()
                .accountId(account == null || account.isEmpty() ? null : account)
                .mailbox(new CreateMailboxRequestMailbox()));
            System.out.println(result.getData().getMailbox().getId() + " " + result.getData().getMailbox().getEmail().getAddress());
        } catch (ApiException error) {
            System.err.println("HTTP " + error.getCode() + ": " + error.getResponseBody());
            if (error.getResponseHeaders() != null) {
                error.getResponseHeaders().firstValue("Retry-After")
                    .ifPresent(delay -> System.err.println("Retry-After: " + delay));
            }
            System.err.println("Creation was not confirmed. Check existing mailboxes before another creation attempt.");
            System.exit(1);
        }
    }
}
