class LabourMarketAgreementFieldNames < ActiveRecord::Migration[8.0]
  def change
    remove_column :labour_market_agreements, :name_en
    remove_column :labour_market_agreements, :description_en
    remove_column :labour_market_agreements, :scope_en
    rename_column :labour_market_agreements, :name_sv, :agreement_name
    rename_column :labour_market_agreements, :description_sv, :agreement_description
    rename_column :labour_market_agreements, :scope_sv, :agreement_scope
    rename_column :labour_market_agreements, :slug, :agreement_slug
  end
end
