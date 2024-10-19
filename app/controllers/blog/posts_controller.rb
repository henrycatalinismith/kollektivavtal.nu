class Blog::PostsController < ApplicationController
  layout "page"

  def index
    @post = Blog::Post.reverse_chronological.first
    redirect_to blog_post_path(@post.slug)
  end

  def show
    @post = Blog::Post.find_by(slug: params[:slug])
    if @post.nil?
      raise ActionController::RoutingError.new("Not Found")
    end
    @posts = Blog::Post.reverse_chronological
  end
end
