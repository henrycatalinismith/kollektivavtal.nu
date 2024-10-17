class RemovePlainText < ActiveRecord::Migration[8.0]
  def change
    remove_column :mailing_list_emails, :text_en, :text
    remove_column :mailing_list_emails, :text_sv, :text
  end
end
