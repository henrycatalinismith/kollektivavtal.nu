class HomeController < ApplicationController
  def index
    if flash[:notice].present?
      flash[:notice] = nil
      @subscription_created = true
    end
    # @subscription_created = true
  end

  def landing
    @blog_posts = Blog::Post.order(published_at: :desc)
    # flash[:notice] = "Welcome to the blog!"
    # @blog_posts = []
  end

  layout "page", only: [:combo]
  def combo
    collective_agreement_slugs = [
      "tekniktjansteavtalet",
      "industriavtalet",
      "it-avtalet",
    ]

    @highlighted_collective_agreements = LabourMarket::Agreement
      .where(slug: collective_agreement_slugs)
      .sort_by { |a| collective_agreement_slugs.index(a.slug) }
  end
end
