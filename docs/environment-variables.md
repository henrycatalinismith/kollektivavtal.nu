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

## SENDGRID_API_KEY

All mailing list-related functionality depends on Sendgrid. This API key is how the site authenticates the requests it sends to Sendgrid's API. If you're doing anything mailing list-related you need a valid value here, and otherwise it's possible to leave this blank.

## SENTRY_DSN

Logging errors to Sentry requires a valid value in this variable. For development purposes it's fine to leave this blank. You only need a value here if you're working directly on the Sentry integration itself.