require "front_matter_parser"
require "redcarpet"

class PagesController < ApplicationController
  def show
    file = Rails.root.join("app/pages/privacy.en.md")
    text = File.read(file)
    unsafe_loader = ->(string) do
      Psych.safe_load(string, permitted_classes: [Date, Time])
    end
    parsed = FrontMatterParser::Parser.parse_file(file, loader: unsafe_loader)
    @data = parsed.front_matter
    @content = parsed.content
    # render template: "pages/show", layout: "internal"
  end
end

