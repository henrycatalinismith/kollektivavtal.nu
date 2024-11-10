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

  enum organisation_type: {
    national_union: 0,
    employer_association: 1,
    local_union: 2,
  }

  rails_admin do
    configure :name do
      sticky true
      column_width 256
    end

    create do
      configure :agreements do hide end
      configure :agreement_memberships do hide end
      configure :parent_memberships do hide end
      configure :child_memberships do hide end
      configure :parents do hide end
      configure :members do hide end
    end
  end

  def to_param
    slug
  end
end