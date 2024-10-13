class ContactsController < ApplicationController
  def create
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.marketing.contacts.put(
      request_body: {
        list_ids: [ENV["SENDGRID_LIST_ID"]],
        contacts: [{
          email: params[:email]
        }]
      }
    )
    flash[:notice] = "Signed up successfully!"
    redirect_to root_path
  end
end
