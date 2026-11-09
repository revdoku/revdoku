# Revdoku Changelog

## 1.0.638 — 2026-11-09

### Added

- Press Cmd+K (Ctrl+K on Windows and Linux) on a docs site to search.
- Ask your search from the last search result of a docs site, also when no page matches.
- Use the header, footer and banner of a Mintlify `docs.json` on docs sites: navbar links and button, footer links, and a banner that visitors can close.
- Copy a docs page as Markdown, or open it in ChatGPT, Claude or Perplexity, from the page menu.

### Improved

- Leave a message on a docs site with a name, an email address and the message, without a code. A person reviews and sends every reply.
- Ask answers a question about the page you are reading, such as "what is that?".
- Show a docs page's own card components, such as hero cards, as cards.
- Keep the security check of Ask right above the question box.
- Move the theme switch of a docs site to the bottom of the page list. Switching back to your system theme makes the site follow the system again.

## 1.0.637 — 2026-11-09

### Improved

- Open the Markdown of any docs page by replacing the last slash of its URL with `.md`, for example `/guides/setup.md`. It always shows the page as the site shows it, with its title.
- See AI agents and bots first in a site's analytics, then people, with one chart of all three per day.
- Simplify Analytics: Logs list every action, and the Timeline view is gone.

### Fixed

- Open a site's analytics from "View analytics" in the weekly report and in notifications. These links opened the account's activity instead.

## 1.0.636 — 2026-11-09

### Improved

- Show matching pages as you type in a docs site's search box and in Ask. The search box opens faster on large sites.
- Fit a docs site's header on one row on phones, with icons for Ask, the language menu and the theme switch. The page no longer zooms in when you tap the search box or Ask.
- Copy code with an icon button. A code block shows its title, and the tabs of a code group show the file names.
- Show a docs site's own logo alone in the header, and its dark logo in the dark theme.
- Open a page's Markdown as plain text. It starts with the page title and description, and docs pages name it in their headers for AI agents.
- Make the Revdoku badge smaller and lighter.

### Fixed

- Show the text and code inside Mintlify components such as Steps correctly when they are indented. Code examples that contain code blocks also show correctly.
- Keep braces in their place in highlighted code on docs sites. Show the tabs of a Tabs component above their content.

## 1.0.635 — 2026-11-09

### Fixed

- Update the pages of a docs site at its next publish after an improvement to docs sites, also when the site's own files did not change.

## 1.0.634 — 2026-11-09

### Fixed

- Show no extra API reference on a Mintlify site whose docs.json names no OpenAPI file. Its links led to missing pages.

## 1.0.632 — 2026-11-08

### Fixed

- Keep a site online while it publishes again. After each publish, a site showed "Site unpublished" for a minute or two.

## 1.0.631 — 2026-11-08

### Improved

- Read docs sites on phones: the list of pages folds behind a Pages button, and the search has its own row.

### Fixed

- Show the Visibility blocks of Mintlify pages to the right readers: content for AI agents appears only in the Markdown of a page, and content for people only on the page.

## 1.0.630 — 2026-11-08

### Improved

- Open the pages of docs sites faster, and publish large docs sites faster.

### Fixed

- Publish docs sites whose docs.json has redirects. Their publish stopped with "Publication settings changed during review."

## 1.0.629 — 2026-11-08

### Added

- Add a chat to any website from Email Settings → Website chat. Visitors confirm their email with a code, each message arrives in the bucket's Support, and the replies show in the chat.

### Improved

