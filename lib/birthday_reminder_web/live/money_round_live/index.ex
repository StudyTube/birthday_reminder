defmodule BirthdayReminderWeb.MoneyRoundLive.Index do
  use BirthdayReminderWeb, :live_view

  alias BirthdayReminder.MoneyRounds

  def mount(_params, _session, socket) do
    if connected?(socket), do: subscribe()

    socket =
      assign(socket,
        current_rounds: MoneyRounds.current_rounds(),
        past_rounds: MoneyRounds.past_rounds()
      )

    {:ok, socket, temporary_assigns: [current_rounds: [], past_rounds: []]}
  end

  def handle_info({:money_round_updated, money_round}, socket) do
    case Timex.compare(money_round.expired_date, Timex.today()) do
      diff when diff in [1, 0] -> {:noreply, assign(socket, current_rounds: MoneyRounds.current_rounds())}
      _ -> {:noreply, assign(socket, past_rounds: MoneyRounds.past_rounds())}
    end
  end

  defp subscribe do
    Phoenix.PubSub.subscribe(BirthdayReminder.PubSub, "money-rounds")
  end
end
