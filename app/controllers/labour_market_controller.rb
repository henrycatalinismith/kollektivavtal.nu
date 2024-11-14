
class LabourMarketController < ApplicationController
  layout "page"

  def index
    collective_agreement_slugs = [
      "tekniktjansteavtalet",
      "motorbranschavtalet",
      "techsverige",
      "industriavtalet",
    ]

    @highlighted_collective_agreements = LabourMarket::Agreement
      .where(slug: collective_agreement_slugs)
      .sort_by { |a| collective_agreement_slugs.index(a.slug) }

    local_union_slugs = [
      "spotify-workers-unionen",
      "seko-klubb-sj-trafik",
      "volvo-car-verkstadsklubb",
      "sveriges-ingenjorer-pa-sandvik",
    ]

    @highlighted_local_unions = LabourMarket::Organisation
      .where(slug: local_union_slugs)
      .sort_by { |a| local_union_slugs.index(a.slug) }

    central_union_slugs = [
      "if-metall",
      "unionen",
      "kommunal",
      "sveriges-ingenjorer",
    ]

    @highlighted_central_unions = LabourMarket::Organisation
      .where(slug: central_union_slugs)
      .sort_by { |a| central_union_slugs.index(a.slug) }
  end
end