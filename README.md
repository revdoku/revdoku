<p align="center">
  <img src="apps/web/public/icon.svg" width="96" alt="Revdoku" />
</p>

<h1 align="center">Revdoku</h1>

<p align="center">
  <strong>Open-source AI document review.</strong>
</p>

<p align="center">
  <a href="https://revdoku.com"><img alt="Hosted" src="https://img.shields.io/badge/hosted-revdoku.com-2563eb" /></a>
  <a href="LICENSE"><img alt="License: AGPL-3.0" src="https://img.shields.io/badge/license-AGPL--3.0-blue" /></a>
  <img alt="Ruby" src="https://img.shields.io/badge/ruby-3.4.5-red" />
  <img alt="Node" src="https://img.shields.io/badge/node-20+-339933" />
</p>

Revdoku helps you review important documents. Upload a file, run a checklist,
and see the issues Revdoku finds. It can check rules line by line, compare
values with reference files, run custom scripts, and create reports.

## Quick Install

The easiest local install is one command. You need Docker Desktop first.

Open Terminal on macOS or Linux. On Windows, open WSL. Then run:

```bash
curl -fsSL https://raw.githubusercontent.com/revdoku/revdoku/main/install-local.sh | sh
```

The installer will:

- create a local data folder at `~/.revdoku`
- create the secrets needed to encrypt your data
- start Revdoku in Docker
- open a one-time local sign-in link

No email or password is needed for the local single-user install.

## Run It Again

After install, use this command any time:

```bash
~/.revdoku/revdoku open
```

This starts Revdoku if needed and opens a fresh local sign-in link.

Useful commands:

```bash
~/.revdoku/revdoku start
~/.revdoku/revdoku stop
~/.revdoku/revdoku logs
~/.revdoku/revdoku update
~/.revdoku/revdoku backup
```

The local app only listens on `127.0.0.1`. The installer uses the first free
port starting at `3217` and saves it in `~/.revdoku/revdoku.env`.

## Backups

Your local data is encrypted. Keep `revdoku.env` and `storage/` together.

To make a backup:

```bash
~/.revdoku/revdoku backup
```

Do not copy only `storage/`. The `revdoku.env` file has the key needed to read
your documents and saved provider keys.

## Demo Video

<p align="center">
  <video src="https://github.com/user-attachments/assets/15f4de25-3b73-47ea-8f6a-c73e436907e8" controls width="720"></video>
</p>

<p align="center">
  <a href="https://github.com/user-attachments/assets/15f4de25-3b73-47ea-8f6a-c73e436907e8">Watch the demo video</a>
</p>

## Features

- **Checklist review.** Check a document against your own rules.
- **Precise highlights.** See the exact line, number, or clause that needs review.
- **Cross-document checks.** Compare a document with a quote, agreement, policy, or other reference file.
- **Revision tracking.** Upload a new version and keep track of what changed.
- **Reports and public links.** Export reports or create public report links.
- **Custom scripts.** Add small scripts for checks such as totals, counts, and categories.
- **Cloud or local AI.** Use cloud AI providers or local tools such as LM Studio and Ollama.
- **Email upload.** Send files to a per-account email address for upload.
- **Encryption.** Documents and sensitive data are encrypted at rest.

## Hosted Cloud

You can also use Revdoku without installing anything:

<https://app.revdoku.com>

Use the hosted version if you do not want to install Docker, run a server, or
manage backups.

## Local Install Details

The local installer creates this folder:

```text
~/.revdoku
```

It contains:

- `revdoku.env` - local secrets and encryption keys
- `compose.yml` - Docker Compose config
- `storage/` - SQLite databases and uploaded files
- `revdoku` - helper command

Native Windows PowerShell install is experimental. WSL is recommended on
Windows.

PowerShell command:

```powershell
Invoke-WebRequest -UseBasicParsing https://raw.githubusercontent.com/revdoku/revdoku/main/install-local.ps1 -OutFile "$env:TEMP\revdoku-install-local.ps1"; powershell -ExecutionPolicy Bypass -File "$env:TEMP\revdoku-install-local.ps1"
```