- Publish Mintlify repositories with more of their docs.json: files that it includes with $ref, languages with a language menu, tab menus, hidden tabs and redirects. Endpoint pages show the operation of the OpenAPI file that they name.
- Connect a large GitHub repository faster: the first sync and branch previews download the repository at once.
- Publish large docs sites faster: the files of a site upload at the same time.
- Ask questions on public docs sites with the Ask button, now on by default. Ask answers with AI while the account has credits. Without credits it shows the matching pages, and visitors can still leave a message. Turn it off in the Publish dialog.
- Show the Revdoku badge of a site as a "Published with Revdoku" line at the bottom right of the page footer, not as a floating icon over the page.
- Turn off the Revdoku badge in the Settings of a site on a paid plan. The site changes at once, without a republish. See https://app.revdoku.com/pricing.
- Use one balance of credits for messages and AI: chat messages, received email and sent email now use credits too. When the credits run out, chat messages and email still arrive, and sending waits for credits. See https://app.revdoku.com/pricing.
- See the credits that are left, and when they refill, in Account Settings → Subscription.
- On the Free plan, a person approves each email that an API key, an MCP connection or an agent sends. See https://app.revdoku.com/pricing.
- New accounts start with the built-in AI filter off. Administrators turn it on in the Agents view of a bucket.

### Fixed

- Show docs sites with their styles: browsers refused the stylesheet of docs pages.
- Get AI answers from Ask on docs sites.

## 1.0.626 — 2026-11-08

### Improved

- Get answers from Ask AI on docs sites also when a question uses other words than your docs. Each answer links the section that it comes from.
- See links to the exact sections of your docs in the support agent's draft replies.

## 1.0.625 — 2026-11-08

### Added

- Start a docs site from the docs template on GitHub: GitHub makes your own copy, then you connect it to a bucket.

### Improved

- Publish large docs sites faster.
- Publish sites on the Free plan from a connected GitHub repository. Paid plans also publish uploaded files. See https://app.revdoku.com/pricing.
- The Terms of Use cover docs sites, and the Website Publishing Policy is public at https://revdoku.com/website-publishing-policy/.

## 1.0.624 — 2026-11-07

### Improved

- Publish large docs sites: a docs site no longer has a page limit.
- See the title and description of each docs page at its top, from the page's front matter.

### Fixed

- Publish docs sites whose pages are MDX files, and repositories with files such as LICENSE.

## 1.0.623 — 2026-11-07

### Improved

- Republish a site faster after a small change.

### Fixed

- A file that is too large for your plan no longer stops automatic publishing of your site. The file is left out, and the GitHub panel lists it.
- Files stored in Git LFS show as skipped in the GitHub panel instead of syncing as small pointer files.

## 1.0.622 — 2026-11-07

### Improved

- Find a site's pages in the sidebar under **Site**: Previews, GitHub, Domain, Access and Settings. They replace the Website settings dialog.
- See your site and its GitHub repository at a glance on the Site page: the address, when it was published and synced, and how many pages and files it has.
- See what needs you in one line on the Site page: a failed sync with **Try again**, or edits that are not on GitHub with **Review**.
- See every 24-hour preview on the **Previews** page, also the previews of your GitHub branches.
- See the commits that Revdoku sends to GitHub as **Verified**.

### Fixed

- GitHub sync works again. Earlier releases could not copy a repository.
- A bucket connected to GitHub no longer asks you to connect GitHub or add docs while its first sync runs.
- A failed GitHub sync shows a readable message instead of an error from the server.

## 1.0.621 — 2026-11-06

### Added

- Publish edits to GitHub when they are ready. Edits in a bucket linked to GitHub wait as pending changes: **Publish** commits them to your branch, and **Open pull request** sends them for review.
- Merge Revdoku's pull request from the GitHub panel with **Merge and publish**. While the pull request is open, new edits go to it.
- Choose how edits reach GitHub in **Edits in Revdoku**: Publish manually, Commit at once or Read-only.
- See who reads your docs in the bucket's **Analytics**: AI agents and their requests, bots, countries, what visitors and agents searched, and the questions asked in Ask AI. On every plan.
- Leave a message from Ask AI: when the docs do not answer, visitors confirm their email with a code and send a message. It opens a support ticket, and your reply goes to their email.
- Set the name, address, access and docs layout of a site in one **Publish** dialog.
- Add your own Cloudflare Turnstile keys for a custom domain in Website settings, so Ask AI on that domain has a security check.

### Improved

