class CreateLabourMarketBookmarks < ActiveRecord::Migration[8.0]
  def change
    create_table :labour_market_bookmarks, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps
      t.string :url, null: false
    end
    add_column :labour_market_documents, :source_id, :string
    add_foreign_key :labour_market_documents, :labour_market_bookmarks, column: :source_id, primary_key: :id
  end
end
