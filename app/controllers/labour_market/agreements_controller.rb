class LabourMarket::AgreementsController < ApplicationController
  layout "page"

  def index
    @agreements = LabourMarket::Agreement
      .joins(:versions)
      .chronological
      .includes(:versions)
  end

  def show
    @agreement = LabourMarket::Agreement.find_by_slug(params[:agreement])
  end
end
