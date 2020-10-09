defmodule BirthdayReminder.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      BirthdayReminder.Cache,
      BirthdayReminder.Repo,
      BirthdayReminder.Scheduler,
      BirthdayReminderWeb.Endpoint,
      TelegramBot
    ]

    opts = [strategy: :one_for_one, name: BirthdayReminder.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    BirthdayReminderWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
