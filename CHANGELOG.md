# Revdoku Changelog

Notable customer-facing changes to Revdoku. Internal maintenance and operator-only changes are omitted.

## 1.0.480 — 2026-09-21

### Improved

- Buckets with email and ordinary files use Files / Mailbox tabs with icons and
  a shared unread badge. List / Tiles stays inside Files; redundant switching
  controls are removed. Changing tabs preserves the selected message and viewer.
- Skill, connector descriptions, and API documentation now lead with secure cloud
  storage and incoming email, with website publishing as an optional capability.

## 1.0.479 — 2026-09-21

### Added

- Buckets containing incoming email offer a Mailbox view beside List and Tiles,
  with sender/subject search, attachment filtering, and an inline reading pane.
- Quick read/unread controls share status across people and agents. Status changes
  preserve audit history; attachments are marked read separately when opened.
- Mailbox links to other bucket files, while file views link back to Mailbox.
  PDFs, other attachments, and original email use the existing inline viewers.

## 1.0.473 — 2026-09-20

### Added

- New incoming email addresses use two random words and a random letter suffix
  for easier recognition. Previously issued addresses continue receiving mail.
- Private buckets have a toolbar for activity, analytics, history, connecting AI,
  and incoming email. Analytics summarizes storage, received emails, and recent
  activity from the logs available to you.
- Connect AI is available in the Add menu, with a connection prompt above the
  workspace when no agent is connected. Buckets appear before Websites in navigation.

### Fixed

- Folders containing media default to tile view with image and video thumbnails.
  Your manual view choice is remembered for each folder.
- Visitor analytics can update during file uploads without competing for an
  exclusive bucket lock. Opening analytics and logs does not inflate usage counts.

## 1.0.453 — 2026-09-14

### Added

- The account switcher groups agencies with their clients and shows account names,
  separate client names, and owner emails. Client names can be set during creation
  or edited in Account Settings.
- Agents and the CLI can request a quick analytics summary across accessible
  websites, defaulting to this week compared with the same elapsed last week.

### Improved

- MCP, API, CLI, and documentation consistently identify account types and granted
  agency relationships, with account selection applied separately to each call.

### Fixed

- Publishing stops when the configured website root has no publishable files,
  preserving the previous live build instead of exposing sibling files.

## 1.0.451 — 2026-09-13

### Fixed

- The shell installer verifies CLI and skill payloads before installation and
  rejects alternate download sources. Skills always run their bundled CLI.
- Agent discovery describes authenticated previews. API and skill guidance now
  agree on guest comments, approval defaults, reports, and Comment fields.
- Framework draft examples use supported CLI options, and current website
  examples use `revdoku.site`.

## 1.0.450 — 2026-09-11

### Added

- Account owners receive an email and in-app notice when a website or account is
  suspended, with policy and support links. Takedown retries do not repeat notices.

## 1.0.449 — 2026-09-11

### Improved

- Signup requires explicit Terms and Acceptable Use Policy acceptance. New email
  and social identities complete account creation through signup.
- The slim, translucent Edit with Revdoku badge stays at the bottom right and
  moves above open feedback forms. Its flag opens Revdoku's report page.
- Publication notices link to the Acceptable Use Policy and support while keeping
  review details private. Bucket files remain available to download.

## 1.0.444 — 2026-09-09

### Fixed

- Pricing features no longer overlap. Cards show live website and draft allowances,
  form examples, and supported publishing formats.

## 1.0.441 — 2026-09-09

### Added

- Pro Agency includes one agency and nine client accounts with shared capacity,
  credits, and 15 unique members. Connected agents can select authorized clients.

### Improved

- Plus is now Pro, and Agency is now Pro Agency. Client subscriptions are managed
  by the provider; an ended Agency subscription preserves sites and data read-only.
- Free PDF uploads are limited to 1 MB. Pricing no longer promises an email response time.

## 1.0.439 — 2026-09-09

### Fixed

- Large website dashboards no longer download published pages to list forms.
- Dashboard settings saves return promptly without loading the full file history.
- Consecutive GitHub pulls no longer mistake previously imported content for a conflicting local edit.


