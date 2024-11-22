class AddSourceUrl < ActiveRecord::Migration[8.0]
  def change
    add_column :labour_market_documents, :source_url, :string
  end
end