- Your live docs site shows only your GitHub branch: edits that wait for Publish or for review never go live.
- A protected branch gets its changes through a pull request.
- Ask AI opens as a panel beside the page, and asks visitors to pass a security check once.
- Docs pages link llms.txt, the page's Markdown and the MCP server for AI agents, in the page and in its footer.
- A bucket with a site shows Site, Analytics, Support and Files in the sidebar. Compose, the folders and Agents are in Support.
- New buckets take a name, and a bucket without a chosen name takes the name of its first GitHub repository.
- A site never shows your support email address to visitors or AI agents.

### Fixed

- Starting a bucket from the docs template works again.
- A publish that fails because the site review could not run now says so and can be retried.
- The email about a failed publish is sent again.

## 1.0.620 — 2026-11-06

### Added

- Add AI agents to any bucket from its Agents view. An agent runs on new email with your instructions: it can draft replies, email your team, write files in its folder and add labels. Its runs spend the account's AI credits.

## 1.0.619 — 2026-11-06

### Added

- Answer support email from your docs: the built-in support agent drafts a reply to each support email from the bucket's docs pages, and a person sends it.
- Connect a GitHub repository from the new GitHub tab in Website settings.
- Track support requests as tickets: each conversation in Support has a number. Filter open or solved tickets, and solve or reopen one from the email.
- Ask AI on public docs sites: visitors ask a question and get an answer from your docs with links to its pages, and can contact support.
- Connect AI agents to the MCP server of a public docs site at `/mcp`, with the tools `search_docs`, `read_page` and `list_pages`, without sign-in.
- Search the whole pages of a docs site from code with `GET /_revdoku/search?q=`. It answers the page, the matching section and a snippet.
- Find the MCP server of a docs site at `/.well-known/mcp`.
- Show the bucket's mailbox address to AI agents from the Site tab, so they send questions and requests by email.
- Try API requests from the API console of a public docs site even when the API does not allow browser requests from the site.
- See each publish from GitHub on its commit: the Revdoku check shows the build while it runs, then links the published site, or the bucket when publishing failed.
- Preview every branch of a published site: a push to another branch of the connected repository, such as a pull request's, gets a 24-hour preview with the site's access settings, linked from its commit on GitHub.

### Improved

- Set up a new account by adding your docs: connect a GitHub repository, upload files or start from the docs template, then publish.
- The Mailbox tab is now Support. Its email controls show there, and the other views of a bucket show Website settings.
- Pricing leads with docs sites: each plan names its docs sites, access protection, custom domains and docs features. Email is the support channel of a docs site, with smaller allowances. Password-protected sites and email-code gates need a paid plan. See https://app.revdoku.com/pricing.
- The dashboard, notifications and messages say bucket for a bucket, and notifications name it by its title.
- Read the pages of a docs site in `llms.txt` by navigation group, each with a summary.
- List every page of a docs site in `sitemap.xml` when the site allows search indexing.
- Search the whole text of the pages from the search box of a docs site.

## 1.0.618 — 2026-11-05

### Added

- Publish a bucket as a website or a docs site. A Mintlify repository works as it is: `docs.json` navigation, `.mdx` pages with snippets and components, an OpenAPI document and endpoint pages.
- Connect a GitHub repository to a bucket. The bucket's files follow the repository, and each push publishes the site.
- Start a new account by connecting a GitHub repository. Connect GitHub… is the first choice in the Connect menu and in an empty bucket.

## 1.0.616 — 2026-11-05

### Improved

- The public resource is now the bucket: a bucket has files, a site, a mailbox and agents. REST paths are `/v1/buckets/{bucket_id}`, MCP tools are `bucket_*`, and the CLI takes `--bucket-id`. The SDKs are 3.0.0.
- A bucket keeps its email in the `_mailbox/` folder. `_agents/` and `_revdoku/` are the other reserved folders; every other folder name that starts with `_` is an ordinary folder.

## 1.0.614 — 2026-11-03

### Improved

- Filter Logs by the built-in AI filter, separately from connected apps and people.
- Name more actions in Logs, such as Viewed email list and Opened email.

