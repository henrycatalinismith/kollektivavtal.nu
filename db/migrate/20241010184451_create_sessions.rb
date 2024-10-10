class CreateSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :user_sessions, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps
      t.references :user_account, null: false, type: :string, foreign_key: true
      t.string :ip_address
      t.string :user_agent
    end
    rename_column :user_sessions, :user_account_id, :account_id
  end
end
