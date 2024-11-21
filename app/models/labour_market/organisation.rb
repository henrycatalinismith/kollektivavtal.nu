class LabourMarket::Organisation < ApplicationRecord
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  scope :chronological, -> { order(created_at: :asc) }
  scope :reverse_chronological, -> { order(created_at: :desc) }
  has_one_attached :logo
  has_many :agreement_memberships, class_name: "LabourMarket::AgreementMembership", dependent: :destroy
  has_many :agreements, through: :agreement_memberships
  has_many :parent_memberships, class_name: "LabourMarket::OrganisationMembership", foreign_key: :parent_id
  has_many :child_memberships, class_name: "LabourMarket::OrganisationMembership", foreign_key: :child_id
  has_many :parents, through: :child_memberships, source: :parent
  has_many :members, through: :parent_memberships, source: :child

  enum organisation_type: [
    :central_union,
    :employer_association,
    :local_union,
  ]

  scope :without_agreements, -> {
    left_outer_joins(:agreements)
      .where(labour_market_agreements: { id: nil })
      .distinct
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

  rails_admin do
    configure :name do
      sticky true
      column_width 256
    end

    list do
      scopes [nil, :without_agreements]
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
      field :organisation_type
      field :website
      field :logo
    end

    edit do
      field :name_en
      field :name_sv
      field :slug
      field :description_en
      field :description_sv
      field :organisation_type
      field :website
      field :logo
    end
  end

  def to_param
    slug
  end
end
