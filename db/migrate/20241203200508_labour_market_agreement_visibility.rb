class LabourMarketAgreementVisibility < ActiveRecord::Migration[8.0]
  def change
    add_column :labour_market_agreements, :agreement_visibility, :integer, default: 0, null: false
  end
end
