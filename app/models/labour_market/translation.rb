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
    :organisation_name,
    :organisation_description,
  ]

  rails_admin do
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
