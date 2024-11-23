class MakeSourceNullable < ActiveRecord::Migration[8.0]
  def change
    change_column_null :labour_market_documents, :source_id, true
  end
end
