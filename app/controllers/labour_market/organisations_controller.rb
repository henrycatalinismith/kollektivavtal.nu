class LabourMarket::OrganisationsController < ApplicationController
  around_action :set_locale_from_url

  def index
    @organisation_type = params[:organisation_type]
    @organisations = LabourMarket::Organisation
      .where(organisation_type: params[:organisation_type])
      .order(:organisation_name)
    @letters = @organisations.map { |o| o.organisation_name.upcase }.uniq.sort
    render action: "index", layout: "page"
  end

  def show
    puts params.inspect
    @organisation_type = params[:organisation_type]
    @organisation = LabourMarket::Organisation.find_by_organisation_slug(params[:id])
    @agreements = @organisation.agreements.agreement_public
    render action: "show", layout: "one-two-three"
  end
end
