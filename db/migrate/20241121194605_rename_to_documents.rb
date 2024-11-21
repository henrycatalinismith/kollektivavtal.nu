class RenameToDocuments < ActiveRecord::Migration[8.0]
  def change
    rename_table :labour_market_agreement_documents, :labour_market_documents
  end
end
