class CreateLabourMarketUnions < ActiveRecord::Migration[8.0]
  def change
    create_table :labour_market_unions, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps
      t.string :name, null: false
      t.string :slug, index: { unique: true }
    end

    create_table :labour_market_collective_agreement_signatories, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps
      t.references :agreement, index: true, type: :string, foreign_key: { to_table: :labour_market_collective_agreements }
      t.references :union, index: true, type: :string, foreign_key: { to_table: :labour_market_unions }
    end
  end
end
