class MailingList::CreateSendgridSubscriptionJob < ApplicationJob
  queue_as :default

  rescue_from(StandardError) do |exception|
    puts exception.message
    puts exception.backtrace
    @subscription.sendgrid_add_failure!
  end

  def perform(subscription_id)
    @subscription = MailingList::Subscription.find(subscription_id)

    accept_language_parser = HttpAcceptLanguage::Parser.new(@subscription.accept_language)
    language = accept_language_parser.language_region_compatible_from(["en", "sv"]) || "en"

    sg = SendGrid::API.new(api_key: ENV["SENDGRID_API_KEY"])
    response = sg.client.marketing.contacts.put(
      request_body: {
        list_ids: [@subscription.list.sendgrid_id],
        contacts: [{
          email: @subscription.email,
          custom_fields: { language: }
        }]
      }
    )
    puts response.status_code
    puts response.body

    @subscription.sendgrid_add_success!
  end
end
