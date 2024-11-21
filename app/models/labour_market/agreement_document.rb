class LabourMarket::AgreementDocument < ApplicationRecord
  belongs_to :version, class_name: "LabourMarket::AgreementVersion", foreign_key: "version_id"
  has_one_attached :file

  include Translatable
  translates :name

  rails_admin do
    list do
      field :file
      field :name
      field :created_at
      field :updated_at
      sort_by :created_at
    end
  end
end
