defmodule BirthdayReminderWeb.MoneyRoundLive.Index do
  use BirthdayReminderWeb, :live_view

  alias BirthdayReminder.MoneyRounds

  def mount(_params, _session, socket) do
    if connected?(socket), do: MoneyRounds.subscribe()

    socket =
      assign(socket,
        current_rounds: current_rounds(),
        past_rounds: past_rounds()
      )

    {:ok, socket, temporary_assigns: [current_rounds: [], past_rounds: []]}
  end

  def handle_info({:money_round_updated, money_round}, socket) do
    case Timex.compare(money_round.expired_date, Timex.today) do
      diff when diff in [1, 0] -> {:noreply, assign(socket, current_rounds: current_rounds())}
      _ -> {:noreply, assign(socket, past_rounds: past_rounds())}
    end
  end

  defp current_rounds do
    MoneyRounds.current_rounds()
  end

  defp past_rounds do
    MoneyRounds.past_rounds()
  end
end
