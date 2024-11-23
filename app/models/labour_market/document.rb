class LabourMarket::Document < ApplicationRecord
  belongs_to :agreement, class_name: "LabourMarket::Agreement", foreign_key: "agreement_id", optional: true
  belongs_to :period, class_name: "LabourMarket::Period", foreign_key: "period_id", optional: true
  belongs_to :source, class_name: "LabourMarket::Bookmark", foreign_key: "source_id", optional: true
  has_one_attached :file

  scope :source_missing, -> { where(source_id: nil) }
  scope :period_missing, -> { where(period_id: nil) }
  scope :agreement_missing, -> { where(agreement_id: nil) }

  include Translatable
  translates :name

  rails_admin do
    list do
      scopes [nil, :source_missing, :period_missing, :agreement_missing]
      field :file
      field :name
      field :created_at
      field :updated_at
      sort_by :created_at
    end
  end
end
