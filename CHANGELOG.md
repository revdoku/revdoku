# Revdoku Changelog

## 1.0.650 — 2026-11-11

### Added

- Read a site's analytics by section: send `section` (`agents`, `humans`, `pages`, `search`, `ask_ai` or `gaps`) to `GET /v1/buckets/{bucket_id}/analytics`, or to the MCP tool `bucket_publication_get`. Each section has the lists that the dashboard shows.
- Use the `gaps` section to find what your docs do not answer: questions that Ask AI could not answer, searches without results, pages that readers marked as not helpful and missing pages. Each page names its source file, so an AI agent can update the docs.

### Improved

- Analytics of a site has its own pages in the sidebar: Overview, AI agents, Humans, Pages, Search and Ask AI. Each page shows only its own lists, and a list without data is not shown.
- The Ask AI numbers of the traffic widget open the Ask AI conversations.
- AI chats comes right after Inbox in Support.

### Fixed

- A link to the Analytics of a site opens Analytics, not Logs.

## 1.0.649 — 2026-11-11

### Added

- Each Ask AI conversation on your docs site is now a support ticket with its own number. Read it as a conversation in the new AI chats folder of Support, and solve or reopen it there.
- A message that a visitor leaves after an AI chat joins the ticket of that chat, so the questions, the AI's answers and your reply are in one place.

## 1.0.648 — 2026-11-11

### Added

- See the search history of your docs site in Analytics: each search, and whether the visitor opened a page, found nothing or opened no page.
- See the activity of AI agents on your docs site in Analytics: each search with its number of results, and each page that an agent read through the site's MCP server.
- Read a site's analytics with `GET /v1/buckets/{bucket_id}/analytics`, or with `analytics` in the MCP tool `bucket_publication_get`.

### Improved

- The dashboard starts with a bucket switcher in the sidebar, and bucket lists show the site address.
- The traffic widget stacks AI agents, humans and bots in one chart, with a comparison to the period before.
- Critical notifications open as a dialog.
- A search that you send to Ask on a docs site starts an AI conversation and is no longer counted as a search.

## 1.0.647 — 2026-11-11

### Added

- Create a bucket that starts with a docs site: send `bucket.template` (`docs-api` or `docs-product`) in the API, `template` in the MCP tool `bucket_create`, or `--template` in `revdoku create`.
- Start from the new `docs-product` template for the docs of a web, mobile or desktop app.
- Describe your product when you start, and the docs site begins with its name and a short summary.
- Docs pages give search engines and link previews their own data: the page's address, title and description, and structured data (JSON-LD) with its place in the site.

### Improved

- Ask on a docs site: "Was this helpful?" with Yes and No, sources in one line that opens, and a clearer answer when the docs do not cover a question.
- Ask on a docs site keeps a passed security check while you move between pages.
- Docs pages: the header lines up with the page list on wide screens, and the Pages menu on phones shows that it opens.
- The sitemap of a site of uploaded HTML pages lists every page.
- Site settings have "Hide this site from search engines", off by default. Previews are always hidden from search engines.
- The API and MCP guides follow the order of a first integration and show how to preview a branch.

## 1.0.646 — 2026-11-11

### Added

- Start a docs site from a template: name it, and it is live in one step. Then connect your AI app to change the pages, or connect a GitHub repository later.
- Connect a GitHub repository to a bucket that already has files. The site and its address stay. When the repository has files, they replace the bucket's files, which stay in the bucket's versions. When the repository is empty, the bucket's files become its first commit. In the API, MCP and CLI, send `bucket_files` (`replace` or `copy`) after a person agrees; without it the answer is `409 GITHUB_SYNC_BUCKET_NOT_EMPTY` with the value that fits.

### Improved

- Publish a bucket's files without a GitHub repository. See https://app.revdoku.com/pricing.
- Change files with your AI app or through GitHub. The file viewer shows Edit with AI in place of the editor.
- See an AI answer on a docs site write itself out like a chat reply, with its sources after it.
- See that Ask is working from the moment you send a question, also with reduced motion on your device.
- Use the full width of the page for the site overview and its Analytics, with AI agents and people in the traffic widget.

