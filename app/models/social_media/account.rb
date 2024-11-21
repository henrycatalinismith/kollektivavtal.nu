class SocialMedia::Account < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true
  enum :provider, [
    :facebook,
    :linkedin,
    :x,
    :instagram,
    :tiktok,
    :mastodon,
    :bluesky,
  ]

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
