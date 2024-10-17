class CreateMailingList < ActiveRecord::Migration[8.0]
  def change
    create_table :mailing_list_lists, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps
      t.string :name, null: false
      t.string :sendgrid_id, null: false
    end
    add_index :mailing_list_lists, :name, unique: true
    add_column :mailing_list_subscriptions, :list_id, :string
    add_foreign_key :mailing_list_subscriptions, :mailing_list_lists, column: :list_id
    add_index :mailing_list_subscriptions, :list_id
  end
end
