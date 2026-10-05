import com.revdoku.api.ApiClient;
import com.revdoku.api.endpoints.DefaultApi;

public class ListMailboxes {
    public static void main(String[] args) throws Exception {
        String key = System.getenv("REVDOKU_API_KEY");
        if (key == null || key.isEmpty()) throw new IllegalArgumentException("Set REVDOKU_API_KEY");
        String account = System.getenv("REVDOKU_ACCOUNT_ID");
        var client = new ApiClient().setRequestInterceptor(request -> request.header("Authorization", "Bearer " + key));
        var result = new DefaultApi(client).listMailboxes(account == null || account.isEmpty() ? null : account, false, null);
        for (var mailbox : result.getData().getMailboxes()) System.out.println(mailbox.getId() + " " + (mailbox.getEmail() == null ? mailbox.getId() : mailbox.getEmail().getAddress()));
    }
}
