class LabourMarket::Agreement < ApplicationRecord
  scope :lexicographical, -> { order(name_sv: :asc) }
  scope :chronological, -> { order(created_at: :asc) }
  scope :reverse_chronological, -> { order(created_at: :desc) }
  has_many :documents, class_name: "LabourMarket::Document", dependent: :destroy, inverse_of: :agreement
  has_many :signatures, class_name: "LabourMarket::Signature", dependent: :destroy, inverse_of: :agreement
  has_many :members, through: :signatures, source: :organisation
  has_many :periods, through: :documents
  has_many :references, as: :referenceable

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

  include Translatable
  translates :name
  translates :description

  before_create :set_default_names
  def set_default_names
    if self.name_sv.blank? and self.name_en.present?
      self.name_sv = self.name_en
    elsif self.name_en.blank? and self.name_sv.present?
      self.name_en = self.name_sv
    end
  end

  before_create :set_slug
  def set_slug
    if self.slug.blank?
      self.slug = self.name_sv.parameterize
    end
  end

  before_update :update_slug
  def update_slug
    if self.name_sv_changed?
      self.slug = self.name_sv.parameterize
    end
  end

  rails_admin do
    configure :name do
      sticky true
      column_width 256
    end

    list do
      scopes [
        nil,
        :documents_missing,
        :organisations_missing,
        :references_missing
      ]
      field :name
      field :slug
      field :created_at
      field :updated_at
      sort_by :created_at
    end

    create do
      field :name_en
      field :name_sv
      field :slug
      field :description_en
      field :description_sv
    end

    edit do
      field :name_en
      field :name_sv
      field :slug
      field :description_en
      field :description_sv
      field :members
    end
  end

  def to_param
    slug
  end
end
