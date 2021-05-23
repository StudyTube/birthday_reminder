defmodule BirthdayReminder.MoneyRounds.Services.UpdateMoneyRoundTest do
  use BirthdayReminder.DataCase, async: true

  alias BirthdayReminder.MoneyRounds.Services.UpdateMoneyRound

  describe "with valid params" do
    test "returns updated money_round" do
      money_round = insert(:money_round)

      assert {:ok, updated_money_round} = UpdateMoneyRound.call(money_round, %{name: "John's birthday"})
      assert money_round.name != updated_money_round.name
    end
  end

  describe "with invalid params" do
    test "returns error" do
      money_round = insert(:money_round)

      assert {:error, %Ecto.Changeset{}} = UpdateMoneyRound.call(money_round, %{name: ""})
    end
  end
end
