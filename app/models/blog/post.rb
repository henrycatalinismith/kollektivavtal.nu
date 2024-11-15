class Blog::Post < ApplicationRecord
  validates :title_en, presence: true
  validates :body_en, presence: true
  validates :title_sv, presence: true
  validates :body_sv, presence: true
  validates :slug, presence: true

  has_one_attached :image
  validates :image, presence: true

  scope :chronological, -> { order(published_at: :asc) }
  scope :reverse_chronological, -> { order(published_at: :desc) }

  def title
    if I18n.locale == :sv
      title_sv
    else
      title_en
    end
  end

  def body
    if I18n.locale == :sv
      body_sv
    else
      body_en
    end
  end

  rails_admin do
    configure :body_en, :text
    configure :body_sv, :text

    configure :title_en do
      sticky true
      column_width 256
    end

    edit do
      configure :body_en, :editorjs do
        label "Body (en)"
      end
    end
  end
end
