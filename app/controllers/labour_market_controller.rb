
class LabourMarketController < ApplicationController
  layout "page"
  around_action :set_locale_from_url

  def index
    collective_agreement_slugs = [
      "tekniktjansteavtalet",
      "motorbranschavtalet",
      "industriavtalet",
    ]

    @highlighted_collective_agreements = LabourMarket::Agreement
      .where(slug: collective_agreement_slugs)
      .sort_by { |a| collective_agreement_slugs.index(a.slug) }

    central_union_slugs = [
      "if-metall",
      "unionen",
      "kommunal",
    ]

    @highlighted_central_unions = LabourMarket::Organisation
      .where(slug: central_union_slugs)
      .sort_by { |a| central_union_slugs.index(a.slug) }
  end
end