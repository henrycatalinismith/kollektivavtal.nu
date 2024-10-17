class Blog::PostsController < ApplicationController
  layout "page"

  def show
    @post = Blog::Post.find_by(slug: params[:slug])
    if @post.nil?
      raise ActionController::RoutingError.new("Not Found")
    end
    @posts = Blog::Post.reverse_chronological
  end
end

