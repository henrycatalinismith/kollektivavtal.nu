class MailingListSubscription < ActiveRecord::Migration[8.0]
  def change
    create_table :mailing_list_subscriptions, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps
      t.string :email
    end
  end
end
