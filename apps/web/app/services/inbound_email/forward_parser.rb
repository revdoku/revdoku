module InboundEmail
  # Parses forward metadata out of an inbound Mail::Message.
  #
  # Tries, in order:
  #   1. Gmail "---------- Forwarded message ----------" block
  #   2. Apple Mail "Begin forwarded message:" block
  #   3. Outlook "-----Original Message-----" block (with or without field order variants)
  #   4. Formal RFC/extension headers (Resent-*, X-Forwarded-*)
  #   5. No detection → forwarded: false
  #
  # Returns a frozen Result struct — callers treat `.forwarded`,
  # `.original_from`, `.original_subject`, `.original_date`,
  # `.original_date_raw`, `.parser_method` etc. as read-only.
  class ForwardParser
    Result = Struct.new(
      :forwarded,
      :original_from,
      :original_from_name,
      :original_subject,
      :original_date,
      :original_date_raw,
      :original_message_id,
      :parser_method,
      keyword_init: true
    )

    # Subject-line prefixes we strip when the original subject isn't parseable
    # from the body. Multi-language: en(fwd/fw), fr(tr), de(wg), es/it(rv/i),
    # repeated in case of Fwd: Re: Fwd: chains.
    FORWARD_PREFIX_RE = /\A(?:(?:fwd?|fw|tr|wg|rv):\s*)+/i

    GMAIL_BLOCK_RE = /
      ^-{5,}\s*Forwarded\s+message\s*-{5,}\s*\r?\n
      (?:^(?:From|De|Von|Da):\s*(?<from>.+?)\r?\n)
      (?:^(?:Date|Sent|Fecha|Envoy[eé]|Gesendet):\s*(?<date>.+?)\r?\n)?
      (?:^(?:Subject|Asunto|Objet|Betreff):\s*(?<subject>.+?)\r?\n)?
      (?:^(?:To|Para|[AÀ]|An):\s*.+?\r?\n)?
    /xi

    APPLE_BLOCK_RE = /
      ^Begin\s+forwarded\s+message:\s*\r?\n
      \s*\r?\n
      (?:^(?:From):\s*(?<from>.+?)\r?\n)?
      (?:^(?:Subject):\s*(?<subject>.+?)\r?\n)?
      (?:^(?:Date):\s*(?<date>.+?)\r?\n)?
      (?:^(?:To):\s*.+?\r?\n)?
    /xi

    OUTLOOK_BLOCK_RE = /
      (?:
        ^-{5,}\s*Original\s+Message\s*-{5,}\s*\r?\n |
        ^_{10,}\s*\r?\n
      )
      (?:^(?:From):\s*(?<from>.+?)\r?\n)
      (?:^(?:Sent):\s*(?<date>.+?)\r?\n)?
      (?:^(?:To):\s*.+?\r?\n)?
      (?:^(?:Cc):\s*.+?\r?\n)?
      (?:^(?:Subject):\s*(?<subject>.+?)\r?\n)?
    /xi

    def self.parse(mail)
      new(mail).parse
    end

    def initialize(mail)
      @mail = mail
    end

    def parse
      try_gmail || try_apple || try_outlook || try_headers_only || empty_result
    end

    private

    def try_gmail
      match = body_text.match(GMAIL_BLOCK_RE)
      return nil unless match
      build_result(match, :gmail_forward_header)
    end

    def try_apple
      match = body_text.match(APPLE_BLOCK_RE)
      return nil unless match
      build_result(match, :apple_forward_header)
    end

    def try_outlook
      match = body_text.match(OUTLOOK_BLOCK_RE)
      return nil unless match
      build_result(match, :outlook_forward_header)
    end

    # X-Forwarded-For / Resent-From etc. — no body match, but headers indicate
    # the mail was forwarded by infrastructure.
    def try_headers_only
      resent_from = @mail["Resent-From"]&.to_s
      xfwd_from   = @mail["X-Forwarded-For"]&.to_s || @mail["X-Forwarded-From"]&.to_s
      return nil if resent_from.blank? && xfwd_from.blank?

      addr = parse_address(resent_from.presence || xfwd_from)
      Result.new(
        forwarded: true,
        original_from: addr[:email],
        original_from_name: addr[:name],
        original_subject: nil,
        original_date: nil,
        original_date_raw: nil,
        original_message_id: @mail["Resent-Message-ID"]&.to_s.presence,
        parser_method: :resent_headers
      ).freeze
    end

    def empty_result
      Result.new(
        forwarded: false,
        original_from: nil,
        original_from_name: nil,
        original_subject: nil,
        original_date: nil,
        original_date_raw: nil,
        original_message_id: nil,
        parser_method: :none
      ).freeze
    end

    def build_result(match, method)
      raw_date    = named_capture(match, :date)
      raw_subject = named_capture(match, :subject)
      raw_from    = named_capture(match, :from)
      from_parsed = raw_from ? parse_address(raw_from) : { email: nil, name: nil }

      Result.new(
        forwarded: true,
        original_from: from_parsed[:email],
        original_from_name: from_parsed[:name],
        original_subject: raw_subject,
        original_date: normalize_date(raw_date),
        original_date_raw: raw_date,
        original_message_id: nil,
        parser_method: method
      ).freeze
    end

    def named_capture(match, name)
      match.names.include?(name.to_s) ? match[name]&.strip.presence : nil
    end

    def body_text
      return @body_text if defined?(@body_text)

      chunks = []
      chunks << to_utf8(@mail.text_part.body.decoded) if @mail.text_part
      chunks << to_utf8(ActionController::Base.helpers.strip_tags(to_utf8(@mail.html_part.body.decoded))) if @mail.html_part

      if chunks.empty?
        if @mail.multipart?
          # Some clients stash plain text as the MIME preamble instead of a
          # dedicated text/plain part. Include it as a fallback.
          chunks << to_utf8(@mail.preamble) if @mail.preamble.to_s.present?
        else
          chunks << to_utf8(@mail.body.decoded)
        end
      end

      @body_text = chunks.join("\n\n")
    end

    def to_utf8(str)
      s = str.to_s
      s = s.dup unless s.frozen? == false
      s = s.force_encoding("UTF-8") if s.respond_to?(:force_encoding)
      s.valid_encoding? ? s : s.scrub("")
    end

    def parse_address(str)
      addr = Mail::Address.new(str.to_s.strip)
      { email: addr.address.to_s.presence, name: addr.display_name.to_s.presence }
    rescue Mail::Field::ParseError, StandardError
      { email: nil, name: nil }
    end

    def normalize_date(raw)
      return nil if raw.blank?
      # Gmail: "Thu, Apr 2, 2026 at 1:11 AM" — DateTime.parse trips on "at".
      cleaned = raw.gsub(/\bat\b/i, " ").gsub(/\s+/, " ").strip
      DateTime.parse(cleaned).iso8601
    rescue Date::Error, ArgumentError
      nil
    end
  end
end
