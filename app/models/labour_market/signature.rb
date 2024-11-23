class LabourMarket::Signature < ApplicationRecord
  belongs_to :agreement, class_name: "LabourMarket::Agreement"
  belongs_to :organisation, class_name: "LabourMarket::Organisation"

  rails_admin do
    list do
      field :agreement
      field :organisation
      field :created_at
      field :updated_at
      sort_by :created_at
    end
  end
end
