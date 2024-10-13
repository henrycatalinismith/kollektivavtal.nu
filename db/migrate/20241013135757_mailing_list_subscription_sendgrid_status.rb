class MailingListSubscriptionSendgridStatus < ActiveRecord::Migration[8.0]
  def change
    add_column :mailing_list_subscriptions, :sendgrid_status, :integer
  end
end
