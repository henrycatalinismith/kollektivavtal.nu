class MailingList::SubscriptionsController < ApplicationController

  def create
    sendgrid_status = :sendgrid_pending
    turnstile_status = :turnstile_pending

    if cloudflare_turnstile_ok?
      turnstile_status = :turnstile_success
    else
      turnstile_status = :turnstile_failure
    end

    if turnstile_status == :turnstile_success and Flipper.enabled?(:mailing_list_subscriptions_create_sendgrid, current_user)
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
      turnstile_status:,
    )
    flash[:notice] = "Signed up successfully!"
    redirect_to root_path
  end

  def created
  end
end