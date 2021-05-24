defmodule BirthdayReminder.MoneyRounds.Services.GetPastRoundsTest do
  use BirthdayReminder.DataCase, async: true

  alias BirthdayReminder.MoneyRounds.Services.GetPastRounds

  test "returns a list of past money rounds" do
    _money_round1 = insert(:money_round, expired_date: Timex.shift(Timex.today(), days: 2))
    money_round2 = insert(:money_round, expired_date: Timex.shift(Timex.today(), days: -5))

    assert [money_round2] == GetPastRounds.call()
  end
end
