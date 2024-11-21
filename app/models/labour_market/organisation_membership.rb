class LabourMarket::OrganisationMembership < ApplicationRecord
  belongs_to :parent, class_name: "LabourMarket::Organisation"
  belongs_to :child, class_name: "LabourMarket::Organisation"

  rails_admin do
    list do
      field :parent
      field :child
      field :created_at
      field :updated_at
      sort_by :created_at
    end
  end
end
