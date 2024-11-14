class CreateLabourMarketAgreementDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :labour_market_agreement_documents, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps
      t.string :name_en, null: false
      t.string :name_sv, null: false
    end
  end
end
