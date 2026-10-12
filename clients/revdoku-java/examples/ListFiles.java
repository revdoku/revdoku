import com.revdoku.api.ApiClient;
import com.revdoku.api.endpoints.DefaultApi;
import java.util.HashSet;

public class ListFiles {
    public static void main(String[] args) throws Exception {
        String key = System.getenv("REVDOKU_API_KEY");
        String mailbox = System.getenv("REVDOKU_BUCKET_ID");
        if (key == null || key.isEmpty() || mailbox == null || mailbox.isEmpty()) throw new IllegalArgumentException("Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID");
        String account = System.getenv("REVDOKU_ACCOUNT_ID");
        var client = new ApiClient().setRequestInterceptor(request -> request.header("Authorization", "Bearer " + key));
        var api = new DefaultApi(client);
        String cursor = null;
        var seen = new HashSet<String>();
        while (true) {
            var page = api.listFiles(mailbox, account == null || account.isEmpty() ? null : account, null, null, null, 100, cursor).getData();
            for (var file : page.getFiles()) System.out.println(client.getObjectMapper().writeValueAsString(file));
            if (!page.getPagination().getHasMore()) break;
            cursor = page.getPagination().getNextCursor();
            if (cursor == null || cursor.isEmpty() || !seen.add(cursor)) throw new IllegalStateException("File pagination did not advance");
        }
    }
}
