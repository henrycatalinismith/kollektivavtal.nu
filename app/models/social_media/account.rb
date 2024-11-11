class SocialMedia::Account < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true
  enum :provider, {
    facebook: 0,
    linkedin: 1,
    x: 2,
  }

  rails_admin do
    list do
      field :rank
      field :name
      field :url
      field :created_at
      sort_by :rank
    end
  end
end
