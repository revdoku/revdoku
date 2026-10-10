import com.revdoku.api.ApiClient;
import com.revdoku.api.endpoints.DefaultApi;

public class ListMailboxes {
    public static void main(String[] args) throws Exception {
        String key = System.getenv("REVDOKU_API_KEY");
        if (key == null || key.isEmpty()) throw new IllegalArgumentException("Set REVDOKU_API_KEY");
        String account = System.getenv("REVDOKU_ACCOUNT_ID");
        var client = new ApiClient().setRequestInterceptor(request -> request.header("Authorization", "Bearer " + key));
        var api = new DefaultApi(client);
        int offset = 0;
        while (true) {
            var page = api.listMailboxes(account == null || account.isEmpty() ? null : account, null, "active", 100, offset).getData();
            for (var mailbox : page.getMailboxes()) System.out.println(mailbox.getId() + " " + (mailbox.getEmail() == null ? mailbox.getId() : mailbox.getEmail().getAddress()));
            if (!page.getPagination().getHasMore()) break;
            var next = page.getPagination().getNextOffset();
            if (next == null || next <= offset) throw new IllegalStateException("Mailbox pagination did not advance");
            offset = next;
        }
    }
}
