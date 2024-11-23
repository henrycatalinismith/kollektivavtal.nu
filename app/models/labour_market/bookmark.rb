class LabourMarket::Bookmark < ApplicationRecord
  belongs_to :source, class_name: "LabourMarket::Document", foreign_key: "source_id", optional: true
  validates :url, presence: true

  rails_admin do
    list do
      field :url
      field :created_at
      field :updated_at
      sort_by :created_at
    end
  end
end