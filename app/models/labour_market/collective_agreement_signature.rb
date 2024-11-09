class LabourMarket::CollectiveAgreementSignature < ApplicationRecord
  belongs_to :agreement, class_name: "LabourMarket::CollectiveAgreement"
  belongs_to :union, class_name: "LabourMarket::Union"
end