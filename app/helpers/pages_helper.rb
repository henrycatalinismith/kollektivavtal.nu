module PagesHelper
  def render_page(markdown, data = {})
    @data = data
    renderer = PageRender.new(@data)
    redcarpet =
      Redcarpet::Markdown.new(
        renderer,
        tables: true,
        fenced_code_blocks: true,
        autolink: true
      )
    redcarpet.render(markdown)
  end
end

class PageRender < Redcarpet::Render::HTML
  def initialize(data)
    super
    @data = data
  end

  def header(text, header_level)
    case header_level
    when 1
      %(<h1 class="text-3xl font-bold font-bold mb-8 pb-8 border-b border-gray-300">#{text}</h1>)
    when 2
      %(<h#{header_level} class="text-2xl font-bold font-bold mt-8 mb-6">#{text}</h#{header_level}>)
    when 3
      %(<h#{header_level} class="text-xl font-bold font-bold mt-8 mb-6">#{text}</h#{header_level}>)
    else
      %(<h#{header_level} class="text-lg font-bold font-bold mt-8 mb-6">#{text}</h#{header_level}>)
    end
  end

  def link(href, title, text)
    %(<a class="text-blue-700 underline" href="#{href}">#{text}</a>)
  end

  def table(header, body)
    %(<table class="mb-8"><thead>#{header}</thead><tbody>#{body}</tbody></table>)
  end

  def table_row(content)
    %(<tr class="border-b border-gray-300">#{content}</tr>)
  end

  def table_cell(content, alignment, header)
    if header
      %(<th class="text-left">#{content}</th>)
    else
      %(<td class="align-top py-4 first:pr-4">#{content}</td>)
    end
  end

  def block_code(code, language)
    %(<pre class="bg-black-100 p-4 rounded-md"><code class="language-#{language}">#{code}</code></pre>)
  end
end
