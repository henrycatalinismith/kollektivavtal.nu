class CreateOrgMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :labour_market_organisation_memberships, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps
      t.references :parent, index: true, type: :string, foreign_key: { to_table: :labour_market_organisations }
      t.references :child, index: true, type: :string, foreign_key: { to_table: :labour_market_organisations }
    end
    remove_column :labour_market_organisations, :parent_id, :string
  end
end
