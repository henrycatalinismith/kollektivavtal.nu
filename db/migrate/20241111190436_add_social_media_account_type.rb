class AddSocialMediaAccountType < ActiveRecord::Migration[8.0]
  def change
    add_column :social_media_accounts, :type, :integer, null: false
    add_column :social_media_accounts, :rank, :integer, null: false
    add_index :social_media_accounts, :rank
  end
end
