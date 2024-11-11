class RenameToProvider < ActiveRecord::Migration[8.0]
  def change
    rename_column :social_media_accounts, :type, :provider
  end
end
