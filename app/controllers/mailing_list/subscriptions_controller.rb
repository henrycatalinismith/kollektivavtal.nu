class MailingList::SubscriptionsController < ApplicationController
  def create
    sendgrid_status = :sendgrid_pending

    if Flipper.enabled?(:mailing_list_subscriptions_create_sendgrid, current_user)
      begin
        sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
        response = sg.client.marketing.contacts.put(
          request_body: {
            list_ids: [ENV["SENDGRID_LIST_ID"]],
            contacts: [{
              email: params[:email]
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
    )
    flash[:notice] = "Signed up successfully!"
    redirect_to root_path
  end
end