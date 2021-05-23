defmodule BirthdayReminder.MoneyRounds.Services.GetCurrentRoundsTest do
  use BirthdayReminder.DataCase, async: true

  alias BirthdayReminder.MoneyRounds.Services.GetCurrentRounds

  test "returns a list of current money rounds" do
    money_round1 = insert(:money_round, expired_date: Timex.shift(Timex.today(), days: 2))
    _money_round2 = insert(:money_round, expired_date: Timex.shift(Timex.today(), days: -5))

    assert [money_round1] == GetCurrentRounds.call()
  end
end
