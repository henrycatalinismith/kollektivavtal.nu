class Media::Image < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true
  validates :image, presence: true

  rails_admin do
    list do
      field :image
      field :name
      field :created_at
      field :updated_at
      sort_by :created_at
    end
  end
end
