class LabourMarket::Document < ApplicationRecord
  belongs_to :agreement, class_name: "LabourMarket::Agreement", foreign_key: "agreement_id", optional: true
  has_many :references, as: :referenceable, inverse_of: :referenceable
  has_many :translations, as: :translatable
  has_one_attached :file

  enum document_language: [:sv, :en]

  scope :agreement_missing, -> { where(agreement_id: nil) }
  scope :reference_missing, -> {
    left_outer_joins(:references)
      .where(labour_market_references: { id: nil })
  }

  scope :translations_missing, -> {
    left_outer_joins(:translations)
      .where(labour_market_translations: { id: nil })
  }

  rails_admin do
    object_label_method do
      :document_name
    end

    list do
      scopes [
        nil,
        :agreement_missing,
        :reference_missing,
        :translations_missing,
      ]
      field :file
      field :name
      field :created_at
      field :updated_at
      sort_by :created_at
    end

    create do
      field :document_name
      field :document_language
      field :document_start_year
      field :document_end_year
      field :references
      field :main_document
      field :agreement
    end

    edit do
      field :document_name
      field :document_language
      field :document_start_year
      field :document_end_year
      field :references
      field :main_document
      field :agreement
      field :translations
    end
  end
end
