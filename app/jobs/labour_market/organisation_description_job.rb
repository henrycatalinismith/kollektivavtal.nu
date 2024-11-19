require "openai"

class LabourMarket::OrganisationDescriptionJob < ApplicationJob
  queue_as :default

  def perform(id)
    OpenAI.configure do |config|
      config.access_token = ENV.fetch("OPENAI_ACCESS_TOKEN")
      config.organization_id = ENV.fetch("OPENAI_ORGANIZATION_ID")
      config.log_errors = true
    end

    organisation = LabourMarket::Organisation.find(id)

    prompt = <<~EOP
      Given the following description of a Swedish trade union in English, provide the corresponding description in Swedish.
      Return only the Swedish description without any preamble or other commentary.
      Do not translate word for word into Svengelska, but rather provide a natural translation.

      The following table contains a dictionary of terms with their corresponding translations in English and Swedish.
      Do not deviate from those translations if you encounter any of the terms in the description.

      | English     | Swedish     |
      | ----------- | ----------- |
      | trade union | fackförbund |

      #{organisation.description_en}
    EOP

    client = OpenAI::Client.new
    response = client.chat(
        parameters: {
        model: "gpt-3.5-turbo-1106",
        messages: [
          { role: "user", content: prompt },
        ],
        temperature: 0.0,
      }
    )

    description_sv = response.dig("choices", 0, "message", "content")
    puts "Description in Swedish: #{description_sv}"
    organisation.update(description_sv: description_sv)
  end
end