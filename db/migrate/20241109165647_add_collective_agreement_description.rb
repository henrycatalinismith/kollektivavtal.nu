class AddCollectiveAgreementDescription < ActiveRecord::Migration[8.0]
  def change
    add_column :labour_market_collective_agreements, :description_en, :text
  end
end
