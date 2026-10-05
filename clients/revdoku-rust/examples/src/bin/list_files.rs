use revdoku_api::apis::{configuration::Configuration, default_api};

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
    let mut offset = 0;
    loop {
        let page = default_api::list_mailbox_files(
            &config,
            &mailbox,
            Some(100),
            Some(offset),
            None,
            None,
            None,
            account.as_deref(),
        )
        .await?
        .data;
        for file in page.files {
            println!("{}", serde_json::to_string(&file)?);
        }
        if !page.pagination.has_more {
            break;
        }
        let next = page.pagination.next_offset.ok_or("Missing next_offset")?;
        if next <= offset {
            return Err("File pagination did not advance".into());
        }
        offset = next;
    }
    Ok(())
}
