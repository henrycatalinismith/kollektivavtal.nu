class MailingList::Subscription < ApplicationRecord
  enum :sendgrid_status, {
    sendgrid_pending: 0,
    sendgrid_success: 1,
    sendgrid_failure: 2,
  }

  enum :turnstile_status, {
    turnstile_pending: 0,
    turnstile_success: 1,
    turnstile_failure: 2,
  }
end