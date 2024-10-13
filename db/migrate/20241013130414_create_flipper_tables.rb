class CreateFlipperTables < ActiveRecord::Migration[8.0]
  def up
    create_table :flipper_features, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps null: false
      t.string :key, null: false
    end
    add_index :flipper_features, :key, unique: true

    create_table :flipper_gates, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps null: false
      t.string :feature_key, null: false
      t.string :key, null: false
      t.text :value
    end
    add_index :flipper_gates, [:feature_key, :key, :value], unique: true, length: { value: 255 }
  end

  def down
    drop_table :flipper_gates
    drop_table :flipper_features
  end
end
