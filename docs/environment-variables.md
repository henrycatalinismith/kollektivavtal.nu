---
title: Environment Variables
layout: default
---

# Environment Variables
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

In production, certain configuration values are passed to the Ruby process as environment variables. In development, we use a gem called [dotenv](https://github.com/bkeepers/dotenv) to load these values from a file called `.env`.

## CLOUDFLARE_TURNSTILE_SITE_KEY

The mailing list form uses [Cloudflare Turnstile](https://www.cloudflare.com/products/turnstile/) to filter out automated signups by spambots. You can use one of [Cloudflare's dummy sitekeys](https://developers.cloudflare.com/turnstile/troubleshooting/testing/) for this value unless you need to test something very very specific related to the real integration.

## CLOUDFLARE_TURNSTILE_SITE_SECRET

Similar to [CLOUDFLARE_TURNSTILE_SITE_KEY](#cloudflare_turnstile_site_key) above. You can use one of [Cloudflare's dummy secret keys](https://developers.cloudflare.com/turnstile/troubleshooting/testing/) for this value too.

## SENDGRID_API_KEY

All mailing list-related functionality depends on Sendgrid. This API key is how the site authenticates the requests it sends to Sendgrid's API. If you're doing anything mailing list-related you need a valid value here, and otherwise it's possible to leave this blank.

## SENTRY_DSN

Logging errors to Sentry requires a valid value in this variable. For development purposes it's fine to leave this blank. You only need a value here if you're working directly on the Sentry integration itself.