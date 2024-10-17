class MailingList::Subscription < ApplicationRecord
  belongs_to :list, class_name: 'MailingList::List', foreign_key: :list_id

  enum :sendgrid_status, {
    sendgrid_pending: 0,
    sendgrid_add_success: 1,
    sendgrid_add_failure: 2,
    sendgrid_delete_success: 3,
    sendgrid_delete_failure: 4,
  }

  enum :turnstile_status, {
    turnstile_pending: 0,
    turnstile_success: 1,
    turnstile_failure: 2,
  }

  rails_admin do
    object_label_method do
      :email
    end
    configure :email do
      sticky true
      column_width 256
    end
    configure :sendgrid_status do
      sticky true
    end
    configure :turnstile_status do
      sticky true
    end
  end
end