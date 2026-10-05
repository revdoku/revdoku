import com.revdoku.api.ApiClient;
import com.revdoku.api.endpoints.DefaultApi;
import java.util.HashSet;
import java.util.LinkedHashMap;

public class ReadEmails {
    public static void main(String[] args) throws Exception {
        String key = System.getenv("REVDOKU_API_KEY");
        String mailbox = System.getenv("REVDOKU_BUCKET_ID");
        if (key == null || key.isEmpty() || mailbox == null || mailbox.isEmpty()) throw new IllegalArgumentException("Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID");
        String account = System.getenv("REVDOKU_ACCOUNT_ID");
        if (account != null && account.isEmpty()) account = null;
        var client = new ApiClient().setRequestInterceptor(request -> request.header("Authorization", "Bearer " + key));
        var api = new DefaultApi(client);
        String cursor = null;
        var seen = new HashSet<String>();
        while (true) {
            var page = api.listEmails(mailbox, account, 100, cursor, "asc", null, null, null, null, false, null, null, null).getData();
            for (var summary : page.getEmails()) {
                var email = api.getEmail(mailbox, summary.getId(), account, null, null, null).getData().getEmail();
                var output = new LinkedHashMap<String, Object>();
                output.put("id", email.getId());
                output.put("subject", email.getSubject());
                output.put("body_status", email.getBodyStatus());
                output.put("body_text", email.getBodyText());
                output.put("attachments", email.getAttachments());
                System.out.println(client.getObjectMapper().writeValueAsString(output));
            }
            if (!page.getPagination().getHasMore()) break;
            cursor = page.getPagination().getNextCursor();
            if (cursor == null || cursor.isEmpty() || !seen.add(cursor)) throw new IllegalStateException("Email pagination did not advance");
        }
        // Reading does not change shared read/unread status.
    }
}
