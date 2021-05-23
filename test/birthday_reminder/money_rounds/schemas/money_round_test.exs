defmodule BirthdayReminder.MoneyRounds.Schemas.MoneyRoundTest do
  use BirthdayReminder.DataCase, async: true

  alias BirthdayReminder.MoneyRounds.Schemas.MoneyRound

  setup do
    base_params = %{
      name: "John's birthday",
      expired_date: Timex.shift(Timex.today, days: 7),
      identifier: "identifier123"
    }

    [base_params: base_params]
  end

  describe "changeset/2" do
    test "returns valid changeset", %{base_params: base_params} do
      changeset = MoneyRound.changeset(%MoneyRound{}, base_params)

      assert errors_on(changeset) == %{}
    end

    test "returns invalid chaangeset, when name isn't present", %{base_params: base_params} do
      invalid_params = Map.merge(base_params, %{name: nil})
      changeset = MoneyRound.changeset(%MoneyRound{}, invalid_params)

      assert errors_on(changeset) == %{name: ["can't be blank"]}
    end

    test "returns invalid chaangeset, when expired_date isn't present", %{base_params: base_params} do
      invalid_params = Map.merge(base_params, %{expired_date: nil})
      changeset = MoneyRound.changeset(%MoneyRound{}, invalid_params)

      assert errors_on(changeset) == %{expired_date: ["can't be blank"]}
    end

    test "returns invalid chaangeset, when identifier isn't present", %{base_params: base_params} do
      invalid_params = Map.merge(base_params, %{identifier: nil})
      changeset = MoneyRound.changeset(%MoneyRound{}, invalid_params)

      assert errors_on(changeset) == %{identifier: ["can't be blank"]}
    end
  end
end
