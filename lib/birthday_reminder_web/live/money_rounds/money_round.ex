defmodule BirthdayReminderWeb.MoneyRound do
  use BirthdayReminderWeb, :live_view

  alias BirthdayReminder.MoneyRounds

  def mount(_params, _session, socket) do
    current_rounds = MoneyRounds.current_rounds()
    past_rounds = MoneyRounds.past_rounds()

    socket =
      assign(socket,
        current_rounds: current_rounds,
        past_rounds: past_rounds
      )

    {:ok, socket, temporary_assigns: [current_rounds: [], past_rounds: []]}
  end
end
