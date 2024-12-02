
class LabourMarket::IndexController < ApplicationController
  layout "page"
  around_action :set_locale_from_url

  def index
    collective_agreement_slugs = [
      "tekniktjansteavtalet",
      "motorbranschavtalet",
      "industriavtalet",
    ]

    @highlighted_collective_agreements = LabourMarket::Agreement
      .where(agreement_slug: collective_agreement_slugs)
      .sort_by { |a| collective_agreement_slugs.index(a.agreement_slug) }

    central_union_slugs = [
      "if-metall",
      "unionen",
      "kommunal",
    ]

    @highlighted_central_unions = LabourMarket::Organisation
      .where(organisation_slug: central_union_slugs)
  end
end
