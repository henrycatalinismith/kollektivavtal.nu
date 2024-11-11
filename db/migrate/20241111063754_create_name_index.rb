class CreateNameIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :labour_market_agreements, :name_en
    add_index :labour_market_agreements, :name_sv
    add_index :labour_market_organisations, :name_en
    add_index :labour_market_organisations, :name_sv
  end
end
