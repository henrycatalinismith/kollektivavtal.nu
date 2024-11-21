class MailingList::Subscription < ApplicationRecord
  belongs_to :list, class_name: "MailingList::List", foreign_key: :list_id

  enum :sendgrid_status, [
    :sendgrid_pending,
    :sendgrid_add_success,
    :sendgrid_add_failure,
    :sendgrid_delete_success,
    :sendgrid_delete_failure,
  ]

  enum :turnstile_status, [
    :turnstile_pending,
    :turnstile_success,
    :turnstile_failure,
  ]

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
