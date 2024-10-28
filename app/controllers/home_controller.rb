class HomeController < ApplicationController
  def index
    if flash[:notice].present?
      flash[:notice] = nil
      @subscription_created = true
    end
    # @subscription_created = true
  end

  def landing
    @blog_posts = Blog::Post.order(published_at: :desc)
    # flash[:notice] = "Welcome to the blog!"
    # @blog_posts = []
  end
end
