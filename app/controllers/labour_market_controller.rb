class LabourMarketController < ApplicationController
  layout "page"

  def index
    @highlighted_collective_agreements = LabourMarket::Agreement.first(3)
    @highlighted_local_unions = LabourMarket::Organisation.local_union.first(3)
    @highlighted_central_unions = LabourMarket::Organisation.central_union.first(3)
  end
end