## 1.0.437 — 2026-09-08

### Fixed

- Analytics delay notifications ignore pre-rollout traffic and allow new visitor
  snapshots time to arrive before alerting administrators.
- Returning website visitors receive the refreshed analytics runtime.
- Published HTML preserves encoded characters, including text surrounding built-in form placeholders.

## 1.0.436 — 2026-09-08

### Fixed

- Public visitor estimates show as unavailable when their collection is disabled,
  instead of presenting an unsupported historical estimate as zero.

## 1.0.435 — 2026-09-08

### Improved

- Analytics separates external referrers from tracking links and labels public
  audience counts as visitor-days, with unavailable or sampled estimates identified.
- CLI guidance explains static exports for Astro and Next.js and includes the
  publishing CLI with installed agent skills and plugins.

### Fixed

- Analytics excludes detected bots from human breakdowns, removes self-referrals,
  and counts clicks and downloads when detailed destinations are unavailable.

## 1.0.433 — 2026-09-08

### Improved

- Visitors can read public feedback previews and post with optional name/email.
  Require Email websites reuse the gate login, and pending feedback stays visible
  to its author. Comment emails go only to verified account members and owners.
- Shared feedback defaults to requiring approval. Reports flag review without
  hiding comments automatically.

### Fixed

- Submission deletion asks for confirmation, and editing supports Pending,
  Approved, Reported, and Hidden statuses alongside comment content.

## 1.0.431 — 2026-09-08

### Fixed

- Direct Auto-Index file links recognize the same image, media, spreadsheet, and
  source-file formats as the listing, including TSV and XLSB.

## 1.0.430 — 2026-09-08

### Improved

- Auto-Index files, including HTML, open inline with Back navigation that restores
  the folder, sorting, view, scroll, and focus. Browser Back and Forward keep the
  selected file, and folders remain available for single-file collections.

## 1.0.429 — 2026-09-08

### Fixed

- Newly posted feedback stays visible when History refreshes before the edge
  feed catches up.

## 1.0.428 — 2026-09-08

### Fixed

- Reply opens the feedback composer directly from History. Reply labels clear
  after posting or cancellation.

## 1.0.427 — 2026-09-08

### Added

- Public websites can show shared feedback: visitors see selection counts, then
  verify email to read comments and reply. Contact emails stay private.
- Shared forms support optional approval, visitor reporting, and Approve/Hide
  actions in existing submission review and notifications.

## 1.0.403 — 2026-09-04

### Improved

- New managed website URLs use `*.localhost3000.love`, while every existing
  `*.revdoku.site` URL continues to work as an alias.
- Managed website names can now be as short as three characters on every
  signed-in plan.
- Public agent, CLI, MCP, and API guidance now matches the authenticated
  private-draft and 15-minute preview workflow.

## 1.0.398 — 2026-09-04

### Improved

- The Files and Preview switcher now appears compactly beside the website address only after a preview is requested, leaving the default file view less cluttered.
- Website-list actions now use quieter borderless styling so rows are easier to scan.
- AI Helper can reuse identical OpenRouter responses for faster repeat requests while keeping provider caching disabled for High Security and HIPAA accounts.

## 1.0.397 — 2026-09-03

### Improved

- Opening Preview now builds the current draft before showing it inline, avoiding stale or partially styled previews.
- Published websites now have one-click Republish controls with publishing options kept in a compact menu, including matching AI Helper actions.

## 1.0.395 — 2026-09-03

### Added

- Built-in forms can open in accessible popups from buttons styled by the published website, including buttons rendered by SPAs.
- The dashboard AI Helper can create and edit website files in a guided, preview-first workflow for signed-in accounts.

### Improved

- Website creation now starts with a private account draft; the retired anonymous publishing and claim flow is no longer offered.
- Form popup references that become unavailable no longer remove the website's original button or content.
- The form setting that keeps floating widgets beside inline and popup embeds is now named `show_floating_with_embeds`; the previous key remains compatible for older clients.
- Generated Auto-Index websites now open supported direct file links in Revdoku's viewer while keeping HTML pages direct and owner-disabled downloads hidden.

