class LabourMarket::CollectiveAgreementSignature < ApplicationRecord
  belongs_to :agreement, class_name: "LabourMarket::CollectiveAgreement"
  belongs_to :organisation, class_name: "LabourMarket::Organisation"
end