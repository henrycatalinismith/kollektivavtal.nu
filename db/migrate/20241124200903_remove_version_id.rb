class RemoveVersionId < ActiveRecord::Migration[8.0]
  def change
    remove_column :labour_market_documents, :version_id
  end
end