### Fixed

- A redirect rule of a site matches its path with and without the trailing slash.
- A GitHub sync that added and removed files at the same time no longer stops with a locked bucket.

## 1.0.645 — 2026-11-10

### Improved

- Connect a GitHub repository with less setup: Revdoku finds the folder that holds your docs and names its format before the first sync. You can change the folder and the branch.
- See and change the address of your site when you connect GitHub. You can add your own domain later.
- Keep your code private: a repository that does not look like docs is not published automatically. Publish it yourself when you are ready.
- Read and answer support tickets from the CLI: `revdoku tickets`, `ticket ID`, `ticket-messages ID`, `ticket-reply ID --text TEXT`, `ticket-update ID --status solved`, `ticket-download ID --message-id ID` and `ticket-message-delete ID`. They replace the `emails` and `email-*` commands.
- Get a subscription token for live ticket events with `revdoku events-subscription`. It replaces `email-subscription`. The `webhook` commands set the webhook for ticket events.
- Preview a branch of the connected repository from the CLI with `revdoku preview --branch NAME`, and list the branches with `revdoku github branches`.
- Read a bucket's email address from `revdoku ls`. The `mailbox` command is gone.
- Use the CLI, the skill, the guides and the examples with the current API names: tickets, `email` in a bucket, `/github` and `/v1/auth`.

## 1.0.644 — 2026-11-10

### Added

- Preview a branch of your GitHub repository from the API and MCP: `POST /v1/buckets/{bucket_id}/publication/preview` takes `branch`, and `GET /v1/buckets/{bucket_id}/github/branches` lists the branches. In MCP, use `bucket_publish` with `action: "preview"` and `branch`, and `bucket_github` with `action: "branches"`.

### Improved

- See your site right after you connect GitHub: Import and sync publishes the site after the first sync, without a Publish click. Uncheck "Publish the site after the first sync" to publish later. You can change the address, layout and Ask AI afterwards.

## 1.0.643 — 2026-11-10

### Improved

- Keep Ask AI conversations and feedback comments as long as your site's analytics. Your plan sets how much of this history the Analytics page shows, and an upgrade shows all of it at once. See https://app.revdoku.com/pricing.
- Send only replies from a bucket: each reply answers a received message and goes to the person who sent it.
- Read and answer support requests as tickets in the API and MCP. A ticket is one conversation that came by email, as a message left on your docs site or as page feedback. Use `GET /v1/buckets/{bucket_id}/tickets`, `GET` and `PATCH .../tickets/{ticket_id}` (solve, reopen, labels) and `POST .../tickets/{ticket_id}/messages` to reply to the requester. The MCP tools are `bucket_ticket_list`, `bucket_ticket_get`, `bucket_ticket_reply`, `bucket_ticket_update`, `bucket_ticket_download` and `bucket_ticket_message_delete`. They replace the `/mailbox/emails` endpoints and the `bucket_email_*` tools.
- Get ticket events for every channel from one webhook and one live subscription per bucket: `/v1/buckets/{bucket_id}/webhook` and `/v1/buckets/{bucket_id}/events/subscription`, or the MCP tools `bucket_webhook` and `bucket_events_subscription`. Events are `ticket.created` and `ticket.message_received`, with `ticket_id`, `message_id` and `channel`. A message labeled Junk sends no event.
- Use clearer API names. Sign-in for the CLI and AI agents is under `/v1/auth` (`sign_in_code`, `sign_in_code/verify`, `grant/exchange`, `dashboard_link`). GitHub is `/v1/buckets/{bucket_id}/github` and `/v1/account/github/installations`, with the JSON key `github`. A bucket's address is `bucket.email.address`, and a new bucket takes `email: {username, domain}`.
- Upload one file with `POST /v1/buckets/{bucket_id}/uploads`, and lock or unlock a bucket or its files with `POST /v1/buckets/{bucket_id}/lock` and `.../unlock`.
- Change a bucket's address, aliases, allowed senders and email domains in the dashboard. The API no longer has endpoints for them.
- The SDKs and the CLI move to these names in their next versions.
- Choose Send at once or Review first in the Replies tab of Email Settings. The Send only to tab is gone.
- Let AI agents reply to the sender. The Email members action of agents is gone.
- Get credits every month on the Free plan, in addition to the signup credits. Monthly credits are spent first and do not roll over. See https://app.revdoku.com/pricing.
- Name a new bucket with the address of its first site. A bucket that got a made-up name at signup takes the address you choose at its first Publish, so the bucket, its site and its email have one name.
- Publish and preview sites with credits: a publish or preview uses credits only when a new version goes live. An unchanged republish, a failed build and reading your site use none.
- Pay a fixed number of credits for each Ask AI question that AI reads, answered or not. A question answered from search only uses none.
- Index your docs for Ask AI as part of each publish, with no separate charge.
- See what each action costs in the FAQ of the pricing page and in `credits.costs` of https://app.revdoku.com/pricing.json.
- Get `402 INSUFFICIENT_CREDITS` from `POST /v1/buckets/{bucket_id}/publication`, `POST /v1/buckets/{bucket_id}/publication/preview`, the `bucket_publish` MCP tool, `revdoku publish` and `revdoku preview` when the account has too few credits. Nothing is built, and the dashboard shows the error with an upgrade link for people who manage billing.
- See "Publishing paused: not enough credits" on the Site page when a GitHub push could not publish. The commit shows "Not enough credits to publish", and the site keeps its version. When credits arrive, the waiting push publishes.
- Change the docs layout and Ask AI of a live site without credits: a settings save rebuilds the site with the files it already serves.

