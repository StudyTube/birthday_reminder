defmodule TelegramBot.Commands do
  def match_message(%{message: %{text: "/start"}} = message) do

  end

  def match_message(%{message: %{text: "/subscribe"}} = message) do
    # message
    # |> current_user
    # |> subscribe
    # |> Nadia.send_messsage("You successfully subscribed")
  end

  def match_message(%{message: %{text: "/unsubscribe"}} = message) do

  end

  def match_message(%{message: %{text: _any_text}} = message) do

  end

  defp current_user(message) do

  end
end
