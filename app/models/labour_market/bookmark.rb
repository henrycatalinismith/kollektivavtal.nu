class LabourMarket::Bookmark < ApplicationRecord
  belongs_to :source, class_name: "LabourMarket::Document", foreign_key: "source_id"
  validates :url, presence: true
end
