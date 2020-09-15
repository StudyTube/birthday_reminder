# BirthdayReminder

Simple telegram bot for reminders of the Kharkiv team birthdays.

## Without Docker

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

## With Docker

   * Run `docker-compose up`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Website

[BirthdayReminder](https://birthday-reminder.gigalixirapp.com/)

## How to deploy

We are using [Gigalixir](https://gigalixir.com/) as a hosting provider.

`git push gigalixir master`