## 1.0.642 — 2026-11-10

### Improved

- Preview any branch of your GitHub repository from New preview on the site's Previews page. Revdoku builds a 24-hour preview of the branch, as after a push to it.
- Publish a site from a shorter dialog: its address, the docs layout and Ask AI. A new site is public.
- Republish a site in one click. Change its docs layout and Ask AI on the site's Settings page.
- Read what visitors were looking for when a docs page did not help them. Their comment arrives in Support as an anonymous email that cannot be replied to, and the site's Analytics lists it with its page. No AI answers it.
- See the site's address at the top right of every bucket page, next to the page's own actions. Pages no longer repeat their name above the content.
- Choose a docs layout from a dropdown with a small preview of the layout.
- Site analytics are always on, so the Settings page no longer has a switch for them.
- Reply to support requests from Support. Support only answers requests that come in, so it has no Compose button.
- Find a draft that waits for your approval in its conversation in Support. The Drafts folder is gone, and links to it open the draft.
- Open Email Settings from the gear button at the top right of Support.
- Remove the website chat button for other websites and its Email Settings tab. Visitors of your docs sites still reach you with Leave a message.
- Email your reply to a visitor who left a message at once.
- Open public sites faster. Browsers keep their logo, icons, images and search index between visits.
- Choose Last 12 Months in a site's Analytics. A chart of more than 90 days shows one point per week.
- See more of the referrers, bots and AI agents that reach your sites in a site's Analytics.
- Compare this week with last week at the top of Manage buckets: AI agent requests, views and visitors of all your sites, per day. Its period menu also sets the totals below it.
- See the same comparison for one site at the top of its Site page. Click it to open the site's Analytics.
- Read the transcript of every Ask AI conversation in the site's Analytics, answered or not: each question, what the visitor saw, the pages and the vote.
- Show only the Ask AI conversations that got no answer, and open the support ticket of a visitor who left a message.

### Fixed

- See every site setting on the Settings page again, including the Revdoku badge and the GitHub options.
- Get Ask AI answers to short questions and questions with typos, such as "how to publishw ebsite". Before, Ask AI often said that the docs did not answer them.

## 1.0.641 — 2026-11-10

### Improved

- Choose a bucket's GitHub repository from a dropdown with a search field. The branch and the folder sit in one row with Import and sync.
- See a connected repository and the progress of its sync in one short block on the GitHub page.
- Choose how edits made in Revdoku reach GitHub on the site's Settings page, next to Auto-publish GitHub updates.

## 1.0.640 — 2026-11-09

### Added

