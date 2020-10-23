defmodule BirthdayReminder.Scheduler.NotifyStakeholders do
  import Ecto.Query, warn: false

  alias BirthdayReminder.{Cache, Users, User}

  @payment_limit 5000

  def run do
    data_preparation()
    execution()
    clear_data()
  end

  defp birthday do
    Timex.today
    |> Timex.shift(days: 7)
    |> Timex.format!("%d %B", :strftime)
  end

  def clear_data do
    Cache.delete(:culprits)
    Cache.delete(:stakeholders)
  end

  defp culprits do
    Cache.get(:culprits)
  end

  defp culprits_names do
    culprits()
    |> Enum.map(fn user -> "#{user.first_name} #{user.last_name}" end)
    |> Enum.join(", ")
  end

  defp execution do
    case culprits() do
      [%User{}|_] -> send_notifications()
      [] -> nil
    end
  end

  defp data_preparation do
    users = Users.closest_birthdays()
    Cache.insert(:culprits, users)
    Cache.insert(:stakeholders, Users.subscribed_users(users))
  end

  defp payment_size do
    round(@payment_limit / Enum.count(stakeholders())) * Enum.count(culprits())
  end

  defp stakeholders do
    Cache.get(:stakeholders)
  end

  defp send_notifications do
    Enum.each(stakeholders(), fn user -> Nadia.send_message(user.chat_id, text_message(user), parse_mode: "Markdown") end)
  end

  defp text_message(user) do
    """
    Hello #{user.first_name},

    #{birthday()} is *#{culprits_names()}'s* birthday.

    Send #{payment_size()} uah to the card

    5168 7554 2585 9853
    """
  end
end
