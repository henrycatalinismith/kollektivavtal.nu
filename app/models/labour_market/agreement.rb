class LabourMarket::Agreement < ApplicationRecord
  scope :lexicographical, -> { order(agreement_name: :asc) }
  scope :chronological, -> { order(created_at: :asc) }
  scope :reverse_chronological, -> { order(created_at: :desc) }
  has_many :documents, class_name: "LabourMarket::Document", dependent: :destroy, inverse_of: :agreement
  has_many :signatures, class_name: "LabourMarket::Signature", dependent: :destroy, inverse_of: :agreement
  has_many :members, through: :signatures, source: :organisation
  has_many :references, as: :referenceable
  has_many :translations, as: :translatable

  scope :documents_missing, -> {
    left_outer_joins(:documents)
      .where(labour_market_documents: { id: nil })
      .distinct
  }

  scope :organisations_missing, -> {
    left_outer_joins(:signatures)
      .where(labour_market_signatures: { id: nil })
      .distinct
  }

  scope :references_missing, -> {
    left_outer_joins(:references).where(labour_market_references: { id: nil })
  }

  before_create :set_slug
  def set_slug
    if self.slug.blank?
      self.agreement_slug = self.agreement_name.parameterize
    end
  end

  before_update :update_slug
  def update_slug
    if self.agreement_name_changed?
      self.agreement_slug = self.agreement_name.parameterize
    end
  end

  rails_admin do
    list do
      scopes [
        nil,
        :documents_missing,
        :organisations_missing,
        :references_missing
      ]
      field :agreement_name
      field :agreement_slug
      field :created_at
      field :updated_at
      sort_by :created_at
    end

    create do
      field :agreement_name
      field :agreement_slug
      field :agreement_description
      field :agreement_scope
      field :references
    end

    edit do
      field :agreement_name
      field :agreement_slug
      field :agreement_description
      field :agreement_scope
      field :members
      field :references
    end
  end

  def to_param
    agreement_slug
  end
end
