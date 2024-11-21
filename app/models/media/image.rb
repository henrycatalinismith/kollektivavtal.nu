class Media::Image < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true
  validates :image, presence: true

  rails_admin do
    field :name, :string
    field :image, :active_storage
  end
end
