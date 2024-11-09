class LabourMarket::OrganisationsController < ApplicationController
  layout "page"

  def show
    @organisation = LabourMarket::Organisation.find_by_slug(params[:organisation])
  end
end
