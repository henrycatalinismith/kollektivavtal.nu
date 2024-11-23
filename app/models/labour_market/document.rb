class LabourMarket::Document < ApplicationRecord
  belongs_to :agreement, class_name: "LabourMarket::Agreement", foreign_key: "agreement_id", optional: true
  belongs_to :period, class_name: "LabourMarket::Period", foreign_key: "period_id", optional: true
  has_many :references, as: :referenceable, inverse_of: :referenceable
  has_one_attached :file

  scope :agreement_missing, -> { where(agreement_id: nil) }
  scope :period_missing, -> { where(period_id: nil) }
  scope :reference_missing, -> {
    left_outer_joins(:references).where(labour_market_references: { id: nil })
  }

  include Translatable
  translates :name

  rails_admin do
    list do
      scopes [
        nil,
        :agreement_missing,
        :period_missing,
        :reference_missing,
      ]
      field :file
      field :name
      field :created_at
      field :updated_at
      sort_by :created_at
    end
  end
end
