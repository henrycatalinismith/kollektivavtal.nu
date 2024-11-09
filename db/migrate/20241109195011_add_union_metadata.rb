class AddUnionMetadata < ActiveRecord::Migration[8.0]
  def change
    add_column :labour_market_unions, :description_en, :text
    add_column :labour_market_unions, :website, :string
  end
end
