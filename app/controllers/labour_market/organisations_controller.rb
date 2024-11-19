class LabourMarket::OrganisationsController < ApplicationController
  layout "page"
  around_action :set_locale_from_url

  def index
    @organisation_type = params[:organisation_type]
    @organisations = LabourMarket::Organisation
      .where(organisation_type: params[:organisation_type])
      .order(I18n.locale == :sv ? :name_sv : :name_en)
    @letters = @organisations.map { |o| o.name[0].upcase }.uniq.sort
  end

  def show
    puts params.inspect
    @organisation_type = params[:organisation_type]
    @organisation = LabourMarket::Organisation.find_by_slug(params[:id])
  end
end
