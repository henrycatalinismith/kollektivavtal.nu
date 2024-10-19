class MailingList::DeleteSendgridSubscriptionJob < ApplicationJob
  queue_as :default

  rescue_from(StandardError) do |exception|
    puts exception.message
    puts exception.backtrace
    @subscription.sendgrid_delete_failure!
  end

  def perform(subscription_id)
    @subscription = MailingList::Subscription.find(subscription_id)

    sg = SendGrid::API.new(api_key: ENV["SENDGRID_API_KEY"])

    response = sg.client.marketing.contacts.search.post(request_body: {
      query: "email LIKE '#{@subscription.email}' AND CONTAINS(list_ids, '#{@subscription.list.sendgrid_id}')"
    })

    payload = JSON.parse(response.body)

    if payload["result"].length == 0
      puts "Contact not found"
      @subscription.sendgrid_delete_success!
    end

    contact = payload["result"][0]
    puts response.body
    puts "Contact found: #{contact["id"]}"
    # {
    #   "contact_count": 1,
    #   "result": [
    #     {
    #       "address_line_1": "",
    #       "address_line_2": "",
    #       "alternate_emails": null,
    #       "city": "",
    #       "country": "",
    #       "email": "test123@example.org",
    #       "first_name": "",
    #       "id": "a8adf288-4bef-4a98-abd6-8156ca7d7fef",
    #       "last_name": "",
    #       "list_ids": [
    #         "6bc677e7-0955-4e58-9226-9b495de010b5"
    #       ],
    #       "postal_code": "",
    #       "segment_ids": null,
    #       "state_province_region": "",
    #       "phone_number": "",
    #       "whatsapp": "",
    #       "line": "",
    #       "facebook": "",
    #       "unique_name": "",
    #       "custom_fields": {
    #         "language": "en"
    #       },
    #       "created_at": "2024-10-17 10:05:54 +0000 UTC",
    #       "updated_at": "2024-10-17 10:06:24 +0000 UTC",
    #       "_metadata": {
    #         "self": "https://api.sendgrid.com/v3/marketing/contacts/a8adf288-4bef-4a98-abd6-8156ca7d7fef"
    #       }
    #     }
    #   ],
    #   "_metadata": {
    #     "self": "https://api.sendgrid.com/v3/marketing/contacts/search"
    #   }
    # }

    response = sg.client.marketing.lists._(@subscription.list.sendgrid_id).contacts.delete(
      query_params: {
        contact_ids: [contact["id"]]
      }
    )

    @subscription.sendgrid_delete_success!
  end
end
