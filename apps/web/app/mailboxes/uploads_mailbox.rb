class UploadsMailbox < ApplicationMailbox
  INBOUND_ADDRESS_REGEX = /\Auploads\+([^@]+)@/i
  PDF_MIME = "application/pdf".freeze
  MAX_SUBJECT_BYTES = 255
  AUDIT_PATH = "/inbound_email/uploads".freeze
  # Sentinel header set by an ingress when the remote message body cannot
  # be fetched. When present, the email arrives with just From / To /
  # Subject and no body — sender + recipient still resolve via the normal
  # callbacks, then `check_ingress_error` short-circuits into the standard
  # bounce pipeline so audit + notifications fire for resolved members
  # (silent drop for non-members). Keeps ingress failures visible in /logs
  # instead of bubbling up to the admin-email exception reporter.
  INGRESS_ERROR_HEADER = "X-Revdoku-Ingress-Error".freeze

  before_processing :extract_inbound_metadata
  before_processing :resolve_account
  before_processing :authenticate_sender
  before_processing :check_ingress_error
  before_processing :collect_attachments
  before_processing :enforce_plan_envelope_cap
  before_processing :enforce_size_limits
  before_processing :parse_forward

  def process
    envelope = nil
    ApplicationRecord.transaction do
      ActsAsTenant.with_tenant(@account) do
        Principal.account = @account
        Principal.user = @user

        envelope = @account.envelopes.create!(
          title: derived_title,
          source: :email,
          status: :new,
          inbound_metadata: metadata_payload,
          auto_tag_paths: [ "Source/Email" ]
        )
        revision = envelope.envelope_revisions.create!(
          revision_number: 0,
          comment: revision_comment
        )

        dfrs = @pdf_attachments.map { |att| attach_file(envelope, revision, att) }
        envelope.update_title_from_files!(dfrs) if envelope.title.blank?

        record_audit(envelope: envelope, response_code: 201, extras: { attachments: dfrs.size })
        notify_delivered(envelope)
      end
    end
  ensure
    Principal.account = nil
    Principal.user = nil
  end

  private

  # -------- before_processing callbacks --------

  def extract_inbound_metadata
    @inbound_message_id = mail.message_id.to_s.presence
    @sender_email       = mail.from&.first.to_s.strip
    @matched_address    = find_upload_recipient
  end

  def resolve_account
    tag = @matched_address.to_s[INBOUND_ADDRESS_REGEX, 1]
    # Defensive downcase: new tokens are lowercase hex (RFC-safe), but
    # existing mixed-case tokens are preserved. A sender/forwarder that
    # re-cases the local-part would break a case-sensitive match; look
    # up with a downcased key so both old and new tokens survive.
    if tag.present?
      normalized = tag.downcase
      @account = Account.find_by(inbound_token: normalized) ||
                 Account.find_by(inbound_token: tag)
    end
    return if @account

    bounce_with_reason(response_code: 404, reason: "unknown_recipient",
      log: "[UploadsMailbox] bounce: unknown recipient (to=#{mail.to.inspect} matched=#{@matched_address.inspect})")
  end

  def authenticate_sender
    if @sender_email.present?
      canonical = User.canonicalize_email(@sender_email)
      @user = ActsAsTenant.with_tenant(@account) do
        @account.users.find_by(email_canonical: canonical)
      end
    end
    return if @user

    bounce_with_reason(response_code: 403, reason: "sender_not_member",
      log: "[UploadsMailbox] bounce: sender #{@sender_email.inspect} not a member of #{@account.prefix_id}")
  end

  def check_ingress_error
    code = mail.header[INGRESS_ERROR_HEADER]&.decoded.to_s.strip
    return if code.empty?

    # Callbacks before this one (resolve_account, authenticate_sender)
    # have already set @account / @user if the recipient + sender are
    # resolvable — so `bounce_with_reason` below will audit + notify
    # iff this is a resolved member, otherwise silently drop per the
    # project-wide silent-bounce-for-non-members rule.
    bounce_with_reason(
      response_code: 422,
      reason: code,
      log: "[UploadsMailbox] bounce: ingress error #{code.inspect} for #{@sender_email.inspect} → #{@matched_address.inspect}"
    )
  end

  def collect_attachments
    non_inline = Array(mail.attachments).reject do |att|
      # Reject inline parts regardless of filename — covers signature logos etc.
      att.content_disposition.to_s.downcase.start_with?("inline")
    end

    if non_inline.empty?
      return bounce_with_reason(response_code: 422, reason: "no_attachments",
        log: "[UploadsMailbox] bounce: no attachments from #{@sender_email.inspect}")
    end

    pdfs     = non_inline.select { |att| att.mime_type.to_s.downcase == PDF_MIME }
    @skipped_non_pdf_filenames = (non_inline - pdfs).map(&:filename).compact

    if pdfs.empty?
      return bounce_with_reason(response_code: 415, reason: "no_pdf_attachments",
        log: "[UploadsMailbox] bounce: no PDF attachments (skipped: #{@skipped_non_pdf_filenames.inspect})")
    end

    if @skipped_non_pdf_filenames.any?
      Rails.logger.info("[UploadsMailbox] skipping non-PDF attachments: #{@skipped_non_pdf_filenames.inspect}")
    end

    @pdf_attachments = pdfs
  end

  def enforce_plan_envelope_cap
    return if ActsAsTenant.with_tenant(@account) { @account.allows_envelope_creation? }

    bounce_with_reason(response_code: 402, reason: "envelope_limit_reached",
      log: "[UploadsMailbox] bounce: envelope cap reached for #{@account.prefix_id}")
  end

  def enforce_size_limits
    per_file_limit = FileSizeLimits.max_file_size_for_account(@account)
    oversized = @pdf_attachments.find { |att| att.decoded.bytesize > per_file_limit }
    if oversized
      return bounce_with_reason(response_code: 413, reason: "file_too_large",
        log: "[UploadsMailbox] bounce: #{oversized.filename.inspect} exceeds #{per_file_limit} bytes")
    end

    total = @pdf_attachments.sum { |att| att.decoded.bytesize }
    if total > FileSizeLimits.max_envelope_size
      bounce_with_reason(response_code: 413, reason: "envelope_too_large",
        log: "[UploadsMailbox] bounce: total #{total} bytes exceeds envelope cap #{FileSizeLimits.max_envelope_size}")
    end
  end

  def parse_forward
    @forward = InboundEmail::ForwardParser.parse(mail)
  end

  # -------- process helpers --------

  def attach_file(envelope, revision, attachment)
    payload = attachment.decoded
    document_file = envelope.document_files.create!
    dfr = document_file.document_file_revisions.build(
      revision_number: 0,
      mime_type: attachment.mime_type,
      content_hash: Digest::SHA256.hexdigest(payload)
    )
    dfr.name = attachment.filename
    dfr.file.attach(
      io: StringIO.new(payload),
      filename: dfr.sanitized_blob_filename,
      content_type: attachment.mime_type
    )
    dfr.save!
    revision.add_document_file_revision(dfr)
    dfr
  end

  # -------- recipient + title helpers --------

  def find_upload_recipient
    candidates = Array(mail.recipients_addresses).map do |addr|
      addr.respond_to?(:address) ? addr.address.to_s : addr.to_s
    end
    candidates.find { |a| a.match?(INBOUND_ADDRESS_REGEX) }
  end

  def derived_title
    candidate = @forward&.original_subject.presence ||
                strip_forward_prefix(mail.subject.to_s).presence ||
                mail.subject.to_s
    ActionController::Base.helpers.strip_tags(candidate).to_s.strip[0, MAX_SUBJECT_BYTES].to_s
  end

  def strip_forward_prefix(subject)
    subject.to_s.sub(InboundEmail::ForwardParser::FORWARD_PREFIX_RE, "").strip
  end

  def metadata_payload
    {
      forwarder_email: @sender_email,
      inbound_message_id: @inbound_message_id,
      forwarded: @forward&.forwarded,
      parser_method: @forward&.parser_method&.to_s,
      original_from: @forward&.original_from,
      original_from_name: @forward&.original_from_name,
      original_subject: @forward&.original_subject,
      original_date: @forward&.original_date,
      original_date_raw: @forward&.original_date_raw,
      original_message_id: @forward&.original_message_id
    }.compact
  end

  def revision_comment
    return "Received via email from #{@sender_email}" unless @forward&.forwarded

    if @forward.original_from.present?
      date_str = @forward.original_date.present? ? @forward.original_date.to_s[0, 10] : @forward.original_date_raw
      tail = date_str.present? ? " on #{date_str}" : ""
      "Forwarded via email by #{@sender_email} — original from #{@forward.original_from}#{tail}"
    else
      "Forwarded via email by #{@sender_email} (original sender unknown)"
    end
  end

  # -------- audit + bounce --------

  def bounce_with_reason(response_code:, reason:, log:)
    Rails.logger.info(log)
    # Silent-drop rule: when the sender is not a resolved account
    # member (either the recipient token doesn't match an account, or
    # the sender email isn't a member of the resolved account), skip
    # audit + notification to keep the owner's /logs free of noise
    # from spam / wrong-recipient / external-sender traffic. We still
    # `bounced!` so ActionMailbox marks the message and SES stops
    # retrying. See the "Silent bounce for non-members" memory for
    # the project-wide convention.
    if @user && @account
      record_audit(envelope: nil, response_code: response_code, extras: { reason: reason })
      notify_bounced(reason)
    else
      Rails.logger.warn("[UploadsMailbox] silent bounce (non-member or unknown recipient): reason=#{reason} code=#{response_code}")
    end
    bounced!
  end

  def notify_delivered(envelope)
    return unless @user && @account

    NotificationService.notify!(
      user: @user,
      account: @account,
      type: "inbound_email_delivered",
      params: {
        envelope_id: envelope.prefix_id,
        subject: envelope.title.to_s[0, 120],
        forwarded: @forward&.forwarded || false
      }
    )
  rescue => e
    Rails.logger.warn("[UploadsMailbox] delivered notification failed: #{e.class}: #{e.message}")
  end

  def notify_bounced(reason)
    # Can only notify users we actually resolved. For `sender_not_member`
    # and `unknown_recipient` there's no in-app identity to notify.
    return unless @user && @account

    ActsAsTenant.with_tenant(@account) do
      NotificationService.notify!(
        user: @user,
        account: @account,
        type: "inbound_email_bounced",
        params: {
          reason: reason,
          sender: @sender_email,
          subject: mail.subject.to_s[0, 120]
        }
      )
    end
  rescue => e
    Rails.logger.warn("[UploadsMailbox] bounced notification failed: #{e.class}: #{e.message}")
  end

  def record_audit(envelope:, response_code:, extras: {})
    payload = {
      sender: @sender_email,
      message_id: @inbound_message_id,
      inbound_address: @matched_address,
      subject: mail.subject.to_s[0, 200],
      attachment_count: Array(@pdf_attachments).size,
      total_bytes: Array(@pdf_attachments).sum { |a| a.decoded.bytesize },
      skipped_non_pdf: Array(@skipped_non_pdf_filenames).presence,
      forwarded: @forward&.forwarded,
      parser_method: @forward&.parser_method&.to_s,
      original_from: @forward&.original_from,
      original_subject: @forward&.original_subject
    }.merge(extras).compact

    AuditLog.create!(
      source_type: :INTERNAL,
      path: AUDIT_PATH,
      response_code: response_code,
      account_id: @account&.prefix_id,
      user_id: @user&.prefix_id,
      envelope_id: envelope&.prefix_id,
      request: payload,
      response: { envelope_id: envelope&.prefix_id }.compact
    )
  rescue => e
    Rails.logger.warn("[UploadsMailbox] audit-log write failed: #{e.class}: #{e.message}")
  end
end
