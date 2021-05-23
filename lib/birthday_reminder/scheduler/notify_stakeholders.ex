defmodule BirthdayReminder.Scheduler.NotifyStakeholders do
  @moduledoc """
  The notification module to inform users about upcoming birthday.
  """
  import Ecto.Query, only: [where: 3]

  alias BirthdayReminder.{MoneyRounds, Users}
  alias BirthdayReminder.Repo
  alias BirthdayReminder.Users.Schemas.User

  @payment_limit 5000

  def call do
    with [%User{} | _] = birthday_people <- Users.upcoming_birthdays(),
         {:ok, birthday_people_names} <- get_birthday_people_names(birthday_people),
         {:ok, money_round} <- create_money_round(birthday_people_names),
         subscribers <- get_subscribers(birthday_people),
         {:ok, payment_size} <- calculate_payment_size(subscribers, birthday_people) do
      send_notifications(subscribers, birthday_people_names, money_round.identifier, payment_size)
    else
      _ -> :ok
    end
  end

  defp birthday do
    Timex.today()
    |> Timex.shift(days: 7)
    |> Timex.format!("%d %B", :strftime)
  end

  def get_birthday_people_names(users) do
    names =
      users
      |> Enum.map(fn user -> "#{user.first_name} #{user.last_name}" end)
      |> Enum.join(", ")

    {:ok, names}
  end

  defp get_subscribers(except_users) do
    except_ids = Enum.map(except_users, & &1.id)

    User
    |> where([u], u.subscribed == true and not (u.id in ^except_ids))
    |> Repo.all()
  end

  defp calculate_payment_size(subscribers, birthday_people) do
    {:ok, round(@payment_limit / Enum.count(subscribers) * Enum.count(birthday_people))}
  end

  defp create_money_round(birthday_people_names) do
    MoneyRounds.create_money_round(%{
      name: "#{birthday_people_names}'s birthday",
      expired_date: Timex.shift(Timex.today(), days: 7),
      identifier: :crypto.strong_rand_bytes(32) |> Base.encode64() |> binary_part(0, 32)
    })
  end

  defp send_notifications(subscribers, birthday_people_names, identifier, payment_size) do
    Enum.each(subscribers, fn subscriber ->
      Nadia.send_message(subscriber.chat_id, text_message(subscriber, birthday_people_names, identifier, payment_size),
        parse_mode: "Markdown"
      )
    end)
  end

  defp text_message(user, user_names, identifier, payment_size) do
    """
    Hello #{user.first_name},

    #{birthday()} is *#{user_names}'s* birthday.

    Send #{payment_size} uah to the card

    5351 2901 5939 9725

    -------------------------------

    Please write "code #{identifier}" to the chat to confirm your payment.
    """
  end
end
