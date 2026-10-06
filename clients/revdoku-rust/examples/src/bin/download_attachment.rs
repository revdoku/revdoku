use revdoku_api::{
    apis::{configuration::Configuration, default_api},
    models::email_download::Authentication,
};
use std::{fs::OpenOptions, io::Write, time::Duration};

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let names = [
        "REVDOKU_API_KEY",
        "REVDOKU_BUCKET_ID",
        "REVDOKU_EMAIL_ID",
        "REVDOKU_ATTACHMENT_ID",
        "REVDOKU_DOWNLOAD_PATH",
    ];
    let values = names
        .iter()
        .map(std::env::var)
        .collect::<Result<Vec<_>, _>>()?;
    if values.iter().any(|value| value.is_empty()) {
        return Err("Set all required environment variables".into());
    }
    let account = std::env::var("REVDOKU_ACCOUNT_ID")
        .ok()
        .filter(|s| !s.is_empty());
    let config = Configuration {
        bearer_access_token: Some(values[0].clone()),
        ..Configuration::default()
    };
    let download = default_api::get_email_attachment_download_url(
        &config,
        &values[1],
        &values[2],
        &values[3],
        account.as_deref(),
        None,
        None,
    )
    .await?
    .data
    .download;
    let url = reqwest::Url::parse(&download.url)?;
    if download.authentication != Authentication::None
        || url.scheme() != "https"
        || url.host_str().is_none()
        || !url.username().is_empty()
        || url.password().is_some()
    {
        return Err("Expected an HTTPS download without API authentication".into());
    }
    // Separate client: no API bearer token, and no redirects on the signed URL.
    let http = reqwest::Client::builder()
        .timeout(Duration::from_secs(60))
        .redirect(reqwest::redirect::Policy::none())
        .build()?;
    let response = http.get(url).send().await?;
    if response.status() != reqwest::StatusCode::OK {
        return Err(format!("Download failed: HTTP {}", response.status()).into());
    }
    let bytes = response.bytes().await?;
    let mut file = OpenOptions::new()
        .write(true)
        .create_new(true)
        .open(&values[4])?;
    file.write_all(&bytes)?;
    println!("{}", values[4]);
    Ok(())
}
