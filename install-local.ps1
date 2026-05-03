<# 
install-local.ps1 - one-command local Revdoku Core installer for Windows.

Intended usage:
Invoke-WebRequest -UseBasicParsing https://raw.githubusercontent.com/revdoku/revdoku/main/install-local.ps1 -OutFile "$env:TEMP\revdoku-install-local.ps1"; powershell -ExecutionPolicy Bypass -File "$env:TEMP\revdoku-install-local.ps1"

The WSL shell installer is the recommended Windows path for now; this script is
provided for native PowerShell testing.
#>

param(
  [string]$InstallDir = $(if ($env:REVDOKU_HOME) { $env:REVDOKU_HOME } else { Join-Path $env:APPDATA "Revdoku" }),
  [string]$Image = $(if ($env:REVDOKU_IMAGE) { $env:REVDOKU_IMAGE } else { "ghcr.io/revdoku/revdoku:latest" }),
  [int]$Port = $(if ($env:REVDOKU_PORT) { [int]$env:REVDOKU_PORT } else { 0 }),
  [string]$ContainerName = $(if ($env:REVDOKU_CONTAINER_NAME) { $env:REVDOKU_CONTAINER_NAME } else { "revdoku-local" }),
  [string]$ProjectName = $(if ($env:REVDOKU_PROJECT_NAME) { $env:REVDOKU_PROJECT_NAME } else { "" }),
  [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$EnvChanged = $false

if ([string]::IsNullOrWhiteSpace($ProjectName)) {
  $ProjectName = $ContainerName
}

$EnvFile = Join-Path $InstallDir "revdoku.env"
$ComposeFile = Join-Path $InstallDir "compose.yml"
$HelperFile = Join-Path $InstallDir "revdoku-local.ps1"
$StorageDir = Join-Path $InstallDir "storage"
$BackupDir = Join-Path $InstallDir "backups"

function Write-Info([string]$Message) {
  Write-Host $Message
}

function Set-Utf8NoBomContent([string]$Path, [string]$Value) {
  $encoding = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($Path, $Value, $encoding)
}

function New-RandomHex([int]$Bytes) {
  $buffer = New-Object byte[] $Bytes
  $rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
  try {
    $rng.GetBytes($buffer)
  } finally {
    $rng.Dispose()
  }
  -join ($buffer | ForEach-Object { $_.ToString("x2") })
}

function Get-EnvFileValue([string]$Key) {
  if (-not (Test-Path $EnvFile)) {
    return $null
  }

  $line = Get-Content -Path $EnvFile | Where-Object { $_ -match "^$([regex]::Escape($Key))=" } | Select-Object -Last 1
  if ($line) {
    return ($line -replace "^$([regex]::Escape($Key))=", "")
  }
  return $null
}

function Test-PortAvailable([int]$CandidatePort) {
  try {
    $listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Parse("127.0.0.1"), $CandidatePort)
    $listener.Start()
    $listener.Stop()
    return $true
  } catch {
    return $false
  }
}

function Get-AvailablePort {
  $defaultPort = if ($env:REVDOKU_DEFAULT_LOCAL_PORT) { [int]$env:REVDOKU_DEFAULT_LOCAL_PORT } else { 3217 }
  for ($candidate = $defaultPort; $candidate -le ($defaultPort + 50); $candidate++) {
    if (Test-PortAvailable $candidate) {
      return $candidate
    }
  }

  throw "Could not find a free localhost port in $defaultPort-$($defaultPort + 50); set REVDOKU_PORT and run again."
}

function Ensure-EnvSetting([string]$Key, [string]$Value) {
  if (-not (Test-Path $EnvFile)) {
    return
  }

  $existing = Get-Content -Path $EnvFile | Where-Object { $_ -match "^$([regex]::Escape($Key))=" } | Select-Object -First 1
  if (-not $existing) {
    $encoding = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::AppendAllText($EnvFile, "`n$Key=$Value", $encoding)
    $script:EnvChanged = $true
  }
}

function Assert-Docker {
  if ($DryRun -or $env:REVDOKU_INSTALL_DRY_RUN -eq "1") {
    return
  }

  if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    throw "Docker is not installed. Install Docker Desktop first: https://www.docker.com/products/docker-desktop/"
  }

  & docker info *> $null
  if ($LASTEXITCODE -ne 0) {
    throw "Docker is installed but not running. Start Docker Desktop, wait until it is ready, then run this installer again."
  }

  & docker compose version *> $null
  if ($LASTEXITCODE -ne 0) {
    throw "Docker Compose is missing. Docker Desktop includes it; update Docker Desktop or install the Compose plugin."
  }
}

