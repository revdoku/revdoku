<p align="center">
  <img src="apps/web/public/icon.svg" width="96" alt="Revdoku" />
</p>

<h1 align="center">Revdoku</h1>

<p align="center">
  <strong>Open-source document review with AI.</strong>
</p>

<p align="center">
  <a href="https://revdoku.com"><img alt="Hosted" src="https://img.shields.io/badge/hosted-revdoku.com-2563eb" /></a>
  <a href="LICENSE"><img alt="License: AGPL-3.0" src="https://img.shields.io/badge/license-AGPL--3.0-blue" /></a>
  <img alt="Ruby" src="https://img.shields.io/badge/ruby-3.4.5-red" />
  <img alt="Node" src="https://img.shields.io/badge/node-20+-339933" />
</p>

Revdoku helps you review important documents visually, line by line. Upload a file, run a checklist, and see the issues Revdoku finds. It can check rules line by line, compare
values with reference files, run custom scripts, and create reports.

## Demo 

**Screenshot**

![Revdoko demo poster](revdoku-demo-poster.jpg)

**Video**

https://github.com/user-attachments/assets/ac41ab35-37f1-46e3-855f-40195ab35c48.mp4

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

## Quick Install

Use this for a single-user desktop install on this computer.

Other ways to use Revdoku: [Hosted Cloud](#hosted-cloud) - [Self-host on a server](#self-host-on-a-server)

Required software:

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) on macOS or Windows
- Docker Engine with Docker Compose on Linux

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

After install, use this command any time:

```bash
~/.revdoku/revdoku open
```

This starts Revdoku if needed and opens a fresh local sign-in link.

Do not open `http://localhost:3217` directly. That is the normal app URL and
may show the email/password sign-in page. Use `~/.revdoku/revdoku open`
instead.

### Create a Desktop Shortcut

A shortcut should run the Revdoku helper command. Do not make a shortcut or
bookmark to `http://localhost:3217`. The helper starts Revdoku if needed and
opens a fresh local sign-in link.

macOS:

```bash
cat > "$HOME/Desktop/Revdoku.command" <<'EOF'
#!/bin/sh
"$HOME/.revdoku/revdoku" open
EOF
chmod +x "$HOME/Desktop/Revdoku.command"
```

Double-click `Revdoku.command` on your Desktop. If macOS blocks it the first
time, right-click it and choose `Open`.

Linux desktop:

```bash
mkdir -p "$HOME/.local/share/applications"
cat > "$HOME/.local/share/applications/revdoku.desktop" <<'EOF'
[Desktop Entry]
Name=Revdoku
Comment=Open Revdoku
Exec=sh -lc "$HOME/.revdoku/revdoku open"
Terminal=false
Type=Application
Categories=Office;
EOF
chmod +x "$HOME/.local/share/applications/revdoku.desktop"
```

Some Linux desktops may ask you to mark the launcher as trusted.

Windows with WSL:

Create a normal Windows shortcut. Use this as the shortcut target:

```text
C:\Windows\System32\wsl.exe -e bash -lc "$HOME/.revdoku/revdoku open"
```

If you use a named WSL distro, include it:

```text
C:\Windows\System32\wsl.exe -d Ubuntu -e bash -lc "$HOME/.revdoku/revdoku open"
```

Replace `Ubuntu` with your WSL distro name if needed.

### First Steps

1. Run `~/.revdoku/revdoku open`
2. Add an AI provider in `Settings -> AI -> Providers`, or enable Ollama
3. Upload a document and run a checklist

Revdoku can start without an AI provider, but reviews need either a cloud
provider key or Ollama.

### Configure Cloud AI

In Revdoku, open the top-right menu and select:

- `Settings`
- `AI`
- `Providers`

Add the API keys for the providers you want to use. Revdoku stores them in
encrypted form.

### Use Ollama for Local AI

You can use Revdoku with local AI through Ollama. Revdoku does not install
Ollama or download models for you.

1. Install Ollama:

   - macOS or Windows: download it from <https://ollama.com/download>
   - Linux:

     ```bash
     curl -fsSL https://ollama.com/install.sh | sh
     ```

2. Download the local model:

   ```bash
   ollama pull gemma4:e4b
   ```

   `gemma4:e4b` is the recommended local default. It is an edge Gemma 4 model
   with text and image input support. It is about 9.6 GB.

   Revdoku runs in Docker and connects to Ollama through
   `http://host.docker.internal:11434/v1`. If Revdoku cannot reach Ollama,
   configure Ollama with `OLLAMA_HOST=0.0.0.0:11434` and restart Ollama. Keep
   port `11434` private or firewalled, because this can expose Ollama on your
   host network. See the [Ollama FAQ](https://docs.ollama.com/faq) for the
   exact setup steps for macOS, Linux, and Windows.

3. Enable Ollama in Revdoku:

   ```bash
   ~/.revdoku/revdoku enable-ollama
   ```

   If this command is missing, rerun the install command once. It keeps your
   data and updates the local helper command.

This only adds the Ollama configuration to Revdoku. It keeps your data and
restarts the local container.

After this, `Settings -> AI -> Providers` should show `Local Ollama` as ready.
Model pickers will include `Local Gemma · Basic`.

`Local Gemma · Basic` uses Google Gemma 4 E4B through Ollama on your own
computer or laptop. After the model is downloaded, it works fully offline as
long as Revdoku and Ollama are running.

This does not make local AI the default automatically. After sign-in, open
`Account -> AI` and choose `Local Gemma · Basic` where you want to use it.

## Local Commands

Useful commands:

```bash
~/.revdoku/revdoku start
~/.revdoku/revdoku stop
~/.revdoku/revdoku logs
~/.revdoku/revdoku update
~/.revdoku/revdoku enable-ollama
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

## Reset Local Install

This removes the current local install from Docker and moves the data folder
aside. Do this only when you want a fresh local install.

```bash
~/.revdoku/revdoku stop
mv ~/.revdoku ~/.revdoku.old.$(date +%Y%m%d-%H%M%S)
docker rm -f revdoku-local 2>/dev/null || true
```

Do not delete the old folder until you are sure you do not need the local data.


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
- Local Ollama with `gemma4:e4b`
- other local LLMs such as LM Studio
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

See [env.example](./env.example) for the full list.

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

Please, do not open public GitHub issues for security reports.

## Contributing

Bug reports and pull requests are welcome. For large changes, please open a
GitHub Discussion first.

## License

Revdoku is licensed under AGPLv3. See [LICENSE](./LICENSE).

A commercial license is also available. Contact:

<sales@revdoku.com>

---

Hosted version: <https://revdoku.com> · Issues: <https://github.com/revdoku/revdoku/issues>
