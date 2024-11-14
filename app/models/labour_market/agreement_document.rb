class LabourMarket::AgreementDocument < ApplicationRecord
  belongs_to :version, class_name: "LabourMarket::AgreementVersion", foreign_key: "version_id"
  has_one_attached :file
end
