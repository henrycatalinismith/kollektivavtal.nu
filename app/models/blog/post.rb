class Blog::Post < ApplicationRecord

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
end