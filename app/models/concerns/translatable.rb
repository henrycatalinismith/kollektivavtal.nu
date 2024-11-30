module Translatable
  extend ActiveSupport::Concern

  included do
    def self.translates(*attributes)
      attributes.each do |attribute|
        define_method(attribute) do
          translation_for(attribute)
        end
      end
    end
  end

  def translation_for(attribute)
    available_locales = I18n.available_locales
    sorted_locales = available_locales.sort_by { |locale|
      case locale
      when I18n.locale
        0
      when I18n.default_locale
        1
      else
        2
      end
    }
    available_locales.each do |locale|
      value = read_attribute("#{attribute}_#{locale}")
      return value if value.present?
    end
    return ""
  end
end
