defmodule BirthdayReminder.MoneyRounds.Services.ConfirmPaymentTest do
  use BirthdayReminder.DataCase, async: true

  alias BirthdayReminder.MoneyRounds.Services.ConfirmPayment
  alias BirthdayReminder.MoneyRounds.Schemas.MoneyRound

  describe "with success case" do
    test "returns updated money round" do
      _money_round = insert(:money_round, identifier: "identifier")

      assert {:ok, %MoneyRound{usernames: ["johndoe"|_]}} = ConfirmPayment.call("identifier", "johndoe")
    end
  end

  describe "when money_round not found" do
    test "returns error" do
      assert {:error, :money_round_not_found} = ConfirmPayment.call("unknown_identifier", "johndoe")
    end
  end
end
