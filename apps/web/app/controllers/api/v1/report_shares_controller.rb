# frozen_string_literal: true

class Api::V1::ReportSharesController < Api::BaseController
  before_action :ensure_report_sharing_available!
  before_action :set_report_share, only: [:destroy]

  # GET /api/v1/report_shares
  def index
    authorize ReportShare

    shares = policy_scope(ReportShare)
      .includes(:account, :report, :envelope, :created_by, html_file_attachment: :blob)
      .order(created_at: :desc)

    if params[:report_id].present?
      report = policy_scope(Report).find_by_prefix_id(params[:report_id])
      unless report
        render_api_not_found("Report")
        return
      end
      shares = shares.where(report: report)
    end

    render_api_success({
      report_shares: shares.map { |share| serialize_report_share(share) },
      default_share_link_expiration: ReportShare::DEFAULT_SHARE_LINK_EXPIRATION,
      share_report_enabled: current_account.report_sharing_allowed?
    })
  end

  # DELETE /api/v1/report_shares/:id
  def destroy
    return if performed?

    authorize @report_share
    @report_share.expire!
    render_api_success({ report_share: serialize_report_share(@report_share.reload) })
  end

  private

  def ensure_report_sharing_available!
    return if current_account&.report_sharing_allowed?


    render_api_forbidden("Report sharing is disabled for this account")
  end


  def set_report_share
    @report_share = policy_scope(ReportShare).find_by_prefix_id(params[:id])
    render_api_not_found("Report share") unless @report_share
  end

  def serialize_report_share(share)
    token = share.token
    {
      id: share.prefix_id,
      report_id: share.report.prefix_id,
      envelope_id: share.envelope.prefix_id,
      title: share.title,
      url: token.present? ? shared_report_url(token) : nil,
      active: share.available?,
      expired_at: share.expired_at.iso8601,
      view_count: share.view_count.to_i,
      last_viewed_at: share.last_viewed_at&.iso8601,
      created_at: share.created_at.iso8601,
      created_by_name: share.created_by&.name.presence || share.created_by&.email,
      byte_size: share.byte_size,
      html_sha256: share.html_sha256
    }
  end
end
