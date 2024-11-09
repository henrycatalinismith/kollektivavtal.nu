class AddYears < ActiveRecord::Migration[8.0]
  def change
    add_column :labour_market_collective_agreement_versions, :signed_at_year, :integer
    add_column :labour_market_collective_agreement_versions, :expired_at_year, :integer
    add_index :labour_market_collective_agreement_versions, [:agreement_id, :signed_at_year]
    remove_column :labour_market_collective_agreement_versions, :name
  end
end
