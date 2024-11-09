class AddOrgType < ActiveRecord::Migration[8.0]
  def change
    add_column :labour_market_organisations, :organisation_type, :integer
    add_index :labour_market_organisations, :organisation_type
  end
end
