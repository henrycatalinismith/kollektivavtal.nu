module LabourMarket::AgreementsHelper
  def main_attachment(agreement)
    return nil if agreement.documents.empty?
    main_document = agreement.documents.where(main_document: true).find { |d| d.file.attached? }
    return nil if main_document.nil?
    return main_document.file
  end

  def render_agreement_description(agreement)
    renderer = AgreementDescriptionRenderer.new()
    redcarpet = Redcarpet::Markdown.new(renderer, tables: true)
    redcarpet.render(agreement.description)
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
