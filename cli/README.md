# Revdoku CLI

`revdoku` works with your support portals from the terminal and CI jobs: connect GitHub, publish, write articles, and read and answer support tickets. It prints the JSON of the [Revdoku API](https://support.revdoku.com/docs/api).

## Install

You need macOS, Linux or Windows with WSL, and Bash, curl, OpenSSL, jq, base64 and find. For example, install jq with `brew install jq` on macOS.

```sh
curl -fsSL https://github.com/revdoku/revdoku/releases/latest/download/install-cli.sh -o install-cli.sh
bash install-cli.sh
export PATH="$HOME/.local/bin:$PATH"
revdoku --version
```

The installer checks the SHA-256 checksum of the executable before it installs it in `~/.local/bin`. `--dir /your/bin` chooses another folder. To update, run the latest installer again.

To pin a version, download `revdoku` and `SHA256SUMS` from one [release](https://github.com/revdoku/revdoku/releases), and check the file before you run it:

```sh
test "$(openssl dgst -sha256 revdoku | awk '{print $NF}')" = "$(awk '$2 == "revdoku" { print $1 }' SHA256SUMS)" && chmod +x revdoku
```

## Sign in

```sh
revdoku login    # sign in in the browser
revdoku status   # the account and the connection
revdoku ls       # your projects
```

On a server or in CI, set `REVDOKU_API_KEY` to an API key from the dashboard (**Connect** → **Connect via API**) in place of `revdoku login`.

Most commands work on one project. Pass `--project-id prj_...`, or set `REVDOKU_PROJECT_ID`.

## Publish your portal from GitHub

```sh
# Find the docs folder, connect it, then publish.
revdoku github scan acme/docs --project-id prj_...
revdoku github connect acme/docs --repo-path docs --project-id prj_...
revdoku publish --project-id prj_...
revdoku site --project-id prj_...
```

When the GitHub account is not connected yet, `github connect` prints the link that a person opens to install the Revdoku GitHub App.

## Answer support tickets

```sh
revdoku tickets --status open --project-id prj_...
revdoku ticket-messages tkt_... --project-id prj_...
# The AI writes a draft from your docs. Nothing is sent.
revdoku ticket-draft tkt_... --project-id prj_...
revdoku ticket-reply tkt_... --text "Thanks! Here is how…" --project-id prj_...
revdoku ticket-update tkt_... --status solved --project-id prj_...
```

## Write an article

```sh
revdoku article create --visibility public --file refunds.md --project-id prj_...
revdoku publish --project-id prj_...
```

A public article is on your portal after the next publish. `--visibility private` makes a private note, which is never published. `_repo/` is the read-only copy of your GitHub repository.

## Commands

### Account

| Command | What it does |
| --- | --- |
| `status` | The connection, the account and the versions. |
| `accounts`, `account get ID` | The accounts that the connection reaches, and one account. |
| `account limits` | The limits of the plan and the credits. |
| `account create-client NAME` | Create a client account of an agency. `--client-name` names the client. |
| `dashboard` | Print a link to the dashboard. |

### Projects

| Command | What it does |
| --- | --- |
| `ls` | List projects. `--status`, `--query`, `--limit` and `--cursor` filter and page. |
| `create` | Create a project. `--username` names its site and support address, `--title` names the project. |
| `update` | Change `--title` or `--description`. |
| `open` | Open the project in the dashboard. |
| `archive`, `unarchive` | Archive or unarchive a project. |
| `delete` | Preview the permanent deletion of an archived project, then confirm with `--confirm-delete`. |

### Tickets

| Command | What it does |
| --- | --- |
| `tickets` | List tickets, newest activity first. Filter with `--status`, `--channel`, `--label`, `--updated-after TIME`, `--number N` and `--requester EMAIL`. |
| `ticket ID` | Read one ticket. |
| `ticket-messages ID` | List the messages of a ticket. `--message-id ID` reads one message. |
| `ticket-draft ID` | Let the AI reply drafter write a reply, and wait for it. It sends nothing. `--read` shows the newest draft. |
| `ticket-reply ID` | Reply to the customer, with `--text`, `--text-file` or `--html-file`. `--attach FILE_ID` attaches a project file. |
| `ticket-update ID` | Change `--status`, `--note` (with `--expected-note`, the note that you read) or labels (`--add-label`, `--remove-label`). |
| `ticket-download ID` | Download an attachment (`--message-id`, `--attachment-id`) or the original email, to `--output FILE`. |
| `ticket-message-delete ID` | Delete one message (`--message-id`). Confirm with `--confirm-delete MESSAGE_ID`. |

### Events

| Command | What it does |
| --- | --- |
| `webhook`, `webhook-set`, `webhook-delete` | Read, set (`--webhook-url`, `--rotate-secret`) or turn off the webhook of ticket events. |
| `events-subscription` | Get a short-lived token for live ticket events. |

### Articles

| Command | What it does |
| --- | --- |
| `articles` | List the articles, newest change first. `--public` or `--private` lists one kind. |
| `article ID` | Read one article with its Markdown text. |
| `article create --visibility public\|private --file FILE` | Create an article from Markdown. Its first `#` heading names it, and `--slug billing/refunds` chooses its path. `--file -` reads standard input. It never replaces an article. |
| `article update ID` | Change the text (`--file`), `--slug`, `--visibility` (a move) or `--do-not-publish true\|false`. |
| `article delete ID` | Delete an article. Its versions stay. |
| `article versions ID` | List the versions of an article. |
| `article images` | List the images. `--public` or `--private` lists one kind. |
| `article restore ID --version-id ID` | Make an earlier version current. A deleted article comes back. |
| `article image --file FILE` | Add an image (`.jpg`, `.png`, `.webp`) to the folder of an article (`--article-id ID`), or with `--visibility` to the top of a folder. The answer's `image.markdown` is the link for the article. |
| `scan URL...` | Scan a website: the AI writes one article per page. `--max-articles N` limits them. `--read` shows the newest scan, `--stop` stops it. |

`article create`, `update`, `delete`, `restore` and `image` take `--expected-project-version`, the `project_version` that you read. When the project changed since, nothing changes. `update`, `delete` and `restore` also take `--expected-version-id`, the article's `version_id`, which only a change of that article makes stale. A public article or image needs publish access. A write never publishes: run `revdoku publish`.

A public article with `--do-not-publish true` stays off the site, and the site's AI Support Agent still answers visitors from it. Put only facts that visitors may know there.

### Files

| Command | What it does |
| --- | --- |
| `files` | List files. `--folder _repo/docs` lists one folder. |
| `read PATH` | Read a file. `--output FILE` saves it. |
| `versions PATH` | List the versions of a file. |

### Site

| Command | What it does |
| --- | --- |
| `publish` | Publish the site, and wait until it is ready. `--support form\|form_email\|email\|link\|none` and `--support-link URL` choose how visitors reach your team. |
| `preview` | Make a 24-hour preview. `--branch NAME` previews a branch of the connected repository. |
| `site` | Show the site: its address, status and `republish_reasons`. `--preview` shows the newest preview, `--previews` every preview with its branch. |
| `settings` | Show the site settings. |
| `settings set --file FILE` | Change the settings in a JSON file. `null` removes a setting. Then publish again. |
| `unpublish` | Take the site offline. |

```json
{"layout": "notebook", "ask": {"title": "Questions"}, "primary_color": "#2563eb"}
```

### GitHub

| Command | What it does |
| --- | --- |
| `github` | Show the connected repository and the status of its copy. |
| `github accounts`, `github repos ID` | The connected GitHub accounts, and the repositories of one. |
| `github setup-link` | Print the links that a person opens to add a GitHub account. |
| `github scan [OWNER/NAME]` | Find the docs folders of a repository. Nothing changes. |
| `github connect OWNER/NAME` | Copy a repository into the project. `--repo-path`, `--branch`. A project with files needs `--project-files replace`. |
| `github sync` | Sync now, and wait for the copy. |
| `github set --auto-publish false` | Publish by hand after each push. |
| `github branches` | List the branches that a preview can show. |
| `github disconnect` | Stop the sync. Confirm with `--confirm-delete PROJECT_ID`. The files stay. |

## Options

| Option | Meaning |
| --- | --- |
| `--project-id ID` | The project. Or set `REVDOKU_PROJECT_ID`. |
| `--account-id ID` | Another account that the connection reaches. |
| `--reason TEXT` | Why you read or change something. It shows in the activity log. |
| `--no-wait` | Answer at once, without waiting for background work. |
| `--api-key KEY` | An API key. Or set `REVDOKU_API_KEY`. |

`revdoku --help` lists every command and option.

## Output and background work

Each command prints the JSON of the API on standard output. Notes for people go to standard error.

`publish`, `preview`, `scan`, `github connect`, `github sync` and `ticket-draft` start work in the background and wait for it. The exit code is `0` when it is ready, `1` when it failed and `2` when it still runs after 5 minutes. Read it later with `site`, `github`, `scan --read` or `ticket-draft ID --read`.

Commands that change something never retry by themselves. After an unknown result, read the resource before you run the command again. Deletes show a preview first and need `--confirm-delete`.

## Uninstall

Delete the `revdoku` executable. To also remove your saved sign-in, delete `~/.revdoku/`. Your projects stay.

For AI apps, see the [skill and plugin guide](https://github.com/revdoku/revdoku#local-ai-apps).
