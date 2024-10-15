class TurnstileStatus < ActiveRecord::Migration[8.0]
  def change
    add_column :mailing_list_subscriptions, :turnstile_status, :integer
  end
end
