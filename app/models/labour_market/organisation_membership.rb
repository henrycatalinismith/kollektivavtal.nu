class LabourMarket::OrganisationMembership < ApplicationRecord
  belongs_to :parent, class_name: "LabourMarket::Organisation"
  belongs_to :child, class_name: "LabourMarket::Organisation"
end
