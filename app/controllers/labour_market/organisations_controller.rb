class LabourMarket::OrganisationsController < ApplicationController
  layout "page"

  def index
    @organisation_type = params[:organisation_type]
    @organisations = LabourMarket::Organisation.where(organisation_type: params[:organisation_type])
  end

  def show
    @organisation_type = params[:organisation_type]
    @organisation = LabourMarket::Organisation.find_by_slug(params[:organisation])
  end
end
