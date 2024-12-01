class RemoveMailingListModule < ActiveRecord::Migration[8.0]
  def change
    drop_table :mailing_list_emails
    drop_table :mailing_list_subscriptions
    drop_table :mailing_list_lists
  end
end
