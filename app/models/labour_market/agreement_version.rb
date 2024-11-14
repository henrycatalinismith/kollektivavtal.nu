class LabourMarket::AgreementVersion < ApplicationRecord
  validates :signing_year, presence: true
  validates :expiry_year, presence: true
  scope :chronological, -> { order(signing_year: :asc) }
  scope :reverse_chronological, -> { order(signing_year: :desc) }
  belongs_to :agreement, class_name: "LabourMarket::Agreement"
  has_many :documents, class_name: "LabourMarket::AgreementDocument", dependent: :destroy, inverse_of: :version

  def name
    return if agreement.blank?
    "#{agreement.name} #{signing_year} - #{expiry_year}"
  end

  rails_admin do
    # configure :signing_year do
    #   sticky true
    #   column_width 32
    # end
    # configure :expiry_year do
    #   sticky true
    #   column_width 32
    # end
  end
end