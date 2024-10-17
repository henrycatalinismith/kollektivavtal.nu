class MailingList::Email < ApplicationRecord
  belongs_to :list, class_name: 'MailingList::List', foreign_key: :list_id
  validates :list, presence: true

  validates :subject_en, presence: true
  validates :subject_sv, presence: true

  validates :markdown_en, presence: true
  validates :markdown_sv, presence: true

  rails_admin do
    configure :sent_at do
      visible do
        false
      end
    end

    configure :markdown_en, :text do
      html_attributes rows: 20
    end

    configure :markdown_sv, :text do
      html_attributes rows: 20
    end

  end

end