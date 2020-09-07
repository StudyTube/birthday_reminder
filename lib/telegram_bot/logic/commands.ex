defmodule TelegramBot.Commands do
  alias BirthdayReminder.{Repo, User, Users}

  def match_message(%{message: %{text: "/start"}} = message) do
    message
    |> current_chat
    |> Nadia.send_message("*Hi there!*\nI am the Birthday Reminder Bot.\nIf you want to subscribe to further notifications choose the right option.\n",
        parse_mode: "Markdown",
        reply_markup: %Nadia.Model.InlineKeyboardMarkup{
          inline_keyboard: [
            [
              %{
                callback_data: "/subscribe",
                text: "🥳 Yes, I'm  🥳"
              },
              %{
                callback_data: "/unsubscribe",
                text: "😕 No, thanks  😕"
              }
            ]
          ]
        })
  end

  def match_message(%{message: %{text: "/subscribe"}} = message) do
    message
    |> current_chat
    |> Nadia.send_message("You successfully subscribed")
    # |> Users.subscribe
  end

  def match_message(%{message: %{text: "/unsubscribe"}} = message) do

  end

  def match_message(%{message: %{text: _any_text}} = message) do
    message
    |> current_chat
    |> Nadia.send_message("I don't understand you")
  end

  def match_message(%{callback_query: %{data: "/subscribe"}} = message) do
    message
    |> current_chat
    |> Nadia.send_message("You successfully subscribed")
    # |> Users.subscribe
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
