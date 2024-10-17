module Blog::PostsHelper
  def render_landing_page_blog_post(post)
    renderer = LandingPageBlogPostRender.new()
    redcarpet = Redcarpet::Markdown.new(renderer, tables: true)
    redcarpet.render(blog_post_body(post))
  end

  def render_blog_post(post)
    renderer = BlogPostRender.new(published_at: post.published_at)
    redcarpet = Redcarpet::Markdown.new(renderer, tables: true)
    redcarpet.render(blog_post_body(post))
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
