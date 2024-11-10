class RemoveOrgParent < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :labour_market_organisations, :labour_market_organisations, column: :parent_id
  end
end
