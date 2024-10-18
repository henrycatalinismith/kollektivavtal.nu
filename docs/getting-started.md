---
title: Getting Started
layout: default
nav_order: 0
---

# Getting Started
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

The site runs on [Rails](https://rubyonrails.org/) using [SQLite](https://www.sqlite.org/) as its database, so getting it working locally on your computer entails getting one Ruby process running correctly.

This document assumes you have some software engineering background knowledge and access to a computer that you've already set up with common developer tools such as a terminal and text editor which you know how to use.

## Clone the repo

```
git clone git@github.com:kollektivavtal/kollektivavtal.nu.git
```

It doesn't matter where specifically in your computer's directory structure you put your clone. This document assumes it's in the top level of your home directory, where it's accessible as `~/kollektivavtal.nu`.

## Install rbenv

There's a `.ruby-version` file in the root of the git repository which contains the version of Ruby that the app runs on. You should install [rbenv](https://github.com/rbenv/rbenv), which is a tool that can read from that file and then install the right version of Ruby onto your computer.

```
brew install rbenv
rbenv init
```

Once rbenv is set up, you run `rbenv install` from inside your local clone of the kollektivavtal.nu repo to install the correct Ruby version.

```
cd ~/kollektivavtal.nu
rbenv install
```

## Run `bundle install`

The site depends on a whole bunch of open source code that's packaged as Ruby gems, which are similar to npm packages. You need to download that code onto your computer before you can run it.

```
bundle install
```

## Install yarn

While the back end is built in Ruby, some of the site's front end assets are produced using tools from the npm ecosystem. So we need yarn installed on your computer in order to download those tools.

```
npm install -g yarn
```

If you don't already have Node and npm installed on your computer, you'll have to [take care of that first](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm) too.

## Run `yarn install`

Once you have yarn working you need to run it once to get the various npm packages installed.

```
yarn install
```

## Create `.env` file

Create a file called `.env` in the root of the git repository and then copy and paste the following into it.

```yaml
CLOUDFLARE_TURNSTILE_SITE_KEY="1x00000000000000000000AA"
CLOUDFLARE_TURNSTILE_SECRET_KEY="1x0000000000000000000000000000000AA"
```

You can [read more about the values in this `.env` file](/environment-variables.html) if you're curious. But you can also just carry this step out mechanically and move on.

## Run database migrations

This gets your SQLite database (found in `storage/development.sqlite3`) updated with the correct schema.

```
./bin/rake db:migrate
```

## Start Rails server

```
./bin/dev
```

## Open in browser

[http://localhost:3000/](http://localhost:3000/)