- Connect a GitHub repository to a bucket from the API, the TypeScript and Python SDKs, the `revdoku github` CLI commands and the `bucket_github` MCP tool. Your AI agent lists your connected GitHub accounts and their repositories, connects a repository, reads the sync state, syncs, changes the settings and disconnects. See [GitHub repositories](https://revdoku.com/api.md#github-repositories).
- Get the link to add a GitHub account from the API: your agent gives it to you, and you install the Revdoku GitHub App on GitHub while signed in to Revdoku.
- See how many searches visitors made in your site's search box, as a number in the site's Analytics.
- See the request number at the end of each reply's subject, such as `[#3]`. An answer from the same person that keeps the number joins the same request, also without reply headers.
- Search or ask from a small bar at the bottom of every docs page. It shows the matching pages as you type, and asks AI only when you choose Ask.
- Rate an Ask AI answer with Helpful or Not helpful. The site's Analytics shows the vote next to the question.

### Improved

- Give a bucket one name for its site and its email: the bucket `acme-docs` gets the site `acme-docs.revdoku.site` and the address `acme-docs@revdokumail.com`, with no random characters.
- Change a site's address, and the bucket's revdokumail.com address follows it. The earlier address keeps receiving, so replies to old emails still arrive.
- Use your account's earlier names again: the name of a deleted bucket, an earlier site address or a removed alias. No other account can take them.
- See your GitHub accounts first on a bucket's GitHub page, then the repositories, then Import and sync.
- Refresh your GitHub accounts and their repositories with one Refresh button at the top right, next to Add GitHub account.
- Connect each GitHub account that you own with its own Connect button, and choose its repositories on GitHub with Manage access.
- Add a GitHub account in a new tab. When you come back, the page shows the new account and its repositories.
- Choose a repository from a list with icons and a search field. The branch and the folder stay folded until you change them.
- Start every GitHub connection from the repository. Revdoku no longer offers to copy a bucket into an empty repository.
- Open a docs site's search from the icon in the header, with Cmd+K or Ctrl+K, or with /. Each result shows its section, page and group.
- Read Ask AI answers as a chat, with code blocks, lists and links to the pages that they cite. Copy an answer or ask again, and keep the conversation while you move between pages.
- Open a matching page while you type a question in Ask, or press Enter to ask.
- Copy a docs page, or open it in an AI app, from one button next to the page title. Each menu item says what it does.
- Switch a docs site's language from the menu next to the logo, and its theme from the top right of the header.
- See the section that you read in On this page, the page's group above its title, and the method of each API endpoint page in the page list.
- See exact counts of people's views, bot requests, AI agent requests and searches in a site's Analytics. A number stays the same when you reload the page, and the lists of pages, referrers, countries, bots and AI agents add up to it.
- See today's visitors so far in a site's Analytics. Before, the number showed "—" until enough of the day was counted.
- Open Buckets, Activity and Settings from the sidebar of Manage buckets and Account Settings. The bucket list says Bucket instead of Mailbox, and the date range of its totals sits next to the page title.
- Read each bucket's name in the Grid view of Manage buckets: the email buttons now sit beside the email count. Logs, the account list of the bucket switcher, the Webhooks table and the API's "Bucket not found" error name buckets, not mailboxes.

### Fixed

- Receive email, chat messages and messages left on a docs site, and send replies, while the bucket's site publishes. Before, they could fail during a long publish.

## 1.0.639 — 2026-11-09

### Added

- Ask readers "Was this page helpful?" at the end of every docs page. A reader who answers No can say what they were looking for, and Ask answers it.

### Improved

- Name notifications by what needs you: "Draft of reply awaiting approval" and "Needs a reply". A message left on a docs site arrives as "Question: …".
- End emails sent from the Free plan with a shorter line: "Sent with Revdoku".
- Pick the date range of a site's analytics from one dropdown.
- See the totals of all your buckets at the top of the Buckets page.
- Open a bucket's Logs, Notifications and Webhooks under Activity in the bucket's sidebar, and go back to its site, support or files from there.
- Create a bucket from New bucket at the bottom of the sidebar.

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
