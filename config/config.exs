# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :birthday_reminder,
  ecto_repos: [BirthdayReminder.Repo],
  bot_name: "studytube_bot"

# Configures the endpoint
config :birthday_reminder, BirthdayReminderWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: BirthdayReminderWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: BirthdayReminder.PubSub,
  live_view: [signing_salt: System.get_env("LIVEVIEW_SALT")]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configures Nadia (telegram bot api)
config :nadia,
  token: System.get_env("TELEGRAM_BOT_ID")

# Configures Quantum
config :birthday_reminder, BirthdayReminder.Scheduler,
  jobs: [
    {"0 9 * * *", {BirthdayReminder.Scheduler.NotifyStakeholders, :call, []}}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
