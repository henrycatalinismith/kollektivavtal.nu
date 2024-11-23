class RenameOrganisationMembershipsToMemberships < ActiveRecord::Migration[8.0]
  def change
    rename_table :labour_market_organisation_memberships, :labour_market_memberships
  end
end
