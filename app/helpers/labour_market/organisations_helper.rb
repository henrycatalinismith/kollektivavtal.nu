module LabourMarket::OrganisationsHelper
  def render_organisation_description(union)
    renderer = OrganisationDescriptionRenderer.new()
    redcarpet = Redcarpet::Markdown.new(renderer, tables: true)
    redcarpet.render(union.description_en || "")
  end
end

class OrganisationDescriptionRenderer < Redcarpet::Render::HTML
  def header(text, header_level)
    "<h#{header_level} class=\"text-lg mdtext-2xl font-bold\">#{text}</h#{header_level}>"
  end

  def link(href, title, text)
    %(<a class="text-blue-700 underline" href="#{href}">#{text}</a>)
  end
end
