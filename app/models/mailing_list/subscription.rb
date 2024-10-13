class MailingList::Subscription < ApplicationRecord
  enum :sendgrid_status, {
    sendgrid_pending: 0,
    sendgrid_success: 1,
    sendgrid_failure: 2,
  }
end