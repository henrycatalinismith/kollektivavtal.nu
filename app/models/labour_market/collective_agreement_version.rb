class LabourMarket::CollectiveAgreementVersion < ApplicationRecord
  validates :name_sv, presence: true
  validates :slug, presence: true
  has_one_attached :document
  scope :chronological, -> { order(created_at: :asc) }
  scope :reverse_chronological, -> { order(created_at: :desc) }
  belongs_to :agreement, class_name: "LabourMarket::CollectiveAgreement"
end