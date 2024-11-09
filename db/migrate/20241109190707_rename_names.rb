class RenameNames < ActiveRecord::Migration[8.0]
  def change
    rename_column :labour_market_collective_agreements, :name_sv, :name
    rename_column :labour_market_collective_agreement_versions, :name_sv, :name
    remove_index :labour_market_collective_agreements, name: 'idx_on_agreement_id_slug_96d8908d0d'
    remove_column :labour_market_collective_agreement_versions, :slug
  end
end
