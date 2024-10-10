class User::Session < ApplicationRecord
  belongs_to :account
end
