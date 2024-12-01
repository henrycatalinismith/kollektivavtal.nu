require "openai"

class LabourMarket::SeedTranslationsJob < ApplicationJob
  queue_as :default

  def perform
    agreements = LabourMarket::Agreement.all
    agreements.each do |agreement|
      if agreement.description_en.present?
        has_translation = agreement.translations.where(
          translation_language: :en,
          translation_type: :agreement_description,
        ).exists?
        if !has_translation
          agreement.translations.create(
            translation_language: :en,
            translation_status: :translation_fresh,
            translation_type: :agreement_description,
            translation_text: agreement.description_en,
          )
        end
      end

      if agreement.scope_en.present?
        has_translation = agreement.translations.where(
          translation_language: :en,
          translation_type: :agreement_scope,
        ).exists?
        if !has_translation
          agreement.translations.create(
            translation_language: :en,
            translation_status: :translation_fresh,
            translation_type: :agreement_scope,
            translation_text: agreement.scope_en,
          )
        end
      end
    end
    return nil
  end
end
