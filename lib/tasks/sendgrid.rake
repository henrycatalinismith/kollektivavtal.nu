require "sendgrid-ruby"

namespace :sendgrid do
  desc "Test API"
  task test: :environment do
    puts "Testing SendGrid API"
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.marketing.contacts.put(
      request_body: {
        list_ids: [ENV["SENDGRID_LIST_ID"]],
        contacts: [{
          email: "henry@catalinismith.com"
        }]
      }
    )
    puts response.status_code
    puts response.body
  end
end