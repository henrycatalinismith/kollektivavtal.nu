class LabourMarket::AgreementMembership < ApplicationRecord
  belongs_to :agreement, class_name: "LabourMarket::Agreement"
  belongs_to :organisation, class_name: "LabourMarket::Organisation"
end
