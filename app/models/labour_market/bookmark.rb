class LabourMarket::Bookmark < ApplicationRecord
  has_many :documents, class_name: "LabourMarket::Document", inverse_of: :source
  validates :url, presence: true

  def name
    url
  end

  rails_admin do
    list do
      field :url
      field :created_at
      field :updated_at
      sort_by :created_at
    end

    show do
      field :url
      field :documents
      field :created_at
      field :updated_at
    end
  end
end