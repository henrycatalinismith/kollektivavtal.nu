class RemoveSourceUrl < ActiveRecord::Migration[8.0]
  def change
    remove_column :labour_market_documents, :source_url, :string
  end
end
