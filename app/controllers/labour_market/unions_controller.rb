class LabourMarket::UnionsController < ApplicationController
  layout "page"

  def show
    @union = LabourMarket::Union.find_by_slug(params[:union])
  end
end
