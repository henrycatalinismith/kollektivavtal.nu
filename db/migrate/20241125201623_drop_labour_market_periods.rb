class DropLabourMarketPeriods < ActiveRecord::Migration[8.0]
  def change
    drop_table :labour_market_periods
  end
end
