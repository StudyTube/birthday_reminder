defmodule BirthdayReminder.MoneyRoundFactory do
  @moduledoc false
  defmacro __using__(_opts) do
    quote do
      def money_round_factory do
        %BirthdayReminder.MoneyRounds.Schemas.MoneyRound{
          name: sequence(:name, &"User#{&1}'s birthday"),
          expired_date: Timex.shift(Timex.today(), days: 7),
          identifier: :crypto.strong_rand_bytes(32) |> Base.encode64() |> binary_part(0, 32),
          usernames: []
        }
      end
    end
  end
end
