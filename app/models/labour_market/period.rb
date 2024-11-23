class LabourMarket::Period < ApplicationRecord
  has_many :documents, class_name: "LabourMarket::Document", foreign_key: "period_id"

  scope :reverse_chronological, -> { order(start_year: :desc) }

  def name
    return "#{start_year}" if end_year.blank?
    return "#{start_year}–#{end_year}"
  end

  rails_admin do
    list do
      field :start_year
      field :end_year
      field :created_at
      field :updated_at
      sort_by :created_at
    end
  end
end
