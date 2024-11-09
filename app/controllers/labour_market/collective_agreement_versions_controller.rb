class LabourMarket::CollectiveAgreementVersionsController < ApplicationController
  layout "page"

  def show
    @agreement = LabourMarket::CollectiveAgreement.find_by_slug(params[:agreement])
    @version = @agreement.versions.find_by_slug(params[:version])
  end
end
