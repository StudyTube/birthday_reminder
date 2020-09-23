defmodule BirthdayReminder.NotifyUsers do
  import Ecto.Query, warn: false

  alias BirthdayReminder.{Users, User}

  @payment_limit 5000

  def run do
    case birthday_boys() do
      [%User{}|_] -> send_reminders()
      [] -> nil
    end
  end

  def birthday do
    Timex.today |> Timex.shift(days: 7)
  end

  defp birthday_boys do
    Users.closest_birthdays
  end

  defp birthday_boy_names do
    birthday_boys()
    |> Enum.map(fn user -> "#{user.first_name} #{user.last_name}" end)
    |> Enum.join(", ")
  end

  defp send_reminders do
    birthday_boys()
    |> Users.subscribed_users
    |> Enum.each(&send_reminder(&1))
  end

  defp send_reminder(user) do
    Nadia.send_message(user.chat_id, text_message(user), parse_mode: "Markdown")
  end

  defp payment_size do
    round(@payment_limit / Enum.count(Users.subscribed_users(birthday_boys()))) * Enum.count(birthday_boys())
  end

  defp text_message(user) do
    """
    Hello #{user.first_name},

    #{Timex.format!(birthday(), "%d %B", :strftime)} is *#{birthday_boy_names()}'s* birthday.

    Send #{payment_size()} uah to the card

    5168 7554 2585 9853
    """
  end
end
