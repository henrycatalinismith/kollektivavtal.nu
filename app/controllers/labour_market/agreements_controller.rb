class LabourMarket::AgreementsController < ApplicationController
  around_action :set_locale_from_url

  def index
    if I18n.locale == :sv
      @agreements = LabourMarket::Agreement
        .agreement_public
        .lexicographical
        .joins(:documents)
        .includes(:documents)
    else
      @agreements = LabourMarket::Agreement
        .agreement_public
        .joins(:documents)
        .includes(:documents)
        .joins(:translations)
        .includes(:translations)
        .where(labour_market_translations: { translation_language: I18n.locale.to_s })
      @agreements = @agreements.sort_by do |agreement|
        translation = agreement.translations.find { |t| t.agreement_name? }
        if translation.present?
          translation.translation_text || agreement.agreement_name
        else
          agreement.agreement_name
        end
      end
    end
    render action: "index", layout: "page"
  end

  def show
    @agreement = LabourMarket::Agreement
      .left_outer_joins(:documents, :translations)
      .includes(:documents, :translations)
      .find_by_agreement_slug(params[:id])
    if @agreement.blank?
      raise ActiveRecord::RecordNotFound
    end
    render action: "show", layout: "one-two-three"
  end
end
