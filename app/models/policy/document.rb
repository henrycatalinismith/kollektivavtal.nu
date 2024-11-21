class Policy::Document < ApplicationRecord
  has_many :revisions, class_name: "Policy::Revision", foreign_key: "document_id"

  rails_admin do
    list do
      field :slug
      field :revisions
      field :created_at
      field :updated_at
      sort_by :created_at
    end

    object_label_method do
      :slug
    end
  end
end
