class LabourMarket::AgreementVersion < ApplicationRecord
  validates :signing_year, presence: true
  validates :expiry_year, presence: true
  scope :chronological, -> { order(signing_year: :asc) }
  scope :reverse_chronological, -> { order(signing_year: :desc) }
  belongs_to :agreement, class_name: "LabourMarket::Agreement"
  has_many :documents, class_name: "LabourMarket::Document", dependent: :destroy, inverse_of: :version

  def name
    return if agreement.blank?
    "#{agreement.name} #{signing_year} - #{expiry_year}"
  end

  rails_admin do
    list do
      field :agreement
      field :signing_year
      field :expiry_year
      field :created_at
      field :updated_at
      sort_by :created_at
    end
  end
end
