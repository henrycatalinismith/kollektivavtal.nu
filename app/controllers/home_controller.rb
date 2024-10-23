class HomeController < ApplicationController
  def index
    @blog_posts = Blog::Post.order(published_at: :desc)
    # flash[:notice] = "Welcome to the blog!"
    # @blog_posts = []
    if flash[:notice] == "Signed up successfully!"
      flash[:notice] = nil
      render "mailing_list/subscriptions/created"
    end
  end

  def landing
  end
end
