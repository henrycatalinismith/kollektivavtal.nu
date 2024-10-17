class Policy::Document < ApplicationRecord
  has_many :revisions, class_name: "Policy::Revision", foreign_key: "document_id"

  rails_admin do
    object_label_method do
      :slug
    end
  end
end
