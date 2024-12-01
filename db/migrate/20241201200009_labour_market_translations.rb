class LabourMarketTranslations < ActiveRecord::Migration[8.0]
  def change
    create_table :labour_market_translations, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps
      t.string :translatable_type, null: false
      t.string :translatable_id, null: false
      t.integer :translation_status, null: false
      t.integer :translation_type, null: false
      t.integer :translation_language, null: false
      t.text :translation_text, null: false
    end
  end
end
