class DropLabourMarketBookmarks < ActiveRecord::Migration[8.0]
  def change
    remove_column :labour_market_documents, :source_id
    drop_table :labour_market_bookmarks
  end
end
