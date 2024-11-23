class LabourMarket::Bookmark < ApplicationRecord
  belongs_to :source, class_name: "LabourMarket::Document", foreign_key: "source_id", optional: true
  validates :url, presence: true
end

documents = LabourMarket::Document.where.not(source_url: nil)
documents.each do |document|
  bookmark = LabourMarket::Bookmark.find_or_create_by(url: document.source_url)
  document.update(source: bookmark)
end
