class TranslateFields < ActiveRecord::Migration[8.0]
  def change
    rename_column :labour_market_agreements, :name, :name_sv
    add_column :labour_market_agreements, :name_en, :string
    add_column :labour_market_agreements, :description_sv, :text
    rename_column :labour_market_organisations, :name, :name_sv
    add_column :labour_market_organisations, :name_en, :string
    add_column :labour_market_organisations, :description_sv, :text
  end
end
