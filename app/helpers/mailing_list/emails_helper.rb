module MailingList::EmailsHelper
  def render_email_markdown(markdown)
    renderer = EmailRender.new({})
    redcarpet = Redcarpet::Markdown.new(
      renderer,
      tables: true,
      fenced_code_blocks: true,
      autolink: true
    )
    redcarpet.render(markdown)
  end
end

class EmailRender < Redcarpet::Render::HTML
  def header(text, header_level)
    case header_level
    when 1
      %(<h1 style="font-size: 1.1rem">#{text}</h1>)
    else
      %(<h#{header_level}>#{text}</h#{header_level}>)
    end
  end

  def link(href, title, text)
    %(<a style="color: blue; text-underline: underline;" href="#{href}">#{text}</a>)
  end
end
