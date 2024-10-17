class AddListSegmentIds < ActiveRecord::Migration[8.0]
  def change
    add_column :mailing_list_lists, :segment_id_en, :string
    add_column :mailing_list_lists, :segment_id_sv, :string
    add_column :mailing_list_lists, :segment_id_testers, :string
  end
end
