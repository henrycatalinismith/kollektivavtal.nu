class LabourMarket::Document < ApplicationRecord
  belongs_to :version, class_name: "LabourMarket::AgreementVersion", foreign_key: "version_id"
  belongs_to :source, class_name: "LabourMarket::Bookmark", optional: true, foreign_key: :source_id
  has_one_attached :file

  scope :unsourced, -> { where(source_url: nil) }

  include Translatable
  translates :name

  rails_admin do
    list do
      scopes [nil, :unsourced]
      field :file
      field :name
      field :created_at
      field :updated_at
      sort_by :created_at
    end
  end
end
