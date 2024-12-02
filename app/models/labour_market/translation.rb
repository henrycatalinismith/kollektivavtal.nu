class LabourMarket::Translation < ApplicationRecord
  belongs_to :translatable,
    polymorphic: true,
    optional: true,
    inverse_of: :translations

  enum translation_language: [
    :en,
  ]

  enum translation_status: [
    :translation_fresh,
    :translation_stale,
  ]

  enum translation_type: [
    :agreement_name,
    :agreement_description,
    :agreement_scope,
    :document_name,
    :organisation_name,
    :organisation_description,
  ]

  scope :agreement_names, -> {
    where(translation_type: :agreement_name)
  }

  scope :agreement_descriptions, -> {
    where(translation_type: :agreement_description)
  }

  scope :agreement_scopes, -> {
    where(translation_type: :agreement_scope)
  }

  scope :document_names, -> {
    where(translation_type: :document_name)
  }

  scope :organisation_names, -> {
    where(translation_type: :organisation_name)
  }

  scope :organisation_descriptions, -> {
    where(translation_type: :organisation_description)
  }

  rails_admin do
    list do
      scopes [
        nil,
        :agreement_names,
        :agreement_descriptions,
        :agreement_scopes,
        :document_names,
        :organisation_names,
        :organisation_descriptions,
      ]
    end

    object_label_method do
      :translation_text
    end

    configure :translatable do
      visible true
    end

    create do
      configure :translation_language do
        default_value LabourMarket::Translation.translation_languages[:en]
      end

      configure :translation_type do
        default_value LabourMarket::Translation.translation_types[:agreement_name]
      end
    end

    list do
      field :translatable
      field :translation_text
      sort_by :created_at
    end
  end
end
