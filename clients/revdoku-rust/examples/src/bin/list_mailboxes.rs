use revdoku_api::apis::{configuration::Configuration, default_api};
use std::collections::HashSet;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let key = std::env::var("REVDOKU_API_KEY")?;
    if key.is_empty() {
        return Err("Set REVDOKU_API_KEY".into());
    }
    let config = Configuration {
        bearer_access_token: Some(key),
        ..Configuration::default()
    };
    let account = std::env::var("REVDOKU_ACCOUNT_ID")
        .ok()
        .filter(|s| !s.is_empty());
    let mut cursor: Option<String> = None;
    let mut seen = HashSet::new();
    loop {
        let page = default_api::list_mailboxes(&config, account.as_deref(), None, Some("active"), None, Some(100), cursor.as_deref()).await?.data;
        for mailbox in page.mailboxes {
            println!("{} {}", mailbox.id, mailbox.email.address.unwrap_or_default());
        }
        if !page.pagination.has_more { break; }
        let next = page.pagination.next_cursor.unwrap_or_default();
        if next.is_empty() || !seen.insert(next.clone()) { return Err("Mailbox pagination did not advance".into()); }
        cursor = Some(next);
    }
    Ok(())
}
