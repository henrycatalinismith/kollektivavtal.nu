class MailingList::SendTestEmailJob < ApplicationJob
  queue_as :default

  def perform(email_id, language)
    @email = MailingList::Email.find(email_id)

    subject = case language
      when :en then @email.subject_en
      when :sv then @email.subject_sv
    end

    body = case language
      when :en then @email.body_en
      when :sv then @email.body_sv
    end

    puts "Subject: #{subject}"
    puts "Body: #{body}"

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  end
end
