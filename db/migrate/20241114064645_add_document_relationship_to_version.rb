class AddDocumentRelationshipToVersion < ActiveRecord::Migration[8.0]
  def change
    add_reference :labour_market_agreement_documents, :version, type: :string, index: true, foreign_key: { to_table: :labour_market_agreement_versions }
  end
end