## 1.0.366 — 2026-08-27

### Added

- Paid website forms can hide the Revdoku mark; anonymous and Free forms now show the Revdoku icon and name consistently.

### Improved

- Free website forms now use unchanged predefined templates; custom form copy, fields, behavior, appearance, and widget anchors require a paid plan.
- Predefined form templates now include short, context-specific descriptions.
- Publication moderation now reviews effective built-in form titles, descriptions, fields, and behavior together with published files.

## 1.0.361 — 2026-08-26

### Added

- Form fields can use custom placeholder copy independently from their labels.

### Improved

- Optional and required date fields stay visibly blank until a visitor opens the date picker.
- PDF previews no longer repeat a header above the PDF toolbar, and the toolbar uses the file's real filename instead of a page or document title.

## 1.0.359 — 2026-08-26

### Improved

- A lone top-level HTML file now opens as the website homepage automatically.
- Missing-index file collections keep their navigable Auto-Index Page, with HTML files opening directly and a visible fallback if a rich preview cannot load.

## 1.0.358 — 2026-08-25

### Improved

- Added a concise Free-account reminder after users publish multiple active anonymous previews.

## 1.0.352 — 2026-08-22

### Improved

- Standardized every published-site form submit button to “Send”.
- Protected form-delivered resources with six-hour signed viewer links, blocking direct unsigned access and invalidating old links on republish.

## 1.0.350 — 2026-08-22

### Added

- Added a Booking request form template and calendar-date fields for published-site forms.
- Free forms can now open a same-site file or folder after a confirmed submission.

### Improved

- Added a 30-submission monthly Free allowance alongside the existing 3-per-day limit.
- Added Auto, Light, and Dark themes for inline forms, and kept floating widgets visible by default when the same form is embedded inline.
- Simplified the pricing comparison so plan limits are easier to scan.

## 1.0.290 — 2026-08-05

### Added

- GitHub Sync is now available in production: import an existing repository into an empty bucket or export a bucket to a new private repository, then keep changes synchronized automatically in both directions.

### Improved

- Added clearer GitHub App permission guidance, repository links, and explicit import/export setup.

## 1.0.271 — 2026-08-01

### Improved

- Minor fixes of feedback widget location incorrect on mobile phones after submitting a comment
- Added a focused feedback review workspace and clearer visitor alerts.
- Improved Auto-Index behavior and navigation between published files.

## 1.0.248 — 2026-07-23

### Added

- Added visitor journey analytics for understanding how people move through a published site.

## 1.0.244 — 2026-07-22

### Added

- Added document feedback and clearer viewer activity for published files.

## 1.0.220 — 2026-07-13

### Improved

- Added more granular collaboration permissions and clearer client activity details.

## 1.0.208 — 2026-07-09

### Improved

- Streamlined quick publishing with better examples and in-browser file editing.

## 1.0.177 — 2026-07-05

### Added

- Added Public, Password, and Require Email access choices with recipient-friendly sharing links.

## 1.0.168 — 2026-07-04

### Added

- Added built-in contact, feedback, and intake forms for published sites.

## 1.0.146 — 2026-06-25

### Added

- Added lifetime controls and expiry warnings for free published sites.

## 1.0.142 — 2026-06-24

### Improved

- Made custom-domain setup more reliable and added permanent-site support.

## 1.0.130 — 2026-06-22

### Improved

- Expanded static-site support for JavaScript, fonts, and other binary assets.

## 1.0.111 — 2026-06-16

### Improved

- Streamlined passwordless sign-in and AI-agent connection flows.

## 1.0.99 — 2026-06-12

### Improved

- Added richer Auto-Index previews and easier navigation through published folders.

## 1.0.95 — 2026-06-11

### Added

- Added verified-email visitor access and access analytics for protected sites.

## 1.0.83 — 2026-06-07

### Improved

- Made uploads reliable for folders containing several thousand files.

## 1.0.71 — 2026-06-05

### Added

- Added password protection for published websites.

## 1.0.47 — 2026-06-02

### Added

- Added hosted MCP connections and email notifications.
