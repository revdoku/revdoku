import com.revdoku.api.ApiClient;
import com.revdoku.api.endpoints.DefaultApi;

public class ListFiles {
    public static void main(String[] args) throws Exception {
        String key = System.getenv("REVDOKU_API_KEY");
        String mailbox = System.getenv("REVDOKU_BUCKET_ID");
        if (key == null || key.isEmpty() || mailbox == null || mailbox.isEmpty()) throw new IllegalArgumentException("Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID");
        String account = System.getenv("REVDOKU_ACCOUNT_ID");
        var client = new ApiClient().setRequestInterceptor(request -> request.header("Authorization", "Bearer " + key));
        var api = new DefaultApi(client);
        int offset = 0;
        while (true) {
            var page = api.listMailboxFiles(mailbox, 100, offset, null, null, null, account == null || account.isEmpty() ? null : account).getData();
            for (var file : page.getFiles()) System.out.println(client.getObjectMapper().writeValueAsString(file));
            if (!page.getPagination().getHasMore()) break;
            Integer next = page.getPagination().getNextOffset();
            if (next == null || next <= offset) throw new IllegalStateException("File pagination did not advance");
            offset = next;
        }
    }
}
