defmodule BirthdayReminder.MoneyRounds.Services.CreateMoneyRound do
  @moduledoc false

  alias BirthdayReminder.MoneyRounds.Schemas.MoneyRound
  alias BirthdayReminder.Repo

  @doc """
  Returns new money round.

  ## Examples

    iex> CreateMoneyRound.call({name: "John's birthday", expired_date: ~D[2021-05-26], identifier: "random_string"})
    {:ok, %MoneyRound{}}

    iex> CreateMoneyRound.call(%{})
    {:error, %Ecto.Changeset{}}
  """
  @spec call(map()) :: {:ok, MoneyRound.t()} | {:error, %Ecto.Changeset{}}
  def call(params) do
    %MoneyRound{}
    |> MoneyRound.changeset(params)
    |> Repo.insert()
  end
end
