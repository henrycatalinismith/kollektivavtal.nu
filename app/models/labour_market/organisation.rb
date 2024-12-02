class LabourMarket::Organisation < ApplicationRecord
  validates :organisation_name, presence: true
  validates :organisation_slug, presence: true, uniqueness: true
  scope :chronological, -> { order(created_at: :asc) }
  scope :reverse_chronological, -> { order(created_at: :desc) }
  has_one_attached :logo
  has_many :signatures, class_name: "LabourMarket::Signature", dependent: :destroy
  has_many :agreements, through: :signatures
  has_many :parent_memberships, class_name: "LabourMarket::Membership", foreign_key: :parent_id
  has_many :child_memberships, class_name: "LabourMarket::Membership", foreign_key: :child_id
  has_many :parents, through: :child_memberships, source: :parent
  has_many :members, through: :parent_memberships, source: :child
  has_many :translations, as: :translatable

  enum organisation_type: [
    :central_union,
    :employer_association,
    :local_union,
  ]

  scope :agreements_missing, -> {
    left_outer_joins(:agreements)
      .where(labour_market_agreements: { id: nil })
      .distinct
  }

  rails_admin do
    configure :organisation_name do
      sticky true
      column_width 256
    end

    list do
      scopes [
        nil,
        :local_union,
        :central_union,
        :employer_association,
        :agreements_missing,
      ]
      field :organisation_name
      field :organisation_slug
      field :created_at
      field :updated_at
      sort_by :created_at
    end

    create do
      field :organisation_name
      field :organisation_slug
      field :organisation_description
      field :organisation_type
      field :website
      field :logo
    end

    edit do
      field :organisation_name
      field :organisation_slug
      field :organisation_description
      field :organisation_type
      field :website
      field :logo
    end
  end

  def to_param
    organisation_slug
  end
end
