class User::Role < ApplicationRecord
  has_many :authorizations, class_name: "User::Authorization", foreign_key: "role_id"
  has_many :accounts, through: :authorizations, class_name: "User::Account", foreign_key: "account_id"

  rails_admin do
    list do
      configure :name do
        sticky true
        column_width 256
      end
    end
  end
end