### Fixed

- Keep the AI filter working when the AI model does not answer: another model answers instead.
- Show "AI filter could not check this email." on an email that the AI filter could not check.

## 1.0.613 — 2026-11-03

### Improved

- Keep Compose, the folders and the labels in the mailbox sidebar in Mail, Files and Agents.
- Show the title and the address of each mailbox on two lines in the mailbox switcher.
- Show agents as numbered steps. Each step has a Settings button.
- Change the order of agents by dragging, with the arrow keys or with Move up and Move down, then select Save order.
- Open the built-in AI filter from the Agents view, like other agents. Account Settings no longer has an AI Agents tab.
- Try an agent on an email in a panel beside its settings. The result shows what the agent would do, or why it skipped the email.
- Group agent settings into When it runs, What it reads, What it does and Instructions.
- Go back one step with Back at the top right of Set up this mailbox.

### Fixed

- Save the new order after you drag an agent down.
- Show the full focus outline of form fields in dialogs.

## 1.0.548 — 2026-10-08

### Improved

- Create new accounts in the browser at app.revdoku.com. Direct API and MCP signup are unavailable.
- Require sign-in when an AI client connects to MCP, including initial tool discovery.
- Update API documentation, generated clients and the Skill for browser signup.

## 1.0.547 — 2026-10-08

### Improved

- Connect Claude web and Desktop with Claude's published identity or automatic registration.
- Open reconnect instructions from Account → Access when a saved Claude connector fails.

### Fixed

- Request sign-in when an AI client calls an account tool without a valid connection.
- Improve the security of AI app connections.

## 1.0.540 — 2026-10-06

### Improved

- Simplify web and API signup. Generate the first mailbox address from the verified email automatically.
- Shorten the API guide and show optional usernames and domains when creating another mailbox.
- API and MCP signup now use `email` and `accept_terms_and_policy` only. Signup username, permission and label options were removed.
- Remove the signup capability and policy-read endpoints. Request a verification code directly to start signup.

## 1.0.538 — 2026-10-06

### Improved

- New Free mailbox addresses use a readable prefix and a 12-character random
  suffix. An exact name requires a paid plan. Existing addresses stay unchanged.
- Explain reserved email names and link to custom-domain or upgrade settings.
- Open archived mailboxes from the bottom of the mailbox sidebar.
- Remove the automatic-source marker from label management.

### Fixed

- Keep account switching available in client accounts so people can return to
  their agency account and its mailboxes.
- Align notification email content with its footer and wrap long addresses on
  mobile screens.
- Identify deleted mailboxes in notification emails and show their deletion time once.
- Use readable yellow error text in dark mode.
- Put the read-status envelope beside the sender so subjects use the full message-list width.
- Keep Select mode in the mailbox directory and return Back to the originating view.
- Hide the test-email link after a mailbox receives its first email.
- Follow the browser system theme by default and preserve saved theme choices.
- Fix an error when an AI app connects with a one-time connection code.

## 1.0.535 — 2026-10-05

### Improved

- Identify mailboxes by their email address throughout the dashboard, API,
  MCP, CLI, SDKs and integrations. Mailbox titles are no longer public fields.
- Open a mailbox by selecting its address in mailbox lists. Use separate
  controls to copy the address or compose an email.
- Browse notification history in Analytics. Choose Short or Details in logs.
- See connection icons, counts, action reasons and mailbox links in activity logs.
- Open large mailboxes and Analytics faster. Simplify mailbox settings and menus.

## 1.0.519 — 2026-09-30

### Improved

- Create mailboxes with a confirmed receiving address in one request. Creation no
  longer requires a retry key or client-side readiness polling.
- Complete API signup with one private signup token. Human-authorized terms and
  privacy acknowledgments replace client-supplied policy versions.
- Read effective mailbox and storage quotas from a dedicated limits endpoint,
  the CLI, or MCP. Public mailbox responses use one receiving-state flag.
- Follow reorganized API and developer guides with request/response examples,
  field tables, and direct HTTP examples for JavaScript, TypeScript and Python.

