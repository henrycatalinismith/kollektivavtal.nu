class EmailPlainText < ActiveRecord::Migration[8.0]
  def change
    rename_column :mailing_list_emails, :body_en, :markdown_en
    rename_column :mailing_list_emails, :body_sv, :markdown_sv
    add_column :mailing_list_emails, :text_en, :text
    add_column :mailing_list_emails, :text_sv, :text
  end
end
