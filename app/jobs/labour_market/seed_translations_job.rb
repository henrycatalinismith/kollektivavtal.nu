require "openai"

class LabourMarket::SeedTranslationsJob < ApplicationJob
  queue_as :default

  def perform
    organisations = LabourMarket::Organisation.all
    organisations.each do |organisation|
      if organisation.description_en.present?
        has_translation = organisation.translations.where(
          translation_language: :en,
          translation_type: :organisation_description,
        ).exists?
        if !has_translation
          organisation.translations.create(
            translation_language: :en,
            translation_status: :translation_fresh,
            translation_type: :organisation_description,
            translation_text: organisation.description_en,
          )
        end
      end
    end
    return nil
  end
end
