use revdoku_api::{
    apis::{configuration::Configuration, default_api},
    models::{CreateMailboxRequest, CreateMailboxRequestMailbox},
};

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
    let mut mailbox = CreateMailboxRequestMailbox::new();
    mailbox.title = Some("Example mailbox".into());
    let mut body = CreateMailboxRequest::new(mailbox);
    body.account_id = std::env::var("REVDOKU_ACCOUNT_ID")
        .ok()
        .filter(|s| !s.is_empty());
    let result = match default_api::create_mailbox(&config, body).await {
        Ok(result) => result,
        Err(error) => {
            if let revdoku_api::apis::Error::ResponseError(response) = &error {
                eprintln!("HTTP {}: {}", response.status, response.content);
            }
            eprintln!("Creation was not confirmed. Check existing mailboxes before another creation attempt.");
            return Err(error.into());
        }
    };
    let mailbox = result.data.mailbox.ok_or("Missing mailbox")?;
    let address = mailbox
        .email
        .ok_or("Missing email")?
        .address
        .flatten()
        .ok_or("Missing email address")?;
    println!("{} {}", mailbox.id.ok_or("Missing mailbox ID")?, address);
    Ok(())
}
