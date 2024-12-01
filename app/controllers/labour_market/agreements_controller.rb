class LabourMarket::AgreementsController < ApplicationController
  around_action :set_locale_from_url

  def index
    @agreements = LabourMarket::Agreement
      .lexicographical
      .joins(:documents)
      .includes(:documents)
  render action: "index", layout: "page"
  end

  def show
    @agreement = LabourMarket::Agreement.find_by_agreement_slug(params[:id])
    render action: "show", layout: "one-two-three"
  end
end
