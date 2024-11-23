class RemoveDocumentFkConstraints < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key "labour_market_documents", "labour_market_agreements", column: "agreement_id"
    remove_foreign_key "labour_market_documents", "labour_market_periods", column: "period_id"
    remove_foreign_key "labour_market_documents", "labour_market_bookmarks", column: "source_id"
    remove_foreign_key "labour_market_documents", "labour_market_agreement_versions", column: "version_id"
  end
end
