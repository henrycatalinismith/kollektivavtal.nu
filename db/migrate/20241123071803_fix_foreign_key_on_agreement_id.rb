class FixForeignKeyOnAgreementId < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :labour_market_documents, :labour_market_periods, column: :agreement_id
    add_foreign_key :labour_market_documents, :labour_market_agreements, column: :agreement_id, primary_key: :id
  end
end