function Pull-Image {
  if ($env:REVDOKU_SKIP_PULL -eq "1") {
    Write-Info "Skipping image pull because REVDOKU_SKIP_PULL=1"
    return
  }

  Write-Info "Downloading Revdoku Docker image:"
  Write-Info "  $Image"
  Write-Info "Docker will show layer download progress below."
  docker pull $Image
  if ($LASTEXITCODE -ne 0) {
    Write-Info "Image pull failed; continuing with any local or cached image."
  }
}

function Write-EnvFile {
  if (Test-Path $EnvFile) {
    Write-Info "Keeping existing $EnvFile"
    Ensure-EnvSetting -Key "REVDOKU_PORT" -Value "$Port"
    Ensure-EnvSetting -Key "REVDOKU_LOCAL_ACCESS" -Value "helper"
    Ensure-EnvSetting -Key "REVDOKU_LOCAL_ACCESS_SECRET" -Value "$(New-RandomHex 32)"
    Ensure-EnvSetting -Key "REVDOKU_REGISTRATION_ENABLED" -Value "false"
    return
  }

  if (Test-Path $StorageDir) {
    throw "Storage exists but $EnvFile is missing. Restore your full Revdoku backup, or move $StorageDir aside before starting fresh."
  }

  $content = @(
    "# Generated by Revdoku install-local.ps1."
    "# Keep this file with storage/. Back up the whole Revdoku data folder."
    "# LOCKBOX_MASTER_KEY is required to read your local Revdoku data."
    "SECRET_KEY_BASE=$(New-RandomHex 64)"
    "LOCKBOX_MASTER_KEY=$(New-RandomHex 32)"
    "PREFIX_ID_SALT=$(New-RandomHex 32)"
    "REVDOKU_DOC_API_KEY=$(New-RandomHex 32)"
    "REVDOKU_LOCAL_ACCESS_SECRET=$(New-RandomHex 32)"
    ""
    "REVDOKU_PORT=$Port"
    "REVDOKU_LOCAL_ACCESS=helper"
    "REVDOKU_LOGIN_MODE=password_no_confirmation"
    "REVDOKU_REGISTRATION_ENABLED=false"
    "APP_HOST=localhost"
    "APP_PROTOCOL=http"
  ) -join "`n"

  Set-Utf8NoBomContent -Path $EnvFile -Value $content
  Write-Info "Created $EnvFile"
}

function Write-ComposeFile {
  $shouldWrite = $true
  if (Test-Path $ComposeFile) {
    $existing = Get-Content -Path $ComposeFile -Raw
    if ($existing -notmatch "Generated by Revdoku install-local.ps1") {
      $shouldWrite = $false
    }
  }

  if (-not $shouldWrite) {
    Write-Info "Keeping existing $ComposeFile"
    return
  }

  $content = @"
# Generated by Revdoku install-local.ps1.
name: $ProjectName

services:
  revdoku:
    image: $Image
    container_name: $ContainerName
    ports:
      - "127.0.0.1:${Port}:80"
    env_file:
      - ./revdoku.env
    environment:
      RAILS_LOG_TO_STDOUT: "true"
      RAILS_SERVE_STATIC_FILES: "true"
      REVDOKU_EDITION: "core"
      REVDOKU_RUNNING_IN_DOCKER: "true"
      REVDOKU_DOC_API_URL: "http://localhost:4001"
      SOLID_QUEUE_IN_PUMA: "true"
      ACTIVE_STORAGE_SERVICE: "local"
      DATABASE_PATH: "/rails/storage/production.sqlite3"
      CACHE_DATABASE_PATH: "/rails/storage/production_cache.sqlite3"
      QUEUE_DATABASE_PATH: "/rails/storage/production_queue.sqlite3"
      CABLE_DATABASE_PATH: "/rails/storage/production_cable.sqlite3"
      AUDIT_DATABASE_PATH: "/rails/storage/production_audit.sqlite3"
    extra_hosts:
      - "host.docker.internal:host-gateway"
    volumes:
      - ./storage:/rails/storage
    restart: unless-stopped
"@

  Set-Utf8NoBomContent -Path $ComposeFile -Value $content
  Write-Info "Wrote $ComposeFile"
}

