module Policy::RevisionsHelper
  def render_revision_body(revision)
    renderer = PolicyRevisionRender.new()
    redcarpet = Redcarpet::Markdown.new(renderer, tables: true)
    redcarpet.render(policy_revision_body(revision))
  end

  def policy_revision_title(revision)
    case I18n.locale
    when :en then revision.title_en
    when :sv then revision.title_sv
    end
  end

  def policy_revision_body(revision)
    case I18n.locale
    when :en then revision.body_en
    when :sv then revision.body_sv
    end
  end
end

class PolicyRevisionRender < Redcarpet::Render::HTML
  def link(href, title, text)
    %(<a class="text-blue-700 underline" href="#{href}">#{text}</a>)
  end
end
