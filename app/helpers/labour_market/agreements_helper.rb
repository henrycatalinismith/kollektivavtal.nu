module LabourMarket::AgreementsHelper
  def agreement_name(agreement)
    if I18n.locale == :sv
      return agreement.agreement_name
    end
    translation = agreement.translations.find {
      |t| t.agreement_name? and t.translation_language == I18n.locale.to_s
    }
    if translation.present?
      return translation.text
    end
    return agreement.agreement_name
  end

  def agreement_scope(agreement)
    if I18n.locale == :sv
      return agreement.agreement_scope
    end
    translation = agreement.translations.find {
      |t| t.agreement_scope? and t.translation_language == I18n.locale.to_s
    }
    if translation.present?
      return translation.translation_text
    end
    return agreement.agreement_scope
  end

  def agreement_description(agreement)
    if I18n.locale == :sv
      return agreement.agreement_description
    end
    translation = agreement.translations.find {
      |t| t.agreement_description? and t.translation_language == I18n.locale.to_s
    }
    if translation.present?
      return translation.translation_text
    end
    return agreement.agreement_description
  end

  def main_attachment(agreement)
    return nil if agreement.documents.empty?
    main_document = agreement.documents.where(main_document: true).find { |d| d.file.attached? }
    return nil if main_document.nil?
    return main_document.file
  end

  def render_agreement_description(agreement)
    renderer = AgreementDescriptionRenderer.new()
    redcarpet = Redcarpet::Markdown.new(renderer, tables: true)
    markdown = agreement_description(agreement)
    return redcarpet.render(agreement_description(agreement)) if markdown.present?
    return ""
  end
end

class AgreementDescriptionRenderer < Redcarpet::Render::HTML
  def header(text, header_level)
    "<h#{header_level} class=\"text-lg mdtext-2xl font-bold\">#{text}</h#{header_level}>"
  end

  def link(href, title, text)
    %(<a class="text-blue-700 underline" href="#{href}">#{text}</a>)
  end
end
