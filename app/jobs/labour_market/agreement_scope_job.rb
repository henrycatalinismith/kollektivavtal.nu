require "openai"

class LabourMarket::AgreementScopeJob < ApplicationJob
  queue_as :default

  def perform(id)
    OpenAI.configure do |config|
      config.access_token = ENV.fetch("OPENAI_ACCESS_TOKEN")
      config.organization_id = ENV.fetch("OPENAI_ORGANIZATION_ID")
      config.log_errors = true
    end

    agreement = LabourMarket::Agreement.find(id)

    prompt = <<~EOP
      Given the following description of a Swedish collective agreement in English, shorten it to short phrase stating the scope of the agreement.
      Return only the scope without any preamble or other commentary.

      The following table contains a dictionary of descriptions with their corresponding scopes.
      These are examples of how to distil a description into a scope.

      | Description     | Scope     |
      | ----------- | ----------- |
      | Allmänna bestämmelser – also known as AB – is a collective agreement covering municipal and regional employees | Municipal and regional employees |
      | Friskvårdsavtalet is a collective agreement for staff working in gyms and wellness companies. | Gyms and wellness companies |
      | Glasmästeriavtalet is a collective agreement covering workers in the glass industry. | Glass industry workers |
      | Motorbranschavtalet is a collective agreement that covers workers in the automotive industry, including car dealerships, service centers, and manufacturing plants. | Automotive industry |

      #{agreement.description_en}
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

    scope_en = response.dig("choices", 0, "message", "content")
    agreement.update(scope_en: scope_en)
  end
end
