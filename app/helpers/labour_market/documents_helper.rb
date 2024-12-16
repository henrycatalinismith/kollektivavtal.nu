module LabourMarket::DocumentsHelper
  def document_name(document)
    if I18n.locale == :sv
      return document.document_name
    end
    translation = document.translations.find {
      |t| t.document_name? and t.translation_language == I18n.locale.to_s
    }
    if translation.present?
      return translation.translation_text
    end
    return document.document_name
  end
end
