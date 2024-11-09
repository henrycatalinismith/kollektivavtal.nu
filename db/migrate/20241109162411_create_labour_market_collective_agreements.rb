class CreateLabourMarketCollectiveAgreements < ActiveRecord::Migration[8.0]
  def change
    create_table :labour_market_collective_agreements, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps
      t.string :name_sv, null: false
      t.string :slug, index: { unique: true }
    end

    create_table :labour_market_collective_agreement_versions, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps
      t.references :agreement, index: true, type: :string, foreign_key: { to_table: :labour_market_collective_agreements }
      t.string :name_sv, null: false
      t.string :slug
    end

    add_index :labour_market_collective_agreement_versions, [:agreement_id, :slug], unique: true
  end
end
