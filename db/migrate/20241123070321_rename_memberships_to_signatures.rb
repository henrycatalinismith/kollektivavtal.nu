class RenameMembershipsToSignatures < ActiveRecord::Migration[8.0]
  def change
    rename_table :labour_market_agreement_memberships, :labour_market_signatures
  end
end
