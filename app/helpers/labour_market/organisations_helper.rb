module LabourMarket::OrganisationsHelper
  def organisation_path(organisation)
    return central_union_path(organisation) if organisation.central_union? 
    return employer_association_path(organisation) if organisation.employer_association? 
    return local_union_path(organisation) if organisation.local_union? 
  end

  def organisation_logo(organisation)
    if organisation.logo.attached?
      return organisation.logo
    end
    parent_with_logo = organisation.parents.find { |parent| parent.logo.attached? }
    if parent_with_logo.present?
      puts "Parent with logo: #{parent_with_logo.name}"
      return parent_with_logo.logo
    end
  end

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