function Write-Helper {
  $content = @'
param(
  [ValidateSet("start", "stop", "restart", "update", "logs", "status", "open", "login-url", "enable-ollama", "backup", "help")]
  [string]$Command = "help"
)

$ErrorActionPreference = "Stop"
$HomeDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Set-Location $HomeDir

function Get-EnvFileValue([string]$Key) {
  if (-not (Test-Path "revdoku.env")) {
    return $null
  }

  $line = Get-Content -Path "revdoku.env" | Where-Object { $_ -match "^$([regex]::Escape($Key))=" } | Select-Object -Last 1
  if ($line) {
    return ($line -replace "^$([regex]::Escape($Key))=", "")
  }
  return $null
}

function Set-EnvFileValue([string]$Key, [string]$Value) {
  $path = Join-Path $HomeDir "revdoku.env"
  $lines = if (Test-Path $path) { Get-Content -Path $path } else { @() }
  $found = $false
  $updated = @()

  foreach ($line in $lines) {
    if ($line -match "^$([regex]::Escape($Key))=") {
      $updated += "$Key=$Value"
      $found = $true
    } else {
      $updated += $line
    }
  }

  if (-not $found) {
    $updated += ""
    $updated += "$Key=$Value"
  }

  $encoding = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($path, (($updated -join "`n") + "`n"), $encoding)
}

$Port = if ($env:REVDOKU_PORT) { [int]$env:REVDOKU_PORT } elseif (Get-EnvFileValue "REVDOKU_PORT") { [int](Get-EnvFileValue "REVDOKU_PORT") } else { 3217 }
$Url = "http://localhost:$Port"

function Assert-LocalData {
  if ((Test-Path "storage") -and -not (Test-Path "revdoku.env")) {
    throw "storage\ exists but revdoku.env is missing. Restore the whole Revdoku folder or a backup made with this helper."
  }

  if (-not (Test-Path "revdoku.env")) {
    throw "revdoku.env is missing from $HomeDir. It contains the key needed to read local data."
  }
}

function Wait-ForHealth {
  $healthUrl = "http://127.0.0.1:$Port/up"
  for ($i = 0; $i -lt 60; $i++) {
    try {
      Invoke-WebRequest -Uri $healthUrl -UseBasicParsing -TimeoutSec 3 | Out-Null
      return $true
    } catch {
      Start-Sleep -Seconds 2
    }
  }
  return $false
}

function Get-LocalAccessUrl {
  $output = docker compose exec -T revdoku bin/rails runner "puts Revdoku::LocalAccess.issue_url!" 2>$null
  if ($LASTEXITCODE -eq 0 -and $output) {
    return ($output | Select-Object -Last 1).Trim()
  }
  return $null
}

function Throw-LocalAccessError {
  throw "Could not create a local sign-in link. The running image may not include Core local access yet. Run this helper with update after publishing a new image, or test local source with: docker build -t revdoku-local-current .; `$env:REVDOKU_IMAGE='revdoku-local-current'; `$env:REVDOKU_SKIP_PULL='1'; powershell -ExecutionPolicy Bypass -File .\install-local.ps1"
}

switch ($Command) {
  "start" {
    Assert-LocalData
    docker compose up -d
  }
  "stop" {
    docker compose down
  }
  "restart" {
    Assert-LocalData
    docker compose restart
  }
  "update" {
    Assert-LocalData
    docker compose pull
    docker compose up -d
  }
  "enable-ollama" {
    Assert-LocalData
    $apiKey = if ($env:LOCAL_OLLAMA_API_KEY) { $env:LOCAL_OLLAMA_API_KEY } else { "ollama" }
    $baseUrl = if ($env:LOCAL_OLLAMA_BASE_URL) { $env:LOCAL_OLLAMA_BASE_URL } else { "http://host.docker.internal:11434/v1" }
    Set-EnvFileValue -Key "LOCAL_OLLAMA_API_KEY" -Value $apiKey
    Set-EnvFileValue -Key "LOCAL_OLLAMA_BASE_URL" -Value $baseUrl
    if (-not (Get-Command ollama -ErrorAction SilentlyContinue)) {
      Write-Host "Warning: the 'ollama' command was not found in this shell. Install Ollama and run: ollama pull gemma4:e4b"
    }
    docker compose up -d --force-recreate
    Write-Host "Local Ollama is enabled for Revdoku."
    Write-Host "Install Ollama on this machine, then run: ollama pull gemma4:e4b"
    Write-Host "If Docker cannot reach Ollama, configure Ollama with OLLAMA_HOST=0.0.0.0:11434 and keep port 11434 private."
    Write-Host "After sign-in, choose Local Gemma in Account -> AI."
  }
  "logs" {
    docker compose logs -f --tail=200
  }
  "status" {
    docker compose ps
  }
  "login-url" {
    Assert-LocalData
    $loginUrl = Get-LocalAccessUrl
    if (-not $loginUrl) {
      Throw-LocalAccessError
    }
    Write-Host $loginUrl
  }
  "open" {
    Assert-LocalData
    docker compose up -d
    if (-not (Wait-ForHealth)) {
      throw "Revdoku started, but did not become ready. Run this helper with logs for details."
    }
    $loginUrl = Get-LocalAccessUrl
    if (-not $loginUrl) {
      Throw-LocalAccessError
    }
    Write-Host "Opening $loginUrl"
    Start-Process $loginUrl
  }
  "backup" {
    Assert-LocalData
    if (-not (Test-Path "compose.yml")) {
      throw "compose.yml is missing from $HomeDir."
    }
    New-Item -ItemType Directory -Force -Path "backups" | Out-Null
    $stamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $out = Join-Path "backups" "revdoku-backup-$stamp.zip"
    $running = $null
    $canUseCompose = $false
    if (Get-Command docker -ErrorAction SilentlyContinue) {
      docker compose version *> $null
      if ($LASTEXITCODE -eq 0) {
        $canUseCompose = $true
      }
    }
    if ($canUseCompose) {
      $running = docker compose ps --status running --quiet
      if ($running) {
        docker compose stop
      }
    } else {
      Write-Host "Docker Compose is not available; creating a backup without stopping Revdoku."
    }
    $items = @("compose.yml", "revdoku.env")
    if (Test-Path "revdoku-local.ps1") {
      $items += "revdoku-local.ps1"
    }
    if (Test-Path "storage") {
      $items += "storage"
    }
    Compress-Archive -Path $items -DestinationPath $out -Force
    if ($canUseCompose -and $running) {
      docker compose up -d
    }
    Write-Host "Backup written: $(Join-Path $HomeDir $out)"
    Write-Host "This archive contains the encryption key and local data needed for restore."
  }
  "help" {
    Write-Host @"
Usage: powershell -ExecutionPolicy Bypass -File .\revdoku-local.ps1 <command>

Commands:
  start    Start Revdoku
  stop     Stop Revdoku
  restart  Restart Revdoku
  update   Pull the latest image and restart
  logs     Follow container logs
  status   Show container status
  open     Start Revdoku and open a one-time local sign-in link
  login-url Print a one-time local sign-in link
  enable-ollama Configure Revdoku to use local Ollama
  backup   Create a portable backup of the local Revdoku folder

Data folder:
  $HomeDir

Important:
  Revdoku local data is encrypted by the key in revdoku.env. Keep the whole
  data folder together, or use the backup command before moving to a new
  machine. Copying storage/ without revdoku.env can make the data unreadable.
"@
  }
}
'@

  Set-Utf8NoBomContent -Path $HelperFile -Value $content
}

