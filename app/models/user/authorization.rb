class User::Authorization < ApplicationRecord
  belongs_to :account, class_name: "User::Account", foreign_key: "account_id"
  belongs_to :role, class_name: "User::Role", foreign_key: "role_id"

  rails_admin do
    list do
      configure :account do
        sticky true
        column_width 256
      end

      configure :role do
        sticky true
        column_width 256
      end
    end
  end
end
