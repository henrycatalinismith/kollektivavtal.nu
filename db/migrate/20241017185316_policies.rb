class Policies < ActiveRecord::Migration[8.0]
  def change
    create_table :policy_documents, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps
      t.string :slug, index: { unique: true }
    end

    create_table :policy_revisions, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps
      t.references :document, index: true, type: :string, foreign_key: {
        to_table: :policy_documents
      }
      t.string :title_en
      t.string :title_sv
      t.string :body_en
      t.string :body_sv
    end
    add_index :policy_revisions, [:document_id, :created_at]
  end
end
