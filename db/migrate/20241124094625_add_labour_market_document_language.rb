class AddLabourMarketDocumentLanguage < ActiveRecord::Migration[8.0]
  def change
    add_column :labour_market_documents, :document_language, :integer, default: 0
  end
end
