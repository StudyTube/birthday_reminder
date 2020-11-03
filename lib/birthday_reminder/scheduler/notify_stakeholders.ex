defmodule BirthdayReminder.Scheduler.NotifyStakeholders do
  import Ecto.Query, warn: false

  alias BirthdayReminder.{Cache, MoneyRounds, Users, User}

  @payment_limit 5000

  def run do
    run(Users.closest_birthdays())
  end

  def run([%User{}|_] = birthday_people) do
    birthday_people
    |> create_money_round
    |> stakeholders
    |> send_notifications
  end

  def run(_) do
    :ok
  end

  defp birthday do
    Timex.today
    |> Timex.shift(days: 7)
    |> Timex.format!("%d %B", :strftime)
  end

  defp create_money_round(birthday_people) do
    money_round = MoneyRounds.create_money_round(%{
      name: "#{User.user_names(birthday_people)}'s birthday",
      expired_date: Timex.shift(Timex.today, days: 7),
      identifier: :crypto.strong_rand_bytes(32) |> Base.encode64 |> binary_part(0, 32)
    })

    {money_round, birthday_people}
  end

  defp stakeholders({money_round, birthday_people}) do
    subscribers = Users.subscribed_users(birthday_people)
    {money_round, birthday_people, subscribers}
  end

  defp send_notifications({money_round, birthday_people, subscribers}) do
    payment_size = round(@payment_limit / Enum.count(subscribers) * Enum.count(birthday_people))

    Enum.each(subscribers, fn user ->
      Nadia.send_message(user.chat_id, text_message(user, User.user_names(birthday_people), money_round.identifier, payment_size), parse_mode: "Markdown")
    end)
  end

  defp text_message(user, user_names, identifier, payment_size) do
    """
    Hello #{user.first_name},

    #{birthday()} is *#{user_names}'s* birthday.

    Send #{payment_size} uah to the card

    5351 2901 0222 8682

    -------------------------------

    Please write "code #{identifier}" to the chat to confirm your payment
    """
  end
end
