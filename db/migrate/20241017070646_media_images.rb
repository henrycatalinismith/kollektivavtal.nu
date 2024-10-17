class MediaImages < ActiveRecord::Migration[8.0]
  def change
    create_table :media_images, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps
      t.string :name, null: false
    end
  end
end
