class DropLabourMarketAgreementVersions < ActiveRecord::Migration[8.0]
  def change
    drop_table :labour_market_agreement_versions
  end
end
