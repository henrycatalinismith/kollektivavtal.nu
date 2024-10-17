class Policy::DocumentsController < ApplicationController
  layout "page"

  def show
    @document = Policy::Document.find_by(slug: params[:slug])
    @revision = @document.revisions.order(created_at: :desc).first
  end
end