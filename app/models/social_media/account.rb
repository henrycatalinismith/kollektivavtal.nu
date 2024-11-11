class SocialMedia::Account < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true
  enum :provider, {
    facebook: 0,
    linkedin: 1,
  }
end
