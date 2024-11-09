module LabourMarket::CollectiveAgreementsHelper
  def render_collective_agreement_description(agreement)
    renderer = CollectiveAgreementDescriptionRenderer.new()
    redcarpet = Redcarpet::Markdown.new(renderer, tables: true)
    redcarpet.render(agreement.description_en)
  end
end

class CollectiveAgreementDescriptionRenderer < Redcarpet::Render::HTML
  def header(text, header_level)
    "<h#{header_level} class=\"text-lg mdtext-2xl font-bold\">#{text}</h#{header_level}>"
  end

  def link(href, title, text)
    %(<a class="text-blue-700 underline" href="#{href}">#{text}</a>)
  end
end


class BlogPostRender < Redcarpet::Render::HTML

  def header(text, header_level)
    case header_level
    when 1
      %(
          <h1 class="text-lg mdtext-2xl font-bold">
            #{text}
          </h#{header_level}>

        )
    else
      %(
          <h#{header_level} class="text-lg mdtext-2xl font-bold">
            #{text}
          </h#{header_level}>"
        )
    end
  end

  def link(href, title, text)
    %(<a class="text-blue-700 underline" href="#{href}">#{text}</a>)
  end
end
