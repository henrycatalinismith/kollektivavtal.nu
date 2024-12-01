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

## SENTRY_DSN

Logging errors to Sentry requires a valid value in this variable. For development purposes it's fine to leave this blank. You only need a value here if you're working directly on the Sentry integration itself.