class CreateLabourMarketPeriods < ActiveRecord::Migration[8.0]
  def change
    create_table :labour_market_periods, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps
      t.string :start_year, null: false
      t.string :end_year, null: false
    end
    add_column :labour_market_documents, :agreement_id, :string
    add_column :labour_market_documents, :period_id, :string
    add_foreign_key :labour_market_documents, :labour_market_periods, column: :agreement_id, primary_key: :id
    add_foreign_key :labour_market_documents, :labour_market_periods, column: :period_id, primary_key: :id
  end
end
