defmodule TelegramBot.Commands do
  alias BirthdayReminder.{Repo, User, Users}

  def match_message(%{message: %{text: "/start"}} = message) do
    message
    |> current_chat
    |> Nadia.send_message("*Hi there!*\nI am the Birthday Reminder Bot.\nIf you want to subscribe to further notifications choose the right option.\n",
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

  def match_message(%{message: %{text: "Subscribe"}} = message) do
    message
    |> current_chat
    |> Users.subscribe
    |> Nadia.send_message("You successfully subscribed 🥳")
  end

  def match_message(%{message: %{text: "Unsubscribe"}} = message) do
    message
    |> current_chat
    |> Users.unsubscribe
    |> Nadia.send_message("You unsubscribed 😕")
  end

  def match_message(%{message: %{text: _any_text}} = message) do
    message
    |> current_chat
    |> Nadia.send_message("I don't understand you")
  end

  defp current_chat(%{callback_query: %{message: %{chat: %{id: chat_id, username: username}}}}), do: _current_chat(chat_id, username)
  defp current_chat(%{message: %{chat: %{id: chat_id, username: username}}}), do: _current_chat(chat_id, username)

  defp _current_chat(chat_id, username) do
    with user <- Repo.get_by(User, username: username),
         nil <- user.chat_id do
      Users.update_user(user, %{chat_id: chat_id}); chat_id
    else
      _ -> chat_id
    end
  end
end
