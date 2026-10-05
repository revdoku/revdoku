use revdoku_api::apis::{configuration::Configuration, default_api};

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
    let result = default_api::list_mailboxes(&config, account.as_deref(), None, None).await?;
    for mailbox in result.data.mailboxes {
        println!("{} {}", mailbox.id, mailbox.email.address.flatten().unwrap_or_default());
    }
    Ok(())
}
