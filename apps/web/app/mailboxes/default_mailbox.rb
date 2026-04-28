class DefaultMailbox < ApplicationMailbox
  AUDIT_PATH = "/inbound_email/unrouted".freeze

  def process
    Rails.logger.info(
      "[DefaultMailbox] bounce: unroutable " \
      "recipients=#{mail.recipients.inspect} " \
      "to=#{mail.to.inspect} cc=#{mail.cc.inspect} from=#{mail.from.inspect}"
    )

    # Write an account-less AuditLog row so operators can see WHY an inbound
    # email never made it to UploadsMailbox. Swallow errors — if audit-log
    # writes fail for any reason we still want the bounce to proceed.
    begin
      recipients_list = Array(mail.recipients_addresses).map do |addr|
        addr.respond_to?(:address) ? addr.address.to_s : addr.to_s
      end

      AuditLog.create!(
        source_type: :INTERNAL,
        path: AUDIT_PATH,
        response_code: 404,
        account_id: nil,
        request: {
          recipients: recipients_list,
          to: Array(mail.to),
          cc: Array(mail.cc),
          from: Array(mail.from),
          subject: mail.subject.to_s[0, 200],
          message_id: mail.message_id.to_s
        }
      )
    rescue => e
      Rails.logger.warn("[DefaultMailbox] audit-log write failed: #{e.class}: #{e.message}")
    end

    bounced!
  end
end
