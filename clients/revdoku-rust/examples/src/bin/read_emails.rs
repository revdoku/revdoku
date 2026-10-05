use revdoku_api::apis::{configuration::Configuration, default_api};
use std::collections::HashSet;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let key = std::env::var("REVDOKU_API_KEY")?;
    let mailbox = std::env::var("REVDOKU_BUCKET_ID")?;
    if key.is_empty() || mailbox.is_empty() {
        return Err("Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID".into());
    }
    let account = std::env::var("REVDOKU_ACCOUNT_ID")
        .ok()
        .filter(|s| !s.is_empty());
    let config = Configuration {
        bearer_access_token: Some(key),
        ..Configuration::default()
    };
    let mut cursor: Option<String> = None;
    let mut seen = HashSet::new();
    loop {
        let page = default_api::list_emails(
            &config,
            &mailbox,
            account.as_deref(),
            Some(100),
            cursor.as_deref(),
            Some("asc"),
            None,
            None,
            None,
            None,
            Some(false),
            None,
            None,
            None,
        )
        .await?
        .data;
        for summary in page.emails {
            let email = default_api::get_email(
                &config,
                &mailbox,
                &summary.id,
                account.as_deref(),
                None,
                None,
                None,
            )
            .await?
            .data
            .email;
            println!("{}", serde_json::to_string(&email)?);
        }
        if !page.pagination.has_more {
            break;
        }
        let next = page.pagination.next_cursor;
        if next.is_empty() || !seen.insert(next.clone()) {
            return Err("Email pagination did not advance".into());
        }
        cursor = Some(next);
    }
    // Reading does not change shared read/unread status.
    Ok(())
}
