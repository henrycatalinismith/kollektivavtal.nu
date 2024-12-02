class LabourMarket::DumpToYamlJob < ApplicationJob
  queue_as :default

  def perform
    path = "/Users/henrycatalinismith/kollektivavtal.github.io"
    central_unions = LabourMarket::Organisation.central_union.all
    collective_agreements = LabourMarket::Agreement.all

    central_unions.each do |central_union|
      slug = central_union.organisation_slug.strip.downcase
      dir = "#{path}/fackförbund/#{slug}"
      filename = "#{dir}/#{slug}.md"
      props = {
        name: {
          en: central_union.name_en,
          sv: central_union.name_sv,
        },
        permalink: "/fackförbund/#{slug}/index.html",
        tags: ["fackförbund"],
        description: {
          en: central_union.description_en,
          sv: central_union.description_sv,
        },
        logo: {
          src: central_union.logo.url,
        }
      }
      yaml = props.deep_stringify_keys.to_yaml

      FileUtils.mkdir_p dir
      FileUtils.rm_rf dir
      FileUtils.mkdir_p dir
      file = File.open(filename, "w")
      file.puts yaml
      file.puts "---"
      puts yaml
    end

    collective_agreements.each do |collective_agreement|
      slug = collective_agreement.agreement_slug.strip.downcase
      dir = "#{path}/kollektivavtal/#{slug}"
      filename = "#{dir}/#{slug}.md"
      props = {
        name: {
          en: collective_agreement.name_en,
          sv: collective_agreement.name_sv,
        },
        permalink: "/kollektivavtal/#{slug}/index.html",
        tags: ["kollektivavtal"],
        description: {
          en: collective_agreement.description_en,
          sv: collective_agreement.description_sv,
        },
        versions: collective_agreement.versions.map do |version|
          {
            signing_year: version.signing_year,
            expiry_year: version.expiry_year,
          }
        end
      }
      yaml = props.deep_stringify_keys.to_yaml

      FileUtils.mkdir_p dir
      FileUtils.rm_rf dir
      FileUtils.mkdir_p dir
      file = File.open(filename, "w")
      file.puts yaml
      file.puts "---"
      puts yaml
    end
  end
end
