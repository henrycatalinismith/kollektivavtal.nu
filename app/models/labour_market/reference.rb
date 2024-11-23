class LabourMarket::Reference < ApplicationRecord
  belongs_to :referenceable, polymorphic: true, optional: true, inverse_of: :references
  validates :url, presence: true

  def name
    url
  end

  rails_admin do
    configure :referenceable do
      visible true
    end
  end
end