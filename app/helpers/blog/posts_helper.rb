module Blog::PostsHelper
  def render_landing_page_blog_post(post)
    renderer = LandingPageBlogPostRender.new()
    redcarpet = Redcarpet::Markdown.new(renderer, tables: true)
    redcarpet.render(blog_post_body(post))
  end

  def render_blog_post(post)
    body = blog_post_body(post)
    
    begin
      blob = JSON.parse(body)
    rescue JSON::ParserError
      renderer = BlogPostRender.new(published_at: post.published_at)
      redcarpet = Redcarpet::Markdown.new(renderer, tables: true)
      return redcarpet.render(blog_post_body(post))
    end

    return blob["blocks"].map do |block|
      case block["type"]
      when "header"
        %(
          <h#{block["data"]["level"]} class="text-lg md"text-2xl font-bold">
            #{block["data"]["text"]}
          </h#{block["data"]["level"]}>
        )
      when "paragraph"
        %(
          <p class="text-base md:text-lg">
            #{block["data"]["text"]}
          </p>
        )
      when "list"
        %(
          <ul class="list-disc list-inside">
            #{block["data"]["items"].map { |item| "<li>#{item}</li>" }.join}
          </ul>
        )
      end
    end.join
  end

  def blog_post_body(post)
    case I18n.locale
    when :en then post.body_en
    when :sv then post.body_sv
    end
  end

  def blog_post_title(post)
    case I18n.locale
    when :en then post.title_en
    when :sv then post.title_sv
    end
  end
end

class LandingPageBlogPostRender < Redcarpet::Render::HTML
  def header(text, header_level)
    "<h#{header_level} class=\"text-lg mdtext-2xl font-bold\">#{text}</h#{header_level}>"
  end

  def link(href, title, text)
    %(<a class="text-blue-700 underline" href="#{href}">#{text}</a>)
  end
end


class BlogPostRender < Redcarpet::Render::HTML
  def initialize(data)
    super
    @data = data
  end

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
