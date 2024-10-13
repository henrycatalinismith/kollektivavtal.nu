class MailingListSubscriptionSendgridStatus < ActiveRecord::Migration[8.0]
  def change
    add_column :mailing_list_subscriptions, :sendgrid_status, :integer
    add_column :mailing_list_subscriptions, :ip_address, :string
    add_column :mailing_list_subscriptions, :user_agent, :string
    add_column :mailing_list_subscriptions, :accept_language, :string
  end
end
