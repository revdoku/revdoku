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
        let page = default_api::list_files(
            &config,
            &mailbox,
            account.as_deref(),
            None,
            None,
            None,
            Some(100),
            cursor.as_deref(),
        )
        .await?
        .data;
        for file in page.files {
            println!("{}", serde_json::to_string(&file)?);
        }
        if !page.pagination.has_more {
            break;
        }
        let next = page.pagination.next_cursor.unwrap_or_default();
        if next.is_empty() || !seen.insert(next.clone()) {
            return Err("File pagination did not advance".into());
        }
        cursor = Some(next);
    }
    Ok(())
}
