class Policy::Revision < ApplicationRecord
  belongs_to :document, class_name: "Policy::Document"
  validates :title_en, presence: true
  validates :title_sv, presence: true
  validates :body_en, presence: true
  validates :body_sv, presence: true

  rails_admin do
    object_label_method do
      :created_at
    end

    list do
      field :document
      field :title_en
      field :title_sv
      field :created_at
      sort_by :created_at
    end

    edit do
      exclude_fields :id, :created_at, :updated_at, :document, :title_en, :title_sv, :body_en, :body_sv
    end

    configure :title_en do
      label "Title (English)"
    end

    configure :title_sv do
      label "Title (Swedish)"
    end

    configure :body_en, :text do
      html_attributes rows: 20
    end

    configure :body_sv, :text do
      html_attributes rows: 20
    end
  end
end
