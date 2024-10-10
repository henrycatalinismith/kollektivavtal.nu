class HomeController < ApplicationController
  def index
    @blog_posts = Blog::Post.order(published_at: :desc)
    # @blog_posts = []
  end
end
