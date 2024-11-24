class LabourMarket::AgreementsController < ApplicationController
  layout "page"
  around_action :set_locale_from_url

  def index
    @agreements = LabourMarket::Agreement
      .lexicographical
      .joins(:documents)
      .includes(:documents)
  end

  layout "one-two-three", only: :show
  def show
    @agreement = LabourMarket::Agreement.find_by_slug(params[:id])
  end
end
