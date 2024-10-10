class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :user_accounts, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps
      t.string :email_address, null: false
      t.string :password_digest, null: false
    end
    add_index :user_accounts, :email_address, unique: true
  end
end
