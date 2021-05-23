defmodule TelegramBot.Commands do
  alias BirthdayReminder.{MoneyRounds, Repo, Users}
  alias BirthdayReminder.Users.Schemas.User

  def match_message(%{message: %{text: "/start"}} = message) do
    with user <- current_user(message) do
      Nadia.send_message(user.chat_id, "*Hi there!*\n\nI am the Birthday Reminder Bot.\n\nIf you want to subscribe to further notifications choose the right option.",
          parse_mode: "Markdown",
          reply_markup: %Nadia.Model.ReplyKeyboardMarkup{
            keyboard: [
              [%{text: "Subscribe"}],
              [%{text: "Unsubscribe"}]
            ],
            resize_keyboard: true,
            one_time_keyboard: true
          })
    end
  end

  def match_message(%{message: %{text: "Subscribe"}} = message) do
    with user <- current_user(message),
         {:ok, user} <- Users.update_user(user, %{subscribed: true}) do
      Nadia.send_message(user.chat_id, "You successfully subscribed 🥳")
    end
  end

  def match_message(%{message: %{text: "Unsubscribe"}} = message) do
    with user <- current_user(message),
         {:ok, user} <- Users.update_user(user, %{subscribed: false}) do
      Nadia.send_message(user.chat_id, "You unsubscribed 😕")
    end
  end

  def match_message(%{message: %{text: "code " <> identifier}} = message) do
    with user <- current_user(message),
         {:ok, _money_round} <- MoneyRounds.confirm_payment(identifier, user.username) do
      Nadia.send_message(user.chat_id, "Payment confirmed")
    end
  end

  def match_message(%{message: %{text: _any_text}} = message) do
    with user <- current_user(message) do
      Nadia.send_message(user.chat_id, "I don't understand you")
    end
  end

  defp current_user(%{callback_query: %{message: %{chat: %{id: chat_id, username: username}}}}), do: current_user(chat_id, username)
  defp current_user(%{message: %{chat: %{id: chat_id, username: username}}}), do: current_user(chat_id, username)

  defp current_user(chat_id, username) do
    case Repo.get_by(User, username: username) do
      %User{chat_id: nil} = user ->
        Users.update_user(user, %{chat_id: chat_id})
        user
      %User{} = user -> user
    end
  end

  defp send_message(%User{chat_id: chat_id}, message) do
    Nadia.send_message(chat_id, "I don't understand you")
  end
end
