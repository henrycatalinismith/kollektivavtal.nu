module MailingList::SubscriptionsHelper
  def render_subscription_created_markdown(markdown)
    renderer = SubscriptionCreatedRender.new()
    redcarpet = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
    redcarpet.render(markdown)
  end
end

class SubscriptionCreatedRender < Redcarpet::Render::HTML
  def paragraph(text)
    "<p class=\"slide-text landscape:max-w-[70%]\">#{text}</p>"
  end
end
