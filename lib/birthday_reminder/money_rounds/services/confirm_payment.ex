defmodule BirthdayReminder.MoneyRounds.Services.ConfirmPayment do
  @moduledoc false

  alias BirthdayReminder.MoneyRounds.Schemas.MoneyRound
  alias BirthdayReminder.MoneyRounds.Services.UpdateMoneyRound
  alias BirthdayReminder.Repo

  @doc """
  Returns updated money round with updated usernames field.

  ## Examples

    iex> ConfirmPayment.call(identifier, username)
    {:ok, %MoneyRound{}}
  """
  @spec call(binary(), binary()) ::
          {:ok, MoneyRound.t()} | {:error, %Ecto.Changeset{}} | {:error, :money_round_not_found}
  def call(identifier, username) do
    with {:ok, money_round} <- get_money_round(identifier) do
      UpdateMoneyRound.call(money_round, %{usernames: [username | money_round.usernames]})
    end
  end

  defp get_money_round(identifier) do
    case Repo.get_by(MoneyRound, identifier: identifier) do
      nil -> {:error, :money_round_not_found}
      money_round -> {:ok, money_round}
    end
  end
end
