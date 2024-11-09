class RenameToSignatures < ActiveRecord::Migration[8.0]
  def change
    rename_table :labour_market_collective_agreement_signatories, :labour_market_collective_agreement_signatures
  end
end
