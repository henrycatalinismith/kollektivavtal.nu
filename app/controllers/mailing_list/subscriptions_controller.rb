class MailingList::SubscriptionsController < ApplicationController
  # include RailsCloudflareTurnstile::ControllerHelpers

  before_action :validate_cloudflare_turnstile, only: :create
  rescue_from RailsCloudflareTurnstile::Forbidden, with: :redirect_home

  def create
    sendgrid_status = :sendgrid_pending

    if Flipper.enabled?(:mailing_list_subscriptions_create_sendgrid, current_user)
      begin
        sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
        response = sg.client.marketing.contacts.put(
          request_body: {
            list_ids: [ENV["SENDGRID_LIST_ID"]],
            contacts: [{
              email: params[:email],
              custom_fields: {
                language: http_accept_language.preferred_language_from(["en", "sv"]) || "en",
              }
            }]
          }
        )
      rescue Exception => e
        Rails.logger.error e.message
        sendgrid_status = :sendgrid_failure
      else
        sendgrid_status = :sendgrid_success
      end
    end

    MailingList::Subscription.create!(
      email: params[:email],
      sendgrid_status:,
      ip_address: request.remote_ip,
      user_agent: request.user_agent,
      accept_language: request.headers["Accept-Language"],
    )
    flash[:notice] = "Signed up successfully!"
    redirect_to root_path
  end

  def created
  end

  def redirect_home
    flash[:notice] = "Captcha required"
    redirect_to root_path
  end
end