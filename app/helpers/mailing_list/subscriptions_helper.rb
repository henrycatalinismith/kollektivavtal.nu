module MailingList::SubscriptionsHelper
  def render_subscription_created_markdown(markdown)
    renderer = SubscriptionCreatedRender.new()
    redcarpet = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
    redcarpet.render(markdown)
  end
end

class SubscriptionCreatedRender < Redcarpet::Render::HTML
  def paragraph(text)
    "<p class=\"mt-4 text-md text-gray-300 max-w-[20rem]\">#{text}</p>"
  end
end
