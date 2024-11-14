class AddMainDocumentCheckbox < ActiveRecord::Migration[8.0]
  def change
    add_column :labour_market_agreement_documents, :main_document, :boolean, default: false, null: false
  end
end
