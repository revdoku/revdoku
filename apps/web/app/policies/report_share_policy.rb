# frozen_string_literal: true

class ReportSharePolicy < ApplicationPolicy
  def index?
    account_member? && current_account&.report_sharing_allowed?
  end

  def destroy?
    return false unless current_account&.report_sharing_allowed?
    return false unless record.account_id == Principal.account&.id

    ReportPolicy.new(user, record.report).share?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.nil? || Principal.account.nil?
        scope.none
      else
        scope.where(account: Principal.account)
      end
    end
  end
end
