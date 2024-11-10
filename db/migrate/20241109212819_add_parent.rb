class AddParent < ActiveRecord::Migration[8.0]
  def change
    add_column :labour_market_organisations, :parent_id, :string
    add_foreign_key :labour_market_organisations, :labour_market_organisations, column: :parent_id
  end
end
