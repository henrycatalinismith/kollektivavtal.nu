class RenameToOrganisation < ActiveRecord::Migration[8.0]
  def change
    rename_table :labour_market_unions, :labour_market_organisations
    rename_column :labour_market_collective_agreement_signatures, :union_id, :organisation_id
  end
end
