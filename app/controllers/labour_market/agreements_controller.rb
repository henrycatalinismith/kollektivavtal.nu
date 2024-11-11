class LabourMarket::AgreementsController < ApplicationController
  layout "page"

  def index
    @agreements = LabourMarket::Agreement
      .order(I18n.locale == :sv ? :name_sv : :name_en)
      .joins(:versions)
      .chronological
      .includes(:versions)
  end

  def show
    @agreement = LabourMarket::Agreement.find_by_slug(params[:agreement])
  end
end
