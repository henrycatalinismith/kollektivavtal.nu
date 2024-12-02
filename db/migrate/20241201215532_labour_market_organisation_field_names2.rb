class LabourMarketOrganisationFieldNames2 < ActiveRecord::Migration[8.0]
  def change
    rename_column :labour_market_organisations, :slug, :organisation_slug
  end
end
