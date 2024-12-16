class LabourMarket::DocumentStubTranslationsJob < ApplicationJob
  queue_as :default

  def perform(document_id)
    document = LabourMarket::Document.find(document_id)
    translations = document.translations
    types = [:document_name]
    types.each do |type|
      if translations.where(translation_type: type).empty?
        document.translations.create(
          translation_status: :translation_missing,
          translation_text: "",
          translation_type: type,
        )
      end
    end
  end
end
