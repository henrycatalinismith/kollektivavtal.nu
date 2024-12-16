require "openai"

class LabourMarket::TranslationBackfillJob < ApplicationJob
  queue_as :default

  def perform
    agreements = LabourMarket::Agreement.all
    agreements.each do |agreement|
      translations = agreement.translations
      types = [:agreement_name, :agreement_description, :agreement_scope]
      types.each do |type|
        if translations.where(translation_type: type).empty?
          agreement.translations.create(
            translation_status: :translation_missing,
            translation_text: "",
            translation_type: type,
          )
        end
      end
    end
  end
end