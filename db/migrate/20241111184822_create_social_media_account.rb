class CreateSocialMediaAccount < ActiveRecord::Migration[8.0]
  def change
    create_table :social_media_accounts, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps
      t.string :name, null: false
      t.string :url, null: false
    end
  end
end
