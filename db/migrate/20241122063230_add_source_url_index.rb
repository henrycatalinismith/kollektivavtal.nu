class AddSourceUrlIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :labour_market_documents, :source_url
  end
end
