defmodule BirthdayReminder.Repo do
  use Ecto.Repo,
    otp_app: :birthday_reminder,
    adapter: Ecto.Adapters.Postgres
end
