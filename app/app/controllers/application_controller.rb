# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # include BaseControllerConcern
  # include PosthogConcern
  # include PunditConcern
  include LocationConcern

  # NOTE: This prevents pwabuilder.com and any other browser to work properly
  # # Only allow modern browsers supporting webp images, web push, badges,
  # # import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern unless Rails.env.development?

  around_action :switch_locale
  before_action :authenticate_user!

  helper_method :current_profile
  def current_profile
    current_user.profile
  end

  def switch_locale(&)
    locale = params[:locale] ||
             http_accept_language.compatible_language_from(I18n.available_locales) ||
             I18n.default_locale

    I18n.with_locale(locale, &)
  end

  def default_url_options
    { }
  end
end
