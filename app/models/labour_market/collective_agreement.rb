class LabourMarket::CollectiveAgreement < ApplicationRecord
  validates :name_sv, presence: true
  validates :slug, presence: true, uniqueness: true
  scope :chronological, -> { order(created_at: :asc) }
  scope :reverse_chronological, -> { order(created_at: :desc) }
  has_many :versions, class_name: "LabourMarket::CollectiveAgreementVersion", dependent: :destroy, inverse_of: :agreement

  def latest_version
    versions.reverse_chronological.first
  end
end