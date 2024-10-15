if defined?(Rails::Console)
  return
end

# https://developers.cloudflare.com/turnstile/troubleshooting/testing/
RailsCloudflareTurnstile.configure do |c|
  c.site_key = ENV["CLOUDFLARE_TURNSTILE_SITE_KEY"] || "0x4AAAAAAAxgQdqTNQrVACX3"
  c.secret_key = ENV["CLOUDFLARE_TURNSTILE_SECRET_KEY"] || "0x4AAAAAAAxgQUGKv-qJFuivSTNTmngj0nY"

  c.theme = :dark
  # c.size = :flexible

  # c.site_key = ENV.fetch("CLOUDFLARE_TURNSTILE_SITE_KEY", "1x00000000000000000000AA")
  # c.secret_key = ENV.fetch("CLOUDFLARE_TURNSTILE_SECRET_KEY", "1x0000000000000000000000000000000AA")

  # c.site_key = "1x00000000000000000000AA"
  # c.secret_key = "1x0000000000000000000000000000000AA"

  # c.site_key = "2x00000000000000000000AB"
  # c.secret_key = "2x0000000000000000000000000000000AA"

  c.fail_open = true
end