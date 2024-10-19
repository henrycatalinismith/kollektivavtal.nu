class MailingList::List < ApplicationRecord
  has_many :subscriptions, class_name: "MailingList::Subscription", foreign_key: :list_id
  validates :name, presence: true
  validates :sendgrid_id, presence: true

  rails_admin do
    configure :name do
      sticky true
      column_width 256
    end

    configure :sendgrid_id do
      label "SendGrid ID"
      sticky true
    end

    configure :segment_id_en do
      label "English Segment ID"
    end

    configure :segment_id_sv do
      label "Swedish Segment ID"
    end

    configure :segment_id_testers do
      label "Test Segment ID"
    end
  end
end
