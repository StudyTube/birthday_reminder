defmodule BirthdayReminder.MoneyRounds.Services.CreateMoneyRoundTest do
  use BirthdayReminder.DataCase, async: true

  alias BirthdayReminder.MoneyRounds.Services.CreateMoneyRound
  alias BirthdayReminder.MoneyRounds.Schemas.MoneyRound

  describe "with valid params" do
    test "returns created money round" do
      assert {:ok, %MoneyRound{}} =
               CreateMoneyRound.call(%{name: "John's birthday", expired_date: ~D[2021-02-20], identifier: "identifier"})
    end
  end

  describe "with invalid params" do
    test "returns error" do
      assert {:error, %Ecto.Changeset{}} = CreateMoneyRound.call(%{})
    end
  end
end
