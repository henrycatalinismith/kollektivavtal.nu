class HomeController < ApplicationController
  allow_unauthenticated_access

  def index
    @blog_posts = Blog::Post.order(published_at: :desc)
    # flash[:notice] = "Welcome to the blog!"
    # @blog_posts = []
  end
end
