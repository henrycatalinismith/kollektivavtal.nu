class RenameToAgreements < ActiveRecord::Migration[8.0]
  def change
    rename_table :labour_market_collective_agreements, :labour_market_agreements
    rename_table :labour_market_collective_agreement_memberships, :labour_market_agreement_memberships
    rename_table :labour_market_collective_agreement_versions, :labour_market_agreement_versions
  end
end
