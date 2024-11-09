class RenameYears < ActiveRecord::Migration[8.0]
  def change
    rename_column :labour_market_collective_agreement_versions, :signed_at_year, :signing_year
    rename_column :labour_market_collective_agreement_versions, :expired_at_year, :expiry_year
  end
end
