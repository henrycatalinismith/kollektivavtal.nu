class CreateLabourMarketReferences < ActiveRecord::Migration[8.0]
  def change
    create_table :labour_market_references, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps
      t.string :referenceable_type, null: false
      t.string :referenceable_id, null: false
      t.string :url, null: false
    end
    add_index :labour_market_references, [:referenceable_type, :referenceable_id]
  end
end
