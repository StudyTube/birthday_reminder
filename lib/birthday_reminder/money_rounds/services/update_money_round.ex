defmodule BirthdayReminder.MoneyRounds.Services.UpdateMoneyRound do
  @moduledoc false

  alias BirthdayReminder.MoneyRounds.Schemas.MoneyRound
  alias BirthdayReminder.Repo

  @doc """
  Returns new money round.

  ## Examples

    iex> UpdateMoneyRound.call(money_round, {expired_date: ~D[2021-05-26]})
    {:ok, %MoneyRound{}}

    iex> UpdateMoneyRound.call(money_round, %{name: ""})
    {:error, %Ecto.Changeset{}}
  """
  @spec call(MoneyRound.t(), map()) :: {:ok, MoneyRound.t()} | {:error, %Ecto.Changeset{}}
  def call(money_round, params) do
    with {:ok, money_round} <- update_money_round(money_round, params),
         :ok <- broadcast(money_round) do
      {:ok, money_round}
    end
  end

  defp update_money_round(money_round, params) do
    money_round
    |> MoneyRound.changeset(params)
    |> Repo.update()
  end

  defp broadcast(money_round) do
    Phoenix.PubSub.broadcast(BirthdayReminder.PubSub, "money-rounds", {:money_round_updated, money_round})
  end
end
