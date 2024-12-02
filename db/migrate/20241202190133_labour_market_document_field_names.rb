class LabourMarketDocumentFieldNames < ActiveRecord::Migration[8.0]
  def change
    remove_column :labour_market_documents, :name_en
    rename_column :labour_market_documents, :name_sv, :document_name
    rename_column :labour_market_documents, :start_year, :document_start_year
    rename_column :labour_market_documents, :end_year, :document_end_year
  end
end
