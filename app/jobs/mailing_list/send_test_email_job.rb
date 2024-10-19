class MailingList::SendTestEmailJob < ApplicationJob
  queue_as :default

  def perform(email_id, language)
    @email = MailingList::Email.find(email_id)
    @list = @email.list

    subject = case language
    when :en then @email.subject_en
    when :sv then @email.subject_sv
    end

    plain_content = case language
    when :en then @email.markdown_en
    when :sv then @email.markdown_sv
    end

    puts "Subject: #{subject}"
    puts "Markdown: #{plain_content}"

    html_content = ApplicationController.new.render_to_string(
      partial: "mailing_list/emails/html",
      locals: { email: @email, language: language }
    )

    singlesend = {
      name: "Test #{email_id} #{language} #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}",
      status: "triggered",
      send_to: {
        segment_ids: [@list.segment_id_testers],
      },
      email_config: {
        subject:,
        html_content:,
        plain_content:,
        sender_id: 6330139,
      },
    }

    sg = SendGrid::API.new(api_key: ENV["SENDGRID_API_KEY"])
    response = sg.client.marketing.singlesends.post(request_body: singlesend)

    puts response.status_code
    puts response.body
  end
end
