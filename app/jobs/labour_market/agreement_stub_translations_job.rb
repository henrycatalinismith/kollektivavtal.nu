class LabourMarket::AgreementStubTranslationsJob < ApplicationJob
  queue_as :default

  def perform(agreement_id)
    agreement = LabourMarket::Agreement.find(agreement_id)
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