class LabourMarket::CollectiveAgreementsController < ApplicationController
  layout "page"

  def index
    @agreements = LabourMarket::CollectiveAgreement
      .joins(:versions)
      .chronological
      .includes(:versions)
  end

  def show
    @agreement = LabourMarket::CollectiveAgreement.find_by_slug(params[:agreement])
  end
end
