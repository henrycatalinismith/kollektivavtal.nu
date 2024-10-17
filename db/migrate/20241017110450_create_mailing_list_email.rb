class CreateMailingListEmail < ActiveRecord::Migration[8.0]
  def change
    create_table :mailing_list_emails, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps
      t.datetime :sent_at
      t.references :list, index: true, type: :string, foreign_key: {
        to_table: :mailing_list_lists
      }
      t.string :subject_en
      t.string :subject_sv
      t.string :body_en
      t.string :body_sv
    end
  end
end
