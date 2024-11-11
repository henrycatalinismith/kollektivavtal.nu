class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  before_action :load_social_media_accounts

  def load_social_media_accounts
    @social_media_accounts = SocialMedia::Account.order(rank: :asc)
  end

  before_action :set_locale

  def set_locale()
    I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales) || I18n.default_locale
  end
end
