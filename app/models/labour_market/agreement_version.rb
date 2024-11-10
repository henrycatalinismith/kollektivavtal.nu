class LabourMarket::AgreementVersion < ApplicationRecord
  validates :signing_year, presence: true
  validates :expiry_year, presence: true
  has_one_attached :document
  scope :chronological, -> { order(signing_year: :asc) }
  scope :reverse_chronological, -> { order(signing_year: :desc) }
  belongs_to :agreement, class_name: "LabourMarket::Agreement"

  def name
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