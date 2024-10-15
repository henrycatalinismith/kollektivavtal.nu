module HomeHelper
  def render_home_index_description_markdown(markdown)
    renderer = HomeDescriptionRender.new()
    redcarpet = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
    redcarpet.render(markdown)
  end
end

class HomeDescriptionRender < Redcarpet::Render::HTML
  def paragraph(text)
    "<p class=\"mt-4 text-sm/6 text-gray-300\">#{text}</p>"
  end
end
