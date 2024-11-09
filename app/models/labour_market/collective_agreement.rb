class LabourMarket::CollectiveAgreement < ApplicationRecord
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  scope :chronological, -> { order(created_at: :asc) }
  scope :reverse_chronological, -> { order(created_at: :desc) }
  has_many :versions, class_name: "LabourMarket::CollectiveAgreementVersion", dependent: :destroy, inverse_of: :agreement
  has_one_attached :image
  has_many :signatures, class_name: "LabourMarket::CollectiveAgreementSignature", dependent: :destroy, inverse_of: :agreement
  has_many :signatories, through: :signatures, source: :union

  rails_admin do
    configure :name do
      sticky true
      column_width 256
    end
  end

  def to_param
    slug
  end

  def latest_version
    versions.reverse_chronological.first
  end
end