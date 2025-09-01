# frozen_string_literal: true

class PunditContext
  attr_reader :user, :admin_user

  def initialize(user, admin_user)
    @user = user
    @admin_user = admin_user
  end

  def admin?
    admin_user.present?
  end
end