## Self-Host on a Server

Use this path for a private team server, VPS, homelab, or internal network
install.

You need:

- a Linux server
- Docker Engine and the Docker Compose plugin
- a domain or internal hostname
- HTTPS from Caddy, nginx, Traefik, Cloudflare Tunnel, or another proxy

1. Clone the repo:

   ```bash
   git clone https://github.com/revdoku/revdoku.git
   cd revdoku
   ```

2. Create your config:

   ```bash
   cp env.example .env.local
   ```

3. Edit `.env.local`.

   Fill in every `[REQUIRED]` value. At minimum, set the secrets, the first
   admin user, and the public URL:

   ```bash
   APP_HOST=revdoku.yourdomain.com
   APP_PROTOCOL=https
   ```

   If HTTPS ends at your proxy, also set:

   ```bash
   REVDOKU_FORCE_SSL=true
   ```

4. Start Revdoku:

   ```bash
   ./bin/start -d
   ```

5. Point your HTTPS proxy to:

   ```text
   http://127.0.0.1:3000
   ```

Before you invite users:

- Back up `.env.local` and the Docker volume `revdoku_storage` together.
- Do not run `docker compose down -v` unless you want to delete local data.
- For a private server, set `REVDOKU_REGISTRATION_ENABLED=false` after you create the first admin user.
- Configure SMTP if you need email confirmation, password reset, or invitations.
- Configure AI provider keys in **Account -> AI -> Providers**, or set operator-wide keys in `.env.local`.

## Manual Install From Source

Use this path only if you want to edit the code or build the image yourself.

You need:

- Docker Desktop, or Docker Engine on Linux
- Git
- WSL if you are on Windows

1. Clone the repo:

   ```bash
   git clone https://github.com/revdoku/revdoku.git
   cd revdoku
   ```

2. Create your config:

   ```bash
   cp env.example .env.local
   ```

3. Open `.env.local` in a text editor.

   Fill in every `[REQUIRED]` value. The file includes commands for creating
   secure random secrets.

4. Start Revdoku:

   ```bash
   ./bin/start
   ```

5. Open:

   ```text
   http://localhost:3000
   ```

6. Sign in with the admin email and password from `.env.local`.

To force a local build instead of using the prebuilt image:

```bash
./bin/start --build
```

## AI Providers

You can add provider keys inside the app:

```text
Account -> AI -> Providers
```

Supported options include:

- OpenAI
- Google Cloud
- OpenRouter
- local LLMs such as LM Studio and Ollama
- custom LLM providers

When Revdoku runs in Docker and your local LLM runs on the same computer, use
`host.docker.internal` instead of `localhost`.

Examples:

```text
http://host.docker.internal:1234/v1
http://host.docker.internal:11434/v1
```

## Public Report Links

Core includes public `/shared/<token>` report links.

To disable report sharing for the whole install:

```bash
SHARE_REPORT_ENABLED=false
```

Without `AWS_S3_SHARED_BUCKET`, self-hosted installs store shared snapshots on
local disk under `storage/shared_reports/`.

## Configuration

All configuration uses environment variables.

See [env.example](https://github.com/revdoku/revdoku/blob/main/env.example) for
the full list.

## Security

- Documents and sensitive database fields are encrypted at rest.
- Local installs use SQLite.
- Two-factor authentication is available.
- Logs are available at `/logs`.
- Revdoku has no telemetry.

For HIPAA or BAA needs, use the hosted version:

<https://revdoku.com>

Report security issues privately:

<security@revdoku.com>

Please do not open public GitHub issues for security reports.

## More Demos

Full playlist on YouTube:

<https://www.youtube.com/playlist?list=PLoSGpfRUg7ywQ7kbEiCuXNI5nN-CRxbZe>

## Contributing

Bug reports and pull requests are welcome. For large changes, please open a
GitHub Discussion first.

## License

Revdoku is licensed under AGPLv3. See [LICENSE](./LICENSE).

A commercial license is also available. Contact:

<sales@revdoku.com>

---

Hosted version: <https://revdoku.com> · Issues: <https://github.com/revdoku/revdoku/issues>
