class AddLabourMarketAgreementScope < ActiveRecord::Migration[8.0]
  def change
    add_column :labour_market_agreements, :scope_en, :text
    add_column :labour_market_agreements, :scope_sv, :text
  end
end