### Fixed

- Hide disabled GitHub Sync controls and remove its public routes and documentation.
- Keep mailbox creation errors, website examples, CLI commands and MCP schemas
  aligned with actual API responses.

## 1.0.518 — 2026-09-30

### Added

- Choose a mailbox username through the API, MCP, CLI, and signup. Omit it for
  a generated address. Retired platform addresses remain reserved.
- Discover authorized accounts and delete individual emails with their attachments
  through the API and agent tools.

### Improved

- Keep email responses focused on message content, with storage details available
  on request. Reading email no longer changes its shared read status.
- Use direct HTTP examples for JavaScript, TypeScript, and Python, without a
  Revdoku SDK or client wrapper.
- Direct API signup requires the person to verify their email.

### Fixed

- Download protected email attachments through expiring authorized links that
  return usable bytes without exposing an API key to storage.

## 1.0.516 — 2026-09-30

- Read emails, conversations, originals and attachments through the email API,
  MCP and CLI. Email settings use `email` across clients and examples.
- Use consistent success and error responses, arrival cursors and retry guidance
  in the API and runnable JavaScript/TypeScript examples.
- Navigate with Mailboxes and Analytics in the header and switch accounts from
  the sidebar. API connections come first in the Connect menu.
- Protect file and email details on HIPAA and high-security accounts.
- Account settings have a separate Subscription tab for billing and usage.

## 1.0.513 — 2026-09-29

- Install the CLI independently from versioned GitHub Release downloads with
  SHA-256 checksums. Existing skill and plugin installation paths remain available.
- Run JavaScript or TypeScript examples for mailbox creation and readiness, mail
  reading, attachment downloads, file uploads/readback, and quota handling.
- Retry mailbox creation with a stable key and inspect monthly creation usage through
  the authenticated account profile. Deletion does not refund creation capacity.

## 1.0.508 — 2026-09-29

- Skill and plugin descriptions disclose file uploads, changes, mailbox deletion,
  and agency client creation alongside receiving email.
- Exclude Revdoku credentials, saved selections, update/version stamps, and deletion
  previews from uploads, including when configuration is stored in a project.

## 1.0.507 — 2026-09-28

- Find Revdoku as an email mailbox with shared file storage for people and AI agents.
- Start with examples for summarizing mail, collecting invoices and attachments,
  and monitoring submission replies. Email guidance appears before file storage.
- Skill and plugin descriptions make clear that email support is incoming only.

## 1.0.506 — 2026-09-28

- Uploads require an explicit path; use `upload .` for the current folder or
  `upload PATH --dry-run` to inspect the selection without connecting.
- Permanent deletion requires an explicit account/mailbox preview followed by
  `--confirm-delete TOKEN`. Confirmations expire after ten minutes and are single-use.
- Public CLI API/auth requests require https://app.revdoku.com. Storage transfers
  use approved HTTPS origins and cannot select local files outside the upload manifest.
- Skill packages contain one readable CLI implementation and a compatibility launcher.
- Fix CLI uploads on macOS. Deletion previews show complete counts, and offline
  upload previews use the saved destination.

## 1.0.499 — 2026-09-25

- Filter messages by read status or attachments, and sort newest, oldest, or unread first.
- Choose a mailbox name before creation and keep it ready when retrying a failed request.
- Review clearer activity totals and relative email arrival times, with exact timestamps on hover.
- Install portable agent skills with bundled resources and updated plugin metadata.

## 1.0.492 — 2026-09-23

- Store, share, and version files in private cloud mailboxes.
- Use each mailbox as a mailbox for messages and attachments.
- Read decoded message bodies and originals through the CLI, API, or hosted MCP.
- Coordinate authorized agents with account selection, locks, and revision checks.

Current setup and usage: [README](https://github.com/revdoku/revdoku), [mailbox guide](https://revdoku.com/docs.md),
[API](https://revdoku.com/api.md), and [MCP](https://revdoku.com/mcp.md).
