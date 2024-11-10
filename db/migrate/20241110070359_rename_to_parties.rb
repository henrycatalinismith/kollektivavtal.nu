class RenameToParties < ActiveRecord::Migration[8.0]
  def change
    rename_table :labour_market_collective_agreement_signatures, :labour_market_collective_agreement_memberships
  end
end