function Wait-ForHealth {
  $url = "http://127.0.0.1:$Port/up"
  for ($i = 0; $i -lt 60; $i++) {
    try {
      Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 3 | Out-Null
      return $true
    } catch {
      Start-Sleep -Seconds 2
    }
  }
  return $false
}

New-Item -ItemType Directory -Force -Path $InstallDir, $BackupDir | Out-Null

if ($Port -eq 0) {
  $existingPort = Get-EnvFileValue "REVDOKU_PORT"
  if ($existingPort) {
    $Port = [int]$existingPort
  } else {
    $Port = Get-AvailablePort
  }
}

Write-EnvFile
New-Item -ItemType Directory -Force -Path $StorageDir | Out-Null
Write-ComposeFile
Write-Helper

if ($DryRun -or $env:REVDOKU_INSTALL_DRY_RUN -eq "1") {
  Write-Info "Dry run complete. Files are in $InstallDir"
  Write-Info "Back up this whole folder, or run:"
  Write-Info "  powershell -ExecutionPolicy Bypass -File `"$HelperFile`" backup"
  exit 0
}

Assert-Docker

Write-Info ""
Write-Info "Starting Revdoku. The first download can take a few minutes."
Push-Location $InstallDir
try {
  Pull-Image
  if ($EnvChanged) {
    docker compose up -d --force-recreate
  } else {
    docker compose up -d
  }
} finally {
  Pop-Location
}

if (Wait-ForHealth) {
  Write-Info ""
  Write-Info "Revdoku is running on localhost:$Port."
  Write-Info "Do not open that address directly; use the helper so you get a one-time local sign-in link."
  Write-Info ""
  Write-Info "Opening Revdoku now. Use this command later:"
  Write-Info "  powershell -ExecutionPolicy Bypass -File `"$HelperFile`" open"
  Write-Info ""
  Write-Info "Local data folder:"
  Write-Info "  $InstallDir"
  Write-Info "Back up this whole folder, or run:"
  Write-Info "  powershell -ExecutionPolicy Bypass -File `"$HelperFile`" backup"
  Write-Info ""
  Write-Info "Useful commands:"
  Write-Info "  powershell -ExecutionPolicy Bypass -File `"$HelperFile`" start"
  Write-Info "  powershell -ExecutionPolicy Bypass -File `"$HelperFile`" stop"
  Write-Info "  powershell -ExecutionPolicy Bypass -File `"$HelperFile`" update"
  Write-Info "  powershell -ExecutionPolicy Bypass -File `"$HelperFile`" backup"
  powershell -ExecutionPolicy Bypass -File "$HelperFile" open
} else {
  Write-Info ""
  Write-Info "Revdoku was started, but the health check did not pass yet."
  Write-Info "Open logs with:"
  Write-Info "  powershell -ExecutionPolicy Bypass -File `"$HelperFile`" logs"
  exit 1
}
