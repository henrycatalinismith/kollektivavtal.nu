class LabourMarketOrganisationFieldNames < ActiveRecord::Migration[8.0]
  def change
    remove_column :labour_market_organisations, :name_en
    rename_column :labour_market_organisations, :name_sv, :organisation_name
    remove_column :labour_market_organisations, :description_en
    rename_column :labour_market_organisations, :description_sv, :organisation_description
  end
end
