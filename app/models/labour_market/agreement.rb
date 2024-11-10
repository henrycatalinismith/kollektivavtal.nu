class LabourMarket::Agreement < ApplicationRecord
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  scope :chronological, -> { order(created_at: :asc) }
  scope :reverse_chronological, -> { order(created_at: :desc) }
  has_many :versions, class_name: "LabourMarket::AgreementVersion", dependent: :destroy, inverse_of: :agreement
  has_one_attached :image
  has_many :memberships, class_name: "LabourMarket::AgreementMembership", dependent: :destroy, inverse_of: :agreement
  has_many :members, through: :memberships, source: :organisation

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

    create do
      field :name_en
      field :name_sv
      field :slug
      field :description_en
      field :description_sv
      field :image
    end

    edit do
      field :name_en
      field :name_sv
      field :slug
      field :description_en
      field :description_sv
      field :image
    end
  end

  def to_param
    slug
  end

  def latest_version
    versions.reverse_chronological.first
  end
end