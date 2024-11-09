class LabourMarket::Organisation < ApplicationRecord
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  scope :chronological, -> { order(created_at: :asc) }
  scope :reverse_chronological, -> { order(created_at: :desc) }
  has_one_attached :logo
  has_many :signatures, class_name: "LabourMarket::CollectiveAgreementSignature", dependent: :destroy
  has_many :agreements, through: :signatures

  rails_admin do
    configure :name do
      sticky true
      column_width 256
    end
  end

  def to_param
    slug
  end
end