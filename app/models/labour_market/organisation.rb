class LabourMarket::Organisation < ApplicationRecord
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  scope :chronological, -> { order(created_at: :asc) }
  scope :reverse_chronological, -> { order(created_at: :desc) }
  has_one_attached :logo
  has_many :agreement_memberships, class_name: "LabourMarket::AgreementMembership", dependent: :destroy
  has_many :agreements, through: :agreement_memberships

  belongs_to :parent, class_name: "LabourMarket::Organisation", optional: true
  has_many :children, class_name: "LabourMarket::Organisation", foreign_key: :parent_id

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
  end

  def to_param
    slug
  end
end