namespace :mailing_list do
  task backfill_list: :environment do
    list = MailingList::List.first
    subscriptions = MailingList::Subscription.all
    subscriptions.each do |subscription|
      subscription.update(list: list)
    end
  end
end
