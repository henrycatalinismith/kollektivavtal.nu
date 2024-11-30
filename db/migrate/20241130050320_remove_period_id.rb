class RemovePeriodId < ActiveRecord::Migration[8.0]
  def change
    remove_column :labour_market_documents, :period_id
  end
end
